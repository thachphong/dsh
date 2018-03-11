<?php

namespace Multiple\Models;

use Multiple\Models\TagsPosts;
use Multiple\Models\DBModel;
use Multiple\PHOClass\PHOArray;
use Multiple\PHOClass\PhoLog;
class Posts extends DBModel
{
    public  $post_id ;
    public  $post_no ;
    public  $post_name   ;
    public  $ctg_id  ;
    public  $m_type_id   ;
    public  $status  ;
    public  $m_provin_id ;
    public  $m_district_id   ;
    public  $m_ward_id   ;
    public  $m_street_id;
    public  $price   ;
    public  $unit_price  ;
    public  $acreage ;
    public  $address ;
    public  $address_ascii ;
    public  $content ;
    public  $add_date    ;
    public  $add_user    ;
    public  $upd_date    ;
    public  $upd_user    ;
    public  $del_flg ;
    public  $toilet_num  ;
    public  $room_num    ;
    public  $floor_num   ;
    public  $street_width    ;
    public  $facade_width    ;
    public  $m_directional_id    ;
    public  $map_lat;
    public  $map_lng;
    public 	$total_view;
    public  $project_id;
    public  $furniture;
    public  $youtube_url;
    public  $youtube_key;
    public $huong_bancong;
    public function initialize()
    {
        $this->setSource("posts");
    }
    
