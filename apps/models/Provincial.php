<?php

namespace Multiple\Models;
use Multiple\Models\DBModel;

class Provincial extends DBModel
{
    public $m_provin_id;
    public $m_provin_name;
  
    public function initialize()
    {
        $this->setSource("m_provincial");
    }
    public static function get_all(){
         //return Provincial::query()->order("m_provin_name")->execute();
         return Provincial::find(['order'=>'sort']);   
    }
    
    public function get_post_count($limit=6)
    {
		$sql="select p.m_provin_name,p.m_provin_id,count(t.post_id) cnt from posts t
				inner join m_provincial p on p.m_provin_id = t.m_provin_id
				where t.status = 1
				group by p.m_provin_name,p.m_provin_id
				ORDER BY cnt desc
				limit $limit";
		return $this->pho_query($sql);
	}
}
