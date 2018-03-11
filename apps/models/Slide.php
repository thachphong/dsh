<?php

namespace Multiple\Models;

use Multiple\Models\DBModel;
use Multiple\PHOClass\PHOArray;

class Slide extends DBModel
{
    public $slide_id;
    public $slide_type;
    public $img_path;
    public $del_flg;
    public $add_date;
    public $add_user;
    public $upd_date;
    public $upd_user;
    public $link_page;
    public $banner_flg;
    public $position;
    public function initialize()
    {
        $this->setSource("slides");
    }        
   
	public function get_all(){
         $usr_data = Slide::find(array('del_flg'=>0));
    }
    public function get_row($slide_id){
         return  Slide::findFirst(array('slide_id'=>$slide_id));
    }
    public function get_info($slide_id){
         return  Slide::findFirst(array("slide_id = :slide_id:",
            'bind' => array('slide_id' => $slide_id)
        ));
    }
    public function get_slides_all($banner_flg= 0)
	{		
		return Slide::find(array("banner_flg = :banner_flg:",
            'bind' => array('banner_flg' => $banner_flg)
        ));
	}
	public function get_slides_list($banner_flg= 0,$position = 0)
	{		
		return Slide::find(array("banner_flg = :banner_flg: and del_flg =0 and position=:position: ",
            'bind' => array('banner_flg' => $banner_flg,'position'=>$position)
        ));
	}
	public function _insert($param){
		//$this->slide_id = $param['slide_id'];
	    $this->slide_type= 0;
	    $this->img_path= $param['img_path'];
	    $this->del_flg= 0;	   
	    $this->add_user= $param['user_id'];	  
	    $this->upd_user= $param['user_id'];
	    $this->link_page= $param['link_page'];
	    $this->banner_flg= 0;
	    if(strlen($param['banner_flg']) > 0){
			$this->banner_flg= $param['banner_flg'];
		}
	    
	    if(isset($param['position'])){
			$this->position = $param['position'];
		}
	    $this->save();
	}
	public function _update($param){
		$sql = "update slides
					set img_path = :img_path
					,del_flg = :del_flg	
					,link_page= :link_page				
					,upd_date =  now()
					,upd_user =:user_id	
					,position =:position				
					where slide_id = :slide_id
				";	
 
		$this->pho_execute($sql, PHOArray::filter($param, array(
					'slide_id'
					,'img_path'					
					,'user_id'
					,'del_flg'	
					,'link_page'
					,'position'			
					)));	
	}
}
