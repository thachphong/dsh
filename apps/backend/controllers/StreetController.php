<?php

namespace Multiple\Backend\Controllers;

use Multiple\PHOClass\PHOController;
use Multiple\PHOClass\PhoLog;
use Multiple\Models\Street;
use Multiple\Models\Provincial;
use Multiple\Models\District;
use Multiple\Library\FilePHP;
class StreetController extends PHOController
{
	const PAGE_LIMIT_RECORD=50;
    public function initialize()
    {        
        $this->check_loginadmin();
    }
	public function indexAction()
	{
		$param = $_GET;       
        $page = 1;
      	if(isset($param['page']) && strlen($param['page']) > 0){
            $page=$param['page'];
        }
        
        $street_db = new Street();
        $start_row = 0;
        if( $page > 1){
            $start_row = ( $page-1)*self::PAGE_LIMIT_RECORD ;
        }
        PhoLog::debug_var('server',$_SERVER);
		
        $param['page'] = $page;       
        //$param['ctg_no'] = str_replace('/','', $_SERVER['REQUEST_URI']);
       // $param['ctg_no'] = str_replace('??','?', $param['ctg_no']);
        //$exp = explode('page',$param['ctg_no'])  ;
        //$param['ctg_no']=  $exp[0];    
        $param['list']=$street_db->search($param,$start_row,self::PAGE_LIMIT_RECORD);
        $param['total_post'] = $street_db->search_count($param);
        $param['total_page']= round($param['total_post']/self::PAGE_LIMIT_RECORD);
        
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
		if(isset($param['m_provin_id'])==FALSE){
			$param['m_provin_id']='';
		}
		if(isset($param['m_district_id'])==FALSE){
			$param['m_district_id']='';
		}		
		$param['ctg_no']= "street?m_provin_id=".$param['m_provin_id'].'&m_district_id='.$param['m_district_id'].'&';
		//$param['list'] = $street_db->get_all();
		$param['provincials'] = Provincial::get_all();
		$param['districts'] = District::find();
		$this->set_template_share();
		$this->ViewVAR($param);
	}
	public function newAction()
	{
		//$param = $this->get_Gparam(array('slide_id'));
		$db = new Street();
		//if(strlen($slide_id)==0 || $slide_id ==0){  // new
		$result['m_street_id'] = '';
		$result['m_street_name'] = '';
		$result['m_district_id'] = '';
		$result['m_provin_id'] = '';
		
		$result['provincials'] = Provincial::get_all();
		$result['districts'] = District::find();
		//}else{//edit
		//	$result['data'] = $db->get_info($slide_id);
		//}		
		$this->ViewHtml('street/edit',$result);
	}
	public function editAction($street_id)
	{
		$db = new Street();
		
		$result = $db->get_info($street_id);
		//PhoLog::debug_var('--edit---',$street_id);
		//PhoLog::debug_var('--edit---',$result);
		$result['provincials'] = Provincial::get_all();
		$result['districts'] = District::find();
		$this->ViewHtml('street/edit',$result);
	}		
	public function listAction($banner_flg)
	{	
		$param = self::get_param(array('acw_url'));	
		$db = new Slide();
		$param['slides']=$db->get_slides_all($banner_flg);
		$param['title'] ='slides';
		$param['banner_flg'] = $banner_flg;
		if($param['banner_flg'] ==1){
			$param['title'] ='banner';
		}
		$this->set_template_share();
		$this->ViewVAR($param);		
	}
	public function updateAction(){
		$param = $this->get_param(array(
			'm_street_id'
			,'m_district_id'				
			,'street_name'					
			));
		
		$result = array('status' => 'OK');
		$result['status'] = 'OK';	
		$result['msg'] = 'Cập nhật thành công!';		
		$db = new Street();
		$msg = $this->check_validate_update($param);
		if($msg ==""){
			if(strlen($param['m_street_id'])==0 || $param['m_street_id'] == 0){
				$db->_insert($param);
			}else{	
				$db->_update($param);
			}			
		}else{
			$result['status'] = 'ER';	
			$result['msg'] = $msg;
		}
		return $this->ViewJSON($result);
	}
	public function check_validate_update($param){
		$db = new Street();
		if($db->check_exist($param)){
			return "Tên đường này đã có, vui lòng nhập tên khác!";
		}				
		return "";
	}
	public function deleteAction($street_id)
	{		
		$db = new Street();		
		$result['status']="OK";		
		$db->m_street_id =$street_id;
		$db->delete();
			
		return $this->ViewJSON($result);
	}
}
