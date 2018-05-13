<?php

namespace Multiple\Backend\Controllers;

use Multiple\PHOClass\PHOController;
use Multiple\Models\DownloadStructure;
use Multiple\Models\DownloadTemp;
use Multiple\Library\AutoDownload;
use Multiple\Models\Category;
use Multiple\Models\Posts;
use Multiple\Models\Tags;
use Multiple\Models\TagsPosts;
use Multiple\Models\DownloadCategory;
use Multiple\Models\Product;
use Multiple\Models\ProductImg;
use Multiple\Models\ProductPrice;
use Multiple\Library\FilePHP;
use Multiple\PHOClass\PhoLog;


//require __DIR__.'/../../library/AutoDownload.php';

class DownloadController extends PHOController
{
	public function initialize()
    {
        $this->check_loginadmin();
    }
	public function indexAction()
	{
		//$this->view->disable();
		$menu = new Category();
		$list_menu = $menu->get_All();
		$this->view->listmenu = $list_menu;
		$ctg = new DownloadCategory();

		$this->view->ctglist = $ctg->get_All();
		$this->view->date_out =date('H:i');
	}
    public function dlbyurlAction()
    {
        //$this->view->setVar('pass', sha1('admin'));
        //return $this->ViewHtml('download/dlbyurl',array());
        $ctg = new Category();
        $result['categorys']= $ctg->get_category_rows(0);
        $this->set_template_share();
        return $this->ViewVAR($result);
    }
    public function downloadurlAction(){
        $result['status']='NOT';
        $result['msg']='Download thất bại !!!';
        if ($this->request->isPost()) {
            $param =$this->get_param(array('link_dl','ctg_id'));
            if($this->dl_product_by_link($param['link_dl'],$param['ctg_id'])){
                $result['status']='OK';
                $result['msg']='Download thành công !';
            }            
        }
        return $this->ViewJSON($result);
    }
    public function downloadctgAction(){
        $result['status']='NOT';
        $result['msg']='Download thất bại !!!';
        if ($this->request->isPost()) {
            $param =$this->get_param(array('max_dl','ctg_id','ctg_url'));
            $ctg = new DownloadCategory();
            if(isset($param['ctg_url']) && strlen($param['ctg_url']) > 0){
                $ctg->link=$param['ctg_url'];
                $ctg->menu_id=$param['ctg_id'];
                $category[]= $ctg;
            }else{
                $category = $ctg->get_All($param['ctg_id']);
            }
            
            //PhoLog::debug_var('---link---',$category);
            $dl = new AutoDownload();
            $structure= new DownloadStructure();
            foreach($category as $item)
            {
                preg_match('/^(http:\/\/).+?\//',$item->link,$match);
                if(count($match)==0){
                    preg_match('/^(https:\/\/).+?\//',$item->link,$match);
                }
                PhoLog::debug_var('---link---','match:'.$match[0]);
                PhoLog::debug_var('---link---','id:'.$param['ctg_id']);
                $data_st = $structure->get_by_ctg_link($match[0],$param['ctg_id']);            
                if($dl->Set_URL($item->link)== FALSE){
                    continue;
                }
                //PhoLog::debug_var('---link---',$data_st);
                $link_get = array();
             
                foreach($data_st as $row){
                    if($row->key=='category_link'){
                        $link_get = $dl->get_link($row->xpath,$match[0]);
                    }else if($row->key=='del'){
                        //$this->logger->info('del'); 
                        //$this->logger->info($row->xpath); 
                        $dl->remove_element($row->xpath,$row->element_remove); 
                    }
                }
                //PhoLog::debug_var('---link---',$link_get);
                foreach($link_get as $link){
                    $dltemp = new DownloadTemp();                    
                    //$this->logger->info('link: '.$link['link']);
                    
                    if(isset($link['title']) && strlen($link['title'])>0 && $dltemp->check_exists($link['link'])){
                        $dltemp->link_dl = $link['link'];
                        $dltemp->status = 0;
                        $dltemp->caption = $link['title'];
                        $dltemp->img_link = $link['img_link'];
                        $dltemp->menu_id = $item->menu_id;
                            
                        $dltemp->save();                       
                    }           
                }                
            }
            $temp = new DownloadTemp();
            $list=$temp->get_All(0,$param['ctg_id']);
            foreach($list as $row){
                //PhoLog::debug_var('---link---','link_dl:'.$row->link_dl);
                //PhoLog::debug_var('---link---','link_dl:'.$row->menu_id);
                if($this->dl_product_by_link($row->link_dl,$row->menu_id))
                {
                    $row->status = 1;                            
                    $row->save();
                }
            }
            $result['status']='OK';
            $result['msg']='Download thành công !';
                    
        }
        return $this->ViewJSON($result);
    }
    public function exeAction(){
        $this->view->disable();
        $result['status']='NOT';
        $result['msg']='';
        if ($this->request->isPost()) {

            $url = $this->request->getPost('link_dl');
            $menu_id = $this->request->getPost('menu_id');
          
            /*$dl = new AutoDownload();
            $structure= new DownloadStructure();
                        
            preg_match('/^(http:\/\/).+?\//',$url,$match);
            if(count($match)==0){
				preg_match('/^(https:\/\/).+?\//',$url,$match);
			}
            $data_st = $structure->get_by_ref_link($match[0]);
            $dl->set_URL($url);
            //$title = "div.artshow h1";
            //$content = "div.artbody";
            //$img = "div.artbody img";
            $title ='';
            $file_name ='';
            $content ='';
            $tags = array();
            foreach($data_st as $row){
                if($row->key=='title'){
                	//$this->logger->info('title');
                    $title = $dl->GetTitle($row->xpath);
                }else if($row->key =='image'){   
                	//$this->logger->info('image');             
                    $file_name = $dl->get_img($row->xpath,$match[0]);
                }else if($row->key=='del'){
                	//$this->logger->info('del'); 
                    $dl->remove_element($row->xpath,$row->element_remove); 
                }else if($row->key=='replace'){ 
                	//$this->logger->info('replace');    
                    $dl->replaceString($row->xpath,$row->from_string,$row->to_string);
                }else if($row->key=='des'){ 
                	//$this->logger->info('des');    
                	$des = $dl->get_text($row->xpath);
                }else if($row->key=='tag'){
                	$this->logger->info('tag');  
                	$this->logger->info($row->xpath);     
                	$tags = $dl->get_tag($row->xpath,$row->from_string,'');
                	
                }else if($row->key=='content'){
                	//$this->logger->info('content'); 
                    //foreach($data_st as $item){
                    //    if($item->key=='del'){
                    //        $dl->remove_element($item->xpath,$item->element_remove);
                    //    }
                    //}
                    $content = $dl->get_content($row->xpath,$match[0]);
                    //$this->logger->info('content2'); 
                }
            }

            //$title .= $dl->GetTitle($title) ;
            //$html .= $dl->get_innerHTML($content) ;
            //$html .= $dl->get_img($img) ;
            //$dl->remove_element('ins;script');
            //$html .= $dl->get_content($content);
           //$this->logger->info($content);
           	if(strlen($des)==0){
				$des = $this->get_des($content);
				//$content = str_replace($des,'',$content);
				
			}
			//$this->logger->info('----------------------------');
			//$this->logger->info($content);
    		$resource = $match[0];
    		
    	    
    	    $file_ext=	pathinfo($file_name,PATHINFO_EXTENSION);
    	    $title = html_entity_decode($title);
    		$post = new Posts();
    	    $post->caption = $title;
    	    $post->caption_url = $this->to_slug($title);
            $post->filename = $file_name;       
    	    $post->size = 0;
    	    $post->type = 'blog';
    	    $post->resource = $resource;
    	    $post->adduser= 1;
    	    $post->des = $des ;
    	    $post->content = $content;
            $post->menu_id = $menu_id;
            $post->add_date = date('Y-m-d');
            $post->add_time = date('H:i');
    	    $post->save(); 
    	    
    	    $tags_model = new Tags();
    	    if(count($tags) >0){
				foreach($tags as $tag){
					$tags_model = new Tags();
					$tag_data = Tags::findFirst(array("tag_no = :tag_no: ",'bind' => array('tag_no' => $tag['tag_no']) ));
					if($tag_data == FALSE)
					{
						$tag_data = new Tags();
						$tag_data->tag_no = $tag['tag_no'];
						$tag_data->tag_name = $tag['tag_name'];
						$tag_data->save();
					}
					
                	$this->logger->info($tag['tag_no']);
                	
					$tagpost = new TagsPosts();
					$tagpost->tag_id = $tag_data->tag_id;
					$tagpost->post_id = $post->id ;
					$tagpost->save();
				}
			}*/
			$this->download_by_link($url,$menu_id);
            $result['status']='OK';
            $result['msg']='Download thành công !';
        }
        $this->response->setJsonContent($result);
        return $this->response;
    }
    public function dlallAction(){
    	$this->view->disable();
    	$result['status']='NOT';
        $result['msg']='';
        $menu_id = $this->request->getPost('menu_id');
        if(strlen($menu_id)>0){
        	$ctg = new DownloadCategory();
			$category = $ctg->get_All($menu_id);
		}else{
			$category = DownloadCategory::find();
		}
		
		$dl = new AutoDownload();
		$structure= new DownloadStructure();
		foreach($category as $item)
		{
			preg_match('/^(http:\/\/).+?\//',$item->link,$match);
            if(count($match)==0){
				preg_match('/^(https:\/\/).+?\//',$item->link,$match);
			}
            $data_st = $structure->get_by_ctg_link($match[0],$item->id);            
			if($dl->Set_URL($item->link)== FALSE){
				continue;
			}
			$link_get = array();
			//$this->logger->info('---------1');
			foreach($data_st as $row){
                if($row->key=='category_link'){
                	$link_get = $dl->get_link($row->xpath,$match[0]);
                }else if($row->key=='del'){
                	//$this->logger->info('del'); 
                	//$this->logger->info($row->xpath); 
                    $dl->remove_element($row->xpath,$row->element_remove); 
                }
            }
            //$this->logger->info('---------2');
            foreach($link_get as $link){
            	$dltemp = new DownloadTemp();
            	//$this->logger->info('---------3');
            	$this->logger->info('link: '.$link['link']);
            	
            	if(isset($link['title']) && strlen($link['title'])>0 && $dltemp->check_exists($link['link'])){
            		//$this->logger->info('---------4');
					/*if($this->download_by_link($link['link'],$item->menu_id))
	            	{*/
						//$this->logger->info('---------5');
						$dltemp->link_dl = $link['link'];
						$dltemp->status = 0;
						$dltemp->caption = $link['title'];
						$dltemp->img_link = $link['img_link'];
						$dltemp->menu_id = $item->menu_id;
						$this->logger->info('dl_link: '.$dltemp->link_dl);
						$dltemp->save();
					//}
				}          	
            }
            $temp = new DownloadTemp();
            $list=$temp->get_All(0,$item->menu_id);
            foreach($list as $row){
				if($this->download_by_link($row->link_dl,$item->menu_id,$row->img_link))
	            {
						//$this->logger->info('---------5:'.$row->img_link);
						//$dltemp->link_dl = $link['link'];
						$row->status = 1;
						//$dltemp->caption = $link['title'];
						$row->save();
				}
			}
		}
		$result['status']='OK';
        $result['msg']='Download thành công !';
        $this->response->setJsonContent($result);
        return $this->response;
	}
	public function dlagainAction(){
    	$this->view->disable();
    	$result['status']='NOT';
        $result['msg']='';
        $menu_id = $this->request->getPost('menu_id');
        if(strlen($menu_id)>0){
        	$ctg = new DownloadCategory();
			$category = $ctg->get_All($menu_id);
		}else{
			$category = DownloadCategory::find();
		}
				
		foreach($category as $item)
		{			
            $temp = new DownloadTemp();
            $list=$temp->get_All(0,$item->menu_id);
            foreach($list as $row){
				if($this->download_by_link($row->link_dl,$item->menu_id,$row->img_link))
	            {
						//$this->logger->info('---------5');
						//$dltemp->link_dl = $link['link'];
						$row->status = 1;
						//$dltemp->caption = $link['title'];
						$row->save();
				}
			}
		}
		$result['status']='OK';
        $result['msg']='Download thành công !';
        $this->response->setJsonContent($result);
        return $this->response;
	}
    public function dl_product_by_link($url,$ctg_id,$img_link = ''){
        try{            
            $dl = new AutoDownload();
            $structure= new DownloadStructure();
                        
            preg_match('/^(http:\/\/).+?\//',$url,$match);
            if(count($match)==0){
                preg_match('/^(https:\/\/).+?\//',$url,$match);
            }
            $data_st = $structure->get_by_ref_link($match[0]);
            if($dl->set_URL($url)== FALSE){
                return FALSE;
            }
           
            $title ='';
            $img_list =array();
            $content ='';
            $datetime = '';
            $code ='';
            $tags = array();
            $price = 0;
            $folder_tmp = uniqid();
            foreach($data_st as $row){
                if($row->key=='title'){
                    //$this->logger->info('title');
                    $title = $dl->GetTitle($row->xpath);
                }else if($row->key =='image'){   
                    //$this->logger->info('image');                     
                    $img_list = $dl->get_img_list($row->xpath,$folder_tmp,$match[0]);
                    
                }else if($row->key=='del'){
                    //$this->logger->info('del'); 
                    $dl->remove_element($row->xpath,$row->element_remove); 
                }else if($row->key=='replace'){ 
                    //$this->logger->info('replace');    
                    $dl->replaceString($row->xpath,$row->from_string,$row->to_string);
                }else if($row->key=='des'){ 
                    //$this->logger->info('des');    
                    $des = $dl->get_text($row->xpath);
                }else if($row->key=='tag'){
                    //$this->logger->info('tag');  
                    //$this->logger->info($row->xpath);     
                    $tags = $dl->get_tag($row->xpath,$row->from_string,'');
                }else if($row->key=='datetime'){
                    //$this->logger->info('datetime');  
                    //$this->logger->info($row->xpath);     
                    $datetime = $dl->get_text($row->xpath);
                    //$this->logger->info($datetime);  
                }else if($row->key=='price'){                     
                    $price = $dl->get_text($row->xpath);
                    $price = trim(str_replace($row->from_string,$row->to_string, $price));
                    $price = str_replace('.','', $price);
                   
                }else if($row->key=='code'){                     
                    $code = trim($dl->get_text($row->xpath));                   
                   
                }else if($row->key=='content'){                    
                    $content = $dl->get_content($row->xpath,$match[0]);
                    //$this->logger->info('content2'); 
                }
            }
            //xoa ma
            
            $title = str_replace($code, '', $title);
            $title = html_entity_decode($title);
            $post = new Product();
            $param_ins['ctg_id']= $ctg_id;
            $param_ins['pro_name']= $title;
            $param_ins['disp_home']= 0;
            $param_ins['user_id']= 1;
            $param_ins['del_flg']= 1;
            $param_ins['src_link']= $url;
            $param_ins['content']= $content;
            $param_ins['pro_no']= $this->convert_url($title);
            $param_ins['sizelist']= $this->get_size_pro($content);
            $param_ins['description']= '';            
            $pro_id = $post->_insert($param_ins);
            PhoLog::debug_var('---insert---','code:'.$code);
            PhoLog::debug_var('---insert---',$param_ins);
            if(count($img_list)>0){
                $paimg['pro_id'] = $pro_id;
                foreach($img_list as $key=> $img){                    
                    $pimg = new ProductImg();
                    $paimg['img_path'] ='/images/products/'.$pro_id.'/'. $img['new'];
                    $paimg['avata_flg'] = 0;
                    if($key==0){
                        $paimg['avata_flg'] =1;
                    }
                    $paimg['color'] = '';                  
                    $content =  str_replace($img['old'], $paimg['img_path'] , $content) ;             
                    $pimg->_insert($paimg);
                }
            }
            // insert price for product
            $proprice = new ProductPrice();
            $proprice->pro_id = $pro_id;
            $proprice->size = '-';            
            $proprice->price_imp = $price;
            $proprice->price_seller = $this->cal_price($price,PERCENT_EXPORT);
            $proprice->price_exp = $this->cal_price($proprice->price_seller,PERCENT_SELLER);
            $proprice->avata_flg =1;
            $proprice->save();
            //
            $content = str_replace($code, '', $content);
            $content = str_replace('class="fr-fic fr-dib" /><br /> <br /> <img', 'class="fr-fic fr-dib" /><br /><img', $content);
            
            $post->content =  $content;
            $post->save();


            $file = new FilePHP();
            $file->CopyFolder(PHO_PUBLIC_PATH.'tmp/'.$folder_tmp,PHO_PUBLIC_PATH.'images/products/'.$pro_id);
            return TRUE;
        } catch (\Exception $e) {           
            PhoLog::Exception_log('---Error---',$e);
            return FALSE;
        }   
        
    }
    public function cal_price($price,$percent){
        if(!is_numeric($price)){
            PhoLog::debug_var('Price_error','is not numeric:'.$price);
            return 0;
        }
        $num_round =100;
        if($price >=30000){
            $num_round =1000;
        }
        $price = ceil(($price + $price*$percent/100)/$num_round) *$num_round;
       return $price;
    }
    public function get_size_pro($content){
        $pattern='/(\+ Size)+[\s\:\w+\,][^+]{1,100}/';
        preg_match($pattern,$content,$match);
        $find ="";
        if(isset($match[0]) && strlen($match[0])>0){
            $find = preg_replace('/(\()+[\w\d\>\s]+(\))/', '', $match[0]);
            //$find= preg_replace('/(<//div>)+.+/', '', $find);  
            $find = str_replace(array(' ','+Size:','.'), '', $find);  
            $find = preg_replace('/(\<\/div\>)+.+/', '', $find);
            $find = preg_replace('/(\<br\/\>)+.+/', '', $find); 
            $find = str_replace(',', ';', $find);
        }
        return $find; 
    }
	public function download_by_link($url,$menu_id,$img_link = ''){
		$dl = new AutoDownload();
            $structure= new DownloadStructure();
                        
            preg_match('/^(http:\/\/).+?\//',$url,$match);
            if(count($match)==0){
				preg_match('/^(https:\/\/).+?\//',$url,$match);
			}
            $data_st = $structure->get_by_ref_link($match[0]);
            if($dl->set_URL($url)== FALSE){
				return FALSE;
			}
            //$title = "div.artshow h1";
            //$content = "div.artbody";
            //$img = "div.artbody img";
            $title ='';
            $file_name ='';
            $content ='';
            $datetime = '';
            $tags = array();
            foreach($data_st as $row){
                if($row->key=='title'){
                	//$this->logger->info('title');
                    $title = $dl->GetTitle($row->xpath);
                }else if($row->key =='image'){   
                	//$this->logger->info('image'); 
                	if($img_link ==''){
						$file_name = $dl->get_img($row->xpath,$match[0]);
					}else{
						$file_name = $dl->get_img_byurl($img_link);
					}
                }else if($row->key=='del'){
                	//$this->logger->info('del'); 
                    $dl->remove_element($row->xpath,$row->element_remove); 
                }else if($row->key=='replace'){ 
                	//$this->logger->info('replace');    
                    $dl->replaceString($row->xpath,$row->from_string,$row->to_string);
                }else if($row->key=='des'){ 
                	//$this->logger->info('des');    
                	$des = $dl->get_text($row->xpath);
                }else if($row->key=='tag'){
                	//$this->logger->info('tag');  
                	//$this->logger->info($row->xpath);     
                	$tags = $dl->get_tag($row->xpath,$row->from_string,'');
                }else if($row->key=='datetime'){
                	//$this->logger->info('datetime');  
                	//$this->logger->info($row->xpath);     
                	$datetime = $dl->get_text($row->xpath);
                	//$this->logger->info($datetime);  
                }else if($row->key=='content'){
                	//$this->logger->info('content'); 
                    /*foreach($data_st as $item){
                        if($item->key=='del'){
                            $dl->remove_element($item->xpath,$item->element_remove);
                        }
                    }*/
                    $content = $dl->get_content($row->xpath,$match[0]);
                    //$this->logger->info('content2'); 
                }
            }

            //$title .= $dl->GetTitle($title) ;
            //$html .= $dl->get_innerHTML($content) ;
            //$html .= $dl->get_img($img) ;
            //$dl->remove_element('ins;script');
            //$html .= $dl->get_content($content);
           //$this->logger->info($content);
           	if(strlen($des)==0){
				$des = $this->get_des($content);
				//$content = str_replace($des,'',$content);
				
			}
			//$this->logger->info('----------------------------');
			//$this->logger->info($content);
    		$resource = $match[0];
    		$add_date = date('Y-m-d');
    		$add_time = date('H:i');
    	    if(strlen($datetime)> 0){
				preg_match('/([0-9\/]){8,10}/',$datetime,$match);	
				$date_format = date_create_from_format('d/m/Y', $match[0]);			 
				$add_date = $date_format->format('Y-m-d');
				preg_match('/([0-9\:]){5}/',$datetime,$match2);
				$add_time = $match2[0];
				//$this->logger->info($add_date);
				//$this->logger->info($add_time);
			}
			$file_size = filesize(IMG_DATA_PATH.'/'.$file_name);
			$status = 0 ;
			if($file_size > 0){
				$status =1 ;
			}
    	    $file_ext=	pathinfo($file_name,PATHINFO_EXTENSION);
    	    $title = html_entity_decode($title);
    		$post = new Posts();
    	    $post->caption = $title;
    	    $post->caption_url = $this->to_slug($title);
            $post->filename = $file_name;       
    	    $post->size = $file_size;
    	    $post->type = 'blog';
    	    $post->resource = $resource;
    	    $post->adduser= 1;
    	    $post->des = $des ;
    	    $post->content = $content;
            $post->menu_id = $menu_id;
            $post->add_date = $add_date;
            $post->add_time = $add_time;
            $post->status = $status;
    	    $post->save(); 
    	    
    	    $tags_model = new Tags();
    	    if(count($tags) >0){
				foreach($tags as $tag){
					$tags_model = new Tags();
					$tag_data = Tags::findFirst(array("tag_no = :tag_no: ",'bind' => array('tag_no' => $tag['tag_no']) ));
					if($tag_data == FALSE)
					{
						$tag_data = new Tags();
						$tag_data->tag_no = $tag['tag_no'];
						$tag_data->tag_name = $tag['tag_name'];
						$tag_data->save();
					}
					
                	//$this->logger->info($tag['tag_no']);
                	
					$tagpost = new TagsPosts();
					$tagpost->tag_id = $tag_data->tag_id;
					$tagpost->post_id = $post->id ;
					$tagpost->save();
				}
			}
		return TRUE;
	}
    function to_slug($str) {
    	//$str = mb_convert_encoding($str, "UTF-8" );
    	$str = html_entity_decode($str );
	    $str = trim(mb_strtolower($str,'UTF-8'));
	    $str = preg_replace('/(à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ)/', 'a', $str);
	    $str = preg_replace('/(è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ)/', 'e', $str);
	    $str = preg_replace('/(ì|í|ị|ỉ|ĩ)/', 'i', $str);
	    $str = preg_replace('/(ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ)/', 'o', $str);
	    $str = preg_replace('/(ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ)/', 'u', $str);
	    $str = preg_replace('/(ỳ|ý|ỵ|ỷ|ỹ)/', 'y', $str);	
	    $str = preg_replace('/(đ)/', 'd', $str);
	    /*$str = str_replace(array('à','á','ạ','ả','ã','â','ầ','ấ','ậ','ậ','ẩ','ẫ','ă','ằ','ắ','ặ','ẳ','ẵ'), 'a', $str);
	    $str = str_replace(array('è','é','ẹ','ẻ','ẽ','ê','ề','ế','ệ','ể','ễ'), 'e', $str);
	    $str = str_replace(array('ì','ị','ỉ','ĩ'), 'i', $str);
	    $str = str_replace(array('ò','ó','ọ','ỏ','õ','ô','ồ','ố','ộ','ổ','ỗ'), 'o', $str);
	    $str = str_replace(array('ù','ú','ụ','ủ','ũ','ư','ừ','ứ','ự','ử','ữ'), 'u', $str);	    
	    $str = str_replace(array('ỳ','ý','ỵ','ỷ','ỹ'), 'y', $str);*/
	    
	       
	    $str = preg_replace('/[^a-z0-9-\s]/', '', $str);
	    $str = preg_replace('/([\s]+)/', '-', $str);
	    
	    //$str = str_replace('đ', 'd', $str);
	    $str = str_replace(array('"',':',"'",'?'), '', $str);
	    return $str;
	}
	public function get_des(&$trg){
		preg_match('/[\>][A-z]/',$trg,$match);
		//var_dump($match);
		$vt1 = strpos($trg,$match[0]);
		$vt2 = strpos($trg,'<',$vt1 );
		$des =  substr($trg,$vt1+1,($vt2-$vt1-1));
		$trg=substr_replace($trg, '', $vt1+1,($vt2-$vt1-1));
		return $des;
		//echo $vt1;
		//echo '<br/>';
		
		//echo $vt2;
		//echo '<br/>';
		
	}
}
