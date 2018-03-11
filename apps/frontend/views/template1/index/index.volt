<div class="row content_bg" >
	<div class="container">
		<!--<ul class="dm-sp">			
			elements.getMenu()		
		</ul>-->
		<div id="myCarousel" class="carousel <!--slide-->" data-ride="carousel" data-interval="5000">
			{% set slides= elements.get_slide_top()%}		    
                  <ol class="carousel-indicators">
                  	 {%for key,item in slides%}
                     		<li data-target="#myCarousel" data-slide-to="{{key}}" {%if key==0%}class="active"{%endif%}></li> 
                     {%endfor%}				    
                  </ol>
                  <!-- Wrapper for slides --> 				    
                  <div class="carousel-inner">
                     {%for key,item in slides%}                     						      
	                     <div class="item {%if key==0%} active{%endif%}"> 
	                        <a href="{{item.link_page}}">					        
	                        <img src="{{url.get(item.img_path)}}" alt="" style="width:100%; "> 	
	                        </a>
	                     </div>
                     {%endfor%}					    
                  </div>
                  <!-- Left and right controls --> 				    <a class="left carousel-control" href="#myCarousel" data-slide="prev"> 				      <span class="glyphicon glyphicon-chevron-left"></span> 				      <span class="sr-only">Previous</span> 				    </a> 				    <a class="right carousel-control" href="#myCarousel" data-slide="next"> 				      <span class="glyphicon glyphicon-chevron-right"></span> 				      <span class="sr-only">Next</span> 				    </a> 				  
               </div>
	</div>
	<div class="container">
		<div class="row margin-top-10">
			<div class="pn-header-top">
				<div class="pn-title">
					<h2>Xu hướng</h2>
				</div>				
			</div>
			<div class="row pro_list">
					{%for item in newlist%}					
					<div class="col-md-20 col-sm-3 col-xs-6 pro_list_item">
						<a href="{{url.get('sp/')}}{{item['pro_no']}}_{{item['pro_id']}}">					
						<img src="{{url.get('')}}{{item['img_path']}}"/>
						<div>
							<span class="lst-it-title">{{item['pro_name']}}</span>
						</div>
						<div>
							<div>Giá bán lẻ: <strong class="font_size14 col_red">{{elements.currency_format(item['price_exp'])}} đ</strong></div>
							<div>Chiết khấu CTV: <strong class="font_size14 col_blue">{{elements.currency_format(item['price_exp']-item['price_seller'])}} đ</strong></div>
						</div>						
						</a>
					</div>
					{%endfor%}
			</div>
		</div>
		<div class="row margin-top-10">
			<div class="pn-header-top">
				<div class="pn-title">
					<h2>Bán chạy</h2>
				</div>
			</div>
			<div class="row pro_list">
					{%for item in goodsells%}					
					<div class="col-md-20 col-sm-3 col-xs-6 pro_list_item">
						<a href="{{url.get('sp/')}}{{item['pro_no']}}_{{item['pro_id']}}">					
						<img src="{{url.get('')}}{{item['img_path']}}"/>
						<div>
							<span class="lst-it-title">{{item['pro_name']}}</span>
						</div>
						<div>
							<div>Giá bán lẻ: <strong class="font_size14 col_red">{{elements.currency_format(item['price_exp'])}} đ</strong></div>
							<div>Chiết khấu CTV: <strong class="font_size14 col_blue">{{elements.currency_format(item['price_exp']-item['price_seller'])}} đ</strong></div>
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