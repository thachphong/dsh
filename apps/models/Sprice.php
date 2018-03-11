<?php

namespace Multiple\Models;
use Multiple\Models\DBModel;

class Sprice extends DBModel
{
    public $s_price_id;
    public $s_price_name;
    public $m_type_id;
  
    public function initialize()
    {
        $this->setSource("s_price");
    }
    public function get_all(){
         return Sprice::find();
    }
}
