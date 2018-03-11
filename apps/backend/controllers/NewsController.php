<?php

namespace Multiple\Backend\Controllers;

use Multiple\PHOClass\PHOController;
use Multiple\Models\Category;
use Multiple\Models\News;
use Multiple\Models\MType;
use Multiple\PHOClass\PhoLog;
use Multiple\Library\FilePHP;
class NewsController extends PHOController
{

    public function initialize()
    {        
        $this->check_loginadmin();
    }
	public function indexAction()
	{
		$param = $this->get_Gparam(array('page'));
		$model = new News();
		
		
		$page = 1;
		$param['limit'] = 50;
	    if(isset($param['page']) && strlen($param['page']) > 0){
	        $page= $param['page'];
	    }       
	        $start_row = 0;
	        if( $page > 1){
	            $start_row = ( $page-1)*$param['limit'] ;
	        }

	        $param['page'] = $page;
	      
	        $param['ctg_no'] = str_replace('/','', $_SERVER['REQUEST_URI']);
        	$exp = explode('&page',$param['ctg_no'])  ;
        	$param['ctg_no']=  $exp[0]; 
	        	        
	        $param['total_post'] = $model->get_news_all_count();
	        $param['total_page']= round($param['total_post']/$param['limit']);
	        
	        $start = $page - 2;
	        $end = $page + 2;
	        if($page < 3){
	            $start = 1;
	            $end = $start + 4;
	            if($end > $param['total_page']){
	               $end = $param['total_page'];
	            }
	        }
	        if($param['total_page']< $page + 2 ){
	            $end = $param['total_page'];
	            $start = $param['total_page'] - 4;
	            if($start < 1){
	               $start = 1;
	            }
	        }
	        $rows = $model->get_news_all($start_row,$param['limit']);		
	        $param['start'] = $start;
	        $param['end'] = $end;
			$param['news'] = $rows	;
		//$this->set_template_share();
		$this->ViewVAR( $param);
	}	
	
