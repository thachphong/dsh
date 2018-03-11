<?php

namespace Multiple\Frontend\Controllers;

use Multiple\PHOClass\PHOController;
use Multiple\Models\Page;
use Multiple\PHOClass\PhoLog;
class PageController extends PHOController
{

	public function indexAction($page_no)
	{
		$param = self::get_param(array(
			'acw_url'
		));
		$model = new Page();
		$rows['page'] = $model->get_page_byno($page_no);	
		//PhoLog::debug_var('---d--',$page_no);
		//PhoLog::debug_var('---d--',$rows);
		if($rows == false){
			$rows['page_no']='';
			$rows['page_name']='Trang không tồn tại';
			$rows['content']= 'Trang này không tồn tại';					  
		}	
		//$this->set_template_share();
		$this->ViewVAR($rows);
	}
	public function route404Action(){
		
	}
}
