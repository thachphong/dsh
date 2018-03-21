<?php

namespace Multiple\Models;
use Multiple\Models\DBModel;

class Bank extends DBModel
{
    public $bank_id;
    public $bank_no;
  	public $bank_name;
    public function initialize()
    {
        $this->setSource("m_bank");
    }
    public function get_all(){
        return Bank::find();
    }
}
