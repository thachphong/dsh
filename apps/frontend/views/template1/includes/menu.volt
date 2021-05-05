<div class="row topheader">
         <div class="container" id="header">
            <div class="row" >	
               {% set login_info= elements.getuser()%}
               <div class="col-md-3 col-sm-3 col-xs-hide no_padding_right pd_t5">
               		<span class="slogan">Sắc Đẹp Là Sức Mạnh Của Phái Nữ </span>
               </div>
               <div class="col-md-9 col-sm-9 col-xs-12 no_padding_right">               	  
               	  <div class="row" style="text-align:right">
                  <ul class="top_menu">  
                     <li><span class="fa fs18 fa-phone-square"></span>
                     	<span class="fs14"> {{define['comp_phone']}}</span>
                     </li>
                     
                     {%if login_info is defined%}
                        <li><span class="fa fs18 fa-users"></span><a href="{{url.get('thanh-vien')}}">{{login_info.user_name}}</a></li>
                        <li><span class="fa fs18 fa-sign-out"></span><a href="{{url.get('users/logout')}}">Thoát</a></li>
                     {%else%}
                        <li><span class="fa fs18 fa-pencil-square-o"></span><a href="{{url.get('dang-ky')}}">Đăng ký</a></li>
                        <li><span class="fa fs18 fa-users"></span><a href="{{url.get('dang-nhap')}}">Đăng nhập</a></li>
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
    		<div class="col-md-3 col-sm-3 col-xs-hide"> 
    			<a href="{{baseurl}}">
    				<img src="{{url.get('template1/images/logo.png')}}" class="logo margin-top10"/>
    				<span class="logo_name">Linh Anh</span>
    			</a>
    		</div>    		
    		<div class="col-md-6 col-sm-8 col-xs-9 box_search"> 
    			<form method="get" class="searchform" action="{{url.get('search')}}">				    
				    <input id="s-keyword" name="s" type="text" value="" class="input_search text_input" placeholder="Tìm sản phẩm và dịch vụ">
					<input type="submit" value="" style="font-family:FontAwesome" class="btn_search">
				</form>   			
    			 			
    		</div>
    		<div class="col-md-3 col-sm-1 col-xs-3 col-xs-npd">   
    			<div class="shopping_cart">
    				<a href="" class="pos_rl">
    				<span class="cart_num"></span>
    				<span class="cart_number">{{elements.get_cart_number()}}</span>
    				</a>
    			</div>
    		</div>
    	</div>
    </div>
</div> 
<div class="row menu_bg" >	
	<div class="container">  
	    <ul class="main_menu">    		
    		{{ elements.getMenu() }}
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
   