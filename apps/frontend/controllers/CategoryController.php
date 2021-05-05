<?php

namespace Multiple\Frontend\Controllers;
use Multiple\PHOClass\PHOController;
//use Phalcon\Mvc\Controller;
use Multiple\Models\Product;
use Multiple\Models\Category;
use Multiple\Models\News;
use Multiple\Models\Project;
use Multiple\PHOClass\PhoLog;
//use Phalcon\Cache\Backend\File as BackFile;
//use Phalcon\Cache\Frontend\Data as FrontData;
class CategoryController extends PHOController
{

	public function indexAction($ctg_no)
	{      
        $page=1;
      	$param = $this->get_Gparam(array('page'));   
        if(isset($param['page']) && strlen($param['page']) > 0){
            $page=$param['page'];
        }
        $db = new Product();
        $ctg = new Category();
        $start_row = 0;
        if( $page > 1){
            $start_row = ( $page-1)*PAGE_LIMIT_RECORD ;
        }

        $param['page'] = $page;
        $param['ctg_name'] ='Sản phẩm mới';
        $param['ctg_no'] ='san-pham-moi';
        $param['breadcrumbs'] = array();
        $param['rel_menu']= array();
        $arr_chk=array('san-pham-moi','ban-chay','top-chiet-khau');
        //PhoLog::debug_var('---abc--',$ctg_no);
        $param['disp_dm'] = 0;
        if(!in_array($ctg_no,$arr_chk) ){
            $info = $ctg->get_ctg_byno($ctg_no);
            $param['ctg_name'] = $info->ctg_name;
            $param['description'] = $info->description;
        	//$param['keywords'] = $info->keywords;
            $param['title'] = $info->title;            
            if($info->ctg_id =='1' || $info->ctg_id=='2'){
				$param['type'] = $info->ctg_id;
			}else{
				$param['ctgid'] = $info->ctg_id;
				$param['type'] = $info->parent_id;
			}
			$param['breadcrumbs'] =$ctg->get_breadcrumb($info->parent_id);
			$param['rel_menu'] =$ctg->get_list_relation($info->ctg_code,15);
            
            $param['disp_dm'] = $info->ctg_level;
                      
        }else{
			$param['description'] = 'Thời trang nam, thời trang, nữ phụ kiện công nghệ, bán lẻ giá sỉ';
			$param['title'] = 'Thời trang nam, thời trang, nữ phụ kiện công nghệ, bán lẻ giá sỉ';
			$param['rel_menu'] =$ctg->get_list_relation('',15);
			if($ctg_no=='ban-chay'){
				$param['ctg_name']="Bán chạy";
			}elseif($ctg_no=='top-chiet-khau'){
				$param['ctg_name']="Top chiết khấu";
			}
		}
		$param['ctg_no'] ='c/'. $ctg_no;
		$param['list'] = $db->get_list_byctg($ctg_no,$start_row);
		
        
        $param['total_post'] = $db->get_list_byctg_count($ctg_no);
        $param['total_page']=  ceil($param['total_post']/PAGE_LIMIT_RECORD);
        
        $start = $page - 2;
        $end = $page + 2;
        if($page < 3){
            $start = 1;
            $end = $start + 4;
            if($end > $param['total_page']){
               $end = $param['total_page'];
            }
        }
        if($param['total_page']< $page + 2 ){
            $end = $param['total_page'];
            $start = $param['total_page'] - 4;
            if($start < 1){
               $start = 1;
            }
        }
        $param['start'] = $start;
        $param['end'] = $end;
        //PhoLog::debug_var('--ccc--',$param);
        //$this->set_template_share();
        $this->ViewVAR($param);
	}
	public function newslistAction($ctg_no)
	{
      
      	$page=1;
        $param = $this->get_Gparam(array('page'));   
        if(isset($param['page']) && strlen($param['page']) > 0){
            $page=$param['page'];
        }
        $cache = $this->createCache(600); //10 phut
        $cachekey = $ctg_no."_p".$page;
        $param = $cache->get($cachekey);
        if($param == null){
            $db = new News();
            $ctg = new Category();
            $start_row = 0;
            if( $page > 1){
                $start_row = ( $page-1)*PAGE_NEWS_LIMIT_RECORD ;
            }

            $param['page'] = $page;
            $info = $ctg->get_ctg_byno($ctg_no);
            $param['description'] = $info->description;
            $param['ctg_name'] = $info->ctg_name;
            $param['title'] = $info->title;	
            $param['news']=$db->get_news_byctgno($ctg_no,$start_row);
            $param['total_post'] = $db->get_news_byctgno_count($ctg_no);
            $param['total_page']= round($param['total_post']/PAGE_NEWS_LIMIT_RECORD);
            $param['ctg_no'] ='dm/'. $ctg_no;
            
            if($info->ctg_id =='1' || $info->ctg_id=='2'){
				$param['type'] = $info->ctg_id;
			}else{
				$param['ctgid'] = $info->ctg_id;
				$param['type'] = $info->parent_id;
			}
			$param['breadcrumbs'] =$ctg->get_breadcrumb($info->parent_id);
			$param['rel_menu'] =$ctg->get_list_relation($info->ctg_code,15);
            
            $param['disp_dm'] = $info->ctg_level;
            
            $start = $page - 2;
            $end = $page + 2;
            if($page < 3){
                $start = 1;
                $end = $start + 4;
                if($end > $param['total_page']){
                   $end = $param['total_page'];
                }
            }
            if($param['total_page']< $page + 2 ){
                $end = $param['total_page'];
                $start = $param['total_page'] - 4;
                if($start < 1){
                   $start = 1;
                }
            }
            $param['start'] = $start;
            $param['end'] = $end;
            $cache->save($cachekey,$param);
        }
        //PhoLog::debug_var('---abc--',$param);
       // $this->set_template_share();
        $this->ViewVAR($param);
	}
	public function prolistAction($ctg_no)
	{
      
      	$page=1;
        $param = $this->get_Gparam(array('page'));   
        if(isset($param['page']) && strlen($param['page']) > 0){
            $page=$param['page'];
        }
        $cache = $this->createCache( 600); //10 phut
        $cachekey = $ctg_no."_da".$page;
        $param = $cache->get($cachekey);
        if($param == null){
            $db = new Project();
            $ctg = new Category();
            $start_row = 0;
            if( $page > 1){
                $start_row = ( $page-1)*PAGE_NEWS_LIMIT_RECORD ;
            }

            $param['page'] = $page;
            $info = $ctg->get_ctg_byno($ctg_no);
            $param['ctg_name'] = $info->ctg_name;
            $param['pros']=$db->get_project_byctgno($ctg_no,$start_row);
            $param['total_post'] = $db->get_project_byctgno_count($ctg_no);
            $param['total_page']= round($param['total_post']/PAGE_NEWS_LIMIT_RECORD);
            $param['ctg_no'] ='la/' .$ctg_no;
            $start = $page - 2;
            $end = $page + 2;
            if($page < 3){
                $start = 1;
                $end = $start + 4;
                if($end > $param['total_page']){
                   $end = $param['total_page'];
                }
            }
            if($param['total_page']< $page + 2 ){
                $end = $param['total_page'];
                $start = $param['total_page'] - 4;
                if($start < 1){
                   $start = 1;
                }
            }
            $param['start'] = $start;
            $param['end'] = $end;
            $cache->save($cachekey,$param);
        }
        //PhoLog::debug_var('---abc--',$param);
       // $this->set_template_share();
        $this->ViewVAR($param);
	}		
	public function searchAction()
	{
        $param = $this->get_Gparam(array('sp','page'));
        //$param = $_GET;
        //PhoLog::debug_var('--testse---',$param);
        //PhoLog::debug_var('--testse---',$_GET);
        $page = 1;
      	if(isset($param['page']) && strlen($param['page']) > 0){
            $page=$param['page'];
        }
        $db = new Product();
        $ctg = new Category();
        $start_row = 0;
        if( $page > 1){
            $start_row = ( $page-1)*PAGE_LIMIT_RECORD ;
        }

        $param['page'] = $page;
        $param['ctg_name'] ="Kết quả tìm '".$param['sp']."'";
        $param['ctg_no'] = str_replace('/','', $_SERVER['REQUEST_URI']);
        $exp = explode('&page',$param['ctg_no'])  ;
        $param['ctg_no']=  $exp[0]; 
        $sp_search = $this->convert_ascii($param['sp']);
         
        $param['list']=$db->search_product($sp_search,$start_row);
        $param['total_post'] = $db->search_product_count($sp_search);
        $param['total_page']= round($param['total_post']/PAGE_LIMIT_RECORD);
        $param['disp_dm'] = 0;
        $param['description'] = 'Thời trang nam, thời trang, nữ phụ kiện công nghệ, bán lẻ giá sỉ';
        $param['title'] = 'Thời trang nam, thời trang, nữ phụ kiện công nghệ, bán lẻ giá sỉ';
        //$param['rel_menu'] =$ctg->get_list_relation('',15);
            

        $start = $page - 2;
        $end = $page + 2;
        if($page < 3){
            $start = 1;
            $end = $start + 4;
            if($end > $param['total_page']){
               $end = $param['total_page'];
            }
        }
        if($param['total_page']< $page + 2 ){
            $end = $param['total_page'];
            $start = $param['total_page'] - 4;
            if($start < 1){
               $start = 1;
            }
        }
        $param['start'] = $start;
        $param['end'] = $end;
        $param['rel_menu'] =$ctg->get_list_search($sp_search,15);
        //$param['dstlist'] = array();
        //if(isset($param['provin']) && strlen($param['provin']) > 0){
            //$param['dstlist'] = $db->get_bydistrict($param);
        //}
        //PhoLog::debug_var('---abc--',$param['dstlist']);
        //$this->set_template_share();
        $this->ViewVAR($param);
	}
}