	public function editAction($new_id)
	{	
		//PhoLog::debug_Var('---ssss--',$new_id);
		$db = new News();
		$ctg = new Category();
		if($new_id == 0){
			$param['news_id'] = null;
			$param['news_no'] = null;
			$param['news_name'] = "";
			$param['img_path'] = "";
			$param['des'] = "";
			$param['content'] = "";
			$param['del_flg'] = "";
			$param['ctg_id'] =null;
		}else{
			$param = $db->get_news_info($new_id);
		}
		$param['folder_tmp'] = uniqid('',true);
		$param['ctg_list'] = $ctg->get_category_rows(1,1);	
		//PhoLog::debug_Var('---ssss--',$param);
		
		//$this->set_template_share();
		$this->ViewVAR($param);
	}
	public function updateAction(){
		$param = $this->get_param(array(
			  'news_id',
			  'news_no',
			  'news_name',			
			  'content',
			  'des',
			  'ctg_id',
			  'img_path',
			  //'add_date',
			// 'add_user',
			 // 'upd_date',
			 // 'upd_user',			 
			  'del_flg'
			  ,'folder_tmp'
			));
		
		$result = array('status' => 'OK');
		$result['status'] = 'OK';	
		$result['msg'] = 'Cập nhật thành công!';		
		$db = new News();
		$msg = $this->check_validate_update($param);
		if($msg == ""){
			$file = new FilePHP();
			$login_info =  $this->session->get('auth');
        	$param['user_id'] = $login_info->user_id;
        	$listfile = $this->get_listfile($param['content']);
			if(strlen($param['news_id'])==0){
				$id = $db->_insert($param);
				$db = $db->get_news($id);
				//PhoLog::debug_Var('---ssss--',$db->add_date);
				$imglist = $this->move_file($db->add_date,$id,$listfile['tmp']);
				//PhoLog::debug_Var('---img--',$imglist);
				$db->content = $this->replace_image_path($imglist,$param['content']);
				//PhoLog::debug_Var('---img--',$db->content);
				if(strpos($param['img_path'], 'tmp') !== false){ // file upload mới

					$imglist = $this->move_file($db->add_date,$id,array(0=>$param['img_path']));
					$db->img_path= $imglist[0]['new'];
					//PhoLog::debug_Var('---img--',$db->img_path);
				}
				$db->save();

			}else{				
				$obj = $db->get_news($param['news_id']);
				$file_old = $this->get_listfile_old($obj->add_date,$obj->news_id);
				$img_main_path = $this->get_img_main_path($obj->add_date,$obj->news_id);

				$imglist = $this->move_file($obj->add_date,$param['news_id'],$listfile['tmp']);
				$param['content'] = $this->replace_image_path($imglist,$param['content']);
				if(strpos($param['img_path'], 'tmp') !== false){ // file upload mới
					$imglist = $this->move_file($obj->add_date,$param['news_id'],array(0=>$param['img_path']));
					$param['img_path'] = $imglist[0]['new'];
				}else{
					$listfile['main'][]=str_replace($img_main_path.'/', '', $param['img_path'])  ;
				}
				$db->_update($param);	
				//delete file not use
				
				
				//PhoLog::debug_Var('---img--','img old');
				//PhoLog::debug_Var('---img--',$file_old);
				//PhoLog::debug_Var('---img--','img main');
				//PhoLog::debug_Var('---img--',$listfile['main']);
				foreach ($file_old as $key => $value) {
					if(in_array($value, $listfile['main']) == false){
						//PhoLog::debug_Var('---img--','delete:'.PHO_PUBLIC_PATH.$img_main_path.'/'.$value);
						$file->DeleteFile(PHO_PUBLIC_PATH.$img_main_path.'/'.$value);
					}
				}			
			}
			$file->DeleteFolder(PHO_PUBLIC_PATH.'tmp/'.$param['folder_tmp']);
			
		}else{
			$result['status'] = 'ER';	
			$result['msg'] = $msg;
		}
		return $this->ViewJSON($result);
	}
	public function get_listfile($content){
		$pattern ='/(src="' .str_replace('/', '\/', BASE_URL_NAME).')(.*?)(\")/' ;
		preg_match_all($pattern,$content,$match);
		//PhoLog::debug_Var('---rrrr--',$pattern);
		$result = array();
		$repl = array(BASE_URL_NAME,'src=','"');
		foreach ($match[0] as $key => $value) {
			if(strpos($value, 'images') > 0){
				$exp = explode('/', $value);
				$result['main'][] =str_replace('"', '', $exp[count($exp) -1]); 		
			}else{
				$result['tmp'][]= str_replace($repl,'',$value);
			}
		}	
		return $result;
		//PhoLog::debug_Var('---rrrr--',$result);	
	}
	public function move_file($add_date,$news_id,$listfile){
		$dest_folder = PHO_PUBLIC_PATH.'images/news';
		//$src_folder= PHO_PUBLIC_PATH.'tmp/'.$folder_tmp;
		$result = array();
		$file = new FilePHP();
		$date = date_create($add_date);
		$year = date_format($date, 'Y');
		$month = date_format($date, 'm');
		$day = date_format($date, 'd');
		$dest_folder .= "/".$year;
		if($file->FolderExists($dest_folder) == false){
			$file->CreateFolder($dest_folder);
		}
		$dest_folder .= "/".$month;
		if($file->FolderExists($dest_folder) == false){
			$file->CreateFolder($dest_folder);
		}
		$dest_folder .= "/".$day;
		if($file->FolderExists($dest_folder) == false){
			$file->CreateFolder($dest_folder);
		}
		$dest_folder .= "/".$news_id;
		if($file->FolderExists($dest_folder) == false){
			$file->CreateFolder($dest_folder);
		}
		//PhoLog::debug_Var('---rrrr--',$listfile);
		foreach ($listfile as $key => $value){
			$exp = explode('/', $value);
			$src_file = 'images/news/'.$year.'/'.$month.'/'.$day.'/'.$news_id.'/'.$exp[count($exp)-1];
			$file->CopyFile(PHO_PUBLIC_PATH.$value,PHO_PUBLIC_PATH.$src_file);
			//PhoLog::debug_Var('---rrrr--','from:'.PHO_PUBLIC_PATH.$value);	
			//PhoLog::debug_Var('---rrrr--','to:'.PHO_PUBLIC_PATH.$src_file);	
			$file->DeleteFile(PHO_PUBLIC_PATH.$value);
			$result[$key]['old'] = $value;
			$result[$key]['new'] = $src_file;
		}
		return $result;
	}
	public function get_listfile_old($add_date,$news_id)
	{		
		
		$file = new FilePHP();
		$src_file = $this->get_img_main_path($add_date,$news_id);
		$listfile = $file->FileList(PHO_PUBLIC_PATH.$src_file);

		return $listfile;
	}
	public function get_img_main_path($add_date,$news_id)
	{
		$date = date_create($add_date);
		$year = date_format($date, 'Y');
		$month = date_format($date, 'm');
		$day = date_format($date, 'd');
		$path = 'images/news/'.$year.'/'.$month.'/'.$day.'/'.$news_id;
		return $path;
	}
	public function replace_image_path($imglist,$content){
		//$img_new = $imglist['new'];
		foreach ($imglist as $key => $value) {
			$content = str_replace($value['old'], $value['new'], $content);
		}
		return $content;
	}
	public function check_validate_update(&$param){
		if(strlen($param['news_name'])== 0){
			return "Bạn chưa nhập tên trang !";
		}
		$news_no = $this->convert_url($param['news_name']);
		$param['news_no'] = $news_no;	
		$db = new News();	
		// if(strlen($param['news_id']) == 0){
		// 	//$sql = "select news_id from news	where news_no = :news_no";
		// 	$row = $db->get_news_byno($param['news_no'] );
		// 	//$row = $this->get_ctg_byno($param['page_no']);
		// 	$i = 0;
		// 	while($row){
		// 		$i++;
		// 		$param['news_no'] = $news_no.'-'.$i;
		// 		$row = $db->get_news_byno($param['news_no'] );
		// 	}
		// }else{
		// 	//$sql = "select news_id from news	where news_no = :news_no	and news_id <> :news_id";
		// 	$res = $db->get_news_exist($param['news_no'] ,$param['news_id']);
		// 	$i = 0;
		// 	while($res){
		// 		$i++;
		// 		$param['news_no'] = $news_no.'-'.$i;
		// 		$res = $db->get_news_exist($param['news_no'] ,$param['news_id']);
		// 	}
		// }
		return "";
	}
	public function deleteAction($news_id)
	{	
		$db = new News();
		$msg = "";//$db->check_before_delete($ctg_id);
		$result['status']="OK";
		$obj = $db->get_news($news_id);			
		$img_main_path = $this->get_img_main_path($obj->add_date,$news_id);
		$file = new FilePHP();		
		if($msg== ""){
			$db->news_id = $news_id;
			$db->delete();
			$file->DeleteFolder(PHO_PUBLIC_PATH.$img_main_path);
		}else{
			$result['status']="NOT";
			$result['msg']= $msg;
		}
		
		return $this->ViewJSON($result);
	}
}
