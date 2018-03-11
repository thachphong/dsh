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
					<div class="row row-margin-bottom">
						<label class="col-md-3 col-sm-3 col-xs-12 title_col">Tên đăng nhập</label>
						<div class="col-md-7 col-sm-7 col-xs-12">
							<input type="text" value="{{user.user_no}}" disabled="disabled">
						</div>
						<input type="hidden" name="avata" id="avata" value="">
						<input type="hidden" name="folder_tmp" id="folder_tmp" value="{{folder_tmp}}"/>						
					</div>
					<div class="row row-margin-bottom">
						<label class="col-md-3 col-sm-3 col-xs-12 title_col">Email</label>
						<div class="col-md-7 col-sm-7 col-xs-12">
							<input type="text" value="{{user.email}}" disabled="disabled">							
						</div>
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
					<!--<div class="row row-margin-bottom">
						<label class="col-md-4 col-sm-4 col-xs-12 title_col">Thành phố</label>
						<div class="col-md-7 col-sm-7 col-xs-12">
							<input type="text" name="re_pass_new"  value="" id="re_pass_new" required>
							<label class="lab_red lab_invisible" id="re_pass_new_error">Bạn cần nhập lại mật khẩu mới</label>
							<label class="lab_red lab_invisible" id="pass_validate">Mật khẩu mới không khớp</label>
						</div>
					</div>-->
					<div class="row row-margin-bottom">
						<label class="col-md-3 col-sm-3 col-xs-12 title_col">Địa chỉ</label>
						<div class="col-md-7 col-sm-7 col-xs-12">
							<input type="text" name="address"  value="{{user.address}}" id="address" >							
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
						<label class="col-md-3 col-sm-3 col-xs-12 title_col">Facebook</label>
						<div class="col-md-7 col-sm-7 col-xs-12">
							<input type="text" name="facebook"  value="{{user.facebook}}" >
						</div>
					</div>
					<div class="row row-margin-bottom">
						<label class="col-md-3 col-sm-3 col-xs-12 title_col">Skype</label>
						<div class="col-md-7 col-sm-7 col-xs-12">
							<input type="text" name="skype"  value="{{user.skype}}" >							
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
	});
</script>
