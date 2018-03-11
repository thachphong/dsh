<?php

namespace Multiple\Models;
use Multiple\Models\DBModel;

class Unit extends DBModel
{
    public $m_unit_id;
    public $m_unit_name;
  
    public function initialize()
    {
        $this->setSource("m_unit");
    }
    public function get_all(){
         return MType::find();
    }
}
