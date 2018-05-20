<?php
namespace Multiple\Models;

use Multiple\Models\DBModel;
use Multiple\PHOClass\PHOArray;
use Multiple\PHOClass\PHOLog;
class Product extends DBModel
{	
	public  $pro_id ;
    public  $pro_no ;
    public  $pro_name   ;  // ten san pham
    public  $disp_home  ;  // hien thi tren trang chu
    public  $good_sell   ; //sp ban chay
    public  $status  ;  //0:con hang; 1:het hang
    public  $content ;  // noi dung
    public  $technology   ;
    public  $promotions   ;
    public  $add_date;
    public  $add_user   ;
    public  $upd_date  ;
    public  $upd_user;
	public  $del_flg;
	public 	$pro_code;  //ma san pham
	public 	$src_link;  //link nguon hang
	public  $sizelist;  // size san phan
	public  $description; 
	public function initialize()
    {
        $this->setSource("product");
    }
	public function get_product_all($param){
		$sql="select p.pro_id,
				p.pro_name,		
				p.pro_no,			
				(case when p.status = 0 then 'còn hàng' else 'hết hàng' end) status,
				--(case when p.disp_home= 1 then 'hiện' else 'không' end) disp_home,
				p.disp_home,
				c.ctg_name,
				DATE_FORMAT(p.upd_date ,'%d/%m/%Y')  upd_date,
				p.del_flg,
				good_sell,
				img.img_path
				FROM
				product p
				left join product_img img on  img.avata_flg = 1 and img.pro_id =p.pro_id
				INNER JOIN category  c on c.ctg_id = p.ctg_id 
				where 1=1
				";
		$pasql = array();
		if(strlen($param['status']) > 0){
			$sql .=" and p.status = :status";	
			$pasql['status'] = $param['status'];		
		}
		if(strlen($param['del_flg']) > 0){
			$sql .=" and p.del_flg = :del_flg";	
			$pasql['del_flg'] = $param['del_flg'];		
		}		
        if (isset($param['fdate']) && empty($param['fdate'])==FALSE && isset($param['tdate']) && empty($param['tdate'])==FALSE) {
			$pasql['tdate'] = $param['tdate'].' 23:59';
			$pasql['fdate'] = $param['fdate'];
            $sql .= " and p.add_date between STR_TO_DATE(:fdate,'%d/%m/%Y') and STR_TO_DATE(:tdate,'%d/%m/%Y %H:%i')";
		}elseif(isset($param['fdate']) && empty($param['fdate'])==FALSE){
            $sql .= " and p.add_date >= STR_TO_DATE(:fdate,'%d/%m/%Y %H:%i')";
            $pasql['fdate'] = $param['fdate'];
        }elseif(isset($param['tdate']) && empty($param['tdate'])==FALSE){
			$pasql['tdate'] = $param['tdate'].' 23:59';
			$sql .= " and p.add_date <= STR_TO_DATE(:tdate,'%d/%m/%Y %H:%i')";
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
			$sql .=" and p.pro_id = :pro_id";	
			$pasql['pro_id'] = $param['pid'];
		}
		$sql .=" order by p.pro_id desc";
		return $this->pho_query($sql,$pasql);
	}
	public function get_product_all_count($param){
		$sql="select count(p.pro_id) cnt
				FROM
				product p
				where 1=1
				";
		$pasql = array();
		if(strlen($param['status']) > 0){
			$sql .=" and p.status = :status";	
			$pasql['status'] = $param['status'];		
		}	
		if(strlen($param['del_flg']) > 0){
			$sql .=" and p.del_flg = :del_flg";	
			$pasql['del_flg'] = $param['del_flg'];		
		}	
        if (isset($param['fdate']) && empty($param['fdate'])==FALSE && isset($param['tdate']) && empty($param['tdate'])==FALSE) {
			$pasql['tdate'] = $param['tdate'].' 23:59';
			$pasql['fdate'] = $param['fdate'];
            $sql .= " and p.add_date between STR_TO_DATE(:fdate,'%d/%m/%Y') and STR_TO_DATE(:tdate,'%d/%m/%Y %H:%i')";
		}elseif(isset($param['fdate']) && empty($param['fdate'])==FALSE){
            $sql .= " and p.add_date >= STR_TO_DATE(:fdate,'%d/%m/%Y %H:%i')";
            $pasql['fdate'] = $param['fdate'];
        }elseif(isset($param['tdate']) && empty($param['tdate'])==FALSE){
			$pasql['tdate'] = $param['tdate'].' 23:59';
			$sql .= " and p.add_date <= STR_TO_DATE(:tdate,'%d/%m/%Y %H:%i')";
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
			$sql .=" and p.pro_id = :pro_id";	
			$pasql['pro_id'] = $param['pid'];
		}

		$res = $this->query_first($sql,$pasql);
		return $res['cnt'];
	}
	public function get_img_path($pro_img_id){
		$sql="select img_path from product_img where pro_img_id = $pro_img_id";
		$res = $this->pho_query($sql);
		if(count($res)>0){
			return $res[0]['img_path'];
		}
		return "";
	}
	
