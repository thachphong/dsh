<?php

namespace Multiple\Models;
use Multiple\Models\DBModel;
use Multiple\PHOClass\PhoLog;
class Street extends DBModel
{
    public $m_street_id;
    public $m_street_name;
  	public $m_district_id;

    public function initialize()
    {
        $this->setSource("m_street");
    }
    public function get_all(){
        $sql="select p.m_provin_name,d.m_district_name,s.m_street_id,s.m_street_name from m_street s
		INNER JOIN m_district d on d.m_district_id= s.m_district_id
		INNER JOIN m_provincial p on p.m_provin_id = d.m_provin_id
		";
		return $this->pho_query($sql);
    }
    public function get_list($m_district_id){
        $sql="select s.m_street_id,s.m_street_name from m_street s
		where m_district_id =:m_district_id
		";
		return $this->pho_query($sql,array('m_district_id'=>$m_district_id));
    }
    public function get_info($m_street_id){
        $sql="select d.m_provin_id,d.m_district_id,s.m_street_id,s.m_street_name from m_street s
		INNER JOIN m_district d on d.m_district_id= s.m_district_id		
		where m_street_id=:m_street_id
		";
		return $this->query_first($sql,array('m_street_id'=>$m_street_id));
    }
    public function get_bydistrict($m_district_id){
        $sql ="select m_street_id,m_street_name,m_ward_id from m_street where m_district_id=:m_district_id";
        return $this->pho_query($sql,array('m_district_id'=>$m_district_id));
    }
    public function _insert($param){
		$this->m_street_name = $param['street_name'];
		$this->m_district_id = $param['m_district_id'];
		$this->save();
	}
    public function _update($param){
		$sql="update m_street set m_street_name=:m_street_name 
				, m_district_id = :m_district_id 
				where m_street_id=:m_street_id";
		PhoLog::debug_var('--test--',$param);
		$this->pho_execute($sql,array(
					'm_street_name'=>$param['street_name']
					,'m_district_id'=>$param['m_district_id']
					,'m_street_id'=>$param['m_street_id']
				));		
	}
	public function check_exist($param){
		$sql="select m_street_id from  m_street where m_street_name=:m_street_name 
				and m_district_id = :m_district_id ";
		$res = $this->query_first($sql,array('m_street_name'=>$param['street_name']
					,'m_district_id'=>$param['m_district_id']));
		//PhoLog::debug_var('--test--',$res);
		if(isset($res['m_street_id'])){
			if(strlen($param['m_street_id']) >0 && $param['m_street_id'] ==$res['m_street_id'] ){
				return FALSE;
			}
			
			return TRUE;			
		}
		return FALSE;
	}
	public function search($param,$start_row,$limit){
        $sql="select p.m_provin_name,d.m_district_name,s.m_street_id,s.m_street_name from m_street s
		INNER JOIN m_district d on d.m_district_id= s.m_district_id
		INNER JOIN m_provincial p on p.m_provin_id = d.m_provin_id
		";
		$where="where 1=1";
		$search =array();
		if(isset($param['m_provin_id']) && strlen($param['m_provin_id']) >0){
			$where .=" and d.m_provin_id=:m_provin_id";
			$search['m_provin_id']= $param['m_provin_id'];
		}
		if(isset($param['m_district_id']) && strlen($param['m_district_id']) >0){
			$where .=" and d.m_district_id = :m_district_id";
			$search['m_district_id']= $param['m_district_id'];
		}
		$sql .= $where.
		" limit $limit OFFSET $start_row";
		PhoLog::debug_var('--test1--',$sql);
		PhoLog::debug_var('--test1--',$search);
		return $this->pho_query($sql,$search);
    }
    public function search_count($param){
        $sql="select count(s.m_street_id) cnt
        from m_street s
		INNER JOIN m_district d on d.m_district_id= s.m_district_id		
		";
		$where="where 1=1";
		$search =array();
		if(isset($param['m_provin_id']) && strlen($param['m_provin_id']) >0){
			$where .=" and d.m_provin_id=:m_provin_id";
			$search['m_provin_id']= $param['m_provin_id'];
		}
		if(isset($param['m_district_id']) && strlen($param['m_district_id']) >0){
			$where .=" and d.m_district_id = :m_district_id";
			$search['m_district_id']= $param['m_district_id'];
		}
		$sql .= $where;
		PhoLog::debug_var('--test1--',$sql);
		PhoLog::debug_var('--test1--',$search);
		$res = $this->query_first($sql,$search);
		return $res['cnt'];
    }
}
