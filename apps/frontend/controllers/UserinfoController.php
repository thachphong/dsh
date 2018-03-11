<?php

namespace Multiple\Frontend\Controllers;

use Multiple\PHOClass\PHOController;
use Multiple\Models\Users;
use Multiple\Models\Define;
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
		$this->ViewVAR($result);
	}
	public function thongtinAction()
	{
		$db = new Users();
		$login_info =  $this->session->get('auth');
		$result['user']=$db->get_info($login_info->user_id);
		$result['folder_tmp']= uniqid('',TRUE);
		$this->set_template_share();
		$this->ViewVAR($result);
	}
	
}
