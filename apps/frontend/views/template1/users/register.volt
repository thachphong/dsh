<div class="row breadcrumb">
	<div class="container">
		<a href="{{baseurl}}">Trang chủ</a>		
		<span>> Đăng ký</span>			
	</div>
</div>
<div class="row content_bg margin-top10">
	<div class="container register_form panel_bg">		
		<div class="col-md-12 col-sm-12 col-xs-12 padding-mobi">
			<div class="pn_posts">
				<div class="pn_title">
					<!--<span class="bg_icon"><i class="fa post-pencil"></i></span>-->
					<h1>Đăng ký </h1>
				</div>		
				<hr class="line" />		
				<div class="pn_content padding-bottom20">					
					<form enctype="multipart/form-data" id="from_post">
						<!--<div class="row margin-top10">
							<label class="col-md-3 col-sm-3 col-xs-12 title_col align_right">Tên đăng nhập <span class="lab_red">(*)</span>:</label>
							<div class="col-md-6 col-sm-8 col-xs-12">
								<input type="text" name="user_no"  value="" id="user_no" required>
								<span class="lab_red lab_invisible" id="user_no_error">Bạn cần nhập tên đăng nhập !</span>
								<span class="lab_red lab_invisible" id="user_no_validate">Tên đăng nhập này đã có, vui lòng nhập tên khác !</span>
							</div>
						</div>-->
						<div class="row margin-top10">
							<label class="col-md-3 col-sm-3 col-xs-12 title_col align_repon">Email <span class="lab_red">(*)</span>:</label>
							<div class="col-md-6 col-sm-8 col-xs-12">
								<input type="Email" name="email"  value="" id="email" required>
								<span class="lab_red lab_invisible" id="email_error">Bạn cần nhập email !</span>
								<span class="lab_red lab_invisible" id="email_validate">Bạn cần nhập đúng định dạng email !</span>
							</div>							
						</div>
						<div class="row margin-top10">
							<label class="col-md-3 col-sm-3 col-xs-12 title_col align_repon">Mật khẩu <span class="lab_red">(*)</span>:</label>
							<div class="col-md-6 col-sm-8 col-xs-12">
								<input type="password" name="pass"  value="" id="pass" required>
								<span class="lab_red lab_invisible" id="pass_error">Bạn cần nhập mật khẩu !</span>
							</div>
						</div>
						<div class="row margin-top10">
							<label class="col-md-3 col-sm-3 col-xs-12 title_col align_repon">Xác nhận lại mật khẩu <span class="lab_red">(*)</span>:</label>
							<div class="col-md-6 col-sm-8 col-xs-12">
								<input type="password" name="re_pass"  value="" id="re_pass" required>
								<span class="lab_red lab_invisible" id="re_pass_error">Bạn cần nhập xác nhận lại mật khẩu !</span>
								<span class="lab_red lab_invisible" id="pass_validate">Xác nhận lại mật khẩu không chính xác !</span>
							</div>
						</div>
						<div class="row margin-top10">
							<label class="col-md-3 col-sm-3 col-xs-12 title_col align_repon">Di động <span class="lab_red">(*)</span>:</label>
							<div class="col-md-6 col-sm-8 col-xs-12">
								<input type="text" name="mobile"  value="" id="mobie" required>
								<span class="lab_red lab_invisible" id="mobie_error">Bạn cần nhập số điện thoại di động !</span>
							</div>
						</div>
						<div class="row margin-top10">
							<label class="col-md-3 col-sm-3 col-xs-12 title_col align_repon">Họ và tên <span class="lab_red">(*)</span>:</label>
							<div class="col-md-6 col-sm-8 col-xs-12">
								<input type="text" name="user_name"  value="" id="user_name" required>
								<span class="lab_red lab_invisible" id="user_name_error">Bạn cần nhập số điện thoại di động !</span>
							</div>
						</div>
						<div class="row margin-top10">
							<label class="col-md-3 col-sm-3 col-xs-12 title_col align_repon">Tỉnh/TP</label>
							<div class="col-md-6 col-sm-8 col-xs-12">
								<select id="m_provin_id" name="city">            			
			            			<option value="">--Chọn Tỉnh/TP--</option>
			            			{%for item in provins%}
			            				<option value="{{item.m_provin_id}}">{{item.m_provin_name}}</option>
			            			{%endfor%}
			            		</select>
								<label class="lab_red lab_invisible" id="m_provin_id_error">Bạn cần chọn Tỉnh/TP</label>
							</div>
						</div>
						<div class="row margin-top10">
							<label class="col-md-3 col-sm-3 col-xs-12 title_col align_repon">Quận/Huyện</label>
							<div class="col-md-6 col-sm-8 col-xs-12">
								<select id="m_district_id" name="district">            			
			            			<option value="">--Chọn Quận/Huyện--</option>
			            		</select>
								<label class="lab_red lab_invisible" id="m_district_id_error">Bạn cần chọn Quận/Huyện</label>
							</div>
						</div>
						<div class="row margin-top10">
							<label class="col-md-3 col-sm-3 col-xs-12 title_col align_repon">Phường/Xã</label>
							<div class="col-md-6 col-sm-8 col-xs-12">
								<select id="m_ward_id" name="ward">            			
			            			<option value="">--Chọn Phường/Xã--</option>
			            		</select>
								<label class="lab_red lab_invisible" id="m_ward_id_error">Bạn cần chọn Phường/Xã</label>
							</div>
						</div>						
						<div class="row margin-top10">
							<label class="col-md-3 col-sm-3 col-xs-12 title_col align_repon">Địa chỉ :</label>
							<div class="col-md-6 col-sm-8 col-xs-12">
								<input type="text" name="address"  value="" >
							</div>
						</div>
						<div class="row margin-top10">
							<label class="col-md-3 col-sm-3 col-xs-12 title_col align_repon">Thành viên :</label>
							<div class="col-md-2 col-sm-2 col-xs-5">
								<label class="control control-radio">
							        Thường
							        <input type="radio" name="ctv_flg" checked="checked" value="0" class="m_type_id" />
							        <div class="control_indicator"></div>
							    </label>
							</div>
							<div class="col-md-4 col-sm-4 col-xs-7">							
								<label class="control control-radio">
							        Cộng tác viên (CTV)
							        <input type="radio" name="ctv_flg"  value="1" class="m_type_id"/>
							        <div class="control_indicator"></div>
							    </label>
							</div>
						</div>
						<div class="row margin-top10">
							<label class="col-md-3 col-sm-3 col-xs-12 title_col align_repon">Giới tính :</label>
							<div class="col-md-2 col-sm-2 col-xs-5">
								<label class="control control-radio">
							        Nam
							        <input type="radio" name="sex" checked="checked" value="1" class="m_type_id" />
							        <div class="control_indicator"></div>
							    </label>
							</div>
							<div class="col-md-2 col-sm-2 col-xs-7">							
								<label class="control control-radio">
							        Nữ
							        <input type="radio" name="sex"  value="2" class="m_type_id"/>
							        <div class="control_indicator"></div>
							    </label>
							</div>
						</div>
					</form>
					<div class="row margin-top10">
							<div class="col-md-12 col-sm-12 col-xs-12" style="text-align: center;">								
								<button class="btn_dangtin" id="btn_save" ><i class="fa fa-check-square-o"></i>Đăng ký</button>
							</div>
					</div>
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
		$(document).off('click','#btn_save'); 
        $(document).on('click','#btn_save',function(event){
        	var msg = check_validate_update();
          	if(!msg){
            	topFunction();
            	return;
          	}
          	var arr = $('#from_post').serializeArray();
	      	Pho_json_ajax('POST',"{{url.get('users/update')}}" ,arr,function(datas){
		        if(datas.status =="OK"){
		          //Pho_modal_close("modal1");
		          //Pho_message_box("Thông báo",'Đăng tin thành công !');
		          Pho_direct("{{url.get('users/success')}}" );
		        }else{
		        	if(datas.code=='email'){ // trung email
		        		$('#email_validate').text(datas.msg);
		        		$('#email_validate').show();
		        	}else if(datas.code =='userno'){ // trung ten dang nhap
		        		$('#user_no_validate').show();
		        	}else{
		        		Pho_message_box_error("Lỗi",datas.msg);
		        	}		        	
		        }	                
	        });
        });
        var check_validate_update = function(){
        	var flg = true;
        	$('#user_no_validate').hide();
        	$('input:required').each(function(key,item){
        		if($(this).val().trim().length == 0){
        			$('#'+ $(this).attr('id') + "_error").show();
        			flg = false;
        		}else{
        			$('#'+ $(this).attr('id') + "_error").hide();
        		}
        	});
        	       	
        	// if(!flg){
        	// 	$('#lab_message_error').show();
        	// }else{
        	// 	$('#lab_message_error').hide();
        	// }
        	if($('#email').val().trim() !=''){
        		if(!validateEmail($('#email').val())){
        			$('#email_validate').text('Bạn cần nhập đúng định dạng email !');
        			$('#email_validate').show();
        			flg = false;
        		}else{
        			$('#email_validate').hide();
        		}
        	}
        	if($('#pass').val().trim() !='' && $('#re_pass').val().trim() !=''){
        		if($('#pass').val().trim() != $('#re_pass').val().trim()){
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
	});
</script>