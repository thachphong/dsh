<?php

namespace Multiple\Models;

use Multiple\Models\DBModel;
use Multiple\PHOClass\PHOArray;
use Multiple\PHOClass\PHOLog;
class DownloadTemp extends DBModel
{
    public $id_dl;
    public $status;
    public $link_dl;
    public $caption;
    public $menu_id;
    public $img_link;
    public $addtime;
        
    public function initialize()
    {
        $this->setSource("download_temp");
    }
    public function get_All($status,$menu_id){    	
        return  DownloadTemp::find(array(
                "status = :status: and menu_id = :menu_id: ",
                'bind' => array("status" => $status,'menu_id'=>$menu_id),
                'order'=> "id_dl desc"
        ));
        /*$usr_data = DownloadTemp::find(array('status'=>1));
        return $usr_data;*/
    }
    public function check_exists($url){    
    	
    	//$pql = "SELECT count(*) cnt FROM download_temp	where link_dl = :link_dl";
        $pql = "select count(*) cnt from(
                    SELECT pro_id FROM product  where src_link = :link_dl
                    union 
                    SELECT id_dl FROM download_temp where link_dl = :link_dl
                ) t";
		$total =$this->query_first($pql,array( 'link_dl' => $url)) ;
		if($total['cnt'] == 0){
			return TRUE;
		}
		
		return FALSE;
    }   
}
