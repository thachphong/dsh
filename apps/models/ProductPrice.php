<?php

namespace Multiple\Models;
use Multiple\Models\DBModel;
use Multiple\PHOClass\PHOArray;
class ProductPrice extends DBModel
{
    public $pro_price_id;
    public $pro_id;
  	public $price_exp;
  	public $price_seller;
  	public $price_imp;
  	public $color;
  	public $size;
  	public $avata_flg;  
  	
    public function initialize()
    {
        $this->setSource("product_price");
    }
    public function get_all(){
         return ProductPrice::find();
    }
    public function _insert($param){

        $this->pro_id = $param['pro_id'];
        $this->img_path = $param['img_path'];
        $this->avata_flg = $param['avata_flg'];
        return $this->save();
    }
    public function insert_multi($param){
    	$this->pho_execute("delete from product_price where pro_id=".$param['pro_id']);
		foreach($param['pro_size'] as $key=>$item){
			$db = new ProductPrice();
			if(strlen($item) >0){
				$db->avata_flg =0;
				if($key == 0){
					$db->avata_flg =1;
				}
				$db->pro_id = $param['pro_id'];
				$db->size = $item;
				$db->price_exp = $param['price_exp'][$key];
				$db->price_imp = $param['price_imp'][$key];
				$db->price_seller = $param['price_seller'][$key];
				$db->save();
			}
		}
	}
    
    public function get_price_list($pro_id){
		$sql="select *  from product_price where pro_id  = $pro_id";
		return  $this->pho_query($sql);		
	}
    public function delete_bypost($post_id,$img_path){
        $sql="delete from posts_img where post_id=:post_id and img_path =:img_path";
        return $this->pho_execute($sql,array('post_id'=>$post_id,'img_path'=>$img_path));
    }
    public function deleteall_bypost($post_id){
        $sql="delete from posts_img where post_id=:post_id";
        return $this->pho_execute($sql,array('post_id'=>$post_id));
    }
    public function get_list_bypro($pro_id){
      return  ProductPrice::find(array("pro_id = :pro_id: ",
      			'order'=> 'avata_flg desc',
                'bind' => array('pro_id' => $pro_id)
      ));
    }
    
}
