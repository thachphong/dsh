<?php

namespace Multiple\Models;

use Multiple\Models\DBModel;
use Multiple\PHOClass\PHOArray;
//use Phalcon\Mvc\Model\Query;

class Menu extends DBModel
{
    public $menu_id;    
    public $menu_name;                   
    public $parent_id;
    public $del_flg;
    public $add_date;
    public $add_user;
    public $upd_date;
    public $upd_user;
    public $menu_level;
    public $sort;
    public $page_flg;
    public $link;
    public $position; //0 : top :1 bottom
    public function initialize()
    {
        $this->setSource("menu");
    }
    public function get_menu_all($all_flg= FALSE)
    {
        $sql = "select * from(
                (select * ,CONCAT(LPAD(sort,5,'0'),'_',LPAD(menu_id,5,'0'))   sort2
                from menu
                where menu_level = 1)
                union
                (select m.* , CONCAT(m1.sort2,'_',LPAD(m.sort,5,'0'),'_',LPAD(m.menu_id,5,'0')) sort2
                from 
                menu m,
                (select * ,CONCAT(LPAD(sort,5,'0'),'_',LPAD(menu_id,5,'0'))   sort2
                from menu m
                where menu_level = 1) m1
                where m.parent_id = m1.menu_id
                and m.menu_level = 2 )
                union
                (select m3.*, CONCAT(m2.sort2,'_',LPAD(m3.sort,5,'0'),'_',LPAD(m3.menu_id,5,'0')) sort2
                from menu m3,
                (select m.* , CONCAT(m1.sort2,'_',LPAD(m.sort,5,'0'),'_',LPAD(m.menu_id,5,'0')) sort2
                from 
                menu m,
                (select * ,CONCAT(LPAD(sort,5,'0'),'_',LPAD(menu_id,5,'0'))   sort2
                from menu m
                where menu_level = 1) m1
                where m.parent_id = m1.menu_id
                and m.menu_level = 2 ) m2
                where m3.parent_id = m2.menu_id
                and m3.menu_level = 3)

                ) t
                ORDER BY t.sort2";
        
