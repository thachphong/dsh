<?php

namespace Multiple\Backend\Controllers;

use Multiple\PHOClass\PHOController;
use Multiple\Models\Menu;
use Multiple\Models\Category;
use Multiple\Models\Page;
use Multiple\PHOClass\PhoLog;
class MenuController extends PHOController
{

    public function initialize()
    {        
        $this->check_loginadmin();
    }
	public function indexAction()
	{
		//return $this->response->forward('login');
       // $this->view->name= 'aaaa';
		// $db = new Menu_model();
		// $param['menus']=$db->get_menu_all(TRUE);
		// return ACWView::template_admin('menu.html', $param);
	}
	public function listAction($level_id,$position)
	{
		$db = new Menu();
		$param = array( );
		$param['menus']=$db->get_menu_list_info($level_id,$position);
		$param['level_flg'] = $level_id;
		$param['position']=$position;
		if($level_id > 1){
			$param['parent_list1']= $db->get_menu_list(1,$position);
			if($level_id > 2){
				$param['parent_list2']= json_encode($db->get_menu_list(2,$position));
			}
		}
		$gpar = $this->get_Gparam(array('level1'));
		//PhoLog::debug_var('param',$gpar);
		$param['level_1']= $gpar['level1'];
		$this->set_template_share();
		$this->ViewVAR($param);
	}
	public function newAction()
	{
		$param = $this->get_param(array('menu_level','position'));
		$ctg = new Category();
		$pg = new Page();
		$param['menu_id'] = null;
		$param['menu_name'] = null;
		$param['del_flg'] = 0;
		//$param['menu_level'] = 1;
		$param['page_flg'] = 0;
		$param['parent_id'] = NULL;
		$param['link'] = null;
		$param['ctg_list'] = addslashes(json_encode($ctg->get_category_rows(0)));
		$param['news_list'] = addslashes(json_encode($ctg->get_category_rows(1)));
		$param['page_list'] = addslashes(json_encode($pg->get_page_list()));
		$param['project_list'] = addslashes(json_encode($ctg->get_category_rows(2)));		
		if(strlen($param['menu_level'])==0){
			$param['menu_level'] = 1;
		}
		$level_id =$param['menu_level'];
		$param['parent_id_1']= NULL;
		$param['parent_id_2']= NULL;
		$db = new Menu();
		if($level_id > 1){			
			$param['parent_list1']= $db->get_menu_list(1);			
			if($level_id > 2){
				$param['parent_list2']= json_encode($db->get_menu_list(2));
			}
		}
		$param['sort'] = 1;
		//return ACWView::template_admin('menu/edit.html', $param,FALSE);
		$this->ViewHtml('menu/edit',$param);
	}
	public function updateAction()
	{
		
		$param = $this->get_param(array(
			'menu_id'
			,'menu_name'
			, 'menu_sort'	
			, 'del_flg'
			, 'parent_id_1'
			, 'parent_id_2'
			, 'menu_level'
			,'page_flg'
			,'link'
			,'position'
			));
		
		$result = array('status' => 'OK');
		$result['status'] = 'OK';	
		$result['msg'] = 'Cập nhật thành công!';		
		$db = new Menu();
		$msg = $this->check_validate_update($param);
		$login_info =  $this->session->get('auth');
        $param['user_id'] = $login_info->user_id;
		if($msg ==""){
			if(strlen($param['menu_id'])==0){
				$ctg_id = $db->_insert($param);
			}else{
				$db->_update($param);
			}
		}else{
			$result['status'] = 'ER';	
			$result['msg'] = $msg;
		}
		return $this->ViewJSON($result);
	}
	public function editAction($menu_id)
	{		
		
		$db = new Menu();
		$result = $db->get_menu_info($menu_id);
		$ctg = new Category();
		$pg = new Page();
		$result['ctg_list'] = addslashes(json_encode($ctg->get_category_rows(0)));
		$result['news_list'] = addslashes(json_encode($ctg->get_category_rows(1)));
		$result['page_list'] = addslashes(json_encode($pg->get_page_list()));
		$result['project_list'] = addslashes(json_encode($ctg->get_category_rows(2)));
		if($result['menu_level'] > 1){			
			$result['parent_list1']= $db->get_menu_list(1);
			//$param['parent_id_1']= NULL;
			if($result['menu_level'] > 2){
				$result['parent_list2']= json_encode($db->get_menu_list(2));
			}
		}
		return $this->ViewHtml('menu/edit', $result);
	}
	public function deleteAction($menu_id)
	{		
		$db = new Menu();
		$msg = "";//$db->check_before_delete($param['my_id']);
		$result['status']="OK";
		if($msg== ""){
			$db->menu_id = $menu_id;
			$db->delete();
		}else{
			$result['status']="NOT";
			$result['msg']= $msg;
		}		
		return $this->ViewJSON($result);
	}
	public function check_validate_update($param){
		if(strlen($param['menu_name'])== 0){
			return "Bạn chưa nhập tên menu !";
		}		
		return "";
	}
}
