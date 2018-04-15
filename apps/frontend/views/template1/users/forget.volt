<div class="row breadcrumb">
	<div class="container">
		<a href="{{baseurl}}">Trang chủ</a>		
		<span>> Đăng nhập</span>			
	</div>
</div>
<div class="row content_bg margin-top10">
	<div class="container register_form panel_bg">		
		<div class="col-md-12 col-sm-12 col-xs-12 padding-mobi">
			<div class="pn_posts">
				<div class="pn_title">					
					<h1>Quên mật khẩu </h1>
				</div>
				<hr class="line" />					
				<div class="pn_content pn_background pn_border_2 login_form">					
					<form enctype="multipart/form-data" id="from_post">
						<div class="row row-margin-bottom" style="text-align: center;">
							<label class="col-md-12 col-sm-12 col-xs-12 title_col lab_red" id="msg_err"></label>
							
						</div>
						<div class="row row-margin-bottom">
							<label class="col-md-4 col-sm-4 col-xs-12 title_col align_renpon">Email đã đăng ký</label>
							<div class="col-md-7 col-sm-7 col-xs-12">
								<input type="text" name="email"  value="" id="user_no" required>							
							</div>							
						</div>	
						<div class="row row-margin-bottom">
							<span id="send_msg" style="display: none">Đã gửi 1 email đến địa chỉ mail của bạn, vui lòng check mail để đặt lại mật khẩu.</span>
						</div>			
					</form>
					<div class="row row-margin-bottom" style="margin-top:20px">
							<div class="col-md-12 col-sm-12 col-xs-12" style="text-align: center;">								
								<button class="btn_dangtin" id="btn_login" style="width:120px" ><i class="fa fa-sign-in"></i>Gửi mail</button>
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
		$(document).off('click','#btn_login'); 
        $(document).on('click','#btn_login',function(event){        	
          	var arr = $('#from_post').serializeArray();
	      	Pho_json_ajax('POST',"{{url.get('users/sendpass')}}" ,arr,function(datas){
		        if(datas.status =="OK"){
		          //Pho_modal_close("modal1");
		          //Pho_message_box("Thông báo",'Đăng tin thành công !');
		          //Pho_direct("{{url.get('thanh-vien')}}" );
		           $('send_msg').show();
		        }else{
		        	//Pho_message_box_error("Lỗi",datas.msg);
		        	$('#msg_err').text(datas.msg);
		        	$('#msg_err').show();
		        }	                
	        });
        }); 
        $(document).off('keydown','#password'); 
        $(document).on('keydown','#password',function(event){   
        	if ( event.which == 13 ) {
			   event.preventDefault();
			   $('#btn_login').click();
			}  
        });      	
	});
</script>