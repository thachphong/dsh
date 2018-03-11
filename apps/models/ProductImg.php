<?php

namespace Multiple\Models;
use Multiple\Models\DBModel;
use Multiple\PHOClass\PHOArray;
class ProductImg extends DBModel
{
    public $pro_img_id;
    public $pro_id;
  	public $img_path;
  	public $avata_flg;
  	
    public function initialize()
    {
        $this->setSource("product_img");
    }
    public function get_all(){
         return ProductImg::find();
    }
    public function _insert($param){

        $this->pro_id = $param['pro_id'];
        $this->img_path = $param['img_path'];
        $this->avata_flg = $param['avata_flg'];
        return $this->save();
    }
    public function get_img_bypro($pro_id){
      return  ProductImg::find(array("pro_id = :pro_id: ",
                'bind' => array('pro_id' => $pro_id)
      ));
    }
    public function delete_bypost($pro_id,$img_path){
        $sql="delete from product_img where pro_id=:pro_id and img_path =:img_path";
        return $this->pho_execute($sql,array('pro_id'=>$pro_id,'img_path'=>$img_path));
    }
    public function deleteall_bypost($pro_id){
        $sql="delete from product_img where pro_id=:pro_id";
        return $this->pho_execute($sql,array('pro_id'=>$pro_id));
    }
    public function reset_avata($pro_id){
        $sql="update product_img set avata_flg =0  where pro_id=:pro_id";
        $this->pho_execute($sql,array('pro_id'=>$pro_id));        
    }
    public function update_avata_flg($pro_img_id,$avata_flg){
		$sql ="update product_img set avata_flg = $avata_flg where pro_img_id = $pro_img_id";
		$this->pho_execute($sql);
	}
}
