<?php

namespace Multiple\Frontend\Controllers;

use Multiple\PHOClass\PHOController;
use Multiple\Models\News;
use Multiple\Models\Tags;
use Multiple\Models\CheckView;
use Multiple\PHOClass\PhoLog;
class NewsController extends PHOController
{

	public function indexAction($url)
	{
        $db = new News();
        $exp  = explode('_', $url)  ;   
        $id = $exp[count($exp)-1];
        $result = $db->get_news_row($id);
		
        $result['relations'] = $db->get_news_relation($result['ctg_id'],$result['news_id']);
        //update traffic
        $time = time();
		$traffic['time'] = $time;//-600;  //10phut		
		$traffic['section_id'] = session_id();
		$traffic['ip'] = $this->get_client_ip_server();
		$traffic['news_id'] =$id;
		$db->update_traffic($traffic);
        
		//$this->set_template_share();
        //PhoLog::debug_var('---tét---',$result);
        $this->ViewVAR($result);
		
  //       $url =  $this->request->getURI();
  //       $abc =1;
  //       $db = new Posts();
  //      // $post_data= Posts::findFirst
  //       $post_data = Posts::findFirst(array("id = :id:  AND status = 1 ",'bind' => array('id' => $id) ));
  //       $post_data->total_view += 1; 
  //       $post_data->save();
  //       $db_v->postid = $post_data->id;
  //       $db_v->user_ip = $ip;
  //       $db_v->date_view = date('Y-m-d');
  //       $db_v->time_view = date('H:i:s');
  //       $db_v->save();
        
	}
	public function viewAction($id)
	{
		$url =  $this->request->getURI();
        $abc =1;
       // $post_data= Posts::findFirst
	}
	
}
