<div class="row topheader">
         <div class="container" id="header">
            <div class="row" >	
               {% set login_info= elements.getuser()%}
               <div class="col-md-12 col-sm-12 col-xs-12 no_padding_right">               	  
               	  <div class="row">
                  <ul class="top_menu">                  	 
                     <!--<li><span class="fa fa-pencil"></span><a href="{{url.get('dang-tin/0')}}">Đăng tin miễn phí</a></li>-->
                     {%if login_info is defined%}
                        <li><span class="fa fa-users"></span><a href="{{url.get('thanh-vien')}}">{{login_info.user_name}}</a></li>
                        <li><span class="fa fa-sign-out"></span><a href="{{url.get('users/logout')}}">Thoát</a></li>
                     {%else%}
                        <li><span class="fa fa-pencil-square-o"></span><a href="{{url.get('dang-ky')}}">Đăng ký</a></li>
                        <li><span class="fa fa-users"></span><a href="{{url.get('dang-nhap')}}">Đăng nhập</a></li>
                     {%endif%}                     
                  </ul>                  
                  </div>
               </div>        
            </div>             
         </div>
</div>  
<div class="row header_bg">
    <div class="container">
    	<div class="row" >
    		<div class="col-md-3 col-sm-3 col-xs-12"> 
    			<a href="{{baseurl}}">
    				<img src="{{url.get('template1/images/logo.png')}}" class="logo margin-top10"/>
    			</a>
    		</div>
    		<div class="col-md-6 col-sm-9 col-xs-12">
    			<div class="div_search">
    				<input placeholder="Nhập tên sản phẩm cân tìm"/>
    				<button class="fa fa-search" ></button>
    			</div>
    			
    		</div>
    		<div class="col-md-3 col-sm-3 col-xs-12">
    			<div class="shopping_cart" style="">
    				<a href="{{baseurl}}cart"><i class="fa fa-shopping-cart"></i>
    					<span class="cart_number" id="cart_number">{{elements.get_cart_number()}}</span>
    				</a>
    			</div>
    		</div>
    	</div>
    </div>
</div> 
<div class="row top-container-bg">
    <div class="container">  
    	<ul class="main_menu">
    		<li onclick="show_menu()"><label>Danh mục sản phẩm <i id="icon_dm" class="fa fa-sort-down"></i></label>
    			<ul class="dm-sp" id="dm-sp">			
					{{elements.getMenu()}}			
				</ul>
    		</li>
    		<li><a>Xu hướng</a></li>
    		<li><a>Bán chạy</a></li>
    		<li><a>Khuyến mãi</a></li>
    		<li><a>Quyền lợi CTV</a></li>
    		<li><a>Hướng đẫn đăng ký CTV</a></li>
    	</ul>
    </div>
</div>
<script>
		function show_menu(){					
			if($('#icon_dm').hasClass('fa-sort-down')){
				console.log(1);
				$('#icon_dm').removeClass('fa-sort-down');
				$('#icon_dm').addClass('fa-sort-up');
				$('#dm-sp').show();
			}else{
				console.log(2);
				$('#icon_dm').addClass('fa-sort-down');
				$('#icon_dm').removeClass('fa-sort-up');
				$('#dm-sp').hide();
			}
		}
	
</script>
   