	public function delete_pro_img($img_list){
		$sql="delete from  product_img where img_thumb= :img_thumb" ;
		$file_lb = new FilePHPDebug_lib();
		foreach($img_list as $item){
			$img_path = str_replace(ACW_BASE_URL_DATA,"",$item);		
			$this->execute($sql,array('img_thumb'=>$img_path));
			if(is_file(DATA_MAIN_PATH.'/'.$img_path)){
				$file_lb->DeleteFile(DATA_MAIN_PATH.'/'.$img_path);
				$file_lb->DeleteFile(DATA_MAIN_PATH.'/'.str_replace("_thumb","",$img_path));
			}			
		}
	}
	public function reset_img_bypro($pro_id){
		$sql ="update product_img set avata_flg = 0 where pro_id = $pro_id";
		$this->execute($sql);
	}
	public function update_pro_img($pro_img_id,$avata_flg){
		$sql ="update product_img set avata_flg = $avata_flg where pro_img_id = $pro_img_id";
		$this->execute($sql);
	}
	
	public function _insert($param)
	{
		try {		    
		    $this->ctg_id  = $param['ctg_id'];
		    $this->disp_home   = $param['disp_home'];
		    $this->status  = 0;
		    
		    $this->content   = $param['content'];   
		 
		    if(isset($param['technology'])){
		    	$this->technology    = $param['technology'];
			}
		    if(isset($param['promotions'])){
		    	$this->promotions    = $param['promotions'];
			}
		    $this->add_user    = $param['user_id'];	    
		    $this->upd_user    = $param['user_id'];
		    $this->add_date = date("Y-m-d H:i:s");
		    $this->upd_date = date("Y-m-d H:i:s");
		    if(isset($param['del_flg'])){
		    	$this->del_flg = $param['del_flg'];
		    }else{
		    	$this->del_flg = 0;
		    }		    
		    $this->src_link = $param['src_link'];
		    $this->pro_code =$this->get_code_max($param['ctg_id']);
		    $this->pro_code++;
		    $this->pro_no = $param['pro_no'] .'-'.strtolower($this->pro_code);
		    $this->pro_name   = $param['pro_name'].' '.$this->pro_code;
		    $this->sizelist = $param['sizelist'];
		    $this->description =$param['description'];	
		    if(isset($param['good_sell']) && strlen($param['good_sell'])>0){
				$this->good_sell = $param['good_sell'];  
			}else{
				$this->good_sell = 0;
			}  
		     
		    $this->save();
	    } catch (\Exception $e) {
			PhoLog::debug_var('update----',$e);
		}	    
	    return $this->pro_id;
	}	
	public function get_code_max($parent_id){
		$sql ="select IFNULL(max(p.pro_code),CONCAT((select ctg_code from category where ctg_id = :ctg_id ),'0000')) code_max 
				from product p
				where p.ctg_id = :ctg_id";
		$res = $this->query_first($sql,array('ctg_id'=>$parent_id));
		return $res['code_max'];
	}
	public function _update($param){
		try {		
		$sql = "update product
					set pro_name= :pro_name ,					
					  pro_no = :pro_no,
					  pro_code = :pro_code,
					  ctg_id = :ctg_id,					  
					  status = :status,					  				 				
					  upd_date =now(),
					  upd_user =:user_id,
					  del_flg =:del_flg,
					  content =:content,
					  disp_home =:disp_home,
					  technology = :technology,
					  promotions = :promotions,
					  good_sell =:good_sell,
					  src_link =:src_link,
					  sizelist =:sizelist,
					  description =:description					 
					where pro_id = :pro_id
				";
		
 		$sql_par = PHOArray::filter($param, array(
					'pro_id',
					'pro_name',					
					  'pro_no',
					  'pro_code',
					  'ctg_id' ,
					 // 'price_old' ,
					 // 'price_new',
					 'disp_home' ,
					 'good_sell' ,					
					  'status',	
					  'del_flg',
					  'content',
					  'promotions',
					  'technology',
					  'user_id'	,
					  'src_link',
					  'sizelist',
					  'description'
					));
		$this->pho_execute($sql,$sql_par );			
		return TRUE;	
		} catch (\Exception $e) {
			PhoLog::debug_var('update----',$e);
			return FALSE;
		}
	}
	public function get_product_byid($pro_id){
		$sql=" select pro_name,
					  pro_id,
					  pro_no,			
					  ctg_id ,					
					  disp_home ,
					  good_sell ,
					  status,
					  del_flg,
					  content,
					  promotions,
					  technology,
					  full_box
			  from product where pro_id = :pro_id";
		$res = $this->pho_query($sql ,array('pro_id'=>$pro_no));
		if(count($res)> 0){
			return $res[0];
		}
		return null;
	}
	public function get_relation($ctg_id,$pro_id,$limit=6){
		$sql=" select t.*,
				 img.img_path,pri.price_exp,pri.price_seller
				 from (
				select pro_name,
									  pro_id,
									  pro_no,			
									  ctg_id ,					
									  disp_home ,
									  good_sell ,
									  status,
									  del_flg,
									  content,
									  promotions,
									  technology,
									  full_box
							  from product where ctg_id = :ctg_id
				union
				select pro_name,
									  pro_id,
									  pro_no,			
									  ctg_id ,					
									  disp_home ,
									  good_sell ,
									  status,
									  del_flg,
									  content,
									  promotions,
									  technology,
									  full_box
							  from product 
				where ctg_id in (select ctg_id 
							from category 
							where parent_id = (select parent_id 
										from category where ctg_id = :ctg_id))
				) t
				INNER JOIN product_img img on img.pro_id = t.pro_id and img.avata_flg =1
				INNER JOIN product_price pri on pri.pro_id = t.pro_id and pri.avata_flg = 1
				where t.pro_id <> :pro_id
				and t.del_flg= 0
				ORDER BY pro_id DESC
				limit $limit";
		return $this->pho_query($sql ,array('pro_id'=>$pro_id,'ctg_id'=>$ctg_id));		
	}
	
