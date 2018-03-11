<div class="row">
	<div class="container">
		{{ partial('includes/user_left') }}
		<div class="col-md-9 col-sm-12 col-xs-12 margin_top">
			<div class="pn_title margin_top">
					<span class="bg_icon"><i class="fa post-pencil"></i></span>
					<h1>Phương thức thanh toán </h1>
			</div>
			<div class="row margin_top pn_background pn_border post_pn" >
            <div class="post_head">
               <div class="row pn_content">				
					<div class="row row-margin-bottom">
						<div class="col-md-2 col-sm-2 col-xs-3 align_right title_col">
							<img src="{{url.get('template1/images/atm.png')}}"/>
						</div>
						<div class="col-md-10 col-sm-10 col-xs-9">							
							<label class="">Thanh toán online dùng thẻ Visa, Master Card, thẻ ATM có Internet Banking</label><br>
							<span style="color: rgba(51, 51, 51, 0.68);">Thanh toán nhanh gọn và có thể mua hàng hay sử dụng dịch vụ ngay sau khi thanh toán.</span><br />
							<img src="{{url.get('template1/images/img-visa.png')}}"/>
						</div>
						<a class="btn_dangtin" style="float: right" href="{{url.get('exchange/pay')}}"><i class="fa fa-usd-while"></i>Nạp tiền</a>
					</div>
					<hr class="line"/>
					<div class="row row-margin-bottom">
						<div class="col-md-2 col-sm-2 col-xs-3 align_right title_col">
							<img src="{{url.get('template1/images/money.png')}}" width="50px"/>
						</div>
						<div class="col-md-10 col-sm-10 col-xs-9">							
							<label class="">Tiền mặt, chuyển khoản ngân hàng</label><br>
							<span style="color: rgba(51, 51, 51, 0.68);">Bạn sẽ được hỗ trợ thanh toán tiền mặt hoặc chuyển khoản vào tài khoản công ty chúng tôi</span><br />
						</div>
						<a class="btn_dangtin" style="float: right" href="{{url.get('p/huong-dan-thanh-toan')}}"><i class="fa fa-usd-while"></i>Nạp tiền</a>
					</div>
			   </div>
            </div>
            <!--<hr class="line" />-->
            
         </div>			
		</div>
	</div>
</div>
{{ partial('includes/pho_ajax') }}
<script type="text/javascript">
	$(document).ready(function() {		
		function topFunction() {
		    document.body.scrollTop = 0; // For Chrome, Safari and Opera 
		    document.documentElement.scrollTop = 0; // For IE and Firefox
		}
		$(document).off('click','#btn_save'); 
        $(document).on('click','#btn_save',function(event){
        	var msg = check_validate_update();
          	if(!msg){
            	topFunction();
            	return;
          	}
          	var arr = $('#from_user').serializeArray();
	      	Pho_json_ajax('POST',"{{url.get('users/updatepass')}}" ,arr,function(datas){
		        if(datas.status =="OK"){
		          //Pho_modal_close("modal1");
		          Pho_message_box("Thông báo",'Thay đổi mật khẩu thành công !');
		          //Pho_direct("{{url.get('dang-nhap/')}}" + datas.msg);
		        }else{
		        	/*if(datas.code=='email'){ // trung email
		        		$('#email_validate').text(datas.msg);
		        		$('#email_validate').show();
		        	}else if(datas.code =='userno'){ // trung ten dang nhap
		        		$('#user_no_validate').show();
		        	}else{*/
		        		Pho_message_box_error("Lỗi",datas.msg);
		        	//}		        	
		        }	                
	        });
        });
        var check_validate_update = function(){
        	var flg = true;
        	//$('#user_no_validate').hide();
        	$('input:required').each(function(key,item){
        		if($(this).val().trim().length == 0){
        			$('#'+ $(this).attr('id') + "_error").show();
        			flg = false;
        		}else{
        			$('#'+ $(this).attr('id') + "_error").hide();
        		}
        	});        	       	
        	
        	if($('#pass_new').val().trim() !='' && $('#re_pass_new').val().trim() !=''){
        		if($('#pass_new').val().trim() != $('#re_pass_new').val().trim()){
        			flg = false;
        			$('#pass_validate').show();        			
        		}else{
        			$('#pass_validate').hide();
        		}
        	}
        	return flg;
        }	
        function validateEmail($email) {
		  var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
		  return emailReg.test( $email );
		}	
	});
</script>
