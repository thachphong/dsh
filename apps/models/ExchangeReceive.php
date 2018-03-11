<?php

namespace Multiple\Models;

use Multiple\Models\DBModel;
use Multiple\PHOClass\PHOArray;

class ExchangeReceive extends DBModel
{
    public $exchange_receive_id;
    public $data;
    public $signature;
    public $amount;
    public $message;
    public $payment_type;
    public $reference_number;
    public $status;
    public $trans_ref_no;
    public $website_id;
    public $add_user;
    public function initialize()
    {
        $this->setSource("exchange_receive");
    }        
    public function _insert($param){
		$this->data=$param['data'];
		$this->signature=$param['signature'];
		$this->amount=$param['amount'];
		$this->message=$param['message'];
		$this->payment_type=$param['payment_type'];
		$this->reference_number=$param['reference_number'];
		$this->website_id=$param['website_id'];
		$this->status=$param['status'];
		$this->trans_ref_no=$param['trans_ref_no'];
		$this->add_user =$param['user_id'];
		return $this->save();
	}
	public function get_name($status_id){
		$sql="select desc from m_name where status = :status ";
		$res = $this->query_first($sql,array('status'=>$status_id));
		if(count($res)> 0){
			return $res['desc'];
		}
		return "Nguyên nhân không xác định";
	}
	public function update_amount_user($user_id,$amount){
		$sql ="update user set amount = amount+ :amount where user_id = :user_id";
		return $this->pho_execute($sql,array('amount'=>$amount,'user_id'=>$user_id));
	}
	
}
