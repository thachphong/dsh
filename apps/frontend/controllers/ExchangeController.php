<?php

namespace Multiple\Frontend\Controllers;

use Multiple\PHOClass\PHOController;
use Multiple\Models\Exchange;
use Multiple\Models\ExchangeReceive;
use Multiple\Models\Users;
use Multiple\Models\Define;
use Multiple\PHOClass\PhoLog;
use Multiple\Library\FilePHP;
class ExchangeController extends PHOController
{
	public function indexAction()
	{		
		$res['webtitle']="Phương thức thanh toán";
		$this->ViewVAR($res);
	}	
	public function payAction()
	{		
		$res['webtitle']="Thanh toán";
		$user = $this->session->get('auth');
		$res['user_name'] = $user->user_name;
		$res['user_mobile']=$user->mobile;
		$this->ViewVAR($res);
	}
	public function sendAction()
	{
		$param =$this->get_param(array('amount'));
		$param['amount'] = str_replace(',','',$param['amount']);
		//PhoLog::debug_var('---param---',$param);
		$param['currency']= 'VND';
		//$param['payment_type'] = 'VTCPay';
		//$param['reference_number']= 'VND';
		//PhoLog::debug_var('---param---',$param);
		$cdata = $this->get_define();
		//PhoLog::debug_var('---param---',__LINE__);
		$user = $this->session->get('auth');
		//PhoLog::debug_var('---param---',__LINE__);
		//PhoLog::debug_var('---param---',$param);
		$param['receiver_account']= $cdata['pay_vtc_account'];	
		$param['reference_number']='';	
		$param['website_id']= $cdata['pay_website_id'];		
		$url_checkout = $cdata['pay_url_checkout'].'?';
		$par_ins = $param;
		//PhoLog::debug_var('---param---',__LINE__);
		$par_ins['add_user'] = $user->user_id;
		//PhoLog::debug_var('---param---',$param);
		$db = new Exchange();
		
		$param['reference_number'] = $db->_insert($par_ins);
		//$arr_key = array_keys($param);
		
		$param['signature']= strtoupper(hash('sha256',  implode('|',$param).'|'.$cdata['pay_securitycode']));
		
		$data =array();
		foreach($param as $key =>$val){
			$data[]= $key.'='.$val;
		}
		$url_checkout .= implode('&',$data);
		$this->view->disable();
		
		return $this->response->redirect($url_checkout);
		
	}
	public function recieveAction()
	{
		try{
			$param = $this->get_param(array('data','signature'));
			
			$res['webtitle']="Thanh toán";
			$res['status']='OK';
			$res['msg']="Thanh toán thành công !";
			$res['reason']='';
			if(strlen($param['data'])>0){
				$data = explode('|',$param['data']);
				$param['amount']= $data[0];
				$param['message']= $data[1];
				$param['payment_type'] = $data[2];
				$param['reference_number'] = $data[3];
				$param['status'] = $data[4];
				$param['trans_ref_no'] = $data[5];
				$param['website_id'] = $data[6];
				$cdata = $this->get_define();
				$plaintext = $param['data'].'|'.$cdata['pay_securitycode'];
				$mysign = strtoupper(hash('sha256', $plaintext));
				//PhoLog::debug_var('---recieve---',$param);
				//PhoLog::debug_var('---recieve---',$cdata);
				//PhoLog::debug_var('---recieve---',$mysign);
				if($mysign != $param['signature']){
					//PhoLog::debug_var('---recieve---','1');
					$res['reason']="Kết quả không hợp lệ.";
					$res['msg']="Thanh toán không thành công.";
					$res['status']='NOT';
				}else{
					//PhoLog::debug_var('---recieve---','2');
					$user = $this->session->get('auth');
					//PhoLog::debug_var('---recieve---','2.1');
					$db = new ExchangeReceive();
					//PhoLog::debug_var('---recieve---','2.2');
					$param['user_id']= $user->user_id;
					PhoLog::debug_var('---recieve---','2.3');
					$upd_flg = $db->_insert($param);
					PhoLog::debug_var('---recieve---','2.4');
					if($param['status'] !='1'){
						//PhoLog::debug_var('---recieve---','2.5');
						$res['reason']= $db->get_name($param['status']);					
						$res['msg']="Thanh toán không thành công.";
						$res['status']='NOT';
						//PhoLog::debug_var('---recieve---','3');
					}else{
						//PhoLog::debug_var('---recieve---','4');
						if($upd_flg){
							$db->update_amount_user($user->user_id,$param['amount']);
						}
						$usdb = new Users();
						$us_data = $usdb->get_info($user->user_id);
						$this->session->set('auth', $us_data);
						$res['reason']= "Tài khoản của bạn hiện tại là:".$this->currency_format($us_data->amount) . ' VNĐ';
					}				
					
				}
			}else{
				$res['reason']="Kết quả không hợp lệ.";
				$res['msg']="Thanh toán không thành công.";
				$res['status']='NOT';			
			}				
		}catch (\Exception $e) {
			PhoLog::debug_var('---Error---',$e);
			$res['reason']="Có lỗi xảy ra trong quá trình nhận kết quả thanh toán";
			$res['msg']="Thanh toán không thành công.";
			$res['status']='NOT';
		}
		$this->ViewVAR($res);
		
	}
	public function get_define(){
		$cache = $this->createCache(['lifetime' => 86400 ]); //1 ngay
        $cachekey ="paysend.cache";
        $cdata = $cache->get($cachekey);        
        if($cdata == null){
        	$df = new Define();
        	$res = $df->get_list_bygroup_all(1);
        	foreach($res as $row){
				$cdata[$row['define_key']] = $row['define_val'];			
			}        	
			$cache->save($cachekey,$cdata);			
		}
		return $cdata;
	}
	
}
