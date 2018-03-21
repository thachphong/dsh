<div class="row breadcrumb">
	<div class="container">
		<a href="{{baseurl}}">Trang chủ</a>		
		<span>> Đăng nhập</span>			
	</div>
</div>
<div class="row content_bg">
	<div class="container register_form panel_bg margin-top10">		
		<div class="col-md-12 col-sm-12 col-xs-12 margin_top">
			<div class="pn_posts">
				<div class="pn_title">
					<!--<span class="bg_icon"><i class="fa post-pencil"></i></span>-->
					<h1>Đăng nhập </h1>
				</div>	
				<hr class="line" />			
				<div class="margin_top login_form">
					<!-- <div style="text-align:center">
						<h3>Tin của bạn đã được hiển thị trên website</h3>
					</div>
					<div class="row">
						
					</div> -->
					<form enctype="multipart/form-data" id="from_post">
						<div class="row row-margin-bottom" style="text-align: center;">
							<span class="col-md-12 col-sm-12 col-xs-12 title_col col_red" id="msg_err"></span>
							
						</div>
						<div class="row margin-top10">
							<label class="col-md-4 col-sm-4 col-xs-12 title_col align_right">Email</label>
							<div class="col-md-5 col-sm-7 col-xs-12">
								<input type="text" name="email"  value="" id="user_no" placeholder="Vui lòng nhập email" required>							
							</div>
						</div>
						<div class="row margin-top10">
							<label class="col-md-4 col-sm-4 col-xs-12 title_col align_right">Mật khẩu</label>
							<div class="col-md-5 col-sm-7 col-xs-12">
								<input type="password" name="password"  value="" id="password" placeholder="Vui lòng nhập mật khẩu" required>								
							</div>
						</div>
						<div class="row margin-top10">
							<label class="col-md-4 col-sm-4 col-xs-12 title_col"></label>
							<div class="col-md-5 col-sm-7 col-xs-12 align_right">								
								<a class="link_color" href="{{url.get('quen-mat-khau')}}">Quên mật khẩu ?</a>
							</div>
						</div>						
					</form>
					<div class="row" >
							<div class="col-md-12 col-sm-12 col-xs-12" style="text-align: center;">								
								<button class="btn_dangtin" id="btn_login" style="width:120px" ><i class="fa fa-sign-in"></i>Đăng nhập</button>
							</div>
					</div>
					<div class="row margin-top10" style="text-align: center;">
							<label class="col-md-12 col-sm-12 col-xs-12 title_col">Nếu bạn chưa có tài khoản của {{constant("SITE_NAME")}}, vui lòng <a class="link_color" href="{{url.get('dang-ky')}}"><strong>đăng ký tại đây</strong></a></label>
							
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
	      	Pho_json_ajax('POST',"{{url.get('users/auth')}}" ,arr,function(datas){
		        if(datas.status =="OK"){
		          //Pho_modal_close("modal1");
		          //Pho_message_box("Thông báo",'Đăng tin thành công !');
		          //Pho_direct("{{url.get('thanh-vien')}}" );
		            if(datas.url_refer != null){
		            	Pho_direct(datas.url_refer);
		            }else{
		            	Pho_direct("{{baseurl}}" );
		            }
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