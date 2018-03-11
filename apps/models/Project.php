<?php

namespace Multiple\Models;

use Multiple\Models\DBModel;
use Multiple\PHOClass\PHOArray;

class Project extends DBModel
{
      public $pubproject_id;
	  public $project_name;
	  public $project_no;
	  public $ctg_id;
	  public $boss_name;
	  public $address;
	  public $acreage;
	  public $address_ascii;
	  public $percent;
	  public $m_provin_id;
	  public $m_district_id;
	  public $m_ward_id;
	  public $m_street_id;
	  public $map_lat;
	  public $map_lng;
	  public $content;
	  public $des;
	  public $add_date;
	  public $add_user;
	  public $upd_date;
	  public $upd_user;
 	  public $del_flg;
 	  public $img_path;

    public function initialize()
    {
        $this->setSource("project");
    }
    public function get_list_all(){
        $sql="select n.project_id,
				  n.project_name,
				  n.address,
				  n.acreage,
				  n.m_provin_id,
				  n.m_district_id,
				  n.m_ward_id,
				  n.m_street_id,	
				  n.del_flg,			  
				  c.ctg_name
              from project n
                left JOIN category c on c.ctg_id = n.ctg_id    ";
        return $this->pho_query($sql);
    }
    public function get_info($project_id){
        $sql=" select n.project_id,
					  n.project_name,
					  n.project_no,
					  n.ctg_id,
					  n.boss_name,
					  n.address,
					  (trim(n.acreage)+0) acreage,
					  n.address_ascii,					  
					  (trim(n.percent)+0) percent,
					  n.m_provin_id,
					  n.m_district_id,
					  n.m_ward_id,
					  n.m_street_id,
					  n.map_lat,
					  n.map_lng,
					  n.content,
					  n.des,
					  n.scale,					  
					  n.img_path,
					  n.del_flg,
					  n.add_date,
                    c.ctg_name
              from project n
                left JOIN category c on c.ctg_id = n.ctg_id
               where n.project_id = :project_id";
        $res = $this->pho_query($sql ,array('project_id'=>$project_id));
        if(count($res)> 0){
            return $res[0];
        }
        return null;
    }
  
