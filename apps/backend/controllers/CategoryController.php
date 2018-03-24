<?php

namespace Multiple\Backend\Controllers;

use Multiple\PHOClass\PHOController;
use Multiple\Models\Category;
use Multiple\Models\MType;
use Multiple\PHOClass\PhoLog;
class CategoryController extends PHOController
{

    public function initialize()
    {        
        $this->check_loginadmin();
    }
	public function indexAction()
	{
		//return $this->response->forward('login');
       // $this->view->name= 'aaaa';
	}
	public function listAction($level_id,$news_flg)
	{
		// $param = self::get_param(array('acw_url'));
		// $level_id  = $param['acw_url'][0];	
		// $news_flg  = $param['acw_url'][1];
		$param = $this->get_Gparam(array('lv1','lv2'));
		$db = new Category();
		$param['category']=$db->get_ctg_list($level_id,$news_flg);
		$param['news_flg']=$news_flg;
		$param['level_flg']=$level_id;
		if($level_id > 1){
			$param['parent_list1']= $db->get_ctg_list(1,$news_flg);
			if($level_id > 2){
				$param['parent_list2']= json_encode($db->get_ctg_list(2,$news_flg));
			}
		}
		//return ACWView::template_admin('category_list.html', $param);
		$this->set_template_share();
		$this->ViewVAR($param);
	}
	public function projectAction()
	{
		$level_id = 2;
		$news_flg = 2;		
		$db = new Category();
		$param['category']=$db->get_ctg_list($level_id,$news_flg);
		$param['news_flg']=$news_flg;
		$param['level_flg']=$level_id;
		if($level_id > 1){
			$param['parent_list1']= $db->get_ctg_list(1,$news_flg);
			
		}		
		$this->set_template_share();
		$this->ViewVAR($param);
	}
	public function newAction()
	{		
		$param = $this->get_param(array('ctg_level','news_flg'));
		$param['ctg_id'] = null;
		$param['ctg_name'] = null;
		$param['del_flg'] = 0;	
		$param['sort'] = 1;	
		$param['m_type_id'] = 0;
		$param['title'] = '';
		$param['description'] = '';
		$param['keywords'] = '';
		$mt = new MType();
		$param['mtypelist'] = $mt->get_all();	
		if(strlen($param['ctg_level'])==0){
			$param['ctg_level'] = 1;
		}
		$level_id =$param['ctg_level'];
		$param['parent_id_1']= NULL;
		$param['parent_id_2']= NULL;
		$db = new Category();
		if($level_id > 1){			
			$param['parent_list1']= $db->get_ctg_list(1,$param['news_flg']);
			if($level_id > 2){
				$param['parent_list2']= json_encode($db->get_ctg_list(2,$param['news_flg']));
			}
		}
				
		return $this->ViewHtml('category/edit',$param);
	}
	public function newproAction()
	{		
		$param = $this->get_param(array('ctg_level','news_flg'));
		$param['news_flg'] = 2;
		$param['ctg_id'] = null;
		$param['ctg_name'] = null;
		$param['del_flg'] = 0;	
		$param['sort'] = 1;	
		$param['m_type_id'] = 0;
		$mt = new MType();
		$param['mtypelist'] = $mt->get_all();	
		if(strlen($param['ctg_level'])==0){
			$param['ctg_level'] = 1;
		}
		$level_id =$param['ctg_level'];
		$param['parent_id_1']= 5;
		
		$db = new Category();
		if($level_id > 1){			
			$param['parent_list1']= $db->get_ctg_list(1,$param['news_flg']);
		}
				
		return $this->ViewHtml('category/editpro',$param);
	}
	public function editproAction($ctg_id)
	{		
		
		$db = new Category();
		$result = $db->get_ctg_info($ctg_id);
		//$param['parent_id_2']= NULL;
		//$param['parent_id_2']= NULL;
		if($result['ctg_level'] > 1){			
			$result['parent_list1']= $db->get_ctg_list(1,$result['news_flg'] );
		}
		$mt = new MType();
		$result['mtypelist'] = $mt->get_all();	
		return $this->ViewHtml('category/editpro',$result);
	}
	public function ctgnewsAction()
	{
		$db = new Category_model();
		$param['category']=$db->get_catgory_all(1);
		$param['news_flg']=1;
		return ACWView::template_admin('category.html', $param);
	}
	
