<?php

namespace Multiple\Backend\Controllers;

use Multiple\PHOClass\PHOController;
use Multiple\Library\FilePHP;
use Multiple\PHOClass\PhoLog;
use Multiple\Models\Users;
use Multiple\Models\Orders;
class IndexController extends PHOController
{

    public function initialize()
    {        
        $this->check_loginadmin();
    }
	public function indexAction()
	{
		$us = new Users();
		$resul['user_info'] = $us->get_total_info();
		$db = new Orders();
		$resul['order_info'] = $db->get_total_info();
		$this->set_template_share();
		$this->ViewVAR($resul);
		//return $this->response->forward('login');
       // $this->view->name= 'aaaa';
	}
	public function delcacheAction(){
		$file_lb = new FilePHP();
		$filelist = $file_lb->FileList(PHO_CACHE_DIR);
		//PhoLog::debug_var('cache',$filelist);
		foreach($filelist as $item){
			$file_lb->DeleteFile(PHO_CACHE_DIR.$item);
		}
		$filelist = $file_lb->FileList(PHO_CACHE_HTML);
		//PhoLog::debug_var('cache',$filelist);
		foreach($filelist as $item){
			$file_lb->DeleteFile(PHO_CACHE_HTML.$item);
		}
		$result['status']="OK";	
		$this->ViewJSON($result);
	}
}
