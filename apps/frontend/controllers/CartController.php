<?php
namespace Multiple\Frontend\Controllers;
use Multiple\PHOClass\PHOController;
use Multiple\PHOClass\PhoLog;
use Multiple\Models\Orders;
use Multiple\Models\OrdersDetail;
use Multiple\Models\Provincial;
use Multiple\Models\Define;
use Multiple\Library\Mail;
class CartController extends PHOController
{
	public function indexAction()
	{		
		$db = new Orders();
		$cart = $this->session->get('cart_info');
		
		$products = array();
		$total_amount = 0;
		$total_ck=0;
		//$list_pro = array();
		if($cart != NULL){
			$products = $db->get_products($cart);	
				
			foreach($cart as $key=>&$item){
				$exp = explode('_',$key);
				//PhoLog::debug_var('--cart--',$exp );
				$pro_price_id = $exp[0];
				$row = $products[$pro_price_id];
				//$item['qty'] = $cart[$item['pro_price_id']];
				$item['amount'] = $item['qty']*$row['price_exp'];
				$item['chietkhau'] = $item['qty']*($row['price_exp']-$row['price_seller']);
				$item['price_exp'] = $row['price_exp'];
				$item['pro_id'] = $row['pro_id'];
				$item['pro_name'] = $row['pro_name'];
				$item['price_seller'] = $row['price_seller'];
				$item['img_path'] = $row['img_path'];
				$item['pro_price_id'] = $pro_price_id;
				$total_amount += $item['amount'];
				$total_ck +=$item['chietkhau'];
				//$list_pro[$key] = $item;
			}
		}
		$result =array(
			'carts' =>$cart
			,'total_amount'=>$total_amount
			,'total_ck'=>$total_ck
		);
		$user = $this->session->get('auth');
		$result['ctv_flg'] ='';
		if($user !=NULL){
			$result['ctv_flg']=$user->ctv_flg;
		}
		$this->set_template_share();
		$this->ViewVAR($result);		
	}
	
