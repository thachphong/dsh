<?php
namespace Multiple\Frontend\Controllers;
use Multiple\PHOClass\PHOController;
use Multiple\PHOClass\PhoLog;
use Multiple\Models\Orders;
use Multiple\Models\OrdersDetail;
use Multiple\Models\Provincial;
use Multiple\Models\District;
use Multiple\Models\Define;
use Multiple\Library\Mail;
class CartController extends PHOController
{
	public function indexAction()
	{		
		$db = new Orders();
		$cart = $this->session->get('cart_info');
		//ACWLog::debug_var('--cart--',$cart );
		$products = array();
		$total_amount = 0;
		if($cart != NULL){
			$products = $db->get_products($cart);			
			foreach($products as &$item){
				$item['qty'] = $cart[$item['pro_price_id']];
				$item['amount'] = $item['qty']*$item['price_exp'];
				$total_amount += $item['amount'];
			}
		}
		$this->set_template_share();
		$this->ViewVAR(array(
			'carts' =>$products
			,'total_amount'=>$total_amount
		));		
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
			'pro_size'
		));	
		$cart = $this->session->get('cart_info');
		if($cart != NULL){
			if(isset($cart[$param['pro_size']])){
				$cart[$param['pro_size']]= $cart[$param['pro_size']] + $param['pro_qty'];				
			}else{
				//$size_info =$this->get_price($param['pro_size']);
				$cart[$param['pro_size']]=  $param['pro_qty'];
				//$cart[$param['pro_size']]['price'] = $size_info['price_new'];
				//$cart[$param['pro_size']]['size'] = $size_info['size'];
			}
		}else{
			//$size_info =$this->get_price($param['pro_size']);
			$cart[$param['pro_size']] =  $param['pro_qty'];
			//$cart[$param['pro_size']]['price'] = $size_info['price_new'];
			//$cart[$param['pro_size']]['size'] = $size_info['size'];
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
			'pro_size'
		));	
		$cart = $this->session->get('cart_info');
		if($cart != NULL){
			if(isset($cart[$param['pro_size']])){
				$cart[$param['pro_size']]= $cart[$param['pro_size']] + $param['pro_qty'];				
			}else{
				//$size_info =$this->get_price($param['pro_size']);
				$cart[$param['pro_size']]=  $param['pro_qty'];
				//$cart[$param['pro_size']]['price'] = $size_info['price_new'];
				//$cart[$param['pro_size']]['size'] = $size_info['size'];
			}
		}else{
			//$size_info =$this->get_price($param['pro_size']);
			$cart[$param['pro_size']] =  $param['pro_qty'];
			//$cart[$param['pro_size']]['price'] = $size_info['price_new'];
			//$cart[$param['pro_size']]['size'] = $size_info['size'];
		}
			
		$this->session->set('cart_info', $cart);		
		$this->_redirect(BASE_URL_NAME.'cart');
	}
	public function deleteAction($pro_price_id)
	{	
		$cart = $this->session->get('cart_info');
		unset($cart[$pro_price_id ]);
		
		$this->session->set('cart_info', $cart);		
		$this->_redirect(BASE_URL_NAME.'cart');
	}
	public function payAction(){
		$param = self::get_param(array(			  
			  'pro_qty',
			  'pro_price_id',
			  'address_ship'
		));	
		$cart = array();//ACWSession::get("cart_info");
		foreach($param['pro_price_id'] as $key=>$val){
			$cart[$val] = $param['pro_qty'][$key];
		}	
		$this->session->set('cart_info', $cart);
		$result['provins'] = Provincial::get_all();
		$products = array();
		$db = new Orders();
		$total_amount = 0;
		if($cart != NULL){
			$products = $db->get_products($cart);			
			foreach($products as &$item){
				$item['qty'] = $cart[$item['pro_price_id']];
				$item['amount'] = $item['qty']*$item['price_exp'];
				$total_amount += $item['amount'];
			}
		}
		$result['carts']=$products;
		$result['total_amount']=$total_amount;
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
		$products = $db->get_products($cart);
		$total_amount = 0;
		foreach($products as &$item){
			$item['qty'] = $cart[$item['pro_price_id']];
			$item['amount'] = $item['qty']*$item['price_exp'];
			$total_amount += $item['amount'];
		}
		$param['ship_amount'] = SHIP_AMOUNT;
		$param['total_amount']=($total_amount + $param['ship_amount']);
		//$param['total_vat'] = $total_amount*0.1;
		
		$ord_id = $db->_insert($param);
		$param['ord_id']='D'. $ord_id;
		$detail->insert_multi($ord_id,$products);
		$login_info =  $this->session->get('auth');
		$email_to = $param['email'];
		if($login_info != NULL){			
			$email_to = $login_info->email;
		}
     	$this->sendmail($param,$products,$email_to);
		$this->session->set('cart_info', NULL);
		//return ACWView::template('success.html');		
		$this->_redirect(BASE_URL_NAME.'cart/success/'.$ord_id);
	}
	
	
		
	public function sendmail($param,$cart,$email_to){
		$email = new Mail();
		
		$body_tmp = $this->get_body($param,$cart);		
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
	public function get_body($param,$cart){
		$html="<h3>Thông tin khách hàng</h3><table>";
		
		if(strlen($param['fullname']) > 0){
			$html .= "<tr><td><strong>Họ tên: </strong></td><td>".$param['fullname']."</td></tr>"."\r\n";
		} 
		/*if(strlen($param['bill_company']) > 0){
			$html .= "<tr><td><strong>Công ty: </strong></td><td>".$param['bill_company']."</td></tr>"."\r\n";
		}*/
		if(strlen($param['email']) > 0){
			$html .= "<tr><td><strong>Email: </strong></td><td>".$param['email']."</td></tr>"."\r\n";
		}
		if(strlen($param['phone']) > 0){
			$html .= "<tr><td><strong>Điện thoại: </strong></td><td>".$param['phone']."</td></tr>"."\r\n";
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
				  <td style=\"border: 1px solid #d7dbdb;padding:10px;\">Kích thước</td>
				  <td style=\"border: 1px solid #d7dbdb;padding:10px;\">Giá</td>
				  <td style=\"border: 1px solid #d7dbdb;padding:10px;\">Số lượng</td>
				  <td style=\"border: 1px solid #d7dbdb;padding:10px;\">Thành tiền</td>
				  </tr>";
		foreach($cart as $key=>$item){			
			$html .= "<tr><td style=\"border: 1px solid #d7dbdb;padding:5px;\">".($key+1)."</td>
			<td style=\"border: 1px solid #d7dbdb;padding:10px;\">".$item['pro_name']."</td>
			<td style=\"border: 1px solid #d7dbdb;padding:10px;\">".$item['size']."</td>
			<td style=\"border: 1px solid #d7dbdb;padding:10px;\">".self::currency_format($item['price_exp'])." VNĐ</td>
			<td style=\"border: 1px solid #d7dbdb;padding:10px;\">".self::currency_format($item['qty'])."</td>
			<td style=\"border: 1px solid #d7dbdb;padding:10px;\">".self::currency_format($item['amount'])." VNĐ</td></tr>";
		}
		$html .='<tr><td colspan="5" style="border: 1px solid #d7dbdb;padding:10px;">Tổng tiền</td>
		<td style="border: 1px solid #d7dbdb;padding:10px;">'.self::currency_format($param['total_amount']-$param['ship_amount']).' VNĐ</td></tr>';
		$html .='<tr><td colspan="5" style="border: 1px solid #d7dbdb;padding:10px;">Phí ship</td>
		<td style="border: 1px solid #d7dbdb;padding:10px;">'.self::currency_format($param['ship_amount']).' VNĐ</td></tr>';
		$html .='<tr><td colspan="5" style="border: 1px solid #d7dbdb;padding:10px;">Tổng tiền thanh toán</td>
		<td style="border: 1px solid #d7dbdb;padding:10px;">'.self::currency_format($param['total_amount']).' VNĐ</td></tr>';
		$html .="</table>";
		return $html;
	}
}
