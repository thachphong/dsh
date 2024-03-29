<?php

namespace Multiple\Frontend\Controllers;

use Multiple\PHOClass\PHOController;
use Multiple\Models\Product;
use Multiple\Models\ProductPrice;
use Multiple\Models\ProductImg;
use Multiple\Models\PostsContract;

use Multiple\Models\Tags;
use Multiple\Models\CheckView;
use Multiple\Models\Provincial;
use Multiple\Models\District;
use Multiple\Models\Ward;
use Multiple\Models\Street;
use Multiple\Models\Directional;
use Multiple\Models\Unit;
use Multiple\Models\Category;
use Multiple\Library\FilePHP;
use Multiple\PHOClass\PhoLog;
class ProductController extends PHOController
{
	public function initialize()
    {        
        //$this->check_login();
    }
	public function indexAction($url)
	{
		try{	
			//PhoLog::debug_var('view----',$url);
			$db = new Product();
			$img = new ProductImg();
			$price = new ProductPrice();
			$ctg = new Category();
			$exp  = explode('_', $url)	;	
			$id = $exp[count($exp)-1];
			//PhoLog::debug_var('view----',__LINE__);
			$result = $db->get_product_info($id);
			//$result['des']= substr($result['content'],0,150).'...';	
			$sizelist =array();
			if(strlen($result['sizelist'])>0){
				$sizelist= explode(';',$result['sizelist']);
			}	
			//PhoLog::debug_var('view----',__LINE__);	
			$result['sizes'] = $sizelist;
			$result['imglist'] =  $img->get_img_bypro($id);			
			$result['pricelist'] = $price->get_list_bypro($id);
			$result['breadcrumbs'] = $ctg->get_breadcrumb($result['ctg_id']);
			$color_flg = 0;
			foreach($result['imglist'] as $item){
				if($item->color !=''){
					$color_flg = 1;
				}
			}
			$result['color_flg']=$color_flg;
			//update traffic
			//PhoLog::debug_var('view----',__LINE__);
			//$time = time();
			//$traffic['time'] = $time;//-600;  //10phut		
			//$traffic['section_id'] = session_id();
			//PhoLog::debug_var('view----',__LINE__);
			//$traffic['ip'] = $this->get_client_ip_server();			
			//PhoLog::debug_var('view----',__LINE__);
			//$db->update_traffic($traffic);			
			
			$result['relations']= $db->get_relation($result['ctg_id'],$result['pro_id'],8);
			//PhoLog::debug_var('view----',$result['relations']);
	        //PhoLog::debug_var('view----',__LINE__);
	        //PhoLog::debug_var('view----',$result);
			return $this->ViewVAR($result);	
		} catch (\Exception $e) {
			PhoLog::debug_var('---Error---',$e);
		}
	}
	public function check_online(){
		
		
	}
	public function viewAction($id)
	{
		//$url =  $this->request->getURI();
        //$abc =1;
       // $post_data= Posts::findFirst
        $this->set_template_share();
		//$this->ViewVAR($result);
	}
	public function listAction(){
		
		$param = $_GET;
        //PhoLog::debug_var('---search---',$param);
        $page = 1;
      	if(isset($param['page']) && strlen($param['page']) > 0){
            $page=$param['page'];
        }
        $db = new Posts();
        $ctg = new Category();
        $user = $this->session->get('auth');
		//$result['list']=$db->get_list_byuser($user->user_id);
		$param['user_id'] =$user->user_id;
        $start_row = 0;
        if( $page > 1){
            $start_row = ( $page-1)*PAGE_SEARCH_LIMIT_RECORD ;
        }

        $param['page'] = $page;
        //$param['ctg_name'] ='Kết quả tìm';
        $param['ctg_no'] = str_replace('/','', $_SERVER['REQUEST_URI']);
        $exp = explode('&page',$param['ctg_no'])  ;
        $param['ctg_no']=  $exp[0]; 
                  
        $param['list']=$db->get_list_byuser($param,$start_row);
        $param['total_post'] = $db->get_byuser_count($param);
        $param['total_page']= round($param['total_post']/PAGE_SEARCH_LIMIT_RECORD);
        
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
        if(!isset($param['plevel']) ){
			$param['plevel'] = '';
		}
		if(!isset($param['status']) ){			
			$param['status'] = '';
		}
		if(!isset($param['postno']) ){			
			$param['postno'] = '';
		}
		if(!isset($param['fdate'])){			
			$param['fdate'] = '';
		}
		if(!isset($param['tdate'])){			
			$param['tdate'] = '';
		}
        $this->set_template_share();
        $this->ViewVAR($param);
		
		//$db = new Posts();
		//$user = $this->session->get('auth');
		//$result['list']=$db->get_list_byuser($user->user_id);
		//$this->set_template_share();
		//$this->ViewVAR($result);	
	}
	
	
}
