<?php

namespace Multiple\Backend\Controllers;

use Multiple\PHOClass\PHOController;
use Multiple\Models\ProductImg;
use Multiple\Models\Product;
use Multiple\Models\ProductPrice;
use Multiple\Models\Category;
use Multiple\PHOClass\PhoLog;
use Multiple\Library\FilePHP;
class ProductController extends PHOController
{

    public function initialize()
    {        
        $this->check_loginadmin();
    }
	public function indexAction()
	{
		try{
			$param = $this->get_Gparam(array('ctgid','pid','fdate','tdate','status','page'));
			$db = new Product();
			$ctg = new Category();
			
			$page = 1;
			$param['limit'] = 50;
	      	if(isset($param['page']) && strlen($param['page']) > 0){
	            $page=$param['page'];
	        }       
	        $start_row = 0;
	        if( $page > 1){
	            $start_row = ( $page-1)*$param['limit'] ;
	        }

	        $param['page'] = $page;
	        //$param['ctg_name'] ='Kết quả tìm';
	        //PhoLog::debug_var('--url---',$_GET);
	        $param['ctg_no'] = str_replace('/','', $_SERVER['REQUEST_URI']);
        	$exp = explode('&page',$param['ctg_no'])  ;
        	$param['ctg_no']=  $exp[0]; 
	        
	        //if(isset($param['addr']) && strlen($param['addr']) > 0){
	        //    $param['address_ascii'] = $this->convert_ascii($param['addr']);
	        //}   
	        //$param['post']=$db->get_list_all($param,$start_row);
	        $param['total_post'] = $db->get_product_all_count();
	        $param['total_page']= round($param['total_post']/$param['limit']);
	        
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
			
			
			$result = 	$param;	
			$result['list']= $db->get_product_all($param,$start_row);
			$result['categorys']= $ctg->get_category_rows(0);
			//$this->set_template_share();
		} catch (\Exception $e) {
			PhoLog::debug_var('---Error---','------------------------------');
			PhoLog::debug_var('---Error---',$e);
		}
		//PhoLog::debug_var('---result---',$result);
		$this->ViewVAR($result);
	}
	public function editAction($pro_id)
	{
		$ctg = new Category();
		if(strlen($pro_id) == 0 || $pro_id == 0){
			//$param = self::get_param(array('parent_id'));
			
			$param['pro_id'] = null;
			$param['pro_name'] = null;
			$param['del_flg'] = 0;
			$param['ctg_id'] = NULL;		
			$param['price_exp'] = null;
			$param['price_imp'] = null;
			$param['price_seller'] = null;
			$param['disp_home'] = null;
			$param['status'] = null;		
			$param['img_path'] = null;		
			$param['content'] = null;
			$param['good_sell'] = null;
			$param['ctg_list'] = $ctg->get_category_rows(0);//addslashes(json_encode($ctg->get_category_rows()));
			$param['img_list'] = array();
			$param['price_list'] = array();
			$param['new_flg'] = 1;
			$param['technology']='';
			$param['promotions']='';
			$param['good_sell']=NULL;
			$param['full_box']=NULL;
			$param['parent_id'] = 0;
			$param['src_link'] = '';
			$param['sizelist'] ='';
			$param['description']='';
			/*if(strlen($param['parent_id'])==0){
				$param['parent_id'] = 0;
			}*/
			//$param['sort'] = 1;
		}else{						
			$db = new Product();
			$img = new ProductImg();
			$price = new ProductPrice();
			$param = $db->get_product_info($pro_id);			
			$param['ctg_list'] = $ctg->get_category_rows(0);
			$param['img_list'] = $img->get_img_bypro($pro_id);
			$param['price_list'] = $price->get_price_list($pro_id);
			$param['new_flg'] =0;
			//PhoLog::debug_var('---edit---',$param['img_list'] );
		}
		
		$param['folder_tmp'] = uniqid("",true);
		$param['url_refer']= $_SERVER['HTTP_REFERER'];
		$this->ViewVAR($param);		
	}
	public function updateAction(){
		$param = $this->get_param(array(
			  'pro_id',			  
			  'pro_name',
			  'ctg_id' ,
			  'price_exp' ,
			  'price_imp',
			  'price_seller',
			  'pro_price_id',
			  'status' ,
			  'disp_home' ,
			  'good_sell',
			  'img_add',
			  'content',			 
			  'del_flg'	,
			  'avata_id',
			  'img_del',
			  'pro_size'
			  ,'promotions'
			  ,'technology'	
			  ,'full_box'	
			  ,'folder_tmp' 
			  ,'src_link'
			  ,'sizelist'
			  ,'color'
			  ,'description'
			));
				
		$result['status'] = 'OK';	
		$result['msg'] = 'Cập nhật thành công!';	
		PhoLog::debug_Var('---param--',$param);		
		$db = new Product();
		$file = new FilePHP();
		$msg = $this->check_validate_update($param);
		$avatakey = -1;
		if($msg == ""){
			$listfile = $this->get_listfile($param['content']);
			$login_info =  $this->session->get('auth');
        	$param['user_id'] = $login_info->user_id;
			if(strpos($param['avata_id'],'add') !== FALSE){
				$id_add = str_replace("add_","",$param['avata_id']);				
			}
			$pro_id = $param['pro_id'] ;
			if(strlen($param['pro_id'])==0){
				$pro_id = $db->_insert($param);
				$param['pro_id'] = $pro_id;				
				$imglist = $this->move_file($pro_id,$listfile['tmp'],$param['folder_tmp']);
				$db->content = $this->replace_image_path($imglist,$param['content']);
				//PhoLog::debug_Var('---img--',$imglist);		
				//PhoLog::debug_Var('---img--',$db->content);				
				$db->save();
				$avatakey = str_replace("add_","",$param['avata_id']);
				//$db->insert_pro_img($pro_id,$param['img_add'],str_replace("add_","",$param['avata_id']) );
			}else{
				$pro_id =$param['pro_id'];
				$file_old = $this->get_listfile_old($pro_id);
				$img_main_path = $this->get_img_main_path($pro_id);

				$imglist = $this->move_file($param['pro_id'],$listfile['tmp'],$param['folder_tmp']);
				$param['content'] = $this->replace_image_path($imglist,$param['content']);
				
				$db->_update($param);
				
				$proimg = new ProductImg();
				// lấy hinh tu db lên
				$lisimg_db = $proimg->get_img_bypro($pro_id);
				foreach ($lisimg_db as $value) {
					$listfile['main']=str_replace($img_main_path.'/','',$value->img_path) ;
				}
				// xoa hinh du trong phần mô tả sản phẩm
				foreach ($file_old as $key => $value) {
					if(in_array($value, $listfile['main']) == false){
						//PhoLog::debug_Var('---img--','delete:'.PHO_PUBLIC_PATH.$img_main_path.'/'.$value);
						$file->DeleteFile(PHO_PUBLIC_PATH.$img_main_path.'/'.$value);
					}
				}
				//reset all avata flg
				$proimg->reset_avata($pro_id);
				if(strpos($param['avata_id'],'add') === FALSE){						
					$proimg->update_avata_flg($param['avata_id'],1);	// update avat flg					
				}else{
					$avatakey = str_replace("add_","",$param['avata_id']); //avata flg là image mới
				}
				
			}
			//update price
			$price = new ProductPrice();
			$price->insert_multi($param);
			PhoLog::debug_var('--img---',$param['img_add']);
			// thêm hình ảnh sản phẩm
			if(isset($param['img_add']) && count($param['img_add']) > 0){
					$imglist = $this->move_file($param['pro_id'],$param['img_add'],$param['folder_tmp']);			
					$paimg['pro_id'] = $param['pro_id'];
					//PhoLog::debug_var('update----','inset img');
					//PhoLog::debug_var('update----',$imglist);	
					//PhoLog::debug_var('--img---',$imglist);				
					foreach ($imglist as $key => $img) {
						$pimg = new ProductImg();
						$paimg['img_path'] = $img['new'];
						$paimg['avata_flg'] = 0;
						$paimg['color'] = $param['color'][$key];
						if($key == $avatakey){
							$paimg['avata_flg'] = 1;
						}				
						$pimg->_insert($paimg);
					}
					//PhoLog::debug_var('update----','inset img end');
			}
			//PhoLog::debug_var('del----',$param['img_del']);
			//xóa hình ảnh sản phẩm			
			if(isset($param['img_del']) && count($param['img_del']) > 0){
				//$db->delete_pro_img($param['img_del']);
				$pimg = new ProductImg();
				foreach ($param['img_del'] as $key => $img){
					$img_name = str_replace(BASE_URL_NAME,'',$img);
					//PhoLog::debug_var('del----',$img_name);
					//PhoLog::debug_var('del----',$param['pro_id']);
					$pimg->delete_bypost($param['pro_id'],$img_name);
					$file->DeleteFile(PHO_PUBLIC_PATH.$img_name);
				}
			}
			// xóa folder tạm
			$file->DeleteFolder(PHO_PUBLIC_PATH.'tmp/'.$param['folder_tmp']);
		}else{
			$result['status'] = 'ER';	
			$result['msg'] = $msg;
		}
		return $this->ViewJSON($result);
	}
	public function check_validate_update(&$param){
		if(strlen($param['pro_name'])== 0){
			return "Bạn chưa nhập tên sản phẩm !";
		}
		$pro_no = $this->convert_vi_to_en($param['pro_name']);
		$arr_rep = array(' - ',';',',',':','!','&','%',"'",'"','(',')','/',"\\",'?' );
		$pro_no =str_replace($arr_rep,'', $pro_no);		
		$param['pro_no'] =str_replace(' ','-', $pro_no);

		$param['price_imp'] = $this->convert_string_to_number($param['price_imp']);
		$param['price_seller'] = $this->convert_string_to_number($param['price_seller']);
		$param['price_exp'] = $this->convert_string_to_number($param['price_exp']);		
		return "";
	}	
	public function get_listfile($content){
		//$pattern ='/(src="' .str_replace('/', '\/', BASE_URL_NAME).')(.*?)(\")/' ;
		$pattern ='/(src="\\/image|src="\\/tmp)(.*?)(\\")/' ;
		preg_match_all($pattern,$content,$match);
		PhoLog::debug_Var('---rrrr--',$pattern);
		$result = array();
		$repl = array(BASE_URL_NAME,'src=','"');
		$result['main'] = array();
		$result['tmp'] = array();
		foreach ($match[0] as $key => $value) {
			if(strpos($value, 'images') > 0){
				$exp = explode('/', $value);
				$result['main'][] =str_replace('"', '', $exp[count($exp) -1]); 		
			}else{
				$result['tmp'][]= str_replace($repl,'',$value);
			}
		}	
		return $result;
		//PhoLog::debug_Var('---rrrr--',$result);	
	}
	public function move_file($pro_id,$listfile,$folder_tmp){
		$dest_folder = PHO_PUBLIC_PATH.'images/products';
		$src_folder= PHO_PUBLIC_PATH.'tmp/'.$folder_tmp;
		$result = array();
		$file = new FilePHP();
	
		$dest_folder .= "/".$pro_id;
		if($file->FolderExists($dest_folder) == false){
			$file->CreateFolder($dest_folder);
		}
		//PhoLog::debug_Var('---rrrr--',$listfile);
		foreach ($listfile as $key => $value){
			$exp = explode('/', $value);
			$src_file = 'images/products/'.$pro_id.'/'.$exp[count($exp)-1];
			$file->CopyFile($src_folder.'/'.$exp[count($exp)-1],PHO_PUBLIC_PATH.$src_file);
			//PhoLog::debug_Var('---rrrr--','from:'.$src_folder.'/'.$exp[count($exp)-1]);	
			//PhoLog::debug_Var('---rrrr--','to:'.PHO_PUBLIC_PATH.$src_file);	
			$file->DeleteFile($src_folder.'/'.$exp[count($exp)-1]);
			$result[$key]['old'] = $value;
			$result[$key]['new'] = '/'.$src_file;
		}
		return $result;
	}
	public function get_listfile_old($pro_id)
	{			
		$file = new FilePHP();
		$listfile = array();
		$src_file = $this->get_img_main_path($pro_id);
		if($file->FolderExists(PHO_PUBLIC_PATH.$src_file) == true){
			$listfile = $file->FileList(PHO_PUBLIC_PATH.$src_file);
		}		

		return $listfile;
	}
	public function get_img_main_path($pro_id)
	{		
		$path = 'images/pages/'.$pro_id;
		return $path;
	}
	public function replace_image_path($imglist,$content){
		//$img_new = $imglist['new'];
		if(count($imglist) > 0){
			foreach ($imglist as $key => $value) {
				$content = str_replace($value['old'], $value['new'], $content);
			}
		}
		return $content;
	}
	public function uploadAction(){
		$filelist = $_FILES;
		$param = $this->get_param(array('folder_tmp'));
		$folder_tmp = $param['folder_tmp'];
		//PhoLog::debug_var('--data--',$param);
		//PhoLog::debug_var('--data--',$_POST);
		$result['status']='OK';
		if(count($filelist)==0){
			$result['status']='NOT';
			$result['msg']='Không có file nào được chọn !';
		}
		$file_lb = new FilePHP();
		$folder_name = IMG_TMP_PATH.$folder_tmp;
		if(is_dir($folder_name)==false){
			 @mkdir($folder_name, 0777, true);
		}
		//$img = new Images();
		foreach($filelist as $item){
			$name = $item['name'];
			if($item['size'] > 4096000) // >4MB
			{
				$result['status']='NOT';
				$result['msg']='File upload không được lớn 4MB !';
				break;
			}
			
			$file_tmp = $item['tmp_name'];			
			
			$file_name ='tmp/'.$folder_tmp.'/'.uniqid('',true).'.'.$file_lb->GetExtensionName($name);
			$file_lb->CopyFile($file_tmp,PHO_PUBLIC_PATH.$file_name);
			//PhoLog::debug_var('---logo--',PHO_PUBLIC_PATH.$file_name);
			//PhoLog::debug_var('---logo--',PHO_LOGO_ADD);
			//$img->add_logo(PHO_PUBLIC_PATH.$file_name,PHO_LOGO_ADD,5);
			//$img->add_logo(PHO_PUBLIC_PATH.$file_name,PHO_LOGO_ADD,9);
			$file_lb->DeleteFile($file_tmp);
			$result['link'][] = '/'.$file_name;
		}
		
		return $this->ViewJSON($result);
	}
	
	public function deleteAction($pro_id)
	{		
		$db = new Product();
		$img = new ProductImg();
		$msg = "";//$db->check_before_delete($ctg_id);
		$result['status']="OK";
		if($msg== "" && $pro_id > 0){
			$db->pro_id = $pro_id;
			$db->delete();
			$img_list = $img->deleteall_bypost($pro_id);
					
			$file_lb = new FilePHP();
			$dest_folder = PHO_PUBLIC_PATH.'images/products/'.$pro_id;
			$file_lb->DeleteFolder($dest_folder);
		}else{
			$result['status']="NOT";
			$result['msg']= $msg;
		}
		
		return $this->ViewJSON($result);
	}
	public function apprAction($id){
		$db = new Posts();
		$db->update_status($id,1);
		return $this->ViewJSON('OK');
	}
	public function unapprAction($id){
		$db = new Posts();
		$db->update_status($id,2);
		return $this->ViewJSON('OK');
	}
}
