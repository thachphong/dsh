<?php

namespace Multiple\Models;

use Multiple\Models\DBModel;
use Multiple\PHOClass\PHOArray;

class Exchange extends DBModel
{    
    public $exchange_id;
	public $amount;
	public $bill_to_address;
	public $bill_to_address_city;
	public $bill_to_email;
	public $bill_to_forename;
	public $bill_to_phone;
	public $bill_to_surname;
	public $currency;
	public $language;
	public $payment_type;
	public $receiver_account;
	public $reference_number;
	public $transaction_type;
	public $url_return;
	public $website_id;
	public $signature;
	public $add_user;
	public $add_date;
    public function initialize()
    {
        $this->setSource("exchange");
    }        
   	
	public function _insert($param){		
	    $this->amount = $param['amount'];
	    $this->currency = $param['currency'];
	    $this->receiver_account = $param['receiver_account'];	     
	    //$this->reference_number = $param['reference_number'];	  
	    $this->website_id = $param['website_id'];
	    //$this->signature = $param['signature'];
	    $this->add_user = $param['add_user'];
	    $this->save();
	    return $this->exchange_id;
	}
	
}
