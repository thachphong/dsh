<?php

namespace Multiple\Backend\Controllers;

use Multiple\PHOClass\PHOController;
use Multiple\Models\DownloadCategory;
use Multiple\Models\Category;
use Multiple\PHOClass\PHOLog;
class DownloadctgController extends PHOController
{

    public function initialize()
    {        
        $this->check_loginadmin();
    }
	public function indexAction()
	{
		$db = new DownloadCategory();
		$data['list'] = $db->get_rows();
		$this->set_template_share();
		$this->ViewVAR($data);
	}
	public function editAction($id)
	{
		//$param = $this->get_Gparam(array('slide_id'));
		$db = new DownloadCategory();
		if(strlen($id)==0 || $id ==0){  // new
			$result['data'] = $db;
		}else{//editG
			$result['data'] = $db->get_info($id);
		}		
		$ctg = new Category();
        $result['categorys']= $ctg->get_category_rows(0);
		$this->ViewHtml('downloadctg/edit',$result);
	}	
	public function updateAction(){
		$param = $this->get_param(array(
			  'id',
			  'link',
			  'menu_id',			
			  'status'
			));
		PHOLog::debug_var('---test---',$param);
		$result = array('status' => 'OK');
		$result['status'] = 'OK';	
		$result['msg'] = 'Cập nhật thành công!';		
		$db = new DownloadCategory();		
		$msg = '';//$this->check_validate_update($param);
		if($msg == ""){			
			if(strlen($param['id'])==0){
				$id =$db->insert($param);				
			}else{		
				$db->_update($param);				
			}
		}else{
			$result['status'] = 'ER';	
			$result['msg'] = $msg;
		}
		return $this->ViewJSON($result);
	}
	public function deleteAction($id)
	{		
		$db = new DownloadCategory();
		//$msg = $db->check_before_delete($param['my_id']);
		$result['status']="OK";
		//if($msg== ""){
		$db->id =$id;
		$db->delete();	
		return $this->ViewJSON($result);
	}
}
