<?php

namespace Multiple\Models;
use Multiple\Models\DBModel;

class Ward extends DBModel
{
    public $m_ward_id;
    public $m_ward_name;
  	public $m_district_id;

    public function initialize()
    {
        $this->setSource("m_ward");
    }
    public function get_all(){
        return Ward::find();
    }
    public function get_byparent($m_district_id){
        $sql ="select m_ward_id,m_ward_name from m_ward where m_district_id=:m_district_id";
        return $this->pho_query($sql,array('m_district_id'=>$m_district_id));
    }
    public function get_rows(){
        $sql ="select m_ward_id,m_ward_name,m_district_id from m_ward ";
        return $this->pho_query($sql);
    }
    public function get_rows_bypro($provin_id){
        $sql ="select m.m_ward_id,m.m_ward_name,m.m_district_id 
				from m_ward m
				INNER JOIN m_district d on d.m_district_id = m.m_district_id and d.m_provin_id = $provin_id";
        return $this->pho_query($sql);
    }
}