	public function successAction($order_id)
	{			
		$db = new Orders();
		$detail = new OrdersDetail();
		//$result['ord'] = $db->get_info($order_id);
		//$result['ord_detail'] = $detail->get_list($order_id);
		//return ACWView::template('success.html',$result);
		$result['ord_id']=$order_id;
		$this->set_template_share();
		$this->ViewVAR($result);	
	}
	public function addAction()
	{
		$param = $this->get_param(array(
			'pro_id',
			'pro_qty',
			'pro_size',
			'color_sel',
			'size_sel'
		));	
		$cart = $this->session->get('cart_info');
		$key = $this->get_key($param);
		if( $cart != NULL && isset($cart[$key])){
			$cart[$key]['qty'] +=  $param['pro_qty'];				
		}else{			
			$cart[$key]['qty'] =  $param['pro_qty'];
			$cart[$key]['color'] = $param['color_sel'];
			$cart[$key]['size'] = $param['size_sel'];
		}		
		$this->session->set('cart_info', $cart);
		$result['total'] = count($cart);
		$result['status'] = 'OK';
		return $this->ViewJSON($result);		
		//$this->_redirect(BASE_URL_NAME.'cart');
	}
	public function addtocartAction()
	{
		$param = $this->get_param(array(
			'pro_id',
			'pro_qty',
			'pro_size',
			'color_sel',
			'size_sel'
		));	
		$cart = $this->session->get('cart_info');
		$key = $this->get_key($param);
		if( $cart != NULL && isset($cart[$key])){
			$cart[$key]['qty'] +=  $param['pro_qty'];				
		}else{			
			$cart[$key]['qty'] =  $param['pro_qty'];
			$cart[$key]['color'] = $param['color_sel'];
			$cart[$key]['size'] = $param['size_sel'];
		}		
			
		$this->session->set('cart_info', $cart);		
		$this->_redirect(BASE_URL_NAME.'cart');
	}
	public function get_key($param){
		$key = $param['pro_size'];
		if(strlen($param['color_sel'])>0){
			$key .= '_'.$param['color_sel'];
		}
		if(strlen($param['size_sel'])>0){
			$key .= '_'.$param['size_sel'];
		}
		return $key;
	}
	public function deleteAction()
	{	
		$param =$this->get_param(array('pro_size','size_sel','color_sel'));
		$key=$this->get_key($param);
		$cart = $this->session->get('cart_info');
		//PhoLog::debug_var('--del--',$cart );
		//PhoLog::debug_var('--del--',$key );
		unset($cart[$key]);
		
		$this->session->set('cart_info', $cart);		
		//$this->_redirect(BASE_URL_NAME.'cart');
		return $this->ViewJSON(array('status'=>'OK'));
	}
	public function payAction(){
		$param = self::get_param(array(			  
			  'pro_qty',
			  'pro_price_id',
			  'sizes',
			  'colors'
		));	
		$cart = array();//ACWSession::get("cart_info");
		if($_SERVER['REQUEST_METHOD'] =='POST'){
			foreach($param['pro_price_id'] as $key=>$val){
				$kpram['pro_size']= $val;
				$kpram['color_sel']= $param['colors'][$key];
				$kpram['size_sel']= $param['sizes'][$key];
				$key_new = $this->get_key($kpram);
			
				$cart[$key_new]['qty'] =  $param['pro_qty'][$key];
				$cart[$key_new]['color'] = $kpram['color_sel'];
				$cart[$key_new]['size'] = $kpram['size_sel'];
			}	
			$this->session->set('cart_info', $cart);
		}else{
			$cart = $this->session->get('cart_info');
		}
		
		
		$result['provins'] = $this->get_Provin();
		$products = array();
		$db = new Orders();
		
		$total_amount = 0;
		$total_ck=0;
		//$list_pro = array();
		if($cart != NULL){
			$products = $db->get_products($cart);	
				
			foreach($cart as $key=>&$item){
				$exp = explode('_',$key);
				//PhoLog::debug_var('--cart--',$exp );
				$pro_price_id = $exp[0];
				$row = $products[$pro_price_id];
				//$item['qty'] = $cart[$item['pro_price_id']];
				$item['amount'] = $item['qty']*$row['price_exp'];
				$item['chietkhau'] = $item['qty']*($row['price_exp']-$row['price_seller']);
				$item['price_exp'] = $row['price_exp'];
				$item['pro_id'] = $row['pro_id'];
				$item['pro_name'] = $row['pro_name'];
				$item['price_seller'] = $row['price_seller'];
				$item['img_path'] = $row['img_path'];
				$item['pro_price_id'] = $pro_price_id;
				$total_amount += $item['amount'];
				$total_ck +=$item['chietkhau'];
				//$list_pro[$key] = $item;
			}
			$this->session->set('cart_info', $cart);
		}
		$user = $this->session->get('auth');
		$result['districts']=array();
		$result['wards']=array();
		if($user != NULL){
			$result['full_name']=$user->user_name;
			$result['address']=$user->address;
			$result['provin_id']=$user->city;
			$result['district_id']=$user->district;
			$result['ward_id']=$user->ward;
			$result['email']=$user->email;
			$result['phone']=$user->mobile;
			$result['ctv_flg']=$user->ctv_flg;
			if($result['provin_id'] > 0){
				$result['districts']= $this->get_District($result['provin_id']);
			}
			if($result['district_id'] > 0){
				$result['wards']= $this->get_Ward($result['district_id']);
			}
		}else{
			$result['full_name']='';
			$result['address']='';
			$result['provin_id']='';
			$result['district_id']='';
			$result['email']='';
			$result['phone']='';
			$result['ward_id']='';
			$result['ctv_flg']=0;
		}
		
		$result['carts']=$cart;
		$result['total_amount']=$total_amount ;
		$result['total_ck']=$total_ck;
		$this->set_template_share();
		$this->ViewVAR($result);
	}
	public function updateAction(){
		//ACWLog::debug_var('---cart---',$_POST);
		$param = $this->get_param(array(
			  'fullname',
			  'email',
			  'phone',
			  'provin_id',
			  'district_id',
			  'ward_id' ,
			  'address'				  		  
		));	
		$cart = $this->session->get('cart_info');
		// $cart = array();//
		// foreach($param['pro_price_id'] as $key=>$val){
		// 	$cart[$val] = $param['pro_qty'][$key];
		// }		
		$db = new Orders();
		$detail = new OrdersDetail();
		//$products = $db->get_products($cart);
		$total_amount = 0;
		$total_ck =0;
		foreach($cart as $item){
			//$item['qty'] = $cart[$item['pro_price_id']];
			//$item['amount'] = $item['qty']*$item['price_exp'];
			$total_amount += $item['amount'];
			$total_ck +=$item['chietkhau'];
		}
		$param['ship_amount'] = SHIP_AMOUNT;
		$param['total_amount']=($total_amount + $param['ship_amount']);
		$param['total_discount'] = $total_ck;
		$param['discount_flg'] = 0;
		$param['user_id'] = '';
		$param['payment_method'] = '1'; //thanh toan tien mat
		//$param['total_vat'] = $total_amount*0.1;
		$user = $this->session->get('auth');
		if($user != NULL){
			$param['user_id'] = $user->user_id;
			$param['discount_flg'] = $user->ctv_flg;
		}
		PhoLog::debug_var('---order---',$param);
		$ord_id = $db->_insert($param);
		$param['ord_id']= $ord_id;
		$detail->insert_multi($ord_id,$cart);
		$login_info =  $this->session->get('auth');
		$email_to = $param['email'];
		if($login_info != NULL){			
			$email_to = $login_info->email;
		}
		$odb = new Orders();
		$ord_info = $odb->get_info($ord_id);
     	$this->sendmail($param,$cart,$email_to,$ord_info);
		$this->session->set('cart_info', NULL);
		//return ACWView::template('success.html');		
		$this->_redirect(BASE_URL_NAME.'cart/success/'.$ord_id);
	}
	
	
		
