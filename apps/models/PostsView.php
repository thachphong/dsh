<?php

namespace Multiple\Models;
use Multiple\Models\DBModel;
use Multiple\PHOClass\PhoLog;
use Multiple\PHOClass\PHOArray;
class PostsView extends DBModel
{
    public $post_view_id;
    public $post_id;
    public $start_date;
    public $end_date;
    public $post_level;
    public $add_datetime;
    public $upd_datetime;
    public $add_user_id;
    public $upd_user_id;
    public $total_day;
	public $price;
	public $vat;
	public $total_amount ;
	public $hide_flg ;
    public function initialize()
    {
        $this->setSource("posts_view");
    }
    public function get_all(){
         return PostsView::find();
    }
    public function _insert($param){
        $this->post_id = $param['post_id'];
        $this->start_date = \DateTime::createFromFormat('d/m/Y', $param['start_date'])->format('Y-m-d');// date_format(date_create($param['start_date'],'d/m/Y'),'Y-m-d');
        $this->end_date =\DateTime::createFromFormat('d/m/Y', $param['end_date'])->format('Y-m-d');// date_format(date_create($param['end_date'],'d/m/Y'),'Y-m-d');
        $this->post_level = $param['post_level'];
        $this->add_user_id = $param['user_id'];
        $this->upd_user_id = $param['user_id'];
        $this->total_day= $param['total_day'];
		$this->price= $param['price'];
		$this->vat= $param['vat'];
		$this->total_amount = $param['total_amount'];
		$this->hide_flg = 0;
        //PhoLog::debug_var('date----',$param);
        //PhoLog::debug_var('date----','start:'.$this->start_date);
        //PhoLog::debug_var('date----','end:'.$this->end_date);
        $this->save();
    }
    public function _update($param){
        $sql = "update posts_view
                    set start_date = :start_date,
                    end_date = :end_date,
                    post_level = :post_level,
                    total_day =:total_day,
                    price =:price,
                    vat =:vat,
                    total_amount =:total_amount,                    
                    upd_user_id = :user_id,                   
                    upd_datetime =now()
                where post_view_id =:post_view_id
                ";
        $sql_par = PHOArray::filter($param, array(                  
                    'post_level'
                    ,'user_id'
                    ,'post_view_id'
                    ,'total_day' 
                    ,'price'
                    ,'vat'
                    ,'total_amount'                  
                    ));
        $sql_par['start_date']=\DateTime::createFromFormat('d/m/Y', $param['start_date'])->format('Y-m-d');
        $sql_par['end_date']=\DateTime::createFromFormat('d/m/Y', $param['end_date'])->format('Y-m-d');
        $this->pho_execute($sql,$sql_par );  
        return TRUE;
    }
    public function hide($id){
		$sql =" update posts_view set hide_flg =1 where post_id =:post_id";
		$this->pho_execute($sql,array('post_id'=>$id));  
        return TRUE;
	}
}
