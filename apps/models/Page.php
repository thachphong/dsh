<?php

namespace Multiple\Models;

use Multiple\Models\DBModel;
use Multiple\PHOClass\PHOArray;

class Page extends DBModel
{
    public $page_id;
    public $page_no;
    public $page_name;
    public $content;
    public $img_path;
    public $add_date;
    public $add_user;
    public $upd_date;
    public $upd_user;
    public $disp_home;
    public $del_flg;
   

    public function initialize()
    {
        $this->setSource("page");
    }
    public function get_page_list(){
        $sql="select page_id,page_no,page_name from page where del_flg= 0";
        return $this->pho_query($sql);
    }
    public function get_all(){
        $sql="select page_id,page_no,page_name,del_flg from page ";
        return $this->pho_query($sql);
    }
    public function get_page_info($page_id){
        return  Page::findFirst(array(
            "page_id = :page_id: ",
            'bind' => array('page_id' => $page_id)
        ));        
    }
    public function get_page_byno($page_no){
        return  Page::findFirst(array(
            "page_no = :page_no: ",
            'bind' => array('page_no' => $page_no)
        ));        
    }
    public function get_page_exists($page_no,$page_id){
        return  Page::findFirst(array(
            "page_no = :page_no:  and page_id <> :page_id:",
            'bind' => array('page_no' => $page_no,'page_id'=>$page_id)
        ));        
    }
    public function _insert($param){
        //$this->page_id = $param['page_id'];
        $this->page_no = $param['page_no'];
        $this->page_name = $param['page_name'];
        $this->content = $param['content'];
       // $this->img_path = $param['img_path'];
       // $this->add_date = $param['add_date'];
        $this->add_user = $param['user_id'];
        //$this->upd_date = $param[''];
        $this->upd_user = $param['user_id'];
        $this->disp_home = 0;
        $this->del_flg = 0;
        $this->save();
        return $this->page_id;
    }
    public function _update($param){            
        $sql = "update page
                    set page_no = :page_no,
                      page_name = :page_name,
                      content = :content,                    
                      upd_date = now(),
                      upd_user = :user_id,                   
                      del_flg = :del_flg,
                      disp_home= :disp_home
                     
                    where page_id = :page_id
                ";
        
        $sql_par = PHOArray::filter($param, array(
                    'page_id',
                    'page_no',
                      'page_name',
                      'content',                      
                      'user_id',                     
                      'del_flg',
                      'content',                     
                      'disp_home'
                    ));
        $this->pho_execute($sql,$sql_par ); 
        return TRUE;    
    }
}
