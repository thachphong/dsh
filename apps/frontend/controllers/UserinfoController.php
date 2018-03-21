<?php

namespace Multiple\Frontend\Controllers;

use Multiple\PHOClass\PHOController;
use Multiple\Models\Users;
use Multiple\Models\Define;
use Multiple\Models\Withdraw;
use Multiple\Library\Mail;
use Multiple\PHOClass\PhoLog;
use Multiple\Library\FilePHP;
class UserinfoController extends PHOController
{
	public function initialize()
    {        
        $this->check_login();

    }
	public function indexAction()
	{
		$db = new Users();
		$login_info =  $this->session->get('auth');
		$result['user']=$db->get_info($login_info->user_id);
		$this->set_template_share();
		$this->ViewVAR($result);
	}
	public function passAction()
	{
		$this->set_template_share();
		//$this->ViewVAR($result);
	}
	public function thongtinAction()
	{
		$db = new Users();
		$login_info =  $this->session->get('auth');
		$user = $db->get_info($login_info->user_id);
		$result['user']=$user;
		$result['folder_tmp']= uniqid('',TRUE);
		$result['provins'] = $this->get_Provin();
		$result['banks'] = $this->get_Bank();
		if($user->city > 0){
			$result['districts']= $this->get_District($user->city);
		}
		if($user->district > 0){
			$result['wards']= $this->get_Ward($user->district);
		}
		$this->set_template_share();
		$this->ViewVAR($result);
	}
	public function withdrawAction(){
		$result['banks'] = $this->get_Bank();
		$user =  $this->session->get('auth');		
		$result['user'] =$user;		
		$db = new Withdraw();
		$wd = $db->get_info($user->user_id,0);
		$result['request_flg'] = 0;
		if($wd != NULL){
			$result['request_flg'] = 1;
		}
		$this->set_template_share();
		$this->ViewVAR($result);
	}
	public function updwithdrawAction(){
		$param = $this->get_param(array('bank_id','bank_acc_no','bank_acc_name','amount','fee'));
		
		$db = new Withdraw();
		$user =  $this->session->get('auth');
		$param['user_id'] = $user->user_id;
		$result['status']='ER';
		$param['amount']= str_replace('.','',$param['amount']);
		$param['fee']= str_replace('.','',$param['fee']);
		//PhoLog::debug_var('---upd---',$param);
		if($db->_insert($param)){
			$result['status']='OK';
		}		
		return $this->ViewJSON($result);
	}
	public function withdrawhisAction(){

		$user =  $this->session->get('auth');
		$db = new Withdraw();
		$result['list'] = $db->get_list_byuser($user->user_id);
		
		$this->set_template_share();
		$this->ViewVAR($result);
	}
}
