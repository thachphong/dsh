<div class="row breadcrumb">
	<div class="container">
		<a href="{{baseurl}}">Trang chủ</a>	>
		<a href="{{baseurl}}thanh-vien"> Thành viên</a>		
		<span>> Thay đổi mật khẩu</span>			
	</div>
</div>
<div class="row">
	<div class="container">
		{{ partial('includes/user_left') }}
		<div class="col-md-9 col-sm-12 col-xs-12 margin-top20 no_padding_right">
			<div class="row panel_bg padding10">
			<div class="pn_title margin_top">					
				<h1 class="margin-top10">Thay đổi mật khẩu </h1>
			</div>
			<hr class="line" />
			<div class="row margin_top pn_background pn_border post_pn" >
            <div class="post_head">
               <div class="row pn_content">
				<form id="from_user">
					<div class="row row-margin-bottom">
						<label class="col-md-4 col-sm-4 col-xs-12 align_right title_col">Mật khẩu cũ</label>
						<div class="col-md-7 col-sm-7 col-xs-12">
							<input type="password" name="pass_old"  value="" id="pass_old" required>
							<label class="lab_red lab_invisible" id="pass_old_error">Bạn cần nhập mật khẩu cũ</label>
						</div>
					</div>
					<div class="row row-margin-bottom">
						<label class="col-md-4 col-sm-4 col-xs-12 align_right title_col">Mật khẩu mới</label>
						<div class="col-md-7 col-sm-7 col-xs-12">
							<input type="password" name="pass_new"  value="" id="pass_new" required>
							<label class="lab_red lab_invisible" id="pass_new_error">Bạn cần nhập mật khẩu mới</label>
						</div>
					</div>
					<div class="row row-margin-bottom">
						<label class="col-md-4 col-sm-4 col-xs-12 align_right title_col">Nhập lại mật khẩu mới</label>
						<div class="col-md-7 col-sm-7 col-xs-12">
							<input type="password" name="re_pass_new"  value="" id="re_pass_new" required>
							<label class="lab_red lab_invisible" id="re_pass_new_error">Bạn cần nhập lại mật khẩu mới</label>
							<label class="lab_red lab_invisible" id="pass_validate">Mật khẩu mới không khớp</label>
						</div>
					</div>
				</form>	
				<div class="col-md-12 col-sm-12 col-xs-12" style="text-align: center;">								
					<button class="btn_dangtin" id="btn_save" style="width: 150px"><i class="fa fa-save"></i>Lưu thay đổi</button>
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
