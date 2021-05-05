<?php

namespace Multiple\Models;
use Multiple\Models\DBModel;
use Multiple\PHOClass\PhoLog;
class Orders extends DBModel
{
    public $ord_id;
    public $ord_user_id;
    public $ord_date;
    public $total_amount;
    public $full_name;
    public $email;
    public $phone;
    public $address;
    public $note;
    public $status;
    public $payment_method;
    public $address_ship;
    public $ship_amount;
  	public $total_discount;
  	public $upd_date;
  	public $upd_user_id;
  	public $provin_id;
  	public $district_id;
  	public $ward_id;
    public function initialize()
    {
        $this->setSource("orders");
    }
    public function get_all(){
         return Orders::find();
    }
    public function get_products($cart){
		$listkey = array_keys($cart);
		$listid = array();
		foreach($listkey as $item){
			$exp = explode('_',$item);
			$listid[]=$exp[0];
		}
		$sql ="select p.pro_id,p.pro_no,p.pro_name,t.price_seller,t.price_exp,t.pro_price_id,im.img_path
				from product p
				INNER JOIN product_price t on t.pro_id = p.pro_id
				INNER JOIN product_img im on im.pro_id = p.pro_id and im.avata_flg = 1
				where t.pro_price_id in (".implode(',',$listid).")";
		//PhoLog::debug_var('sql--',$cart);
		//PhoLog::debug_var('sql--',$sql);
		$res = $this->pho_query($sql);
		$result = array();
		foreach($res as $item){
			$result[$item['pro_price_id']]=$item;
		}
		return $result;
	}
	public function _insert($param){
		$this->full_name = $param['fullname'];
		$this->email = $param['email'];
		$this->phone = $param['phone'];
		$this->address = $param['address'];
		$this->ord_date = date("Y-m-d H:i:s");
		$this->ship_amount = $param['ship_amount'];
		$this->total_amount = $param['total_amount'];
		$this->total_discount = $param['total_discount'];
		$this->ord_user_id = $param['user_id'];
		$this->discount_flg = $param['discount_flg'];
		$this->payment_method = $param['payment_method'];
		$this->provin_id = $param['provin_id'];
		$this->district_id = $param['district_id'];
		$this->ward_id = $param['ward_id'];
		$this->status = 0;
		$this->save();
		return $this->ord_id;		
	}
	public function update_status($order_id,$status,$user_id){
		$sql="update orders set status =:status, upd_date=now(),upd_user_id=:user_id where ord_id = :ord_id";
		return $this->pho_execute($sql,array('status'=>$status,'ord_id'=>$order_id,'user_id'=>$user_id));
	}
	public function get_info($ord_id){
		$sql="select ord_id,
			  ord_user_id,
			  DATE_FORMAT(ord_date,'%d/%m/%Y') ord_date,
			  total_amount,
			  full_name,
			  email,
			  phone,
			  address,
			  note,
			  status,
			  payment_method,
			  upd_date,
			  ship_amount,
			  total_discount,
			  discount_flg,
			  n.disp_val status_name ,
				p.m_provin_name provin_name,
				d.m_district_name district_name,
				w.m_ward_name ward_name
			from orders m
			LEFT JOIN m_name n on n.def_key = m.status and n.def_name ='ORDER_STATUS'
			LEFT JOIN m_provincial p on p.m_provin_id = m.provin_id
			LEFT JOIN m_district d on d.m_district_id = m.district_id
			LEFT JOIN m_ward w on w.m_ward_id = m.ward_id
			where ord_id = $ord_id";
		//PhoLog::debug_var('sql--',$sql);
		return $this->query_first($sql);
	}
	public function get_list_byuser($param,$start_row =0){
		$sql="select DATE_FORMAT(ord_date,'%d/%m/%Y') ord_date,total_amount,m.total_discount,ord_id,status
				,n.disp_val status_name
				,m.discount_flg
			from orders m			
			LEFT JOIN m_name n on n.def_key = m.status and n.def_name ='ORDER_STATUS'
			where m.ord_user_id = :user_id";
		$search['user_id']=$param['user_id'];
		if(isset($param['orders_id']) && strlen($param['orders_id'])>0){
				$sql .=" and m.ord_id = :ord_id ";
				$search['ord_id'] = $param['orders_id'];
		}else{
			if(isset($param['fdate']) && strlen($param['fdate'])>0 && isset($param['tdate']) && strlen($param['tdate'])>0){
				$sql .=" and m.ord_date between STR_TO_DATE(:fdate,'%d/%m/%Y') and STR_TO_DATE(:tdate,'%d/%m/%Y %H:%i:%s')";
				$search['fdate'] = $param['fdate'];
				$search['tdate'] = $param['tdate'] .' 23:59:59';
			}elseif(isset($param['fdate']) && strlen($param['fdate'])>0){
					$sql .=" and m.ord_date >= STR_TO_DATE(:fdate,'%d/%m/%Y') ";
					$search['fdate'] = $param['fdate'];
			}elseif(isset($param['tdate']) && strlen($param['tdate'])>0){
					$sql .=" and m.ord_date <= STR_TO_DATE(:tdate,'%d/%m/%Y %H:%i:%s') ";
					$search['tdate'] = $param['tdate'] .' 23:59:59';
			}
			
			if(isset($param['status']) && strlen($param['status'])>0){
					$sql .=" and m.status = :status ";
					$search['status'] = $param['status'];
			}
		}
		$sql .=" order by m.ord_id desc limit ".PAGE_SEARCH_LIMIT_RECORD ." OFFSET " .$start_row;
		return $this->pho_query($sql,$search);
	}
	public function get_byuser_count($param){
		$sql="select count(m.ord_id) cnt
			from orders m			
			where m.ord_user_id = :user_id";
		$search['user_id']=$param['user_id'];
		if(isset($param['orders_id']) && strlen($param['orders_id'])>0){
				$sql .=" and m.ord_id = :ord_id ";
				$search['ord_id'] = $param['orders_id'];
		}else{
			if(isset($param['fdate']) && strlen($param['fdate'])>0 && isset($param['tdate']) && strlen($param['tdate'])>0){
				$sql .=" and m.ord_date between STR_TO_DATE(:fdate,'%d/%m/%Y') and STR_TO_DATE(:tdate,'%d/%m/%Y %H:%i:%s')";
				$search['fdate'] = $param['fdate'];
				$search['tdate'] = $param['tdate'] .' 23:59:59';
			}elseif(isset($param['fdate']) && strlen($param['fdate'])>0){
					$sql .=" and m.ord_date >= STR_TO_DATE(:fdate,'%d/%m/%Y') ";
					$search['fdate'] = $param['fdate'];
			}elseif(isset($param['tdate']) && strlen($param['tdate'])>0){
					$sql .=" and m.ord_date <= STR_TO_DATE(:tdate,'%d/%m/%Y %H:%i:%s') ";
					$search['tdate'] = $param['tdate'] .' 23:59:59';
			}
			
			if(isset($param['status']) && strlen($param['status'])>0){
					$sql .=" and m.status = :status ";
					$search['status'] = $param['status'];
			}
		}

		$res = $this->query_first($sql,$search);
		if(count($res) > 0){
			return $res['cnt'];			
		}
		return 0;
	}
	public function get_total_info(){
		$sql ="select 
				(SELECT count(*) from orders where status= 0) cnt_new
				,(SELECT count(*) from orders where status= 1) cnt_shipping";
		return  $this->query_first($sql);
	}
}