	public function get_product_info($pro_id){
		$sql=" select pro_name,
					  pro_id,
					  pro_code,
					  pro_no,			
					  p.ctg_id ,	
					  (case when status = 0 then 'còn hàng' else 'hết hàng' end) status_name,				
					  disp_home ,
					  good_sell ,
					  status,
					  p.del_flg,
					  content,
					  promotions,
					  technology,
					  full_box,
					  src_link,
					  sizelist,
					  p.description,
						c.pro_desc
			  from product p
				INNER JOIN category c on c.ctg_id = p.ctg_id
				where pro_id = :pro_id";
		$res = $this->pho_query($sql ,array('pro_id'=>$pro_id));
		if(count($res)> 0){
			return $res[0];
		}
		return null;
	}
	public function get_list_new($limit = 10){		
		$sql ="select p.pro_id,p.pro_name,p.pro_no,img.img_path,pri.price_exp,pri.price_seller
				from product p
				INNER JOIN product_img img on img.pro_id = p.pro_id and img.avata_flg =1
				INNER JOIN product_price pri on pri.pro_id = p.pro_id and pri.avata_flg = 1
				where p.del_flg= 0
				ORDER BY p.pro_id desc
				limit $limit";
//		PhoLog::debug_var('vip',$sql);
		return $this->pho_query($sql);
	}
	public function get_goodsell($limit = 10){		
		$sql ="select p.pro_id,p.pro_name,p.pro_no,img.img_path,pri.price_exp,pri.price_seller
				from product p
				INNER JOIN product_img img on img.pro_id = p.pro_id and img.avata_flg =1
				INNER JOIN product_price pri on pri.pro_id = p.pro_id and pri.avata_flg = 1
				where p.del_flg= 0
				and good_sell = 1
				ORDER BY p.pro_id desc
				limit $limit";
//		PhoLog::debug_var('vip',$sql);
		return $this->pho_query($sql);
	}
	public function get_topdiscount($limit = 10){		
		$sql ="select p.pro_id,p.pro_name,p.pro_no,img.img_path,pri.price_exp,pri.price_seller,(pri.price_exp-pri.price_seller) disctount
				from product p
				INNER JOIN product_img img on img.pro_id = p.pro_id and img.avata_flg =1
				INNER JOIN product_price pri on pri.pro_id = p.pro_id and pri.avata_flg = 1
				where p.del_flg= 0				
				ORDER BY (pri.price_exp-pri.price_seller)			desc
				limit $limit";
//		PhoLog::debug_var('vip',$sql);
		return $this->pho_query($sql);
	}
	public function get_list_byctg($ctg_no,$start_row=0){	
		$limit = PAGE_LIMIT_RECORD;
		$where ="";
		$param = array();
		$arr_chk=array('san-pham-moi','ban-chay','top-chiet-khau');
		$order = "ORDER BY p.pro_id desc";
		if(!in_array($ctg_no,$arr_chk) ){
			$where =" and p.ctg_id in (
					select ctg_id from category 
					where del_flg =0
					and ctg_no = :ctg_no
					union all
					select ctg_id from category 
					where parent_id =(select ctg_id from category where del_flg =0  and ctg_no = :ctg_no)
					)	";
			$param['ctg_no'] = $ctg_no;
		}elseif($ctg_no == 'ban-chay'){
			$where = " and p.good_sell =1" ;			
		}elseif($ctg_no == 'top-chiet-khau'){
			$order = "ORDER BY (pri.price_exp-pri.price_seller)	desc";
		}	
		$sql ="select p.pro_id,p.pro_name,p.pro_no,img.img_path,pri.price_exp,pri.price_seller
				from product p
				INNER JOIN product_img img on img.pro_id = p.pro_id and img.avata_flg =1
				INNER JOIN product_price pri on pri.pro_id = p.pro_id and pri.avata_flg = 1
				where p.del_flg= 0
				$where
				$order
				limit $limit
				OFFSET $start_row";
		//PhoLog::debug_var('vip',$sql);
		//PhoLog::debug_var('vip',$param);
		return $this->pho_query($sql,$param);
	}	
	public function get_list_byctg_count($ctg_no){
		$where ="";
		$param = array();
		$arr_chk=array('san-pham-moi','ban-chay','top-chiet-khau');
		
		if(!in_array($ctg_no,$arr_chk)){
			$where =" and p.ctg_id in (
					select ctg_id from category 
					where del_flg =0
					and ctg_no = :ctg_no
					union all
					select ctg_id from category 
					where parent_id =(select ctg_id from category where del_flg =0  and ctg_no = :ctg_no)
					)	";
			$param['ctg_no'] = $ctg_no;
		}elseif($ctg_no == 'ban-chay'){
			$where = " and p.good_sell =1" ;			
		}		
		$sql ="select count(p.pro_id) cnt
				from product p				
				where p.del_flg= 0				
				$where
				";