        return $this->pho_query($sql);
    }
    public function get_menu_list($level,$position=0)
    {
        return $this->pho_query("select m.menu_id,m.parent_id, m.menu_name,m.menu_level,m.del_flg,m.sort,m1.menu_name menu_name_1, m2.menu_name menu_name_2
                from menu m
                LEFT JOIN menu m1 on m1.menu_id = m.parent_id 
                LEFT JOIN menu m2 on m2.menu_id = m1.parent_id
                where m.menu_level = $level
                and m.position = $position
                ORDER BY m.sort " );
    } 
    public function get_menu_list_info($level,$position=0)
    {
        return $this->pho_query("select m.menu_id,m.parent_id, m.menu_name,m.menu_level,m.del_flg,m.sort,m1.menu_name menu_name_1, m2.menu_name menu_name_2,
( case m.page_flg when 1 then 'Trang' when 2 then 'Danh mục' when 3 then 'Tin tức' when 4 then 'Dự án' end) type,
(case m.page_flg when 1 then p.page_name else c.ctg_name end ) dm_name
                from menu m
                LEFT JOIN menu m1 on m1.menu_id = m.parent_id 
                LEFT JOIN menu m2 on m2.menu_id = m1.parent_id
								LEFT JOIN category c on c.ctg_no = m.link
								LEFT JOIN page p on p.page_no = m.link and m.page_flg =1
                where m.menu_level = $level
                and m.position = $position
                ORDER BY m.sort  " );
    }  
    public function get_menu_head($position=0){
        $sql = "select t.menu_id,menu_level,parent_id,link,page_flg,menu_name menu_name
                ,(select count(*) from menu where  parent_id = t.menu_id) child_flg
                from menu t
                where del_flg = 0
                and position = $position
                ORDER BY sort";
        return $this->pho_query($sql);
    }
    public function get_menus()
    {        
        $res =  $this->get_menu_head(0);
        $menu = array();
        $this->set_child($menu,$res,0);
        return $menu;       
    }
    public function get_menus_bottom()
    {        
        return  $this->get_menu_head(1);       
    }
    public function set_child(&$menu,&$list,$parent_id){
        foreach($list as $key=>$item){
            if($item['parent_id'] == $parent_id){
                if($item['child_flg'] == 0){
                    $menu[] = $item ;
                    //unset($list[$key]);                
                }else{
                    $data = $item;
                    //unset($list[$key]);   
                    $data['child']= array();                
                    $this->set_child($data['child'],$list,$data['menu_id']);
                    $menu[]= $data;
                }
            }
        }
    }
    public function _update($param)
    {        
        // $login_info =  $this->session->get('auth');
        // $param['user_id'] = $login_info->user_id;
        //$param['ctg_no'] =str_replace(' ','-', ACWModel::convert_vi_to_en( $param['ctg_name']));
        $param['parent_id']=0;
        if(isset($param['parent_id_2']) && strlen($param['parent_id_2'])>0){
            $param['parent_id'] = $param['parent_id_2'];
        }else if(isset($param['parent_id_1']) && strlen($param['parent_id_1'])>0){
            $param['parent_id'] = $param['parent_id_1'];
        }
        if(strlen($param['page_flg'])==0){
        	$param['page_flg'] = 0;
    	}
        $sql = "update menu
                    set menu_name = :menu_name  
                    ,page_flg = :page_flg   
                    ,parent_id =:parent_id          
                    ,del_flg = :del_flg                 
                    ,upd_date =  now()
                    ,upd_user =:user_id
                    ,sort = :menu_sort
                    ,link = :link
                    where menu_id = :menu_id
                ";
        
 
        $this->pho_execute($sql, PHOArray::filter($param, array(
                    'menu_id'
                    ,'menu_name'    
                    ,'page_flg'                             
                    ,'menu_sort'
                    ,'user_id'
                    ,'del_flg'
                    ,'link'
                    ,'parent_id'
                    )));     
        return TRUE;
    }
    public function _insert($param)
    {
        
        $param['parent_id']=0;
        if(isset($param['parent_id_2']) && strlen($param['parent_id_2'])>0){
            $param['parent_id'] = $param['parent_id_2'];
        }else if(isset($param['parent_id_1']) && strlen($param['parent_id_1'])>0){
            $param['parent_id'] = $param['parent_id_1'];
        }
        
        $this->menu_name = $param['menu_name'] ;                  
        $this->parent_id = $param['parent_id'] ;   
        $this->del_flg = 0 ;   
        //$this->add_date
        $this->add_user = $param['user_id'] ;   
        //$this->upd_date
        $this->upd_user = $param['user_id'] ;   
        $this->menu_level = $param['menu_level'] ;   
        $this->sort     = $param['menu_sort'] ;   
        $this->page_flg = $param['page_flg'] ;   
        $this->link     = $param['link'] ; 
        $this->position  =$param['position'];
        return $this->save();
    }
    public function get_menu_info($ctg_id)
    {
        $r = $this->pho_query("
            select m.menu_id
                    ,m.menu_name
              ,(CASE m.menu_level WHEN  3 THEN   m1.parent_id else  m.parent_id END)  parent_id_1
                    ,m.del_flg                  
                    ,m.sort 
                    ,m.menu_level
                    ,m.page_flg
                    ,m.link
                    ,m.position
                    ,m1.parent_id menu_name_2
                    ,(CASE m.menu_level WHEN  3 THEN   m.parent_id else  0 END)  parent_id_2
                from menu m
                LEFT JOIN menu m1 on m1.menu_id = m.parent_id
                where m.menu_id = :menu_id
            ", array ('menu_id' => $ctg_id));
        if(count($r) >0)
            return $r[0];
        else
            return null;
    }
}
