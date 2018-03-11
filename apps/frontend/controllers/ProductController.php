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
			
			$db = new Product();
			$img = new ProductImg();
			$price = new ProductPrice();
			$ctg = new Category();
			$exp  = explode('_', $url)	;	
			$id = $exp[count($exp)-1];
			
			$result = $db->get_product_info($id);
			//$result['des']= substr($result['content'],0,150).'...';			
			
			$result['imglist'] = $img->get_img_bypro($id);			
			$result['pricelist'] = $price->get_list_bypro($id);
			$result['breadcrumbs'] = $ctg->get_breadcrumb($result['ctg_id']);
		
			//update traffic
			//PhoLog::debug_var('view----',__LINE__);
			//$time = time();
			//$traffic['time'] = $time;//-600;  //10phut		
			//$traffic['section_id'] = session_id();
			//PhoLog::debug_var('view----',__LINE__);
			//$traffic['ip'] = $this->get_client_ip_server();			
			//PhoLog::debug_var('view----',__LINE__);
			//$db->update_traffic($traffic);			
			
			$result['relations']= $db->get_relation($result['ctg_id'],$result['pro_id'],6);
			PhoLog::debug_var('view----',$result['relations']);
	        
			$this->ViewVAR($result);	
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
	
	
	
}
