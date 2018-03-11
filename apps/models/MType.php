<?php

namespace Multiple\Models;
use Multiple\Models\DBModel;

class MType extends DBModel
{
    public $m_type_id;
    public $m_type_name;
  
    public function initialize()
    {
        $this->setSource("m_type");
    }
    public function get_all(){
         return MType::find();
    }
}
