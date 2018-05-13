<div class="row content_bg" >
	<!--<div class="container">		
		<div id="myCarousel" class="carousel " data-ride="carousel" data-interval="5000">
			{* set slides= elements.get_slide_top()*}		    
                  <ol class="carousel-indicators">
                  	 {%for key,item in slides%}
                     		<li data-target="#myCarousel" data-slide-to="{{key}}" {%if key==0%}class="active"{%endif%}></li> 
                     {%endfor%}				    
                  </ol>
                  			    
                  <div class="carousel-inner">
                     {%for key,item in slides%}                     						      
	                     <div class="item {%if key==0%} active{%endif%}"> 
	                        <a href="{{item.link_page}}">					        
	                        <img src="{{url.get(item.img_path)}}" alt="" style="width:100%; "> 	
	                        </a>
	                     </div>
                     {%endfor%}					    
                  </div>
                  <a class="left carousel-control" href="#myCarousel" data-slide="prev"> 				      <span class="glyphicon glyphicon-chevron-left"></span> 				      <span class="sr-only">Previous</span> 				    </a> 				    <a class="right carousel-control" href="#myCarousel" data-slide="next"> 				      <span class="glyphicon glyphicon-chevron-right"></span> 				      <span class="sr-only">Next</span> 				    </a> 				  
               </div>
	</div>-->
	<div class="container">
		<div class="row panel_bg margin-top-10" id="banner_1">
			<div class="col-md-9">
				<img src="{{url.get('template1/images/quy_trinh2.png')}}"/>
			</div>
			<div class="col-md-3" style="border-left: 1px solid #ddd;">
				<h4>5 Lợi ích làm cộng tác viên</h4>
				<ul class="loi_ich">
					<li>Không cần vốn</li>
					<li>Không trữ hàng</li>
					<li>Không cần giao hàng</li>
					<li>Không mất khách hàng</li>
					<li>Dễ dàng tăng thu nhập</li>
				</ul>
			</div>
		</div>
		<div class="row margin-top-10">
			<div class="pn-danhmuc">
				<div class="pn-title">
					<h2>Danh mục </h2>
				</div>				
			</div>
			<div class="row pro_list panel_bg">
					{%for item in categorys%}					
					<div class="col-sm-3 ctg_item">
						<a href="{{url.get('c/')}}{{item['ctg_no']}}">	
						<div class="div_img">
							<img src="{{url.get('')}}{{item['img_path']}}"/>
						</div>
						<div>
							<span class="lst-it-title">{{item['ctg_name']}}</span>
						</div>											
						</a>
					</div>
					{%endfor%}
			</div>
		</div>
		<div class="row margin-top-10">
			<div class="pn-header-top">
				<div class="pn-title">
					<h2>Sản phẩm mới <a class="link_color" style="float:right" href="{{baseurl}}c/san-pham-moi">Xem thêm >></a></h2>
				</div>				
			</div>
			<div class="row pro_list">
					{%for item in newlist%}					
					<div class="col-md-20 col-sm-3 col-xs-6 pro_list_item">
						<a href="{{url.get('sp/')}}{{item['pro_no']}}_{{item['pro_id']}}">	
						<div class="div_img">
							<img src="{{url.get('crop/210x210')}}{{item['img_path']}}"/>
						</div>						
						<div class="div_desc">
							<span class="lst-it-title">{{item['pro_name']}}</span>
							<div>Giá bán lẻ: <strong class="font_size14 col_red">{{elements.currency_format(item['price_exp'])}} đ</strong></div>
							<div>Chiết khấu: <strong class="font_size14 col_blue">{{elements.currency_format(item['price_exp']-item['price_seller'])}} đ</strong></div>
						</div>						
						</a>
					</div>
					{%endfor%}
			</div>
		</div>
		<div class="row margin-top-10">
			<div class="pn-header-top">
				<div class="pn-title">
					<h2>Bán chạy <a class="link_color" style="float:right" href="{{baseurl}}c/ban-chay">Xem thêm >></a></h2>
				</div>
			</div>
			<div class="row pro_list">
					{%for item in goodsells%}					
					<div class="col-md-20 col-sm-3 col-xs-6 pro_list_item">
						<a href="{{url.get('sp/')}}{{item['pro_no']}}_{{item['pro_id']}}">	
						<div class="div_img">				
							<img src="{{url.get('crop/210x210')}}{{item['img_path']}}"/>
						</div>						
						<div class="div_desc">
							<span class="lst-it-title">{{item['pro_name']}}</span>
							<div>Giá bán lẻ: <strong class="font_size14 col_red">{{elements.currency_format(item['price_exp'])}} đ</strong></div>
							<div>Chiết khấu: <strong class="font_size14 col_blue">{{elements.currency_format(item['price_exp']-item['price_seller'])}} đ</strong></div>
						</div>						
						</a>
					</div>
					{%endfor%}
			</div>
		</div>
		<div class="row margin-top-10">
			<div class="pn-header-top">
				<div class="pn-title">
					<h2>Top chiết khấu <a class="link_color" style="float:right" href="{{baseurl}}c/top-chiet-khau">Xem thêm >></a></h2>
					
				</div>
			</div>
			<div class="row pro_list">
					{%for item in discounts%}					
					<div class="col-md-20 col-sm-3 col-xs-6 pro_list_item">
						<a href="{{url.get('sp/')}}{{item['pro_no']}}_{{item['pro_id']}}">	
						<div class="div_img">				
							<img src="{{url.get('crop/210x210')}}{{item['img_path']}}"/>
						</div>						
						<div class="div_desc">
							<span class="lst-it-title">{{item['pro_name']}}</span>
							<div>Giá bán lẻ: <strong class="font_size14 col_red">{{elements.currency_format(item['price_exp'])}} đ</strong></div>
							<div>Chiết khấu: <strong class="font_size14 col_blue">{{elements.currency_format(item['price_exp']-item['price_seller'])}} đ</strong></div>
						</div>						
						</a>
					</div>
					{%endfor%}
			</div>
		</div>
	</div>	
</div>
<script>
	show_menu();
</script>