<div class="row breadcrumb">
	<div class="container">
		<a href="{{baseurl}}">Trang chủ</a>	>
		<a href="{{baseurl}}thanh-vien"> Thành viên</a>		
		<span>> Thay đổi thông tin cá nhân</span>			
	</div>
</div>
<div class="row">
	<div class="container">
		{{ partial('includes/user_left') }}
		<div class="col-md-9 col-sm-12 col-xs-12 margin-top20 no_padding_right">
		  <div class="row panel_bg padding10">
			<div class="pn_title margin_top">
				<h1 class="margin-top10">Thay đổi thông tin cá nhân </h1>
			</div>
			<hr class="line"/>
			<div class="row margin_top pn_background pn_border post_pn" >
            <div class="post_head">
               <div class="row pn_content">
               	<div class="row row-margin-bottom">
						<label class="col-md-3 col-sm-3 col-xs-12 title_col">Hình đại diện</label>
						<div class="col-md-7 col-sm-7 col-xs-12">
							<img src="{{url.get('images/users/')}}{{user.avata}}" style="width: 120px" id="img_avata"/>	
							<button class="btn_dangtin" id="btn_upload">Upload ảnh</button>
							<input type="file" style="display: none;" id="upload_file"/>						
						</div>
					</div>
				<form id="from_user">					
					<!--<div class="row row-margin-bottom">
						<label class="col-md-3 col-sm-3 col-xs-12 title_col">Tên đăng nhập</label>
						<div class="col-md-7 col-sm-7 col-xs-12">
							<input type="text" value="{{user.user_no}}" disabled="disabled">
						</div>
						<input type="hidden" name="avata" id="avata" value="">
						<input type="hidden" name="folder_tmp" id="folder_tmp" value="{{folder_tmp}}"/>						
					</div>-->
					<div class="row row-margin-bottom">
						<label class="col-md-3 col-sm-3 col-xs-12 title_col">Email</label>
						<div class="col-md-7 col-sm-7 col-xs-12">
							<input type="text" value="{{user.email}}" disabled="disabled">							
						</div>
						<input type="hidden" name="avata" id="avata" value="">
						<input type="hidden" name="folder_tmp" id="folder_tmp" value="{{folder_tmp}}"/>	
					</div>
					<div class="row row-margin-bottom">
						<label class="col-md-3 col-sm-3 col-xs-12 title_col">Họ và tên<span class="lab_red">(*)</span></label>
						<div class="col-md-7 col-sm-7 col-xs-12">
							<input type="text" name="user_name"  value="{{user.user_name}}" id="full_name" required>
							<label class="lab_red lab_invisible" id="full_name_error">Bạn cần nhập họ và tên</label>
						</div>
					</div>
					<div class="row row-margin-bottom">
						<label class="col-md-3 col-sm-3 col-xs-12 title_col">Điện thoại<span class="lab_red">(*)</span></label>
						<div class="col-md-7 col-sm-7 col-xs-12">
							<input type="text" name="mobile"  value="{{user.mobile}}" id="mobile" required>
							<label class="lab_red lab_invisible" id="mobile_error">Bạn cần nhập số điện thoại</label>
						</div>
					</div>
					<div class="row row-margin-bottom">
						<label class="col-md-3 col-sm-3 col-xs-12 title_col">Tỉnh/TP<span class="lab_red">(*)</span></label>
						<div class="col-md-7 col-sm-7 col-xs-12">
							<select id="m_provin_id" name="city" required>            			
		            			<option value="">--Chọn Tỉnh/TP--</option>
		            			{%for item in provins%}
		            				{%if user.city==item.m_provin_id%}
		            					<option value="{{item.m_provin_id}}" selected="selected">{{item.m_provin_name}}</option>
		            				{%else%}
		            					<option value="{{item.m_provin_id}}">{{item.m_provin_name}}</option>
		            				{%endif%}
		            			{%endfor%}
		            		</select>
							<label class="lab_red lab_invisible" id="m_provin_id_error">Bạn cần chọn Tỉnh/TP</label>
						</div>
					</div>
					<div class="row row-margin-bottom">
						<label class="col-md-3 col-sm-3 col-xs-12 title_col">Quận/Huyện<span class="lab_red">(*)</span></label>
						<div class="col-md-7 col-sm-7 col-xs-12">
							<select id="m_district_id" name="district" required>            			
		            			<option value="">--Chọn Quận/Huyện--</option>
		            			{%for item in districts%}
		            				{%if user.district==item['m_district_id']%}
		            					<option value="{{item['m_district_id']}}" selected="selected">{{item['m_district_name']}}</option>
		            				{%else%}
		            					<option value="{{item['m_district_id']}}">{{item['m_district_name']}}</option>
		            				{%endif%}
		            			{%endfor%}
		            		</select>
							<label class="lab_red lab_invisible" id="m_district_id_error">Bạn cần chọn Quận/Huyện</label>
						</div>
					</div>
					<div class="row row-margin-bottom">
						<label class="col-md-3 col-sm-3 col-xs-12 title_col">Phường/xã<span class="lab_red">(*)</span></label>
						<div class="col-md-7 col-sm-7 col-xs-12">
							<select id="m_ward_id" name="ward" required>            			
		            			<option value="">--Chọn Phường/xã--</option>
		            			{%for item in wards%}
		            				{%if user.ward==item['m_ward_id']%}
		            					<option value="{{item['m_ward_id']}}" selected="selected">{{item['m_ward_name']}}</option>
		            				{%else%}
		            					<option value="{{item['m_ward_id']}}">{{item['m_ward_name']}}</option>
		            				{%endif%}
		            			{%endfor%}
		            		</select>
							<label class="lab_red lab_invisible" id="m_ward_id_error">Bạn cần chọn Phường/xã</label>
						</div>
					</div>					
					<div class="row row-margin-bottom">
						<label class="col-md-3 col-sm-3 col-xs-12 title_col">Địa chỉ</label>
						<div class="col-md-7 col-sm-7 col-xs-12">
							<input type="text" name="address"  value="{{user.address}}" id="address" >							
						</div>
					</div>
					<div class="row row-margin-bottom">
							<label class="col-md-3 col-sm-3 col-xs-12 title_col">Thành viên :</label>
							<div class="col-md-2 col-sm-2 col-xs-12">
								<label class="control control-radio">
							        Thường
							        <input type="radio" name="ctv_flg" {%if user.ctv_flg ==0%}checked="checked"{%else%} disabled{%endif%} value="0" class="m_type_id" />
							        <div class="control_indicator"></div>
							    </label>
							</div>
							<div class="col-md-4 col-sm-4 col-xs-12">							
								<label class="control control-radio">
							        Cộng tác viên(CTV)
							        <input type="radio" name="ctv_flg"  value="1" class="m_type_id"{%if user.ctv_flg ==1%}checked="checked" disabled{%endif%} />
							        <div class="control_indicator"></div>
							    </label>
							</div>
					</div>
					<div class="row row-margin-bottom">
							<label class="col-md-3 col-sm-3 col-xs-12 title_col">Giới tính :</label>
							<div class="col-md-2 col-sm-2 col-xs-12">
								<label class="control control-radio">
							        Nam
							        <input type="radio" name="sex" {%if user.sex ==1%}checked="checked"{%endif%} value="1" class="m_type_id" />
							        <div class="control_indicator"></div>
							    </label>
							</div>
							<div class="col-md-2 col-sm-2 col-xs-12">							
								<label class="control control-radio">
							        Nữ
							        <input type="radio" name="sex"  value="2" class="m_type_id"{%if user.sex ==2%}checked="checked"{%endif%}/>
							        <div class="control_indicator"></div>
							    </label>
							</div>
					</div>
					<hr class="line" />
					<div class="row row-margin-bottom">
						<label class="col-md-3 col-sm-3 col-xs-12 title_col">Tên ngân hàng</label>
						<div class="col-md-7 col-sm-7 col-xs-12">
							<select id="bank_id" name="bank_id">            			
		            			<option value="">--Chọn Ngân hàng--</option>
		            			{%for item in banks%}
		            				{%if user.bank_id==item.bank_id%}
		            					<option value="{{item.bank_id}}" selected="selected">{{item.bank_name}}</option>
		            				{%else%}
		            					<option value="{{item.bank_id}}">{{item.bank_name}}</option>
		            				{%endif%}
		            			{%endfor%}
		            		</select>
						</div>
					</div>
					<div class="row row-margin-bottom">
						<label class="col-md-3 col-sm-3 col-xs-12 title_col">Số tài khoản</label>
						<div class="col-md-7 col-sm-7 col-xs-12">
							<input type="text" name="bank_acc_no"  value="{{user.bank_acc_no}}" >							
						</div>
					</div>
					<div class="row row-margin-bottom">
						<label class="col-md-3 col-sm-3 col-xs-12 title_col">Họ và tên chủ tài khoản</label>
						<div class="col-md-7 col-sm-7 col-xs-12">
							<input type="text" name="bank_acc_name"  value="{{user.bank_acc_name}}" >							
						</div>
					</div>
				</form>	
				<div class="col-md-12 col-sm-12 col-xs-12" style="text-align: center;">								
					<button class="btn_dangtin" id="btn_save" style="width: 150px"><i class="fa fa-save"></i>Lưu thay đổi</button>
				</div>		
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
          	var arr = $('#from_user').serializeArray();
	      	Pho_json_ajax('POST',"{{url.get('users/updateinfo')}}" ,arr,function(datas){
		        if(datas.status =="OK"){
		          //Pho_modal_close("modal1");
		          Pho_message_box("Thông báo",'Lưu thành công !');
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
        	
        	return flg;
        }	
                	
		$(document).off('click','#btn_upload'); 
        $(document).on('click','#btn_upload',function(event){
        	$('#upload_file').click();
        });
		$(document).off('change','#upload_file'); 
        $(document).on('change','#upload_file',function(event){
        	
        	var file_data=$(this).prop("files");
        	//console.log(file_data);	
        	if(file_data.length == 0){
        		return;
        	}
        	var form_data=new FormData(this);
        	for(var i=0;i<file_data.length;i++){
        		form_data.append(i,file_data[i]);
        	}        	
            form_data.append("folder_tmp",$('#folder_tmp').val());
            var base_url= "{{url.get('')}}";
            //console.log(form_data);	
        	Pho_upload("{{url.get('posts/upload')}}" ,form_data,function(datas){
				if(datas.status =="OK"){
					//console.log(datas);					
                    var cnt_add = $('.add_img').length;  
                    var src = datas.link[0];
                    $('#img_avata').attr('src',src);	
                    $('#avata').val(src.replace(base_url,''));
				}else{
					Pho_message_box_error("Lỗi",datas.msg);
				}
                
            });
        });
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