	public function editAction($ctg_id)
	{		
		
		$db = new Category();
		$result = $db->get_ctg_info($ctg_id);
		$result['parent_list2'] = NULL;
		if($result['ctg_level'] > 1){			
			$result['parent_list1']= $db->get_ctg_list(1,$result['news_flg'] );
			if($result['ctg_level'] > 2){
				$result['parent_list2']= json_encode($db->get_ctg_list(2,$result['news_flg']));
			}
		}
		$mt = new MType();
		$result['mtypelist'] = $mt->get_all();	
		return $this->ViewHtml('category/edit',$result);
	}
	public function updateAction()
	{
		
		$param = $this->get_param(array(
			'ctg_id'
			,'ctg_name'
			, 'ctg_sort'	
			, 'del_flg'		
			, 'ctg_level'			
			, 'parent_id_1'
			, 'parent_id_2'
			,'news_flg'
			,'m_type_id'
			,'description'
			,'title'
			,'keywords'
			));
		//$param['news_flg'] =0;
		$result = array('status' => 'OK');
		$result['status'] = 'OK';	
		$result['msg'] = 'Cập nhật thành công!';		
		$db = new Category();
		$msg = $this->check_validate_update($param);
		if($msg ==""){
			$login_info =  $this->session->get('auth');
        	$param['user_id'] = $login_info->user_id;
			if(strlen($param['ctg_id'])==0){
				$ctg_id = $db->_insert($param);
			}else{
				//PhoLog::debug_var('---d---',$param);
				$db->_update($param);
			}
		}else{
			$result['status'] = 'ER';	
			$result['msg'] = $msg;
		}
		return $this->ViewJSON($result);
	}
	public function deleteAction($ctg_id)
	{
		// $param = self::get_param(array('acw_url'));	
		// if (self::get_validate_result() == false)  {
		// 	ACWError::add('acw_url', 'Tham số không hợp lệ');
		// }
		$db = new Category();
		$msg = "";//$db->check_before_delete($ctg_id);
		$result['status']="OK";
		if($msg== ""){
			$db->ctg_id = $ctg_id;
			$db->delete();
		}else{
			$result['status']="NOT";
			$result['msg']= $msg;
		}
		
		return $this->ViewJSON($result);
	}
	public function check_validate_update(&$param){
		if(strlen($param['ctg_name'])== 0){
			return "Bạn chưa nhập tên danh mục !";
		}
		$ctg = new Category();
		$param['ctg_no'] =str_replace(' ','-', $this->convert_vi_to_en($param['ctg_name']));
		if(strlen($param['ctg_id']) == 0){
			$row = $ctg->get_ctg_byno($param['ctg_no']);
			$i = 0;
			//PhoLog::debug_var('test---',$row);
			while($row){
				$i++;
				$param['ctg_no'] = $param['ctg_no'].'-'.$i;
				$row = $ctg->get_ctg_byno($param['ctg_no']);
				//PhoLog::debug_var('test---',$row);
			}
		}else{
			$sql = "select ctg_id from category	where ctg_no = :ctg_no	and ctg_id <> :ctg_id";
			$res = $ctg->get_ctg_exist($param['ctg_no'] , $param['ctg_id']);
			$i = 0;
			while($res ){
				$i++;
				$param['ctg_no'] = $param['ctg_no'].'-'.$i;
				$res = $ctg->get_ctg_exist($param['ctg_no'] , $param['ctg_id']);
			}
		}
		return "";
	}
}
