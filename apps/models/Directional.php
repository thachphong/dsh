<?php

namespace Multiple\Models;
use Multiple\Models\DBModel;

class Directional extends DBModel
{
    public $m_directional_id;
    public $m_directional_name;
  
    public function initialize()
    {
        $this->setSource("m_directional");
    }
    public function get_all(){
        return Directional::find();
    }
}
