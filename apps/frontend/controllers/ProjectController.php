<?php

namespace Multiple\Frontend\Controllers;

use Multiple\PHOClass\PHOController;
use Multiple\Models\Project;
use Multiple\Models\Tags;
use Multiple\Models\CheckView;
use Multiple\PHOClass\PhoLog;
class ProjectController extends PHOController
{

	public function indexAction($url)
	{
        $db = new Project();
        $exp  = explode('_', $url)  ;   
        $id = $exp[count($exp)-1];
        $result = $db->get_info($id);
		
        $result['relations'] = $db->get_project_relation($result['project_id']);
        //update traffic
        /*$time = time();
		$traffic['time'] = $time;//-600;  //10phut		
		$traffic['section_id'] = session_id();
		$traffic['ip'] = $this->get_client_ip_server();
		$traffic['news_id'] =$id;
		$db->update_traffic($traffic);*/
        
        $this->ViewVAR($result);
	}
	public function viewAction($id)
	{
		$url =  $this->request->getURI();
        $abc =1;
       // $post_data= Posts::findFirst
	}
	
}