//		PhoLog::debug_var('vip',$sql);
		$res = $this->query_first($sql,$param);
		if(isset($res['cnt'])){
			return $res['cnt'];
		}
		return 0;
	}
	public function search_product($search_val,$start_row=0){	
		$limit = PAGE_LIMIT_RECORD;		
		
		$param['pro_no'] =	'%'.str_replace(' ','%',$search_val).'%';			
		$sql ="select p.pro_id,p.pro_name,p.pro_no,img.img_path,pri.price_exp,pri.price_seller
				from product p
				INNER JOIN product_img img on img.pro_id = p.pro_id and img.avata_flg =1
				INNER JOIN product_price pri on pri.pro_id = p.pro_id and pri.avata_flg = 1
				where p.del_flg= 0
				and p.pro_no  like :pro_no
				ORDER BY p.pro_id desc
				limit $limit
				OFFSET $start_row";
		//PhoLog::debug_var('vip',$sql);
		//PhoLog::debug_var('vip',$param);
		return $this->pho_query($sql,$param);
	}
	public function search_product_count($search_val){	
		$limit = PAGE_LIMIT_RECORD;		
		
		$param['pro_no'] =	'%'.str_replace(' ','%',$search_val).'%';			
		$sql ="select count(p.pro_id) cnt
				from product p
				INNER JOIN product_img img on img.pro_id = p.pro_id and img.avata_flg =1
				INNER JOIN product_price pri on pri.pro_id = p.pro_id and pri.avata_flg = 1
				where p.del_flg= 0
				and p.pro_no  like :pro_no
				";
		$res = $this->query_first($sql,$param);
		if(count($res)>0){
			return $res['cnt'];
		}
		return 0;
	}	
	public function check_diff($pro_id,$ctg_id){
		$sql="select pro_code,ctg_id ,
				(case when pro_code like  concat((select ctg_code from category where ctg_id = :ctg_id),'%') then 0 else 1 end) diff_flg,
				(select IFNULL(max(p.pro_code),CONCAT((select ctg_code from category where ctg_id = :ctg_id ),'0000')) code_max 
								from product p
								where p.ctg_id = :ctg_id) code_max
				from 
				product 
				where pro_id = :pro_id";
		return $this->query_first($sql,array('ctg_id'=>$ctg_id,'pro_id'=>$pro_id));
	}
}
