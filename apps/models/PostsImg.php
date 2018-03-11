<?php

namespace Multiple\Models;
use Multiple\Models\DBModel;
use Multiple\PHOClass\PHOArray;
class PostsImg extends DBModel
{
    public $post_img_id;
    public $post_id;
  	public $img_path;
  	public $avata_flg;
  	
    public function initialize()
    {
        $this->setSource("posts_img");
    }
    public function get_all(){
         return PostsImg::find();
    }
    public function _insert($param){

        $this->post_id = $param['post_id'];
        $this->img_path = $param['img_path'];
        $this->avata_flg = $param['avata_flg'];
        return $this->save();
    }
    public function get_img_bypost($post_id){
      return  PostsImg::find(array("post_id = :post_id: ",
                'bind' => array('post_id' => $post_id)
      ));
    }
    public function delete_bypost($post_id,$img_path){
        $sql="delete from posts_img where post_id=:post_id and img_path =:img_path";
        return $this->pho_execute($sql,array('post_id'=>$post_id,'img_path'=>$img_path));
    }
    public function reset_avata($post_id){
        $sql="update posts_img set avata_flg =0  where post_id=:post_id";
        $this->pho_execute($sql,array('post_id'=>$post_id));
        $sql ="select min(post_img_id) min_id from posts_img where post_id=:post_id";
        $res = $this->query_first($sql,array('post_id'=>$post_id));
        $sql="update posts_img set avata_flg =1  where post_img_id= :min_id";
        $this->pho_execute($sql,array('min_id'=>$res['min_id']));
    }
}