	public function sendmail($param,$cart,$email_to,$ord_info){
		$email = new Mail();
		
		$body_tmp = $this->get_body($param,$cart,$ord_info);		
		$replacements['HEADER'] = '<h2><strong>Thông tin đặt hàng </strong></h2>';
		$replacements['BODY'] = $body_tmp;
		$db = new Define();
		$df = $db->get_info(DEFINE_KEY_EMAIL);
		$mail_to[]['mail_address']= $df->define_val;
		if(strlen($email_to)>0){
			$mail_to[]['mail_address']=$email_to;	
		}
		
		//ACWLog::debug_var('--mail',$mail_to);	
		//ACWLog::debug_var('--mail',$data);
		$email->AddListAddress($mail_to);
		$email->add_replyto($df->define_val,SITE_NAME);
                
		$email->Subject =$param['ord_id'].': Thông tin đặt hàng - '.date('d/m/Y H:i:s');                
		$email->loadbody('template_mail.html');
		$email->replaceBody($replacements);
		$result = $email->send();
	}
	public function get_body($param,$cart,$ord_info){
		$html="<h3>Địa chỉ nhận hàng</h3><table>";
		
		if(strlen($param['fullname']) > 0){
			$html .= "<tr><td><strong>Họ tên: </strong></td><td>".$param['fullname']."</td></tr>"."\r\n";
		} 
		/*if(strlen($param['bill_company']) > 0){
			$html .= "<tr><td><strong>Công ty: </strong></td><td>".$param['bill_company']."</td></tr>"."\r\n";
		}
		if(strlen($param['email']) > 0){
			$html .= "<tr><td><strong>Email: </strong></td><td>".$param['email']."</td></tr>"."\r\n";
		}*/
		if(strlen($param['phone']) > 0){
			$html .= "<tr><td><strong>Điện thoại: </strong></td><td>".$param['phone']."</td></tr>"."\r\n";
		}
		if(strlen($ord_info['provin_name']) > 0){
			$html .= "<tr><td><strong>TP/Tỉnh: </strong></td><td>".$ord_info['provin_name']."</td></tr>"."\r\n";
		}
		if(strlen($ord_info['district_name']) > 0){
			$html .= "<tr><td><strong>Quận/Huyện: </strong></td><td>".$ord_info['district_name']."</td></tr>"."\r\n";
		}
		if(strlen($ord_info['ward_name']) > 0){
			$html .= "<tr><td><strong>Phường/Xã: </strong></td><td>".$ord_info['ward_name']."</td></tr>"."\r\n";
		}
		if(strlen($param['address']) > 0){
			$html .= "<tr><td><strong>Địa chỉ: </strong></td><td>".$param['address']."</td></tr>"."\r\n";
		}
		/*if(strlen($param['address_ship']) > 0){
			$html .= "<tr><td><strong>Địa chỉ nhận hàng: </strong></td><td>".$param['address_ship']."</td></tr>"."\r\n";
		}*/
		/*if(strlen($param['order_comments']) > 0){
			$html .= "<tr><td><strong>Ghi chú: </strong></td><td>".$param['order_comments']."</td></tr>"."\r\n";
		}*/
		$html .="</table>";
		$html .="<h3>Hình thức thanh toán</h3>";
		/*if($param['payment_method']=='ck'){
			$html .="<p>Chuyển khoản</p>";
		}else if($param['payment_method']=='tm'){*/
			$html .="<p>Tiền mặt</p>";
		//}
		
		$html .="<h3>Thông tin đơn hàng</h3><p><strong>Mã đơn hàng: ".$param['ord_id']."</strong></p><table style=\"border-collapse: collapse;\">";
		$html .= "<tr><td style=\"border: 1px solid #d7dbdb;padding:10px;\">STT</td>
				  <td style=\"border: 1px solid #d7dbdb;padding:10px;\">Tên hàng</td>
				  <td style=\"border: 1px solid #d7dbdb;padding:10px;\">Màu sắc</td>
				  <td style=\"border: 1px solid #d7dbdb;padding:10px;\">Kích thước</td>
				  <td style=\"border: 1px solid #d7dbdb;padding:10px;\">Giá</td>
				  <td style=\"border: 1px solid #d7dbdb;padding:10px;\">Số lượng</td>
				  <td style=\"border: 1px solid #d7dbdb;padding:10px;\">Thành tiền</td>
				  </tr>";
		$stt=0;
		foreach($cart as $key=>$item){	
			$stt++;
			$html .= "<tr><td style=\"border: 1px solid #d7dbdb;padding:5px;\">".$stt."</td>
			<td style=\"border: 1px solid #d7dbdb;padding:10px;\">".$item['pro_name']."</td>
			<td style=\"border: 1px solid #d7dbdb;padding:10px;\">".$item['color']."</td>
			<td style=\"border: 1px solid #d7dbdb;padding:10px;\">".$item['size']."</td>
			<td style=\"border: 1px solid #d7dbdb;padding:10px;\">".self::currency_format($item['price_exp'])." VNĐ</td>
			<td style=\"border: 1px solid #d7dbdb;padding:10px;\">".self::currency_format($item['qty'])."</td>
			<td style=\"border: 1px solid #d7dbdb;padding:10px;\">".self::currency_format($item['amount'])." VNĐ</td></tr>";
		}
		$html .='<tr><td colspan="6" style="border: 1px solid #d7dbdb;padding:10px;">Tổng tiền</td>
		<td style="border: 1px solid #d7dbdb;padding:10px;">'.self::currency_format($param['total_amount']-$param['ship_amount']).' VNĐ</td></tr>';
		$html .='<tr><td colspan="6" style="border: 1px solid #d7dbdb;padding:10px;">Phí ship</td>
		<td style="border: 1px solid #d7dbdb;padding:10px;">'.self::currency_format($param['ship_amount']).' VNĐ</td></tr>';
		$html .='<tr><td colspan="6" style="border: 1px solid #d7dbdb;padding:10px;">Tổng tiền thanh toán</td>
		<td style="border: 1px solid #d7dbdb;padding:10px;">'.self::currency_format($param['total_amount']).' VNĐ</td></tr>';
		$html .="</table>";
		return $html;
	}
}
