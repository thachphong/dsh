<?php

namespace Multiple\Models;

use Multiple\Models\DBModel;
use Multiple\PHOClass\PHOArray;

class News extends DBModel
{
    public $news_id;
    public $news_name;
    public $ctg_id;
    public $news_no;
    public $content;
    public $des;
    public $img_path;
    public $add_date;
    public $add_user;
    public $upd_date;
    public $upd_user;
    public $del_flg;
 

    public function initialize()
    {
        $this->setSource("news");
    }
    public function get_news_all($start_row=0,$limit=50){
        $sql="select n.news_id,
                  n.news_no,
                  n.news_name,               
                  n.content,                 
                  n.des,
                  n.img_path,
                  n.add_date,
                  n.add_user,
                  n.upd_date,
                  n.upd_user,                 
                  n.del_flg,
                    c.ctg_name
              from news n
                left JOIN category c on c.ctg_id = n.ctg_id   
                where n.del_flg = 0 
                order by n.news_id desc
                limit $limit
				OFFSET $start_row";
        return $this->pho_query($sql);
    }
    public function get_news_all_count(){
        $sql="select count(n.news_id)  cnt                
              from news n             
                where del_flg = 0  ";
        $res = $this->query_first($sql);
		return $res['cnt'];
    }
    public function get_news_info($news_id){
        $sql=" select n.news_id,
                  n.news_no,
                  n.news_name,               
                  n.content,                 
                  n.des,
                  n.img_path,
                  n.add_date,
                  n.add_user,
                  n.upd_date,
                  n.upd_user,                 
                  n.del_flg,
                  n.ctg_id,
                    c.ctg_name
              from news n
                left JOIN category c on c.ctg_id = n.ctg_id
               where n.news_id = :news_id";
        $res = $this->pho_query($sql ,array('news_id'=>$news_id));
        if(count($res)> 0){
            return $res[0];
        }
        return null;
    }
  
  public function _insert($param){
    $this->news_name = $param['news_name'];
    $this->news_no= $param['news_no'];
    $this->content= $param['content'];
    $this->ctg_id= $param['ctg_id'];
    $this->des= $param['des'];
    $this->img_path= $param['img_path'];
    //$this->add_date= $param['news_name'];
    $this->add_user= $param['user_id'];
    //$this->upd_date= $param['news_name'];
    $this->upd_user= $param['user_id'];
    $this->del_flg=  $param['del_flg'];
    $this->save();
    return $this->news_id;
  }
  public function _update($param){

    //$login_info = ACWSession::get('user_info');
    //$param['user_id'] = $login_info['user_id'];   
    $sql = "update news
          set news_no = :news_no,
            news_name = :news_name,
            ctg_id = :ctg_id,
            des = :des,
            img_path = :img_path ,
            content = :content,          
            upd_date = now(),
            upd_user = :user_id,           
            del_flg = :del_flg
          where news_id = :news_id
        ";
    
    $sql_par = PHOArray::filter($param, array(
          'news_id',
          'news_no',
            'news_name',
            'content',
            'ctg_id',
            'des',
            'img_path',             
            'user_id',           
            'del_flg'           
          ));
    return $this->pho_execute($sql,$sql_par );     
  }
  public function get_news($news_id){
    return  News::findFirst(array(
                "news_id = :news_id: ",
                'bind' => array('news_id' => $news_id)
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
  public function get_news_row($news_id){
        $sql=" select n.news_id,
                  n.news_no,
                  n.news_name,               
                  n.content,                 
                  n.des,
                  n.img_path,                 
                  DATE_FORMAT(n.add_date ,'%d/%m/%Y %H:%i')  add_date,
                  n.add_user,
                  n.ctg_id,
                    c.ctg_name
              from news n
                left JOIN category c on c.ctg_id = n.ctg_id
               where n.news_id = :news_id";
       return $this->query_first($sql ,array('news_id'=>$news_id));
        
  }
  public function get_news_rows($ctg_id,$limit=10){
        $sql="select n.news_id,
                  n.news_no,
                  n.news_name,
                  n.des,
                  n.img_path,
                  n.add_date
              from news n              
              where n.ctg_id in (select ctg_id from category 
          where ctg_id = :ctg_id
          union all
          select ctg_id from category 
          where parent_id = :ctg_id
        ) 
              order by n.news_id desc
              limit $limit";
        return $this->pho_query($sql,array('ctg_id'=>$ctg_id));
  }
  public function get_news_pupular($limit=10){
        $sql="select n.news_id,
                  n.news_no,
                  n.news_name,
                  n.des,
                  n.img_path,
                  n.add_date
              from news n where ctg_id <> 5
              order by n.total_view desc
              limit $limit";
        return $this->pho_query($sql);
  }
  public function get_news_byctgno($ctg_no,$start_row = 0){
    $limit =PAGE_NEWS_LIMIT_RECORD;
    $sql="select news_id, news_no,news_name,des,img_path from news  where del_flg =0
        and ctg_id in (select ctg_id from category 
          where ctg_no = :ctg_no
          union all
          select ctg_id from category 
          where parent_id =(select ctg_id from category where ctg_no = :ctg_no)
        )
        order by news_id desc
        limit $limit
        OFFSET $start_row
        ";
    return $this->pho_query($sql,array('ctg_no'=>$ctg_no));
  }
  public function get_news_byctgno_count($ctg_no){
   // $limit =PAGE_NEWS_LIMIT_RECORD;
    $sql="select count(news_id) cnt
          from news  where del_flg =0
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
  public function get_news_relation($ctg_id,$news_id){
    $sql="select news_id, news_no,news_name,des,img_path from news  
      where del_flg = 0
        and ctg_id = :ctg_id
        and news_id <> :news_id
        order by news_id desc
        limit 6";
    $res = $this->pho_query($sql ,array('ctg_id'=>$ctg_id,'news_id'=>$news_id));    
    return $res;
  }
  public function update_traffic($param){
		$sql="select update_traffic_news(:news_id,:section_id,:time,:ip)";
		return $this->pho_execute($sql,$param);
  }
  public function get_project_all(){
  	  $sql="select news_id,news_name,news_no from news where ctg_id = 5 and del_flg =0";
  	  return $this->pho_query($sql);
  }
}
