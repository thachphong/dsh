<?php

namespace Multiple\Models;
use Multiple\Models\DBModel;
use Multiple\PHOClass\PHOArray;
class Define extends DBModel
{
    public $define_id;
    public $define_key;
    public $define_name;
    public $define_val;
    public $upd_date;
    public $upd_user;
  	public $sort;
  	public $group_flg;
    public function initialize()
    {
        $this->setSource("define");
    }
    public function get_all(){
         return Define::find();
    }
    public function get_info($define_key){        
		return Define::findFirst(array(
                "define_key = :define_key: ",
                'bind' => array('define_key' => $define_key)
        ));
	}
	public function _insert($param){		
	    $this->define_key =$param['define_key'];
	    $this->define_name =$param['define_name'];
	    $this->define_val =$param['define_val'];	    
	    $this->upd_user =$param['define_key'];
	  	$this->sort =$param['sort'];
	  	$this->group_flg =$param['group_flg'];
	  	return $this->save();
	}
	public function _update($param)
	{	
		$sql = "update define
					set define_val = :define_val,					  				 
					  upd_date = now(),
					  upd_user = :user_id	
					where define_id = :define_id
				";
		
 		$sql_par = PHOArray::filter($param, array(
 					'define_id',
					'define_val',					  					  
					  'user_id',
					));			
		return $this->pho_execute($sql,$sql_par );		
	}
	public function get_define($def_key){
		
		$sql ="select * from define where define_key = :define_key  order by sort";
		$res = $this->query_first($sql,array('define_key'=>$def_key));
		if(count($res) > 0){
			return $res;
		}
		return NULL;
	}
	public function get_define_by_group($group_flg){
		// $data = Define::query()
  //               ->where("group_flg = :group_flg:")
  //               ->bind(array("group_flg" => $group_flg))
  //               ->order("sort")
  //               ->execute();
        $data =  Define::find(array(
                "group_flg = :group_flg: ",
                'order'=>'sort',
                'bind' => array('group_flg' => $group_flg)
        ));
        return $data;
	}
	public function get_define_all(){
		$sql ="select define_key,define_val from define ";
		$res = $this->pho_query($sql);		
		return $res;		
	}
	public function get_list_bygroup_all($group_flg){
		$sql ="select define_key,define_val from define where group_flg = :group_flg";
		$res = $this->pho_query($sql,array('group_flg'=>$group_flg));		
		return $res;		
	}
}
