<?php

namespace Multiple\Backend\Controllers;

use Multiple\PHOClass\PHOController;
use Multiple\Models\Slide;
use Multiple\Library\FilePHP;
class SlideController extends PHOController
{

    public function initialize()
    {        
        $this->check_loginadmin();
    }
	public function indexAction()
	{
		$slide_db = new Slide();
		$data['list'] = $slide_db->get_all();
		$this->set_template_share();
		$this->ViewVAR($data);
	}
	public function editAction($slide_id)
	{
		//$param = $this->get_Gparam(array('slide_id'));
		$slide_db = new Slide();
		if(strlen($slide_id)==0 || $slide_id ==0){  // new
			$result['data'] = $slide_db;
		}else{//editG
			$result['data'] = $slide_db->get_info($slide_id);
		}
		//$data['list'] = $slide_db->get_all();
		//$this->set_template_share();
		$result['folder_tmp'] = uniqid('',TRUE);
		$this->ViewHtml('slide/edit',$result);
	}		
	public function listAction($banner_flg)
	{	
		$param = self::get_param(array('acw_url'));	
		$db = new Slide();
		$param['slides']=$db->get_slides_all($banner_flg);
		$param['title'] ='slides';
		$param['banner_flg'] = $banner_flg;
		if($param['banner_flg'] ==1){
			$param['title'] ='banner';
		}
		$this->set_template_share();
		$this->ViewVAR($param);		
	}
	public function updateAction(){
		$param = $this->get_param(array(
			'slide_id'
			,'img_path'				
			,'del_flg'	
			,'link_page'
			,'banner_flg'
			,'folder_tmp'		
			,'position'
			));
		
		$result = array('status' => 'OK');
		$result['status'] = 'OK';	
		$result['msg'] = 'Cập nhật thành công!';		
		$db = new Slide();
		$msg = $this->check_validate_update($param);
		if($msg ==""){
			$file = new FilePHP();
			$user = $this->session->get('auth');
			$param['user_id'] = $user->user_id;
			if(strlen($param['img_path'])>0 && strpos($param['img_path'],'tmp')!== FALSE){				
				$ext = $file->GetExtensionName($param['img_path']);				
				$file_name = uniqid('',TRUE).'.'.$ext;	
				$file->CopyFile(PHO_PUBLIC_PATH.$param['img_path'],PHO_PUBLIC_PATH.'images/slides/'.$file_name);
				$file->DeleteFolder(PHO_PUBLIC_PATH.'tmp/'.$param['folder_tmp']);
				$param['img_path'] ='images/slides/'.$file_name;
			}
			if(strlen($param['slide_id'])==0 || $param['slide_id'] == 0){
				$ctg_id = $db->_insert($param);
			}else{				
				$slide = $db->get_info($param['slide_id']);
				if($slide->img_path != '' && $slide->img_path != $param['img_path']){
					$file->DeleteFile(PHO_PUBLIC_PATH.'images/slides/'.$user->img_path);
				}	
				$db->_update($param);
			}
			
		}else{
			$result['status'] = 'ER';	
			$result['msg'] = $msg;
		}
		return $this->ViewJSON($result);
	}
	public function check_validate_update($param){
		if(strlen($param['img_path'])== 0){
			return "Bạn chưa upload hình !";
		}		
		return "";
	}
	public function deleteAction($slide_id)
	{		
		$db = new Slide();
		//$msg = $db->check_before_delete($param['my_id']);
		$result['status']="OK";
		//if($msg== ""){
			$db->slide_id =$slide_id;
			$db->delete();
			//$db->delete_slide($param['my_id']);
		/*}else{
			$result['status']="NOT";
			$result['msg']= $msg;
		}*/
		
		return $this->ViewJSON($result);
	}
}