  public function _insert($param){
    $this->project_name = $param['project_name'];
    $this->project_no= $param['project_no'];
    $this->content= $param['content'];
    $this->ctg_id= $param['ctg_id'];
    $this->des= $param['des'];
    $this->img_path= $param['img_path'];    
    $this->add_user= $param['user_id'];    
    $this->upd_user= $param['user_id'];
    $this->del_flg=  $param['del_flg'];
    
    $this->boss_name=  $param['boss_name'];
    $this->address=  $param['address'];    
    $this->address_ascii=  $param['address_ascii'];
   
    $this->m_provin_id=  $param['m_provin_id'];
    
    $this->map_lat=  $param['map_lat'];
    $this->map_lng=  $param['map_lng'];
    if(strlen($param['m_district_id'])>0){
		$this->m_district_id    = $param['m_district_id'];
	}
	if(strlen($param['m_ward_id'])>0){
		$this->m_ward_id    = $param['m_ward_id'];
	}
	if(strlen($param['m_street_id'])>0){
		$this->m_street_id   = $param['m_street_id'];
	}
	if(strlen($param['percent'])>0){
		$this->percent   = $param['percent'];
	}
	if(strlen($param['acreage'])>0){
		$this->acreage   = $param['acreage'];
	}
    
    
    $this->save();
    return $this->project_id;    
  }
  public function _update($param){

    //$login_info = ACWSession::get('user_info');
    //$param['user_id'] = $login_info['user_id'];   
    $sql = "update project
          set project_name=:project_name,
		  project_no=:project_no,
		  ctg_id=:ctg_id,
		  boss_name=:boss_name,
		  address=:address,
		  acreage=:acreage,
		  address_ascii=:address_ascii,
		  percent=:percent,
		  m_provin_id=:m_provin_id,
		  m_district_id=:m_district_id,
		  m_ward_id=:m_ward_id,
		  m_street_id=:m_street_id,
		  map_lat=:map_lat,
		  map_lng=:map_lng,
		  content=:content,
		  des=:des,
		  scale=:scale,
		  img_path=:img_path,
		  upd_date= now(),
		  upd_user=:upd_user,
		  del_flg=:del_flg 
          where project_id = :project_id
        ";
    
    $sql_par = PHOArray::filter($param, array(
          'project_id',
          'project_name',
		  'project_no',
		  'ctg_id',
		  'boss_name',
		  'address',
		  'acreage',
		  'address_ascii',
		  'percent',
		  'm_provin_id',
		  'm_district_id',
		  'm_ward_id',
		  'm_street_id',
		  'map_lat',
		  'map_lng',
		  'content',
		  'des',
		  'scale',
		  'img_path',	
		  'upd_user',
		  'del_flg'          
          ));
    	if(strlen($sql_par['percent'])==0){
			$sql_par['percent'] =NULL;
		}
		if(strlen($sql_par['acreage'])==0){
			$sql_par['acreage'] =NULL;
		}
		if(strlen($sql_par['m_street_id'])==0){
			$sql_par['m_street_id'] =NULL;
		}
		if(strlen($sql_par['m_ward_id'])==0){
			$sql_par['m_ward_id'] =NULL;
		}
		
    return $this->pho_execute($sql,$sql_par );     
  }
  public function get_project($project_id){
    return  Project::findFirst(array(
         "project_id = :project_id: ",
         'bind' => array('project_id' => $project_id)
    ));
  }
  public function get_news_byno($news_no){        
    return  News::findFirst(array(
                "news_no = :news_no: ",
                'bind' => array('news_no' => $news_no)
    ));
  }    
  public function get_news_exist($news_no,$news_id){        
        return  News::findFirst(array(
                "news_no = :news_no: and news_id <> :news_id:",
                'bind' => array('news_no' => $news_no,'news_id'=>$news_id)
        ));
  } 
  public function get_project_rows($limit=10){
        $sql="select n.project_id,
				  n.project_name,
				  n.project_no,
				  n.address,
				  n.acreage,
				  n.m_provin_id,
				  n.m_district_id,
				  n.m_ward_id,
				  n.img_path	,
				  n.add_date
				  
              from project n
              where del_flg=0               
              order by n.project_id desc
              limit $limit";
        return $this->pho_query($sql);
  }
 
  public function get_project_relation($project_id,$limit =6){
	    $sql="select n.project_id,
					  n.project_name,
					  n.project_no,				 		 
					  n.img_path	
					  
	              from project n
	              where del_flg=0  
	              and project_id <> :project_id             
	              order by n.project_id desc
	              limit $limit"; 
	    return $this->pho_query($sql ,array('project_id'=>$project_id)); 
  }
  public function update_traffic($param){
		$sql="select update_traffic_news(:news_id,:section_id,:time,:ip)";
		return $this->pho_execute($sql,$param);
  }
  public function get_project_all(){
  	  $sql="select news_id,news_name,news_no from news where ctg_id = 5 and del_flg =0";
  	  return $this->pho_query($sql);
  }
  public function get_project_byctgno($ctg_no,$start_row = 0){
    $limit =PAGE_NEWS_LIMIT_RECORD;
    $sql="select project_id, project_no,project_name,des,img_path 
				from project  where del_flg =0
        and ctg_id in (select ctg_id from category 
          where ctg_no = :ctg_no
          union all
          select ctg_id from category 
          where parent_id =(select ctg_id from category where ctg_no = :ctg_no)
        )
        order by project_id desc
        limit $limit
        OFFSET $start_row
        ";
    return $this->pho_query($sql,array('ctg_no'=>$ctg_no));
  }
  public function get_project_byctgno_count($ctg_no){
   // $limit =PAGE_NEWS_LIMIT_RECORD;
    $sql="select count(project_id) cnt
				from project  where del_flg =0
	        and ctg_id in (select ctg_id from category 
	          where ctg_no = :ctg_no
	          union all
	          select ctg_id from category 
	          where parent_id =(select ctg_id from category where ctg_no = :ctg_no)
	        )  
        ";
    $res = $this->query_first($sql,array('ctg_no'=>$ctg_no));
    return $res['cnt'];
  }
}
