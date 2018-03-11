<?php

namespace Multiple\Backend\Controllers;

use Multiple\PHOClass\PHOController;
use Multiple\Models\Define;
use Multiple\PHOClass\PhoLog;
class DefineController extends PHOController
{

    public function initialize()
    {        
        $this->check_loginadmin();
    }
	public function indexAction()
	{
		//return $this->response->forward('login');
       // $this->view->name= 'aaaa';
	}
	public function listAction($group_id)
	{			
		$db = new Define();		
		$data['list'] = $db->get_define_by_group($group_id);
		$this->set_template_share();	
		$this->ViewVAR($data);
	}
	public function updatelistAction(){
		$param = $this->get_param(array(
			  'define_val'
			));
		
		$result = array('status' => 'OK');
		$result['status'] = 'OK';	
		$result['msg'] = 'Cập nhật thành công!';		
		$db = new Define();
		$msg = "";//$db->check_validate_update($param);
		$login_info =  $this->session->get('auth');
        $sql_par['user_id'] = $login_info->user_id;
		if($msg == ""){
			// if(strlen($param['define_id'])==0){
			// 	$db->insert($param);
			// }else{
			foreach ($param['define_val'] as $key => $value) {
				$sql_par['define_id'] = $key;
				$sql_par['define_val'] = $value;
				$db->_update($sql_par);
			}
				
			//}
		}else{
			$result['status'] = 'ER';	
			$result['msg'] = $msg;
		}
		return $this->ViewJSON($result);
	
	}
}
