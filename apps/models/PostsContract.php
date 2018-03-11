<?php

namespace Multiple\Models;
use Multiple\Models\DBModel;
use Multiple\PHOClass\PHOArray;
class PostsContract extends DBModel
{
    public $post_contract_id;
    public $post_id;
    public $full_name;
    public $address;
    public $phone;
    public $mobie;
    public $email;  
  
    public function initialize()
    {
        $this->setSource("posts_contract");
    }
    public function get_all(){
         return PostsContract::find();
    }
    public function _insert($param){

        $this->post_id =$param['post_id'];
        $this->full_name =$param['full_name'];
        $this->address =$param['address'];
        $this->phone =$param['phone'];
        $this->mobie =$param['mobie'];
        $this->email =$param['email'];
        return $this->save();
    }
    public function _update($param){
        $sql = "update posts_contract
                    set full_name = :full_name,
                    address = :address,
                    phone = :phone, 
                    mobie =:mobie,  
                    email = :email
                where post_contract_id =:post_contract_id
                ";
        $this->pho_execute($sql, PHOArray::filter($param, array(
                    'full_name'
                    ,'address' 
                    ,'phone'
                    ,'mobie'
                    ,'email'
                    ,'post_contract_id'                   
                    )));  
        return TRUE;
    }
}
