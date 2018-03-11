<?php

namespace Multiple\Models;
use Multiple\Models\DBModel;
use Multiple\PHOClass\PhoLog;
class Orders extends DBModel
{
    public $ord_id;
    public $user_id;
    public $ord_date;
    public $total_amount;
    public $full_name;
    public $email;
    public $phone;
    public $address;
    public $note;
    public $company;
    public $payment_method;
    public $address_ship;
    public $ship_amount;
  
    public function initialize()
    {
        $this->setSource("orders");
    }
    public function get_all(){
         return Orders::find();
    }
    public function get_products($cart){
		$listid = array_keys($cart);
		
		$sql ="select p.pro_id,p.pro_no,p.pro_name,t.price_seller,t.price_exp,t.size,t.pro_price_id,im.img_path
				from product p
				INNER JOIN product_price t on t.pro_id = p.pro_id
				INNER JOIN product_img im on im.pro_id = p.pro_id and im.avata_flg = 1
				where t.pro_price_id in (".implode(',',$listid).")";
		//PhoLog::debug_var('sql--',$cart);
		//PhoLog::debug_var('sql--',$sql);
		return $this->pho_query($sql);
	}
	public function _insert($param){
		$this->full_name = $param['fullname'];
		$this->email = $param['fullname'];
		$this->phone = $param['fullname'];
		$this->address = $param['address'];
		$this->ord_date = date("Y-m-d H:i:s");
		$this->ship_amount = $param['ship_amount'];
		
		$this->save();
		return $this->ord_id;		
	}
	public function get_info($ord_id){
		$sql="select *,DATE_FORMAT(ord_date,'%d/%m/%Y') add_datetime from orders where ord_id = $ord_id";
		PhoLog::debug_var('sql--',$sql);
		return $this->query_first($sql);
	}
}