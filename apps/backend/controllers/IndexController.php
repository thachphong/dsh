<?php

namespace Multiple\Backend\Controllers;

use Multiple\PHOClass\PHOController;
use Multiple\Library\FilePHP;
use Multiple\PHOClass\PhoLog;
class IndexController extends PHOController
{

    public function initialize()
    {        
        $this->check_loginadmin();
    }
	public function indexAction()
	{
		$this->set_template_share();
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
