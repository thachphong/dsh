<?php

namespace Multiple\Backend\Controllers;

use Multiple\PHOClass\PHOController;
use Multiple\Models\Category;
use Multiple\Models\Project;
use Multiple\Models\Provincial;
use Multiple\Models\District;
use Multiple\PHOClass\PhoLog;
use Multiple\Library\FilePHP;
class ProjectController extends PHOController
{

    public function initialize()
    {        
        $this->check_loginadmin();
    }
	public function indexAction()
	{
		$model = new Project();
		$rows = $model->get_list_all();
		//$this->set_template_share();
		$this->ViewVAR( array(
			'news' => $rows			
		));
	}	
	
	public function editAction($new_id)
	{	
		$db = new Project();
		$ctg = new Category();
		$cache = $this->createCache( ['lifetime' => 86400 ]); // 1 ngay
		$cacheKey = 'param_project.cache';
		$param = $cache->get($cacheKey);
		if($param === null){	
			
			$param['provincials'] = Provincial::get_all();
			$param['districts'] = District::find();
			$param['ctg_list'] = $ctg->get_ctg_list(2,2);	
			$cache->save($cacheKey,$param);
		}
		
		if($new_id == 0){
			$param['project_id'] = null;
			$param['project_no'] = null;
			$param['project_name'] = "";
			$param['img_path'] = "";
			$param['des'] = "";
			$param['content'] = "";
			$param['del_flg'] = "";
			$param['ctg_id'] = null;
			$param['boss_name'] = "";
			$param['address'] = "";
			$param['acreage'] = "";
			$param['percent'] = "";
			$param['m_provin_id'] = "";
			$param['m_ward_id'] = "";
			$param['m_district_id'] = "";
			$param['m_street_id'] = "";
			$param['map_lat'] = "";
			$param['map_lng'] = "";
			$param['scale'] = "";
			
		}else{
			$data = $db->get_info($new_id);
			$param = array_merge($param,$data);
		}
		$param['folder_tmp'] = uniqid('',true);
		
		//PhoLog::debug_Var('---ssss--',$param);
		
		//$this->set_template_share();
		$this->ViewVAR($param);
	}
	public function updateAction(){
		$param = $this->get_param(array(
			  'project_id',
			  'project_name',			  
			  'ctg_id',
			  'boss_name',
			  'address',
			  'acreage',			
			  'percent',
			  'm_provin_id',
			  'm_district_id',
			  'm_ward_id',
			  'm_street_id',
			  'map_lat',
			  'map_lng',
			  'content',
			  'des',
			  'scale',			  
			  'img_path',
			  'folder_tmp',
			  'del_flg'
			));
		
		$result = array('status' => 'OK');
		$result['status'] = 'OK';	
		$result['msg'] = 'Cập nhật thành công!';		
		$db = new Project();
		$msg = $this->check_validate_update($param);
		if($msg == ""){
			$file = new FilePHP();
			$login_info =  $this->session->get('auth');
        	$param['user_id'] = $login_info->user_id;
        	$listfile = $this->get_listfile($param['content']);
			if(strlen($param['project_id'])==0){
				$id = $db->_insert($param);
				$db = $db->get_project($id);
				//PhoLog::debug_Var('---ssss--',$id);
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
				$obj = $db->get_project($param['project_id']);
				$file_old = $this->get_listfile_old($obj->add_date,$obj->project_id);
				$img_main_path = $this->get_img_main_path($obj->add_date,$obj->project_id);

				$imglist = $this->move_file($obj->add_date,$param['project_id'],$listfile['tmp']);
				$param['content'] = $this->replace_image_path($imglist,$param['content']);
				if(strpos($param['img_path'], 'tmp') !== false){ // file upload mới
					$imglist = $this->move_file($obj->add_date,$param['project_id'],array(0=>$param['img_path']));
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
		$dest_folder = PHO_PUBLIC_PATH.'images/projects';
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
			$src_file = 'images/projects/'.$year.'/'.$month.'/'.$day.'/'.$news_id.'/'.$exp[count($exp)-1];
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
		$path = 'images/projects/'.$year.'/'.$month.'/'.$day.'/'.$news_id;
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
		if(strlen($param['project_name'])== 0){
			return "Bạn chưa nhập tên trang !";
		}
		$news_no = $this->convert_url($param['project_name']);
		$param['project_no'] = $news_no;	
		
		return "";
	}
	public function deleteAction($project_id)
	{	
		$db = new Project();
		$msg = "";//$db->check_before_delete($ctg_id);
		$result['status']="OK";
		$obj = $db->get_project($project_id);			
		$img_main_path = $this->get_img_main_path($obj->add_date,$project_id);
		$file = new FilePHP();		
		if($msg== ""){
			$db->project_id = $project_id;
			$db->delete();
			$file->DeleteFolder(PHO_PUBLIC_PATH.$img_main_path);
		}else{
			$result['status']="NOT";
			$result['msg']= $msg;
		}
		
		return $this->ViewJSON($result);
	}
}
