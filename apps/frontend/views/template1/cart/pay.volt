
<div class="row breadcrumb">
	<div class="container">
		<a href="{{baseurl}}">Trang chủ</a>		
		<span>> Thông tin giao hàng</span>			
	</div>
</div>
<div class="row content_bg">	
   <div class="container panel_bg margin-top10">
     <div class="row margin_top" >
        <div class="col-md-6 col-sm-6 col-xs-12 margin_top " style="border-right: 1px solid #ddd;">
         <!--<div class="pn_posts">-->
            <div class="pn_title">               
               <h1>Địa chỉ giao hàng {%if email==''%}<a href="{{baseurl}}dang-nhap" class="link_color" style="float: right;">Đăng nhập để đặt hàng</a>{%endif%}</h1>
               
            </div> 
            <hr class="line" />           
            <form id="from_post" enctype="multipart/form-data" method="post" action="{{baseurl}}cart/update">
            <div class="row">
            	<div class="col-md-4 col-sm-4 col-xs-12 align_repon no_padding"><label class="title_col">Họ và Tên<span class="lab_red">(*)</span></label></div>
            	<div class="col-md-8 col-sm-8 col-xs-12">
            		<input type="text" name="fullname" placeholder="Họ và tên" id="fullname" value="{{full_name}}" required/>
            		<span class="lab_red lab_invisible" id="fullname_error">Bạn cần nhập họ và tên.</span>
            	</div>
            </div>
            <div class="row margin-top10">
            	<div class="col-md-4 col-sm-4 col-xs-12 align_repon no_padding"><label class="title_col">Số điện thoại<span class="lab_red">(*)</span></label></div>
            	<div class="col-md-8 col-sm-8 col-xs-12">
            		<input type="text" name="phone" placeholder="Số điện thoại" id="phone_number" value="{{phone}}" required/>
            		<span class="lab_red lab_invisible" id="phone_number_error">Bạn cần nhập số điện thoại.</span>
            		<span class="lab_red lab_invisible" id="phone_number_validate">Bạn cần nhập đúng định dạng số điện thoại !</span>
            	</div>
            </div>            
            <div class="row margin-top10">
            	<div class="col-md-4 col-sm-4 col-xs-12 align_repon no_padding"><label class="title_col">Tỉnh/TP<span class="lab_red">(*)</span></label></div>
            	<div class="col-md-8 col-sm-8 col-xs-12">
            		<select id="m_provin_id" name="provin_id" required>            			
            			<option value="">--Chọn Tỉnh/TP--</option>
            			{%for item in provins%}
            				{%if provin_id==item.m_provin_id%}
            					<option value="{{item.m_provin_id}}" selected="selected">{{item.m_provin_name}}</option>
            				{%else%}
            					<option value="{{item.m_provin_id}}">{{item.m_provin_name}}</option>
            				{%endif%}
            			{%endfor%}
            		</select>
            		<span class="lab_red lab_invisible" id="m_provin_id_error">Bạn cần chọn Tỉnh/TP.</span>
            	</div>
            </div>
            <div class="row margin-top10">
            	<div class="col-md-4 col-sm-4 col-xs-12 align_repon no_padding"><label class="title_col">Quận/Huyện<span class="lab_red">(*)</span></label></div>
            	<div class="col-md-8 col-sm-8 col-xs-12">
            		<select id="m_district_id" name="district_id" required>
            			<option value="">--Chọn Quận/Huyện--</option>
            			{%for item in districts%}
            				{%if district_id==item['m_district_id']%}
            					<option value="{{item['m_district_id']}}" selected="selected">{{item['m_district_name']}}</option>
            				{%else%}
            					<option value="{{item['m_district_id']}}">{{item['m_district_name']}}</option>
            				{%endif%}
            			{%endfor%}
            		</select>
            		<span class="lab_red lab_invisible" id="m_district_id_error">Bạn cần chọn Quận/Huyện.</span>
            	</div>
            </div>
            <div class="row margin-top10">
            	<div class="col-md-4 col-sm-4 col-xs-12 align_repon no_padding"><label class="title_col">Phường/Xã<span class="lab_red">(*)</span></label></div>
            	<div class="col-md-8 col-sm-8 col-xs-12">
            		<select id="m_ward_id" name="ward_id" required>
            			<option value="">--Chọn Phường/Xã--</option>
            			{%for item in wards%}
            				{%if ward_id==item['m_ward_id']%}
            					<option value="{{item['m_ward_id']}}" selected="selected">{{item['m_ward_name']}}</option>
            				{%else%}
            					<option value="{{item['m_ward_id']}}">{{item['m_ward_name']}}</option>
            				{%endif%}
            			{%endfor%}
            		</select>
            		<span class="lab_red lab_invisible" id="m_ward_id_error">Bạn cần chọn Phường/Xã.</span>
            	</div>
            </div>
            <div class="row margin-top10">
            	<div class="col-md-4 col-sm-4 col-xs-12 align_repon no_padding"><label class="title_col">Địa chỉ nhận hàng (tầng, số nhà, đường)<span class="lab_red">(*)</span></label></div>
            	<div class="col-md-8 col-sm-8 col-xs-12">            		
            		<textarea name="address" cols="" rows="3" placeholder="Địa chỉ nhận hàng" id="address"  required>{{address}}</textarea>
            		<span class="lab_red lab_invisible" id="address_error">Bạn cần nhập địa chỉ nhận hàng.</span>
            	</div>
            </div>
            <div class="row margin-top10">
            	<div class="col-md-4 col-sm-4 col-xs-12 align_repon no_padding"><label class="title_col">Email</label></div>
            	<div class="col-md-8 col-sm-8 col-xs-12">
            		<input type="text" name="email" placeholder="Email" id="email" value="{{email}}"/>
            		<span class="lab_red lab_invisible" id="email_error">Bạn cần nhập email.</span>
            		<span class="lab_red lab_invisible" id="email_validate">Bạn cần nhập đúng định dạng email !</span>
            	</div>
            </div>
            <div class="row margin-top10">
            	<div class="col-md-4 col-sm-4 col-xs-12 align_repon no_padding"><label class="title_col">Hình thức thanh toán</label></div>
            	<div class="col-md-8 col-sm-8 col-xs-12">
            		<label class="title_col col_blue">Tiền mặt</label>     		
            	</div>
            </div>
            </form>     
            <div class="row margin-top10">
					<div class="col-md-12 col-sm-12 col-xs-12 no_padding_left" style="padding-bottom: 10px;text-align:right">
						<a class="btn_buy btn_red" id="btn_upd">Hoàn thành</a>
					</div>
			</div>
      	</div>
      	<div class="col-md-6 col-sm-6 col-xs-12 margin_top ">
      		<div class="pn_title">               
               <h3>Thông tin đơn hàng </h3>
            </div> 
            <hr class="line" /> 
            <table class="table tab_sum">
            	<tbody>
	            	<tr>
	            		<th>Sản phẩm</th>
	            		<th>Số lượng</th>
	            		<th>Thành tiền</th>
	            		<th>Chiết khấu</th>
	            	</tr>
	            
	            	{%for item in carts%}
	                    <tr class="">                                       
	                        <td>{{item['pro_name']}}</td>
	                        <td>{{item['qty']}}</td>
	                        <td>{{elements.currency_format(item['amount'])}} ₫</td>
	                        <td>{{elements.currency_format(item['chietkhau'])}} ₫</td>
	                    </tr>
	                {%endfor%}
	                <tr class="">                                       
	                        <th colspan="2">Tổng tiền</th>	                        
	                        <th colspan="2">{{elements.currency_format(total_amount)}} ₫</th>
	                </tr>
	                <tr class="">                                       
	                        <th colspan="2">Phí ship</th>	                        
	                        <th colspan="2">{{elements.currency_format(ship_amount)}} ₫</th>
	                </tr>
	                <tr class="">                                       
	                        <th colspan="2" class="col_red">Tổng tiền thanh toán</th>	                        
	                        <th class="col_red" colspan="2">{{elements.currency_format(total_amount + ship_amount)}} ₫</th>
	                </tr>
	                <tr class="">                                       
	                        <th colspan="2" class="col_blue">Tổng tiền Chiết khấu</th>	                        
	                        <th colspan="2" class="col_blue">{{elements.currency_format(total_ck)}} ₫</th>
	                </tr>
                </tbody>
            </table>
            <div class="row">
      			<span style="font-style: italic;">Tiền chiết khấu sẽ được cộng vào tài khoản của bạn, khi đơn hàng được giao thành công.</span>
      			{%if email==''%}
      				<p class="lab_red">(Bạn chưa đăng ký làm cộng tác viên, nên sẽ không nhận được tiền chiết khấu)</p>
      				<a class="link_color" href="{{baseurl}}p/huong-dan-dang-ky-ctv"><strong>Hướng dẫn đăng ký làm cộng tác viên</strong></a>
      			{%elseif ctv_flg==0%}
      				<p class="lab_red">(Tài khoản của bạn không phải là cộng tác viên, nên sẽ không nhận được tiền chiết khấu)</p>
      				<a class="link_color" href="{{baseurl}}p/huong-dan-dang-ky-ctv"><strong>Hướng dẫn đăng ký làm cộng tác viên</strong></a>
      			{%endif%}
      		</div> 
      	</div> 
      	
      </div>   
   </div>  
