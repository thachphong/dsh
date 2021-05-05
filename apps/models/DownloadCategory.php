<?php

namespace Multiple\Models;

use Multiple\Models\DBModel;
use Multiple\PHOClass\PHOArray;
class DownloadCategory extends DBModel
{
    public $id;
    public $menu_id;
    public $link;
    public $max_get;
    public $status;
    
    public function initialize()
    {
        $this->setSource("download_category");
    }
    public function get_All($menu_id =''){
        //$usr_data = Menu::find(array('status'=>1));
        if($menu_id ==''){
			$data = DownloadCategory::query()
                ->where("status=1")
                ->execute();
		}else{
			/*$data = DownloadCategory::query()
                ->where("status=1 and menu_id = :menu_id:")                
                ->bind(array("menu_id" => $menu_id))
                ->execute();*/
            return  DownloadCategory::find(array(
                "status=1 and menu_id = :menu_id: ", 'bind' => array('menu_id' => $menu_id)
            ));
		}
        
        return $data;
    }
    public  function get_rows(){
        $sql="select dc.*,c.ctg_name from download_category dc
                INNER JOIN category c on c.ctg_id = dc.menu_id
                where c.del_flg = 0";
        return $this->pho_query($sql);
    }
    public function get_info($id){
        return  DownloadCategory::findFirst(array(               
                "id = :id: ",
                'bind' => array('id' => $id)
            ));
    }
    public function insert($param){
        $this->menu_id = $param['menu_id'];
        $this->link = $param['link'];
        $this->max_get = 20;
        $this->status = $param['status'];
        $this->save();
        return $this->id;
    }
    public function _update($param){

        $sql = "update download_category
                    set menu_id = :menu_id
                    ,link = :link 
                    ,status= :status  
                    where id = :id
                ";  
 
        return $this->pho_execute($sql, PHOArray::filter($param, array(
                    'id'
                    ,'menu_id'                 
                    ,'link'
                    ,'status' 
                    )));    
    }
}
