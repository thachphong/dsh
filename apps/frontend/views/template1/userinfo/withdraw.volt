<div class="row breadcrumb">
	<div class="container">
		<a href="{{baseurl}}">Trang chủ</a>	>
		<a href="{{baseurl}}thanh-vien"> Thành viên</a>	
		<span>> Yêu cầu rút tiền</span>			
	</div>
</div>
<div class="row">
	<div class="container">
		{{ partial('includes/user_left') }}
		<div class="col-md-9 col-sm-12 col-xs-12 margin-top20 no_padding_right">
			<div class="row panel_bg padding10">
			<div class="pn_title margin_top">					
				<h1 class="margin-top10">Yêu cầu rút tiền </h1>
			</div>
			<hr class="line" />
			<div class="row margin_top pn_background pn_border post_pn" >
            <div class="post_head">
               <div class="row pn_content">
				<form id="from_user">
					<div class="row" style="text-align: center">
						<h4 class="lab_invisible col_blue msg_success" >{{constant("SITE_NAME")}} đã nhận được yêu cầu rút tiền của bạn</h4>
						<h4 class="lab_invisible col_blue msg_success" >{{constant("SITE_NAME")}} sẽ chuyển khoản cho bạn trong thời gian 2 - 48h giờ làm việc!</h4>
						{%if request_flg == 1%}
							<h4 class="lab_red" >Bạn đã gửi yêu cầu rút tiền, yêu cầu của bạn đang chờ xử lý !</h4>
						{%elseif user.amount < 100000%}
							<h4 class="lab_red" >Số dư của bạn phải >= 100.000 VNĐ mới được gửi yêu cầu rút !</h4>
						{%endif%}
					</div>
					<div class="row row-margin-bottom">
						<label class="col-md-4 col-sm-4 col-xs-12 align_right title_col">Ngân hàng</label>
						<div class="col-md-7 col-sm-7 col-xs-12">
							<select id="bank_id" name="bank_id" required>            			
		            			<option value="">--Chọn Ngân hàng--</option>
		            			{%for item in banks%}
		            				{%if user.bank_id==item.bank_id%}
		            					<option value="{{item.bank_id}}" selected="selected">{{item.bank_name}}</option>
		            				{%else%}
		            					<option value="{{item.bank_id}}">{{item.bank_name}}</option>
		            				{%endif%}
		            			{%endfor%}
		            		</select>
							<span class="lab_red lab_invisible" id="bank_id_error">Bạn cần chọn ngân hàng</span>
						</div>
					</div>
					<div class="row row-margin-bottom">
						<label class="col-md-4 col-sm-4 col-xs-12 align_right title_col">Phí chuyển khoản</label>
						<div class="col-md-7 col-sm-7 col-xs-12">
							<input type="text" name="fee"  value="{%if user.bank_id==1%}3.300{%else%}7.700{%endif%}" id="fee" disabled="disabled">
						</div>
					</div>
					<div class="row row-margin-bottom">
						<label class="col-md-4 col-sm-4 col-xs-12 align_right title_col">Số tài khoản</label>
						<div class="col-md-7 col-sm-7 col-xs-12">
							<input {%if user.amount < 100000%}disabled{%endif%} type="text" name="bank_acc_no"  value="{{user.bank_acc_no}}" id="bank_acc_no" required maxlength="20">
							<span class="lab_red lab_invisible" id="bank_acc_no_error">Bạn cần nhập số tài khoản</span>
						</div>
					</div>
					<div class="row row-margin-bottom">
						<label class="col-md-4 col-sm-4 col-xs-12 align_right title_col">Tên chủ tài khoản</label>
						<div class="col-md-7 col-sm-7 col-xs-12">
							<input {%if user.amount < 100000%}disabled{%endif%} type="text" name="bank_acc_name"  value="{{user.bank_acc_name}}" id="bank_acc_name" required maxlength="50">
							<span class="lab_red lab_invisible" id="bank_acc_name_error">Bạn cần nhập tên chủ tài khoản</span>
						</div>
					</div>
					<div class="row row-margin-bottom">
						<label class="col-md-4 col-sm-4 col-xs-12 align_right title_col">Số tiền rút</label>
						<div class="col-md-7 col-sm-7 col-xs-12">
							<input type="hidden" id="max_amount"  value="{{user.amount}}" required>
							<input {%if user.amount < 100000%}disabled{%endif%} type="text" class="number_format" name="amount"  value="" id="amount" required>
							<span class="lab_red lab_invisible" id="amount_error">Bạn cần nhập số tiền rút</span>
							<span class="lab_red lab_invisible" id="amount_validate"></span>
						</div>
					</div>
				</form>	
				<div class="col-md-12 col-sm-12 col-xs-12" style="text-align: center;">	
					{%if user.amount >= 100000 and request_flg == 0%}
						<button class="btn_dangtin" id="btn_save"><i class="fa fa-save"></i>Gửi yêu cầu rút tiền</button>
					{%endif%}
				</div>		
			   </div>
            </div>
            <!--<hr class="line" />-->
            </div>
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
		$(document).off('change','#bank_id');
		$(document).on('change','#bank_id',function(){
			if($(this).val() != 1){
				$('#fee').val('7.700');
			}else{
				$('#fee').val('3.300');
			}
		});
		$(document).off('click','#btn_save'); 
        $(document).on('click','#btn_save',function(event){
        	var msg = check_validate_update();
          	if(!msg){
            	topFunction();
            	return;
          	}
          	$('#fee').prop('disabled',false);
          	var arr = $('#from_user').serializeArray();
          	$('#fee').prop('disabled',true);
	      	Pho_json_ajax('POST',"{{url.get('thanh-vien/updwithdraw')}}" ,arr,function(datas){
		        if(datas.status =="OK"){
		          //Pho_modal_close("modal1");
		          $('.msg_success').show();
		          $('#btn_save').remove();
		          //Pho_message_box("Thông báo",'Gửi yêu cầu thành công !');
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
        	$('select:required').each(function(key,item){
        		if($(this).val().trim().length == 0){
        			$('#'+ $(this).attr('id') + "_error").show();
        			flg = false;
        		}else{
        			$('#'+ $(this).attr('id') + "_error").hide();
        		}
        	});
        	if($('#amount').val().trim() !='' && $('#max_amount').val().trim() !=''){
        		var amount = parseInt($('#amount').val().trim().replace(/\./g,''));
        		var max_amount = parseInt($('#max_amount').val().trim());
        		var fee = parseInt($('#fee').val().trim().replace(/\./g,''));
        		if((amount + fee)>max_amount){
        			flg = false;
        			$('#amount_validate').text('Bạn chỉ rút tối đa được : '+currency_format(max_amount-fee) +' VNĐ');  
        			$('#amount_validate').show();        			
        		}else if(amount < 50000){
        			flg = false;
        			$('#amount_validate').text('Số tiền rút tối thiếu là : 50.000 VNĐ');  
        			$('#amount_validate').show(); 
        		}else{
        			$('#amount_validate').hide();
        		}
        	}
        	return flg;
        }	
        
		$(document).off('blur','.number_format'); 
        $(document).on('blur','.number_format',function(event){
        	var val = $(this).val().replace(/\./g,'');
        	if($.isNumeric( val) == false){
        		$(this).val("");
        		return;
        	}
        	$(this).val( currency_format(val)   );
        });
        
        function currency_format(n) {
          //console.log(n);
          if(n==null){ return null;}
          n = n.toString().replace(/\./g,'');	
          return n.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1.");
    	}	
	});
</script>
