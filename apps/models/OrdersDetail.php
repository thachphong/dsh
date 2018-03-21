<?php

namespace Multiple\Models;
use Multiple\Models\DBModel;
use Multiple\PHOClass\PhoLog;
class OrdersDetail extends DBModel
{
	public $de_ord_id;
    public $ord_id;    
    public $pro_id;
    public $price;
    public $qty;
    public $total;
    public $size;
    public $color;
    public $discount;
  
    public function initialize()
    {
        $this->setSource("orders_detail");
    }    
    
	public function insert_multi($ord_id,$cart){
		foreach($cart as $item){
			$db = new OrdersDetail();
			$db->ord_id = $ord_id;
			$db->pro_id = $item['pro_id'];
			$db->price = $item['price_exp'];
			$db->qty = $item['qty'];
			$db->total = $item['amount'];
			$db->size = $item['size'];
			$db->color = $item['color'];
			$db->discount = $item['chietkhau'];
			$db->save();
		}
		return TRUE;
	}
	public function get_list($ord_id){
		$sql="select d.*,p.pro_name,p.pro_no from 
				orders_detail d
				INNER JOIN product p
					on p.pro_id = d.pro_id
				where d.ord_id  = $ord_id";
		return $this->pho_query($sql);
	}
}
