<?php

namespace Multiple\Backend\Controllers;

use Multiple\PHOClass\PHOController;

class SlideController extends PHOController
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
}
