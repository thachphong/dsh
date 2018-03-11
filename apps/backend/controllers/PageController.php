<?php

namespace Multiple\Backend\Controllers;

use Multiple\PHOClass\PHOController;
use Multiple\Models\Page;
use Multiple\PHOClass\PhoLog;
use Multiple\Library\FilePHP;
class PageController extends PHOController
{

    public function initialize()
    {        
        $this->check_loginadmin();
    }
	public function indexAction()
	{
		$model = new Page();
		$rows['pages'] = $model->get_all();
		$this->set_template_share();
		$this->ViewVAR($rows);
	}
	
	public function editAction($page_id)
	{
		$db = new Page();
		if($page_id ==0 || $page_id ==''){
			$result['page'] = $db;
		}else{
			$result['page'] = $db->get_page_info($page_id);	
		}
		$result['folder_tmp'] = uniqid('',true);		
		$this->set_template_share();
		$this->ViewVAR($result);
	}
	public function updateAction(){
		$param = self::get_param(array(
			  'page_id',
			  'page_no',
			  'page_name',			
			  'content',
			  'add_date',
			  'add_user',
			  'upd_date',
			  'upd_user',			 
			  'del_flg',
			  'img_path',
			  'disp_home'
			));
		
		$result = array('status' => 'OK');
		$result['status'] = 'OK';	
		$result['msg'] = 'Cập nhật thành công!';		
		$db = new Page();
		$file = new FilePHP();
		$msg = $this->check_validate_update($param);
		if($msg == ""){
			$listfile = $this->get_listfile($param['content']);
			$login_info =  $this->session->get('auth');
        	$param['user_id'] = $login_info->user_id;
			if(strlen($param['page_id'])==0){
				$id =$db->_insert($param);
				$imglist = $this->move_file($id,$listfile['tmp']);
				//PhoLog::debug_Var('---img--',$imglist);
				$db->content = $this->replace_image_path($imglist,$param['content']);
				//PhoLog::debug_Var('---img--',$db->content);				
				$db->save();
			}else{
				$page_id =$param['page_id'];
				$file_old = $this->get_listfile_old($page_id);
				$img_main_path = $this->get_img_main_path($page_id);

				$imglist = $this->move_file($param['page_id'],$listfile['tmp']);
				$param['content'] = $this->replace_image_path($imglist,$param['content']);
				
				$db->_update($param);
				foreach ($file_old as $key => $value) {
					if(in_array($value, $listfile['main']) == false){
						//PhoLog::debug_Var('---img--','delete:'.PHO_PUBLIC_PATH.$img_main_path.'/'.$value);
						$file->DeleteFile(PHO_PUBLIC_PATH.$img_main_path.'/'.$value);
					}
				}
			}
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
		$result['main'] = array();
		$result['tmp'] = array();
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
	public function move_file($page_id,$listfile){
		$dest_folder = PHO_PUBLIC_PATH.'images/pages';
		//$src_folder= PHO_PUBLIC_PATH.'tmp/'.$folder_tmp;
		$result = array();
		$file = new FilePHP();
	
		$dest_folder .= "/".$page_id;
		if($file->FolderExists($dest_folder) == false){
			$file->CreateFolder($dest_folder);
		}
		//PhoLog::debug_Var('---rrrr--',$listfile);
		foreach ($listfile as $key => $value){
			$exp = explode('/', $value);
			$src_file = 'images/pages/'.$page_id.'/'.$exp[count($exp)-1];
			$file->CopyFile(PHO_PUBLIC_PATH.$value,PHO_PUBLIC_PATH.$src_file);
			//PhoLog::debug_Var('---rrrr--','from:'.PHO_PUBLIC_PATH.$value);	
			//PhoLog::debug_Var('---rrrr--','to:'.PHO_PUBLIC_PATH.$src_file);	
			$file->DeleteFile(PHO_PUBLIC_PATH.$value);
			$result[$key]['old'] = $value;
			$result[$key]['new'] = $src_file;
		}
		return $result;
	}
	public function get_listfile_old($page_id)
	{	
		
		$file = new FilePHP();
		$listfile = array();
		$src_file = $this->get_img_main_path($page_id);
		if($file->FolderExists(PHO_PUBLIC_PATH.$src_file) == true){
			$listfile = $file->FileList(PHO_PUBLIC_PATH.$src_file);
		}		

		return $listfile;
	}
	public function get_img_main_path($page_id)
	{		
		$path = 'images/pages/'.$page_id;
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
		if(strlen($param['page_name'])== 0){
			return "Bạn chưa nhập tên trang !";
		}
		$param['page_no'] =$this->convert_url($param['page_name']);
		
		$db = new Page();
		$page_no = $param['page_no'];
		if(strlen($param['page_id']) == 0){		
			$row = $db->get_page_byno( $param['page_no'] );		
			$i = 0;
			while($row){
				$i++;
				$param['page_no'] = $page_no.'-'.$i;
				$row = $this->query($sql, array ('page_no' => $param['page_no'] ));
			}
		}else{
			$res = $db->get_page_exists($param['page_no'] , $param['page_id']);
			$i = 0;
			while($res){
				$i++;
				$param['page_no'] = $page_no.'-'.$i;
				$res = $db->get_page_exists($param['page_no'] , $param['page_id']);
			}
		}
		/*if(strlen($param['img_path']) > 0){
		}*/
		return "";
	}
	public function deleteAction($page_id)
	{		
		$db = new Page();
		$msg = "";//$db->check_before_delete($ctg_id);
		$result['status']="OK";
		if($msg== ""){
			$db->page_id = $page_id;
			$db->delete();
		}else{
			$result['status']="NOT";
			$result['msg']= $msg;
		}
		
		return $this->ViewJSON($result);
	}
}