</div>
{{ partial('includes/pho_ajax') }}
<script type="text/javascript">
	$(document).ready(function() {
		$(document).off('change','#m_provin_id');
		$(document).on('change','#m_provin_id',function(){			
			change_district_option();			
		});
		$(document).off('change','#m_district_id');
		$(document).on('change','#m_district_id',function(){			
			change_ward_option();			
		});
		var change_district_option= function(){
			var val = $('#m_provin_id').val();
			var option = '<option value="">--Chọn Quận/Huyện--</option>';
			$('#m_district_id').empty();
			loading_flg = false;
			Pho_json_ajax('GET',"{{url.get('index/district/')}}"+val ,null,function(datas){
		        
		        var list = datas.list;		          
		        $('#cart_number').text(datas.total);
		        $.each(list,function(key,item){			
						option +='<option value="'+item['m_district_id']+'" >'+item['m_district_name']+'</option>';
				});
		        $('#m_district_id').empty();
				$('#m_district_id').append(option);    
		       	                
	        });
		};
		var change_ward_option= function(){
			var val = $('#m_district_id').val();
			var option = '<option value="">--Chọn Phường/Xã--</option>';
			loading_flg = false;
			 $('#m_ward_id').empty();
			Pho_json_ajax('GET',"{{url.get('index/ward/')}}"+val ,null,function(datas){
		        
		        var list = datas.list;		          
		        $('#cart_number').text(datas.total);
		        $.each(list,function(key,item){			
						option +='<option value="'+item['m_ward_id']+'" >'+item['m_ward_name']+'</option>';
				});
		       
				$('#m_ward_id').append(option);    
		       	                
	        });
		};
		function topFunction() {
		    document.body.scrollTop = 100; // For Chrome, Safari and Opera 
		    document.documentElement.scrollTop = 100; // For IE and Firefox
		}
		$(document).off('click','#btn_upd'); 
        $(document).on('click','#btn_upd',function(event){
        	var msg = check_validate_update();
          	if(!msg){
            	topFunction();
            	return;
          	}
          	$('#from_post').submit();
          	/*var arr = $('#from_post').serializeArray();
	      	Pho_json_ajax('POST',"{{baseurl}}cart/update" ,arr,function(datas){
		        if(datas.status =="OK"){
		          //Pho_modal_close("modal1");
		          //Pho_message_box("Thông báo",'Đăng tin thành công !');
		        	Pho_direct("{{baseurl}}cart/success/"+datas.id  );
		        }else{
	        		Pho_message_box_error("Lỗi",datas.msg);		        			        	
		        }	                
	        });*/
        });
        var check_validate_update = function(){
        	var flg = true;
        	if($('#email').val().trim() !=''){
        		if(!validateEmail($('#email').val())){
        			$('#email_validate').text('Bạn cần nhập đúng định dạng email !');
        			$('#email_validate').show();
        			flg = false;
        		}else{
        			$('#email_validate').hide();
        		}
        	}
        	if($('#phone_number').val().trim() !=''){
        		if(!validatePhone($('#phone_number').val())){
        			//$('#phone_number_validate').text('Bạn cần nhập đúng định dạng email !');
        			$('#phone_number_validate').show();
        			flg = false;
        		}else{
        			$('#phone_number_validate').hide();
        		}
        	}
        	
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
        	$('textarea:required').each(function(key,item){
        		if($(this).val().trim().length == 0){
        			$('#'+ $(this).attr('id') + "_error").show();
        			flg = false;
        		}else{
        			$('#'+ $(this).attr('id') + "_error").hide();
        		}
        	});  
        	return flg;
        }	
        function validateEmail($email) {
		  var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
		  return emailReg.test( $email );
		}	
		function validatePhone(phone){
			//(123) 456-7890
			//123-456-7890
			//123.456.7890
			//1234567890
			//var emailReg = /^[(]{0,1}[0-9]{3,4}[)]{0,1}[-\s\.]{0,1}[0-9]{3}[-\s\.]{0,1}[0-9]{4}$/;
			var phoneReg = /^[0-9]{10,11}$/;
			phone = phone.replace(/([\(\)\-\.\,\s])/g, "");
		  	return phoneReg.test( phone );
		  	
		}
	});
    
    function currency_format(n) {
          return n.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1.");
    }
</script>