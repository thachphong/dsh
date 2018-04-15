<?php

namespace Multiple\Frontend\Controllers;

use Multiple\PHOClass\PHOController;
use Multiple\Models\Users;
use Multiple\Models\Define;
use Multiple\Library\Mail;
use Multiple\PHOClass\PhoLog;
use Multiple\Library\FilePHP;
class UsersController extends PHOController
{
	public function indexAction()
	{		
	}
	public function registerAction(){
		$result['provins'] = $this->get_Provin();		
		$this->set_template_share();
		$this->ViewVAR($result);
	}
	public function loginAction(){		
		if($_SERVER['HTTP_REFERER'] == BASE_URL_NAME.'cart/pay'){
			$this->session->set('url_refer', $_SERVER['HTTP_REFERER']);
		}else{
			$this->session->set('url_refer', BASE_URL_NAME);
		}
		$this->set_template_share();
	}
	public function successAction(){
		//$_SERVER		
		$this->set_template_share();
	}
	public function forgetAction(){
		$this->set_template_share();
	}
	public function activeAction(){
		$param = $this->get_Gparam(array('email','rd'));
		$db = new Users();
		if($db->active($param['email'],$param['rd'])){
			$res['active_msg'] = 'Kích hoạt tài khoản thành công !';
		}else{
			$res['active_msg'] = 'Link kích hoạt tài khoản không đúng !';
		}		
		$this->set_template_share();
		$this->ViewVAR($res);
	}
	public function logoutAction()
	{
		$this->session->set('auth', null);
        return $this->_redirect('dang-nhap');
	}
	public function authAction(){
		
        $result['status']='NOT';
        $result['msg']='';        
        if ($this->request->isPost()) {
        	$param = $this->get_param(array('email','password'));
        	//PhoLog::debug_var('---test---',$param);  
            $db = new Users();
            $user = $db->get_user($param['email'], $param['password']);                   
            $result['msg'] = 'Tên đăng nhập hoặc mật khẩu không đúng !';
            if ($user != false) {
            	if($user->status== 1){
            		$this->_registerSession($user);
                	$result['status'] ='OK';
                	$result['msg'] = 'Đăng nhập thành công !';
                	$result['url_refer'] = $this->session->get('url_refer');
                	$this->session->set('url_refer', null);
            	}else if($user->status== 0){
            		$result['status'] ='NOT';
                	$result['msg'] = 'Tài khoản của bạn chưa kích hoạt, vui lòng kiểm tra email và click vào link kích hoạt tài khoản !';
            	}
                
            }
        }

        return $this->ViewJSON($result);
	}
	private function _registerSession(Users $user)
    {
        $this->session->set('auth', $user);
    }
	public function updateAction(){
		try{
			//PhoLog::debug_var('---user_upd---',__LINE__);
			$param = $this->get_param(array('user_no','user_name','email','mobile','address','pass','sex','city','district','ward','ctv_flg'));
			$result = array('status' => 'OK');
			$result['status'] = 'OK';	
			$result['msg'] = 'Cập nhật thành công!';		
			$db = new Users();
			//PhoLog::debug_var('---user_upd---',__LINE__);
			$msg = $db->get_validation($param);
			//PhoLog::debug_var('---user_upd---',__LINE__);
			if($msg === true){	
				$db->_insert($param);	
				$send_status = $this->sendmail($db);	
				PhoLog::debug_var('---SEND_MAIL_REG---',$db->email .' :'.$send_status);			
				if(!$send_status){
					$result['status'] = 'NOT';	
					$result['msg'] = 'Có lỗi xảy ra trong quá trình gửi mail kích hoạt tài khoản';
					$db->delete();
				}
			}else{			
				$result = $msg;
				$result['status'] = 'NOT';	
			}
			//PhoLog::debug_var('---user_upd---',__LINE__);
			return $this->ViewJSON($result);
		} catch (\Exception $e) {
			PhoLog::debug_var('---SYS_Error---',$e->getMessage());			
			throw $e;
		}
	}
	public function sendmail($usr){
		$email = new Mail();
		
		$body_tmp = $this->get_body($usr);		
		$replacements['HEADER'] = '<h3><strong>Chúc mừng bạn đã đăng kí thành công tài khoản trên '.SITE_NAME.'!</strong></h3>';
		$replacements['BODY'] = $body_tmp;
		$db = new Define();
		$data = $db->get_info(DEFINE_KEY_EMAIL);
		//$mail_to[]['mail_address']= $data->define_val;
		$mail_to[]['mail_address']= $usr->email;	
		//PhoLog::debug_var('--mail',$mail_to);	
		//PhoLog::debug_var('--mail',$data);
		$email->AddListAddress($mail_to);
		$email->add_replyto($data->define_val,SITE_NAME);
                
		$email->Subject = 'Đăng ký tài khoản thành công - '.date('d/m/Y H:i:s');                
		$email->loadbody('template_mail.html');
		$email->replaceBody($replacements);
		return $email->send();
	}
	public function get_body($usr){
		$url = BASE_URL_NAME."users/active?email=".$usr->email."&rd=".$usr->user_id;
		$html="<p>Dưới đây là thông tin đăng nhập của bạn: </p>
			   <p><strong>Email:</strong> ".$usr->email."</p>
			   <p><strong>Điện thoại:</strong> ".$usr->mobile." </p>
			   <br/>
			   <p>Vui lòng kích vào đường link dưới đây để kích hoạt tài khoản của bạn:</p>
			  <a href='".$url ."'>".$url ."</a> 

			<p>Nếu đường link trên không hoạt động, vui lòng copy đường link đó, rồi dán lên thanh địa chỉ của trình duyệt để link tới trang kích hoạt trên hệ thống. </p>
			<p>Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi!</p>";
		return $html;
	}
	public function updatepassAction(){
		$param = $this->get_param(array('pass_old','pass_new'));
		$result = array('status' => 'OK');
		$result['status'] = 'OK';	
		$result['msg'] = 'Cập nhật thành công!';	
		$user = $this->session->get('auth');	
		$db = new Users();
		if($db->get_user($user->user_no,$param['pass_old']) != FALSE){
			$db->updatepass($user->user_id,$param['pass_old'],$param['pass_new']);			
		}else{
			$result['status'] = 'NOT';	
			$result['msg'] = 'Mật khẩu cũ không đúng!';
		}
				
		return $this->ViewJSON($result);
	}
	public function updateinfoAction(){
		$param = $this->get_param(array('user_name','address','mobile','bank_id','bank_acc_no','bank_acc_name','sex'
		,'avata','folder_tmp','city','district','ward','ctv_flg'));
		$result = array('status' => 'OK');
		$result['status'] = 'OK';	
		$result['msg'] = 'Cập nhật thành công!';	
		$user = $this->session->get('auth');	
		$db = new Users();
		$param['user_id'] = $user->user_id;
		if(strlen($param['avata'])>0){
			$file = new FilePHP();
			$ext = $file->GetExtensionName($param['avata']);
			if($user->avata != ''){
				$file->DeleteFile(PHO_PUBLIC_PATH.'images/users/'.$user->avata);
			}	
			$file_name = uniqid('',TRUE).'.'.$ext;	
			$file->CopyFile(PHO_PUBLIC_PATH.$param['avata'],PHO_PUBLIC_PATH.'images/users/'.$file_name);
			$file->DeleteFolder(PHO_PUBLIC_PATH.$param['folder_tmp']);
			$param['avata'] =$file_name;
		}
		$db->updateinfo($param);
		$this->_registerSession($db->get_info($user->user_id));
		return $this->ViewJSON($result);
	}
	public function sendpassAction(){
		$param = $this->get_param(array('email'));
		$result = array('status' => 'OK');
		$result['status'] = 'OK';	
		$result['msg'] = 'Cập nhật thành công!';		
		
		//$msg = '';
		
		if($this->sendmailpass($param['email']) === FALSE)
		{	
			$result['msg'] = 'Gửi mail không thành công';
			$result['status'] = 'NOT';	
		}
		return $this->ViewJSON($result);
	}
	public function sendmailpass($to_mail){
		$email = new Mail();
		$usr = new Users();
		$par = $usr->get_user_bymail($to_mail);
		
		$url = BASE_URL_NAME."users/resetpass?email=".$to_mail."&uid=".$par['user_id']. "&rdom=".$par['pass'];
		$body_tmp="
			   <p>Vui lòng kích vào đường link dưới đây để đặt lại mật khẩu mới cho tài khoản của bạn:</p>
			  <a href='".$url ."'>".$url ."</a> 

			<p>Nếu đường link trên không hoạt động, vui lòng copy đường link đó, rồi paste lên thanh địa chỉ của trình duyệt để đặt lại mật khẩu mới cho tài khoản của bạn. </p>
			<p>Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi!</p>";
		
		$replacements['HEADER'] = '<h3><strong>Đặt lại mật khẩu trên '.SITE_NAME.'!</strong></h3>';
		$replacements['BODY'] = $body_tmp;
		$db = new Define();
		$data = $db->get_info(DEFINE_KEY_EMAIL);
		//$mail_to[]['mail_address']= $data->define_val;
		$mail_to[]['mail_address']= $to_mail;	
		PhoLog::debug_var('--mail--',$mail_to);	
		PhoLog::debug_var('--mail--',$data);
		$email->AddListAddress($mail_to);
		$email->add_replyto($data->define_val,SITE_NAME);
                
		$email->Subject = 'Đặt lại mật khẩu trên '.SITE_NAME.' - '.date('d/m/Y H:i:s');                
		$email->loadbody('template_mail.html');
		$email->replaceBody($replacements);
		$result = $email->send();
		if($result){
			PhoLog::debug_var('--mail--','send mail ok');
		}else{
			PhoLog::debug_var('--mail--','send mail error');
		}
		return $result;
	}
}
