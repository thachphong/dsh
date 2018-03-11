<?php
namespace Multiple\Models;

use Multiple\Models\DBModel;
use Multiple\PHOClass\PHOArray;
use Multiple\PHOClass\PHOLog;
class Product extends DBModel
{	
	public  $pro_id ;
    public  $pro_no ;
    public  $pro_name   ;
    public  $disp_home  ;
    public  $good_sell   ;
    public  $status  ;
    public  $content ;
    public  $technology   ;
    public  $promotions   ;
    public  $add_date;
    public  $add_user   ;
    public  $upd_date  ;
    public  $upd_user;
	public  $del_flg;
	public function initialize()
    {
        $this->setSource("product");
    }
	public function get_product_all(){
		$sql="select p.pro_id,
				p.pro_name,				
				(case when p.status = 0 then 'còn hàng' else 'hết hàng' end) status,
				--(case when p.disp_home= 1 then 'hiện' else 'không' end) disp_home,
				p.disp_home,
				c.ctg_name,
				DATE_FORMAT(p.upd_date ,'%d/%m/%Y')  upd_date,
				p.del_flg,
				good_sell
				FROM
				product p
				INNER JOIN category  c on c.ctg_id = p.ctg_id 
				order by p.pro_id desc
				";
		return $this->pho_query($sql);
	}
	public function get_product_all_count(){
		$sql="select count(p.pro_id) cnt
				FROM
				product p
				";
		$res = $this->query_first($sql);
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
		    $this->pro_no = $param['pro_no'];
		    $this->pro_name   = $param['pro_name'];
		    $this->ctg_id  = $param['ctg_id'];
		    $this->disp_home   = $param['disp_home'];
		    $this->status  = 0;
		    $this->good_sell = $param['good_sell'];
		    $this->content   = $param['content'];   
		    $this->content = $param['content'];
		    $this->technology    = $param['technology'];
		    $this->promotions    = $param['promotions'];
		    $this->add_user    = $param['user_id'];	    
		    $this->upd_user    = $param['user_id'];
		    $this->add_date = date("Y-m-d H:i:s");
		    $this->upd_date = date("Y-m-d H:i:s");
		    $this->del_flg = 0;
		    		     
		    $this->save();
	    } catch (\Exception $e) {
			PhoLog::debug_var('update----',$e);
		}	    
	    return $this->pro_id;
	}	
	public function _update($param){
		try {		
		$sql = "update product
					set pro_name= :pro_name ,					
					  pro_no = :pro_no,
					  ctg_id = :ctg_id,					  
					  status = :status,					  				 				
					  upd_date =now(),
					  upd_user =:user_id,
					  del_flg =:del_flg,
					  content =:content,
					  disp_home =:disp_home,
					  technology = :technology,
					  promotions = :promotions,
					  good_sell =:good_sell					 
					where pro_id = :pro_id
				";
		
 		$sql_par = PHOArray::filter($param, array(
					'pro_id',
					'pro_name',					
					  'pro_no',
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
					  'user_id'	
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
					  pro_no,			
					  ctg_id ,	
					  (case when status = 0 then 'còn hàng' else 'hết hàng' end) status_name,				
					  disp_home ,
					  good_sell ,
					  status,
					  del_flg,
					  content,
					  promotions,
					  technology,
					  full_box
			  from product where pro_id = :pro_id";
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
	public function get_list_byctg($ctg_no,$start_row=0){	
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
		$sql ="select p.pro_id,p.pro_name,p.pro_no,img.img_path,pri.price_exp,pri.price_seller
				from product p
				INNER JOIN product_img img on img.pro_id = p.pro_id and img.avata_flg =1
				INNER JOIN product_price pri on pri.pro_id = p.pro_id and pri.avata_flg = 1
				where p.del_flg= 0
				$where
				ORDER BY p.pro_id desc
				limit $limit
				OFFSET $start_row";
		PhoLog::debug_var('vip',$sql);
		PhoLog::debug_var('vip',$param);
		return $this->pho_query($sql,$param);
	}	
	public function get_list_byctg_count($ctg_no){
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
		$sql ="select count(*) cnt
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
		
}
