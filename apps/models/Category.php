<?php

namespace Multiple\Models;

use Multiple\Models\DBModel;
use Multiple\PHOClass\PHOArray;
use Multiple\PHOClass\PHOLog;
class Category extends DBModel
{
    public $ctg_id;
    public $ctg_name;
    public $ctg_no;
    public $ctg_code;
    public $parent_id;
    public $del_flg;
    public $add_date;
    public $add_user;
    public $upd_date;
    public $upd_user;
    public $ctg_level;
    public $sort;
    public $news_flg;  //0 tin post, 1 tin tuc, 2 du án
    public $m_type_id;
    public function initialize()
    {
        $this->setSource("category");
    }
    public function get_category_rows($news_flg)
    {
        $sql = "select t.ctg_id,t.ctg_name,t.ctg_no,t.cnt_child,t.ctg_level,t.parent_id from(
                (select * ,CONCAT(LPAD(sort,5,'0'),'_',LPAD(ctg_id,5,'0'))   sort2,
                (SELECT count(*) from category where parent_id = x.ctg_id and del_flg = 0)  cnt_child
                from category x
                where ctg_level = 1 and news_flg = $news_flg)
                union
                (select m.* , CONCAT(m1.sort2,'_',LPAD(m.sort,5,'0'),'_',LPAD(m.ctg_id,5,'0')) sort2,
                (SELECT count(*) from category where parent_id = m.ctg_id and del_flg = 0)  cnt_child
                from 
                category m,
                (select * ,CONCAT(LPAD(sort,5,'0'),'_',LPAD(ctg_id,5,'0'))   sort2
                from category m
                where ctg_level = 1 and news_flg = $news_flg) m1
                where m.parent_id = m1.ctg_id
                and m.ctg_level = 2 )
                union
                (select m3.*, CONCAT(m2.sort2,'_',LPAD(m3.sort,5,'0'),'_',LPAD(m3.ctg_id,5,'0')) sort2,0 as cnt_child
                from category m3,
                (select m.* , CONCAT(m1.sort2,'_',LPAD(m.sort,5,'0'),'_',LPAD(m.ctg_id,5,'0')) sort2
                from 
                category m,
                (select * ,CONCAT(LPAD(sort,5,'0'),'_',LPAD(ctg_id,5,'0'))   sort2
                from category m
                where ctg_level = 1 and news_flg = $news_flg) m1
                where m.parent_id = m1.ctg_id
                and m.ctg_level = 2 ) m2
                where m3.parent_id = m2.ctg_id
                and m3.ctg_level = 3)

                ) t where t.del_flg = 0
                ORDER BY t.sort2";
        