    public function get_by_id($id){
	 	return Posts::findFirst(array("post_id = :post_id:  ",'bind' => array('post_id' => $id) ));
	}
	public function get_info($id){
		$sql="select p.post_id,p.post_name,p.post_no, v.post_level,v.total_day post_date_num ,post_view_id
				from posts p
				INNER JOIN posts_view v on v.post_id = p.post_id
				where p.post_id = :post_id
				and v.hide_flg = 0
				ORDER BY post_view_id DESC
				limit 1";
		return $this->query_first($sql,array('post_id'=>$id));
	}
	public function get_post_row($id){
		$sql = "select p.post_id,p.post_name,p.post_no,
				  p.ctg_id,
				  p.m_type_id,
				  p.status,
				  p.m_provin_id,
				  p.m_district_id,
				  p.m_ward_id,
				  (trim(p.price)+0) price,
				  p.unit_price,
				  (trim(p.acreage)+0) acreage,
				  p.address,
				  p.content,  
				  p.del_flg,
				  p.toilet_num,
				  p.room_num,
				  p.floor_num,
				  p.street_width,
				  p.facade_width,
				  p.m_directional_id,
				  p.map_lat,
				  p.map_lng,
				  p.furniture,
				  p.youtube_url,
				  p.huong_bancong,
				 v.post_level,				
				 DATE_FORMAT(v.end_date ,'%d/%m/%Y')  end_date,
				 DATE_FORMAT(v.start_date ,'%d/%m/%Y')  start_date,	
				 v.post_view_id,
				c.post_contract_id,		
				c.full_name,
				c.address contract_address,
				c.phone,
				c.mobie,
				c.email
				from posts p
				INNER JOIN posts_view v on v.post_id = p.post_id
				INNER JOIN posts_contract c on c.post_id = p.post_id
				where p.post_id = :post_id
				and v.hide_flg = 0";
		return $this->query_first($sql,array('post_id'=>$id));
	}	
	public function _insert($param){
		//$this->post_id = $param[''];
		//PhoLog::debug_var('update----','param');
		//PhoLog::debug_var('update----',$param);
		try {
	    $this->post_no = $param['post_no'];
	    $this->post_name   = $param['post_name'];
	    $this->ctg_id  = $param['ctg_id'];
	    $this->m_type_id   = $param['m_type_id'];
	    $this->status  = 0;
	    $this->m_provin_id = $param['m_provin_id'];
	    $this->m_district_id   = $param['m_district_id'];   
	    $this->content = $param['content'];
	    $this->address    = $param['address'];
	    $this->address_ascii    = $param['address_ascii'];
	    $this->add_user    = $param['user_id'];	    
	    $this->upd_user    = $param['user_id'];
	    $this->del_flg = 0;
	    
	    if(strlen($param['unit_price'])>0){
			$this->unit_price  = $param['unit_price'];
		}
		if(strlen($param['price'])>0){
			$this->price   = $param['price'];
		}
		if(strlen($param['m_ward_id'])>0){
			$this->m_ward_id   = $param['m_ward_id'];
		}
	    if(strlen($param['m_directional_id'])>0){
			$this->m_directional_id    = $param['m_directional_id'];
		}
	    if(strlen($param['acreage'])>0){
			$this->acreage = $param['acreage'];
		}
	    if(strlen($param['m_street_id'])>0){
			$this->m_street_id  = $param['m_street_id'];
		}
	    if(strlen($param['toilet_num'])>0){
			$this->toilet_num  = $param['toilet_num'];
		}
		if(strlen($param['room_num'])>0){
			$this->room_num    = $param['room_num'];
		}
		if(strlen($param['floor_num'])>0){
			$this->floor_num   = $param['floor_num'];
		}
		if(strlen($param['street_width'])>0){
			$this->street_width    = $param['street_width'];
		}
	    if(strlen($param['facade_width'])>0){
			$this->facade_width    = $param['facade_width'];
		}
	    if(strlen($param['project_id'])>0){
			$this->project_id    = $param['project_id'];
		}
		if(strlen($param['huong_bancong'])>0){
			$this->huong_bancong    = $param['huong_bancong'];
		}
	    
	    $this->map_lat = $param['map_lat'];
	    $this->map_lng = $param['map_lng'];
	    $this->furniture = $param['furniture'];
	    $this->youtube_url = $param['youtube_url'];
	    if(strlen($param['youtube_url'])>0){
			$this->youtube_key    = $this->extract_youtube_key($param['youtube_url']);
		}	   
	    $this->save();
	    } catch (\Exception $e) {
			PhoLog::debug_var('update----',$e);
		}
	    //PhoLog::debug_var('update----','save');
	    return $this->post_id;
	}
	public function _update($param){
		$sql = "update posts
					set post_name = :post_name,
					ctg_id = :ctg_id,
					post_no = :post_no,
					m_provin_id = :m_provin_id,
					m_district_id = :m_district_id,
					m_ward_id = :m_ward_id,
					m_street_id =:m_street_id,
					price = :price,
					unit_price =:unit_price,
					acreage = :acreage,
					content = :content,
					upd_user = :user_id,
					toilet_num = :toilet_num,
					room_num = :room_num,
					floor_num = :floor_num,
					street_width = :street_width,
					facade_width = :facade_width,
					m_directional_id = :m_directional_id,
					address =:address,
					address_ascii =:address_ascii,
					map_lat = :map_lat ,
					map_lng = :map_lng,
					m_type_id =:m_type_id,
					project_id =:project_id,
					furniture =:furniture,
					youtube_url =:youtube_url,
					youtube_key =:youtube_key,
					huong_bancong =:huong_bancong,
					upd_date =now()

				where post_id =:post_id
				";
		$pasql = PHOArray::filter($param, array(
                    'post_id'
                    ,'post_name' 
                    ,'ctg_id'                               
                    ,'post_no'
                    ,'user_id'
                    ,'m_provin_id'
                    ,'m_type_id'
                    ,'m_district_id'
                    ,'m_ward_id'
                    ,'price'
                    ,'unit_price'
                    ,'acreage'
                    ,'content'
                    ,'toilet_num'
                    ,'room_num'
                    ,'floor_num'
                    ,'street_width'
                    ,'m_directional_id'
                    ,'address'
                    ,'address_ascii'
                    ,'facade_width'
                    ,'map_lat'
                    ,'map_lng'
                    ,'project_id'
                    ,'furniture'
                    ,'youtube_url'
                    ,'huong_bancong'
                    ));
		if(strlen($pasql['unit_price'])==0){
			$pasql['unit_price'] =NULL;
		}
		if(strlen($pasql['price'])==0){
			$pasql['price']=NULL;
		}
		if(strlen($pasql['m_ward_id'])==0){
			$pasql['m_ward_id']=NULL;
		}
	    if(strlen($pasql['m_directional_id'])==0){
			$pasql['m_directional_id']=NULL;
		}
	    if(strlen($pasql['acreage'])==0){
			$pasql['acreage']=NULL;
		}
	    if(strlen($pasql['m_street_id'])==0){
			$pasql['m_street_id']=NULL;
		}
	    if(strlen($pasql['toilet_num'])==0){
			$pasql['toilet_num']=NULL;
		}
		if(strlen($pasql['room_num'])==0){
			$pasql['room_num']=NULL;
		}
		if(strlen($pasql['floor_num'])==0){
			$pasql['floor_num']=NULL;
		}
		if(strlen($pasql['street_width'])==0){
			$pasql['street_width']=NULL;
		}
	    if(strlen($pasql['facade_width'])==0){
			$pasql['facade_width']=NULL;
		}
		if(strlen($pasql['project_id'])==0){
			$pasql['project_id']=NULL;
		}
		if(strlen($pasql['huong_bancong'])==0){
			$pasql['huong_bancong']=NULL;
		}
		$pasql['youtube_key'] = $this->extract_youtube_key($param['youtube_url']);
		
		$this->pho_execute($sql, $pasql);  
        return TRUE;
	}
	public function get_list_new($post_type= '',$limit = 10){
		$where ="";
		if($post_type !=''){
			$where =" and v.post_level = $post_type";
		}
		$sql ="select p.post_id,p.post_name,p.post_no,v.post_level,
		(trim(p.price)+0) price,
		(trim(p.acreage)+0) acreage,pro.m_provin_name,dis.m_district_name,
				NULLIF(un.m_unit_name,'') m_unit_name,
				NULLIF(im.img_path,'') img_path,
				DATE_FORMAT(v.start_date ,'%d/%m/%Y')  start_date
				,rd.m_ward_name,p.youtube_key
				from posts p
				INNER JOIN m_provincial pro on pro.m_provin_id = p.m_provin_id
				INNER JOIN m_district dis on dis.m_district_id = p.m_district_id
				INNER JOIN posts_view v on v.post_id = p.post_id
				LEFT JOIN posts_img im on im.post_id = p.post_id and im.avata_flg = 1
				LEFT JOIN m_unit un on un.m_unit_id = p.unit_price 
				LEFT JOIN m_ward rd on rd.m_ward_id = p.m_ward_id
				where p.del_flg = 0
				and p.status =1
				and v.hide_flg = 0
				and v.end_date >= NOW()
				and v.start_date <= now()
				$where
				order by v.post_level DESC, DATE_FORMAT(v.start_date ,'%Y%m%d') DESC,v.post_view_id desc
				limit $limit";
//		PhoLog::debug_var('vip',$sql);
		return $this->pho_query($sql);
	}
	public function get_post_byctgno($ctg_no,$start_row=0){
		$limit = PAGE_LIMIT_RECORD;
		$where ="";
		$param = array();
		if($ctg_no != 'allnew'){
			$where =" and p.ctg_id in (
					select ctg_id from category 
					where del_flg =0
					and ctg_no = :ctg_no
					union all
					select ctg_id from category 
					where parent_id =(select ctg_id from category where del_flg =0  and ctg_no = :ctg_no)
					)	";
			$param['ctg_no'] = $ctg_no;
		}
		$sql="select p.post_id,p.post_name,p.post_no,v.post_level,
				(trim(p.price) +0) price,
				(trim(p.acreage) +0) acreage,
				pro.m_provin_name,dis.m_district_name,
				NULLIF(un.m_unit_name,'') m_unit_name,
				NULLIF(im.img_path,'') img_path,
				DATE_FORMAT(v.start_date ,'%d/%m/%Y')  start_date
				,rd.m_ward_name,p.youtube_key
				from posts p
				INNER JOIN m_provincial pro on pro.m_provin_id = p.m_provin_id
				INNER JOIN m_district dis on dis.m_district_id = p.m_district_id
				INNER JOIN posts_view v on v.post_id = p.post_id
				LEFT JOIN posts_img im on im.post_id = p.post_id and im.avata_flg = 1
				LEFT JOIN m_unit un on un.m_unit_id = p.unit_price 
				LEFT JOIN m_ward rd on rd.m_ward_id = p.m_ward_id
				where p.del_flg = 0
				and p.status =1
				and v.hide_flg = 0
				and v.end_date >= NOW()
				and v.start_date <= now()
				$where			
				order by v.post_level DESC,DATE_FORMAT(v.start_date ,'%Y%m%d') DESC		
				limit $limit
				OFFSET $start_row
				";
		return $this->pho_query($sql,$param);
	}
	public function get_post_byctgno_count($ctg_no){	
		$where ="";
		$param = array();
		if($ctg_no != 'allnew'){
			$where =" and p.ctg_id in (
					select ctg_id from category 
					where del_flg =0
					and ctg_no = :ctg_no
					union all
					select ctg_id from category 
					where parent_id =(select ctg_id from category where del_flg =0  and ctg_no = :ctg_no)
					)	";
			$param['ctg_no'] = $ctg_no;
		}	
		$sql="select count(p.post_id) cnt
				from posts p
				INNER JOIN posts_view v on v.post_id = p.post_id				
				where p.del_flg = 0
				and p.status =1
				and v.hide_flg = 0
				and v.end_date >= NOW()
				and v.start_date <= now()
				$where
				";
		$res = $this->query_first($sql,$param);
		return $res['cnt'];
	}
	public function get_vpost($post_id){
		$sql="select p.post_id,p.post_name,p.post_no,
				  ctg.ctg_name,
					ctg.ctg_id,
					ctg.ctg_no,
				  p.m_type_id,
				  p.status,
				  mp.m_provin_name,
				  md.m_district_name,
				  mw.m_ward_name,
				  (trim(p.price)+0) price,
				  mu.m_unit_name,
				  (trim(p.acreage)+0) acreage,
				  p.address,
				  p.content,  
				  p.del_flg,
				  p.toilet_num,
				  p.room_num,
				  p.floor_num,
				  p.street_width,
				  p.facade_width,
				  p.map_lat,
				  p.map_lng,
				  p.furniture,
				  p.youtube_key,
				  p.m_district_id,
				  p.m_provin_id,				 
				  di.m_directional_name,
				  bc.m_directional_name as huong_bancong,
				 v.post_level,				
				 DATE_FORMAT(v.end_date ,'%d/%m/%Y')  end_date,
				 DATE_FORMAT(v.start_date ,'%d/%m/%Y')  start_date,	
				 v.post_view_id,
				c.post_contract_id,		
				c.full_name,
				c.address contract_address,
				c.phone,
				c.mobie,
				c.email
				from posts p
				INNER JOIN category ctg on ctg.ctg_id = p.ctg_id
				INNER JOIN posts_view v on v.post_id = p.post_id
				INNER JOIN posts_contract c on c.post_id = p.post_id
				INNER JOIN m_provincial mp on mp.m_provin_id = p.m_provin_id
				INNER JOIN m_district md on md.m_district_id = p.m_district_id
				LEFT JOIN m_ward mw on mw.m_ward_id = p.m_ward_id
				LEFT JOIN m_unit mu on mu.m_unit_id = p.unit_price
				LEFT JOIN m_directional di on di.m_directional_id = p.m_directional_id 
				LEFT JOIN m_directional bc on bc.m_directional_id = p.huong_bancong 			
				
				where p.post_id = :post_id 
				and v.hide_flg = 0
				and p.del_flg = 0";
		return $this->query_first($sql,array('post_id'=>$post_id));
	}
	public function search_posts($param,$start_row=0){
		$limit = PAGE_LIMIT_RECORD;
		$where ="";
		$search = array();

		if(isset($param['ctgid']) && strlen($param['ctgid']) > 0){
			$where .=" and p.ctg_id =:ctg_id";	
			$search['ctg_id'] =	$param['ctgid'];			
		}
		if(isset($param['provin']) && strlen($param['provin']) > 0){
			$where .=" and p.m_provin_id =:m_provin_id";	
			$search['m_provin_id'] =	$param['provin'];			
		}
		if(isset($param['district']) && strlen($param['district']) > 0){
			$where .=" and p.m_district_id =:m_district_id";	
			$search['m_district_id'] =	$param['district'];			
		}
		if(isset($param['ward']) && strlen($param['ward']) > 0){
			$where .=" and p.m_ward_id =:m_ward_id";	
			$search['m_ward_id'] =	$param['ward'];			
		}
		if(isset($param['street']) && strlen($param['street']) > 0){
			$where .=" and p.m_street_id =:m_street_id";	
			$search['m_street_id'] =	$param['street'];			
		}
		if(isset($param['roomnum']) && strlen($param['roomnum']) > 0){
			$where .=" and p.room_num  > :room_num";	
			$search['room_num'] =	$param['roomnum'];			
		}
		if(isset($param['directional']) && strlen($param['directional']) > 0){
			$where .=" and p.m_directional_id  = :m_directional_id";	
			$search['m_directional_id'] =	$param['directional'];			
		}
		if(isset($param['address_ascii']) && strlen($param['address_ascii']) > 0){
			$where .=" and p.address_ascii  like :address_ascii";	
			$search['address_ascii'] =	'%'.str_replace(' ','%',$param['address_ascii']).'%';			
		}
		
		if(isset($param['acreage']) && $param['acreage']> 0){
			switch ($param['acreage']) {
			    case 1:  $where .=" and p.acreage <=30";break;
				case 2:  $where .=" and p.acreage between 30 and 50";break;
				case 3:  $where .=" and p.acreage between 50 and 80";break;
				case 4:  $where .=" and p.acreage between 80 and 100";break;
				case 5:  $where .=" and p.acreage between 100 and 150";break;
				case 6:  $where .=" and p.acreage between 150 and 200";break;
				case 7:  $where .=" and p.acreage between 200 and 250";break;
				case 8:  $where .=" and p.acreage between 250 and 300";break;
				case 9:  $where .=" and p.acreage between 300 and 500";break;
				case 10: $where .=" and p.acreage > 500";break;   
			}						
		}
		
		if(isset($param['price']) && $param['price']> 0){
			switch ($param['price']) {
			    case 2:  $where .=" and p.price <=500 and p.unit_price = 2";break;
				case 3:  $where .=" and p.price between 500 and 800 and p.unit_price = 2";break;
				case 4:  $where .=" and p.price between 800 and 1000 and p.unit_price = 2";break;
				case 5:  $where .=" and p.price between 1 and 2 and p.unit_price = 3";break;
				case 6:  $where .=" and p.price between 2 and 3 and p.unit_price = 3";break;
				case 7:  $where .=" and p.price between 5 and 7 and p.unit_price = 3";break;
				case 8:  $where .=" and p.price between 7 and 10 and p.unit_price = 3";break;
				case 9:  $where .=" and p.price between 10 and 20 and p.unit_price = 3";break;
				case 10:  $where .=" and p.price between 20 and 30 and p.unit_price = 3";break;
				case 11:  $where .=" and p.price >30 and p.unit_price = 3";break;
				case 12:  $where .=" and p.price between 1 and 2 and p.unit_price = 3";break;
				//case 13:  $where .=" and p.price between 1 and 2 and p.unit_price = 3";break;
				case 14:  $where .=" and p.price <1000 and p.unit_price = 10";break;
				case 15:  $where .=" and p.price between 1 and 3 and p.unit_price = 10";break;
				case 16:  $where .=" and p.price between 3 and 5 and p.unit_price = 10";break;
				case 17:  $where .=" and p.price between 5 and 10 and p.unit_price = 10";break;
				case 18:  $where .=" and p.price between 10 and 40 and p.unit_price = 10";break;
				case 19:  $where .=" and p.price between 40 and 70 and p.unit_price = 10";break;
				case 20:  $where .=" and p.price between 70 and 100 and p.unit_price = 10";break;
				case 21:  $where .=" and p.price > 100 and p.unit_price = 10";break;

			}						
		}
		
		$sql="select p.post_id,p.post_name,p.post_no,v.post_level,
				(trim(p.price)+0) price,
				(trim(p.acreage)+0) acreage,
				pro.m_provin_name,dis.m_district_name,
				NULLIF(un.m_unit_name,'') m_unit_name,
				NULLIF(im.img_path,'') img_path,
				DATE_FORMAT(v.start_date ,'%d/%m/%Y')  start_date
				,rd.m_ward_name,p.youtube_key
				from posts p
				INNER JOIN m_provincial pro on pro.m_provin_id = p.m_provin_id
				INNER JOIN m_district dis on dis.m_district_id = p.m_district_id
				INNER JOIN posts_view v on v.post_id = p.post_id
				LEFT JOIN posts_img im on im.post_id = p.post_id and im.avata_flg = 1
				LEFT JOIN m_unit un on un.m_unit_id = p.unit_price 
				LEFT JOIN m_ward rd on rd.m_ward_id = p.m_ward_id
				where p.del_flg = 0
				and p.status =1
				and v.hide_flg = 0
				$where			
				order by v.post_level DESC, v.start_date DESC			
				limit $limit
				OFFSET $start_row
				";
		//PhoLog::debug_var('--search----',$param);
		PhoLog::debug_var('--search----',$sql);
		PhoLog::debug_var('--search----',$search);
		return $this->pho_query($sql,$search);
	}
	public function search_posts_count($param){
		$limit = PAGE_LIMIT_RECORD;
		$where ="";
		$search = array();

		if(isset($param['ctgid']) && strlen($param['ctgid']) > 0){
			$where .=" and p.ctg_id =:ctg_id";	
			$search['ctg_id'] =	$param['ctgid'];			
		}
		if(isset($param['provin']) && strlen($param['provin']) > 0){
			$where .=" and p.m_provin_id =:m_provin_id";	
			$search['m_provin_id'] =	$param['provin'];			
		}
		if(isset($param['district']) && strlen($param['district']) > 0){
			$where .=" and p.m_district_id =:m_district_id";	
			$search['m_district_id'] =	$param['district'];			
		}
		if(isset($param['ward']) && strlen($param['ward']) > 0){
			$where .=" and p.m_ward_id =:m_ward_id";	
			$search['m_ward_id'] =	$param['ward'];			
		}
		if(isset($param['street']) && strlen($param['street']) > 0){
			$where .=" and p.m_street_id =:m_street_id";	
			$search['m_street_id'] =	$param['street'];			
		}
		if(isset($param['roomnum']) && strlen($param['roomnum']) > 0){
			$where .=" and p.room_num  > :room_num";	
			$search['room_num'] =	$param['roomnum'];			
		}
		if(isset($param['directional']) && strlen($param['directional']) > 0){
			$where .=" and p.m_directional_id  = :m_directional_id";	
			$search['m_directional_id'] =	$param['directional'];			
		}
		if(isset($param['address_ascii']) && strlen($param['address_ascii']) > 0){
			$where .=" and p.address_ascii  like :address_ascii";	
			$search['address_ascii'] =	'%'.str_replace(' ','%',$param['address_ascii']).'%';						
		}
		
		if(isset($param['acreage']) && $param['acreage']> 0){
			switch ($param['acreage']) {
			    case 1:  $where .=" and p.acreage <=30";break;
				case 2:  $where .=" and p.acreage between 30 and 50";break;
				case 3:  $where .=" and p.acreage between 50 and 80";break;
				case 4:  $where .=" and p.acreage between 80 and 100";break;
				case 5:  $where .=" and p.acreage between 100 and 150";break;
				case 6:  $where .=" and p.acreage between 150 and 200";break;
				case 7:  $where .=" and p.acreage between 200 and 250";break;
				case 8:  $where .=" and p.acreage between 250 and 300";break;
				case 9:  $where .=" and p.acreage between 300 and 500";break;
				case 10: $where .=" and p.acreage > 500";break;   
			}						
		}
		
		if(isset($param['price']) && $param['price']> 0){
			switch ($param['price']) {
			    case 2:  $where .=" and p.price <=500 and p.unit_price = 2";break;
				case 3:  $where .=" and p.price between 500 and 800 and p.unit_price = 2";break;
				case 4:  $where .=" and p.price between 800 and 1000 and p.unit_price = 2";break;
				case 5:  $where .=" and p.price between 1 and 2 and p.unit_price = 3";break;
				case 6:  $where .=" and p.price between 2 and 3 and p.unit_price = 3";break;
				case 7:  $where .=" and p.price between 5 and 7 and p.unit_price = 3";break;
				case 8:  $where .=" and p.price between 7 and 10 and p.unit_price = 3";break;
				case 9:  $where .=" and p.price between 10 and 20 and p.unit_price = 3";break;
				case 10:  $where .=" and p.price between 20 and 30 and p.unit_price = 3";break;
				case 11:  $where .=" and p.price >30 and p.unit_price = 3";break;
				case 12:  $where .=" and p.price between 1 and 2 and p.unit_price = 3";break;
				//case 13:  $where .=" and p.price between 1 and 2 and p.unit_price = 3";break;
				case 14:  $where .=" and p.price <1000 and p.unit_price = 10";break;
				case 15:  $where .=" and p.price between 1 and 3 and p.unit_price = 10";break;
				case 16:  $where .=" and p.price between 3 and 5 and p.unit_price = 10";break;
				case 17:  $where .=" and p.price between 5 and 10 and p.unit_price = 10";break;
				case 18:  $where .=" and p.price between 10 and 40 and p.unit_price = 10";break;
				case 19:  $where .=" and p.price between 40 and 70 and p.unit_price = 10";break;
				case 20:  $where .=" and p.price between 70 and 100 and p.unit_price = 10";break;
				case 21:  $where .=" and p.price > 100 and p.unit_price = 10";break;

			}						
		}
		
		$sql="select count(p.post_id) cnt
				from posts p
				INNER JOIN m_provincial pro on pro.m_provin_id = p.m_provin_id
				INNER JOIN m_district dis on dis.m_district_id = p.m_district_id
				INNER JOIN posts_view v on v.post_id = p.post_id
				LEFT JOIN posts_img im on im.post_id = p.post_id and im.avata_flg = 1
				LEFT JOIN m_unit un on un.m_unit_id = p.unit_price 

				where p.del_flg = 0
				and p.status =1
				and v.hide_flg = 0
				$where	
				";
		//PhoLog::debug_var('--search----',$sql);
		//PhoLog::debug_var('--search----',$search);
		$res = $this->query_first($sql,$search);
		return $res['cnt'];
	}
	public function get_list_byuser($param,$start_row){
		$sql = "select p.post_id,p.post_name,p.post_no,p.price,p.acreage,pro.m_provin_name,dis.m_district_name,
				NULLIF(un.m_unit_name,'') m_unit_name,
				NULLIF(im.img_path,'') img_path,
				DATE_FORMAT(v.start_date ,'%d/%m/%Y')  start_date,
				DATE_FORMAT(v.end_date ,'%d/%m/%Y')  end_date,p.add_user,
				(case p.`status` when 0 THEN 'Chờ duyệt' when 1 THEN 'đã duyệt' when 2 THEN 'Không duyệt' when 3 THEN 'Đã xóa' end) status,(case when v.end_date < now() then '1' else '0' end ) as end_flg
				from posts p
				INNER JOIN m_provincial pro on pro.m_provin_id = p.m_provin_id
				INNER JOIN m_district dis on dis.m_district_id = p.m_district_id
				INNER JOIN posts_view v on v.post_id = p.post_id
				LEFT JOIN posts_img im on im.post_id = p.post_id and im.avata_flg = 1
				LEFT JOIN m_unit un on un.m_unit_id = p.unit_price
				where p.del_flg = 0
				and v.hide_flg = 0
				and p.add_user = :user_id";
		$search['user_id'] = $param['user_id'];
		if(isset($param['postno']) && strlen($param['postno'])>0 ){
			$sql .=" and p.post_id = :postno";
			$search['postno'] = $param['postno'];
		}else{
			if(isset($param['plevel']) && strlen($param['plevel'])>0 ){
				$sql .=" and v.post_level = :post_level";
				$search['post_level'] = $param['plevel'];
			}
			if(isset($param['status']) && strlen($param['status'])>0 ){
				if($param['status'] == '4'){
					$sql .=" and v.end_date < now() ";
				}else{
					$sql .=" and p.status = :status";
					$search['status'] = $param['status'];
				}				
			}
			
			if(isset($param['fdate']) && strlen($param['fdate'])>0 && isset($param['tdate']) && strlen($param['tdate'])>0){
				$sql .=" and v.start_date between STR_TO_DATE(:fdate,'%d/%m/%Y') and STR_TO_DATE(:tdate,'%d/%m/%Y')";
				$search['fdate'] = $param['fdate'];
				$search['tdate'] = $param['tdate'];
			}elseif(isset($param['fdate']) && strlen($param['fdate'])>0){
				$sql .=" and v.start_date >= STR_TO_DATE(:fdate,'%d/%m/%Y') ";
				$search['fdate'] = $param['fdate'];
			}elseif(isset($param['tdate']) && strlen($param['tdate'])>0){
				$sql .=" and v.start_date <= STR_TO_DATE(:tdate,'%d/%m/%Y') ";
				$search['tdate'] = $param['tdate'];
			}
		}
		$limit = PAGE_SEARCH_LIMIT_RECORD;
		$sql .=" ORDER BY p.post_id DESC
				limit $limit
				OFFSET $start_row";
		PhoLog::debug_var('--search1----',$sql);
		PhoLog::debug_var('--search1----',$search);
		return $this->pho_query($sql, $search);
	}	
	public function get_byuser_count($param){
		$sql = "select count(p.post_id) cnt
				from posts p				
				INNER JOIN posts_view v on v.post_id = p.post_id
				where p.del_flg = 0
				and v.hide_flg = 0
				and p.add_user = :user_id";
		$search['user_id'] = $param['user_id'];
		if(isset($param['plevel']) && strlen($param['plevel'])>0 ){
			$sql .=" and v.post_level = :post_level";
			$search['post_level'] = $param['plevel'];
		}
		if(isset($param['status']) && strlen($param['status'])>0 ){
				if($param['status'] == '4'){
					$sql .=" and v.end_date < now() ";
				}else{
					$sql .=" and p.status = :status";
					$search['status'] = $param['status'];
				}				
		}
		if(isset($param['postno']) && strlen($param['postno'])>0 ){
			$sql .=" and p.post_no = :postno";
			$search['postno'] = $param['postno'];
		}
		if(isset($param['fdate']) && strlen($param['fdate'])>0 && isset($param['tdate']) && strlen($param['tdate'])>0){
			$sql .=" and v.start_date between STR_TO_DATE(:fdate,'%d/%m/%Y') and STR_TO_DATE(:tdate,'%d/%m/%Y')";
			$search['fdate'] = $param['fdate'];
			$search['tdate'] = $param['tdate'];
		}elseif(isset($param['fdate']) && strlen($param['fdate'])>0){
			$sql .=" and v.start_date >= STR_TO_DATE(:fdate,'%d/%m/%Y') ";
			$search['fdate'] = $param['fdate'];
		}elseif(isset($param['tdate']) && strlen($param['tdate'])>0){
			$sql .=" and v.start_date <= STR_TO_DATE(:tdate,'%d/%m/%Y') ";
			$search['tdate'] = $param['tdate'];
		}
		$sql .=" ORDER BY p.post_id DESC";
		$res =  $this->query_first($sql, $search);
		if(isset($res['cnt'])){
			return $res['cnt'];
		}
		return 0;
	}
	public function _delete($id){
		$sql="update posts set del_flg = 1 where post_id = :post_id";
		return $this->pho_execute($sql,array('post_id'=>$id));
	}
	public function get_list_all($param,$start_row=0){
		$limit = 50;
		$del_flg = 0;
		if(strlen($param['limit']) > 0){
			$limit = $param['limit'];
		}
		if(isset($param['del_flg']) && strlen($param['del_flg']) > 0){
			$del_flg = $param['del_flg'];
		}
		$pasql = array();	
		$sql = "select p.post_id,p.post_name,p.post_no,p.price,p.acreage,
			 c.ctg_name,		
				DATE_FORMAT(v.start_date ,'%d/%m/%Y')  start_date,
				DATE_FORMAT(v.end_date ,'%d/%m/%Y')  end_date,p.add_user,
				(case p.status when 0 THEN 'Chờ duyệt' when 1 THEN 'đã duyệt' when 2 THEN 'Không duyệt' when 3 THEN 'Đã xóa' end) status_name,p.status
				from posts p
				LEFT JOIN category c on c.ctg_id = p.ctg_id
				INNER JOIN posts_view v on v.post_id = p.post_id and v.hide_flg = 0

				where p.del_flg = $del_flg	";
		if(strlen($param['status']) > 0){
			$sql .=" and p.status = :status";	
			$pasql['status'] = $param['status'];		
		}
		/*$pasql['fdate'] ='00/00/0000';        
        if (isset($param['fdate']) && empty($param['fdate'])==FALSE) {
			$pasql['fdate'] = $param['fdate'];
		}*/
        if (isset($param['fdate']) && empty($param['fdate'])==FALSE && isset($param['tdate']) && empty($param['tdate'])==FALSE) {
			$pasql['tdate'] = $param['tdate'].' 23:59';
			$pasql['fdate'] = $param['fdate'];
            $sql .= " and v.start_date between STR_TO_DATE(:fdate,'%d/%m/%Y') and STR_TO_DATE(:tdate,'%d/%m/%Y %H:%i')";
		}elseif(isset($param['fdate']) && empty($param['fdate'])==FALSE){
            $sql .= " and v.start_date >= STR_TO_DATE(:fdate,'%d/%m/%Y %H:%i')";
            $pasql['fdate'] = $param['fdate'];
        }elseif(isset($param['tdate']) && empty($param['tdate'])==FALSE){
			$pasql['tdate'] = $param['tdate'].' 23:59';
			$sql .= " and v.start_date <= STR_TO_DATE(:tdate,'%d/%m/%Y %H:%i')";
		}
        if(strlen($param['ctgid']) > 0){
			$sql .=" and p.ctg_id in (
					select ctg_id from category 
					where del_flg =0
					and ctg_id = :ctg_id
					union all
					select ctg_id from category 
					where parent_id = :ctg_id
					)	";
			$pasql['ctg_id'] = $param['ctgid'];
		}
		if(strlen($param['pid']) > 0){
			$sql .=" and p.post_id = :post_id";	
			$pasql['post_id'] = $param['pid'];
		}
		$sql .=	"		
				ORDER BY p.post_id DESC
				limit $limit
				OFFSET $start_row";
		PhoLog::debug_var('query----',$sql);
		PhoLog::debug_var('query----',$pasql);
		return $this->pho_query($sql,$pasql);
	}
	public function get_list_all_count($param){
		$limit = 50;
		$del_flg = 0;
		if(strlen($param['limit']) > 0){
			$limit = $param['limit'];
		}
		if(strlen(isset($param['del_flg']) && $param['del_flg']) > 0){
			$del_flg = $param['del_flg'];
		}
		$pasql = array();	
		$sql = "select count(p.post_id) cnt
				from posts p
				LEFT JOIN category c on c.ctg_id = p.ctg_id
				INNER JOIN posts_view v on v.post_id = p.post_id and v.hide_flg = 0

				where p.del_flg = $del_flg	";
		if(strlen($param['status']) > 0){
			$sql .=" and p.status = :status";	
			$pasql['status'] = $param['status'];		
		}
		if (isset($param['fdate']) && empty($param['fdate'])==FALSE && isset($param['tdate']) && empty($param['tdate'])==FALSE) {
			$pasql['tdate'] = $param['tdate'].' 23:59';
			$pasql['fdate'] = $param['fdate'];
            $sql .= " and v.start_date between STR_TO_DATE(:fdate,'%d/%m/%Y') and STR_TO_DATE(:tdate,'%d/%m/%Y %H:%i')";
		}elseif(isset($param['fdate']) && empty($param['fdate'])==FALSE){
            $sql .= " and v.start_date >= STR_TO_DATE(:fdate,'%d/%m/%Y %H:%i')";
            $pasql['fdate'] = $param['fdate'];
        }elseif(isset($param['tdate']) && empty($param['tdate'])==FALSE){
			$pasql['tdate'] = $param['tdate'].' 23:59';
			$sql .= " and v.start_date <= STR_TO_DATE(:tdate,'%d/%m/%Y %H:%i')";
		}
        if(strlen($param['ctgid']) > 0){
			$sql .=" and p.ctg_id in (
					select ctg_id from category 
					where del_flg =0
					and ctg_id = :ctg_id
					union all
					select ctg_id from category 
					where parent_id = :ctg_id
					)	";
			$pasql['ctg_id'] = $param['ctgid'];
		}
		if(strlen($param['pid']) > 0){
			$sql .=" and p.post_id = :post_id";	
			$pasql['post_id'] = $param['pid'];
		}
		//PhoLog::debug_var('query-count---',$sql);
		//PhoLog::debug_var('query-count---',$pasql);
		$res = $this->query_first($sql,$pasql);
		return $res['cnt'];
	}
	public function get_bydistrict($param){	
		$pa_s = array();
		$where_join = "c.ctg_id = t.m_type_id";
		$ctgid ="'ctgid=";
		if(isset($param['ctgid']) && strlen($param['ctgid'])>0)
		{
			$where_join = "c.ctg_id = t.ctg_id and c.ctg_id= :ctgid";		
			$pa_s['ctgid'] = $param['ctgid'];	
			$ctgid .=$param['ctgid'];
		}
		$ctgid .="'";
		if(isset($param['district']) && strlen($param['district'])>0){
			$sql="select d.m_district_name title,c.ctg_name,t.m_type_id, p.m_ward_name dst_name,CONCAT($ctgid,'&district=',p.m_district_id,'&ward=', p.m_ward_id) dst_id,count(t.post_id) cnt 
						from posts t
			inner join m_ward p on p.m_ward_id = t.m_ward_id
			inner join m_district d on d.m_district_id = p.m_district_id
			inner JOIN category c on $where_join
			where t.status = 1
			and p.m_district_id = :district
			and t.m_type_id = :type
			group by p.m_ward_name,p.m_ward_id,c.ctg_name
			ORDER BY cnt desc";
			$pa_s['district'] = $param['district'];
		}else if(isset($param['provin']) && strlen($param['provin'])>0){
			$sql="select d.m_provin_name title,c.ctg_name,t.m_type_id,p.m_district_name dst_name,CONCAT($ctgid,'&district=', p.m_district_id) dst_id,count(t.post_id) cnt 
			from posts t
			inner join m_district p on p.m_district_id = t.m_district_id
			inner join m_provincial d on d.m_provin_id = p.m_provin_id
			inner JOIN category c on $where_join
			where t.status = 1			
			and t.m_type_id = :type
			and p.m_provin_id = :provin
			group by p.m_district_name,p.m_district_id,c.ctg_name
			ORDER BY cnt desc  ";	
			$pa_s['provin'] = $param['provin'];	
		}else{
			$sql="select '' title,c.ctg_name,t.m_type_id,d.m_provin_name dst_name,CONCAT($ctgid,'&provin=', d.m_provin_id) dst_id,count(t.post_id) cnt 
			from posts t
			
			inner join m_provincial d on d.m_provin_id = t.m_provin_id
			inner JOIN category c on $where_join
			where t.status = 1			
			and t.m_type_id = :type
			group by d.m_provin_name ,d.m_provin_id,c.ctg_name
			ORDER BY d.sort  ";	
		}	
		$pa_s['type'] = $param['type'];
		PhoLog::debug_var('---abc--',$sql);
		PhoLog::debug_var('---abc--',$pa_s);
		return $this->pho_query($sql,$pa_s);	
	}
	public function update_status($post_id,$status){
		$sql="update posts set status =:status where post_id = :post_id";
		return $this->pho_execute($sql,array('status'=>$status,'post_id'=>$post_id));
	}
	public function update_traffic($param){
		$sql="select update_traffic_post(:post_id,:section_id,:time,:ip)";
		return $this->pho_execute($sql,$param);
	}
	public function extract_youtube_key($url_link){
		if(strlen($url_link)==0) return '';
		$position=strpos( $url_link, 'v=',1) + 2;
	    return substr($url_link ,$position,11);
	}
	public function get_post_relation($param,$limit=10){
		$sql="select p.post_id,p.post_name,p.post_no,v.post_level,
		(trim(p.price)+0) price,
		(trim(p.acreage)+0) acreage,pro.m_provin_name,dis.m_district_name,
				NULLIF(un.m_unit_name,'') m_unit_name,
				NULLIF(im.img_path,'') img_path,
				DATE_FORMAT(v.start_date ,'%d/%m/%Y')  start_date
				,rd.m_ward_name
				from posts p
				INNER JOIN m_provincial pro on pro.m_provin_id = p.m_provin_id
				INNER JOIN m_district dis on dis.m_district_id = p.m_district_id
				INNER JOIN posts_view v on v.post_id = p.post_id
				LEFT JOIN posts_img im on im.post_id = p.post_id and im.avata_flg = 1
				LEFT JOIN m_unit un on un.m_unit_id = p.unit_price 
				LEFT JOIN m_ward rd on rd.m_ward_id = p.m_ward_id
				where p.del_flg = 0
				and p.status =1
				and v.hide_flg = 0
				and v.end_date >= NOW()
				and p.m_provin_id = :m_provin_id
				and p.m_type_id = :m_type_id
				and p.m_district_id = :m_district_id	
				and p.post_id <> :post_id	
				order by v.post_level DESC, v.start_date DESC
				limit $limit";
		return $this->pho_query($sql,$param);
	}
}
