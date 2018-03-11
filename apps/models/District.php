<?php

namespace Multiple\Models;
use Multiple\Models\DBModel;

class District extends DBModel
{
    public $m_district_id;
    public $m_district_name;
  	public $m_provin_id;
    public function initialize()
    {
        $this->setSource("m_district");
    }
    public function get_all(){
         return District::find();
    }
    public function get_rows(){
        $sql ="select m_district_id,m_district_name,m_provin_id from m_district ";
        return $this->pho_query($sql);
    }
    public function get_byparent($m_provin_id){
        $sql ="select m_district_id,m_district_name from m_district where m_provin_id = :m_provin_id";
        return $this->pho_query($sql,array('m_provin_id'=>$m_provin_id));
    }
}