        return $this->pho_query($sql);
    }
    public function get_ctg_list($level,$news_flg=0)
    {
        return $this->pho_query("select m.ctg_id,m.parent_id, m.ctg_no,m.ctg_name,m.ctg_level,m.del_flg,m.sort,m1.ctg_name ctg_name_1,t.m_type_name,m.ctg_code
        ,m2.ctg_name ctg_name_2
                from category m
                LEFT JOIN category m1 on m1.ctg_id = m.parent_id 
                LEFT JOIN category m2 on m2.ctg_id = m1.parent_id
                LEFT JOIN m_type t on t.m_type_id = m.m_type_id
                where m.ctg_level = $level
                and  m.news_flg = $news_flg
                ORDER BY m.sort" );
    }
    public function get_ctg_info($ctg_id)
    {
        $r = $this->pho_query("
            select c.ctg_id
                    ,c.ctg_name
                    ,(case when IFNULL(p1.parent_id ,0)<>0 then p1.parent_id else c.parent_id end) as parent_id_1
					,(case when IFNULL(p1.parent_id ,0)<>0 then c.parent_id else p1.parent_id end) as parent_id_2
                    ,c.del_flg                    
                    ,c.sort 
                    ,c.ctg_level
                    ,c.news_flg
                    ,c.m_type_id
                    ,c.ctg_code
                from category c
								LEFT JOIN category p1 on p1.ctg_id = c.parent_id
                where c.ctg_id = :ctg_id
            ", array ('ctg_id' => $ctg_id));
        if(count($r) >0)
            return $r[0];
        else
            return null;
    }
    // public function get_category($ctg_no){
    //     return  Page::findFirst(array(
    //         "del_flg = 0 and ctg_no =:ctg_no:",
    //         'bind' => array('ctg_no'=>$ctg_no)
    //     ));       
    // }
    public function _insert($param)
    {
        //$this->begin_transaction();

        //$login_info = ACWSession::get('user_info');
        //$param['user_id'] = $login_info['user_id'];
        $param['parent_id']=0;
        if(isset($param['parent_id_2']) && strlen($param['parent_id_2'])>0){
            $param['parent_id'] = $param['parent_id_2'];
        }else if(isset($param['parent_id_1']) && strlen($param['parent_id_1'])>0){
            $param['parent_id'] = $param['parent_id_1'];
        }
        // $sql = "INSERT INTO category
        //             (
        //             ctg_name
        //             ,ctg_no
        //             ,parent_id
        //             ,del_flg
        //             ,add_date
        //             ,add_user
        //             ,upd_date
        //             ,upd_user
        //             ,ctg_level
        //             ,sort
        //             ,news_flg
        //             )
        //         VALUES
        //             (
        //             :ctg_name
        //             ,:ctg_no
        //             ,:parent_id
        //             ,0
        //             ,now()
        //             ,:user_id
        //             ,now()
        //             ,:user_id
        //             ,:ctg_level
        //             ,:ctg_sort
        //             ,:news_flg
        //             )
        //         ";
        
 
        // $this->execute($sql, ACWArray::filter($param, array(
        //             'ctg_name'
        //             ,'ctg_no'
        //             ,'parent_id'                    
        //             ,'ctg_sort'
        //             ,'ctg_level'
        //             ,'user_id'
        //             ,'news_flg'
        //             )));            
        // $result = $this->query("SELECT LAST_INSERT_ID() AS ctg_id");            
        // $new_id = $result[0]['ctg_id']; 
        // $this->commit();
        $this->ctg_name = $param['ctg_name'];
        $this->ctg_no = $param['ctg_no'];
        $this->parent_id = $param['parent_id'];
        $this->del_flg = 0;
        //$this->add_date = $param['ctg_name'];
        $this->add_user = $param['user_id'];
        //$this->upd_date = $param['ctg_name'];
        $this->upd_user = $param['user_id'];
        $this->ctg_level = $param['ctg_level'];
        $this->sort = $param['ctg_sort'];
        $this->news_flg = $param['news_flg'];
        $this->m_type_id = $param['m_type_id'];
        if($param['ctg_level'] ==1){
			$this->ctg_code = $this->get_code_max($param['parent_id']);
			$this->ctg_code++;
		}else{
			$this->ctg_code = $this->get_code_max($param['parent_id']);
			if($this->ctg_code =='A'){
				$pa = $this->get_ctg_info($param['parent_id']);
				$this->ctg_code =$pa['ctg_code'].'A';
			}else{
				$this->ctg_code++;
			}
		}        
        
        $this->save();
        return $this->ctg_id;
    }
    
    public function _update($param)
    {      
        $param['parent_id']=0;
        if(isset($param['parent_id_2']) && strlen($param['parent_id_2'])>0){
            $param['parent_id'] = $param['parent_id_2'];
        }else if(isset($param['parent_id_1']) && strlen($param['parent_id_1'])>0){
            $param['parent_id'] = $param['parent_id_1'];
        }
        $sql = "update category
                    set ctg_name = :ctg_name    
                    ,ctg_no = :ctg_no               
                    ,del_flg = :del_flg                 
                    ,upd_date =  now()
                    ,upd_user =:user_id
                    ,sort = :ctg_sort
                    ,m_type_id = :m_type_id
                    ,parent_id=:parent_id
                    where ctg_id = :ctg_id
                ";
        
 
        $this->pho_execute($sql, PHOArray::filter($param, array(
                    'ctg_id'
                    ,'ctg_name' 
                    ,'ctg_no'                               
                    ,'ctg_sort'
                    ,'user_id'
                    ,'del_flg'
                    ,'m_type_id'
                    ,'parent_id'
                    )));  
        return TRUE;
    }
    public function get_ctg_byno($ctg_no){
        //return Category::findFirst(array('ctg_no'=>$ctg_no));
        return  Category::findFirst(array(
                "ctg_no = :ctg_no: ",
                'bind' => array('ctg_no' => $ctg_no)
        ));
    }    
    public function get_ctg_exist($ctg_no,$ctg_id){        
        return  Category::findFirst(array(
                "ctg_no = :ctg_no: and ctg_id <> :ctg_id:",
                'bind' => array('ctg_no' => $ctg_no,'ctg_id'=>$ctg_id)
        ));
    }
    public static function get_all(){
        $data = Category::find(['del_flg = 0','order'=>'ctg_name']);        
        return $data;
    }
    public function get_child($ctg_id){
		$sql="select ctg_id
					,ctg_no
                    ,ctg_name                  
                    ,del_flg                    
                    ,sort 
                    ,ctg_level
                    ,news_flg
                    ,m_type_id
                from category
                where parent_id = :ctg_id
                and del_flg =0";
        return $this->pho_query($sql,array('ctg_id'=>$ctg_id));
		
	}
	public function get_code_max($parent_id){
		$sql ="select IFNULL(max(ctg_code),'A') code_max from category where parent_id = $parent_id";
		$res = $this->query_first($sql);
		return $res['code_max'];
	}
	public function get_ctg_head($position=0){
        $sql = "select t.ctg_id,ctg_level,parent_id,ctg_no,ctg_name menu_name
                ,(select count(*) from category where  parent_id = t.ctg_id) child_flg
                from category t
                where del_flg = 0            
                ORDER BY sort";
        return $this->pho_query($sql);
    }	
	public function get_categorys()
    {        
        $res =  $this->get_ctg_head();
        $menu = array();
        $this->set_child($menu,$res,0);
        //PhoLog::debug_var('--test--',$menu);
        return $menu;       
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
                    $this->set_child($data['child'],$list,$data['ctg_id']);
                    $menu[]= $data;
                }
            }
        }
    }
    public function get_breadcrumb($ctg_id){
		$sql="SELECT t1.ctg_name AS ctg_name4, t2.ctg_name as ctg_name3, t3.ctg_name as ctg_name2,t4.ctg_name as ctg_name1,
			t1.ctg_no AS ctg_no4, t2.ctg_no as ctg_no3, t3.ctg_no as ctg_no2,t4.ctg_no as ctg_no1
			FROM category AS t1
			LEFT JOIN category AS t2 ON t2.ctg_id = t1.parent_id
			LEFT JOIN category AS t3 ON t3.ctg_id = t2.parent_id
			LEFT JOIN category AS t4 ON t4.ctg_id = t3.parent_id
			WHERE t1.ctg_id = :ctg_id";
		$r = $this->query_first($sql,array('ctg_id'=>$ctg_id));
		if(count($r) >0){
			$result = array();
			if( strlen($r['ctg_name1'])>0){
				$result[] = array('ctg_no'=> $r['ctg_no1'],'ctg_name'=> $r['ctg_name1']);
			}
			if( strlen($r['ctg_name2'])>0){
				$result[] = array('ctg_no'=> $r['ctg_no2'],'ctg_name'=> $r['ctg_name2']);
			}
			if( strlen($r['ctg_name3'])>0){
				$result[] = array('ctg_no'=> $r['ctg_no3'],'ctg_name'=> $r['ctg_name3']);
			}
			if( strlen($r['ctg_name4'])>0){
				$result[] = array('ctg_no'=> $r['ctg_no4'],'ctg_name'=> $r['ctg_name4']);
			}
			return $result;
		} 
        else
            return null;
	}
	public function get_list_relation($ctg_code,$limit = 10){
		$sql="select ctg_id,ctg_level,parent_id,ctg_no,ctg_name  from 
				(select * from category
				where ctg_code like :ctg_code1
				and ctg_level = 3
				UNION 
				select * from category
				where ctg_code like :ctg_code2
				and ctg_level = 3
				) t
				limit $limit
				";		
		$ctg_code1= substr($ctg_code,0,2).'%';
		$ctg_code2= substr($ctg_code,0,1).'%';
		return $this->pho_query($sql,array('ctg_code1'=>$ctg_code1,'ctg_code2'=>$ctg_code2));		
	}
}