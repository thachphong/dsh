<div class="row col-xs-hide">
	<div id="container" class="">
	  <ul id="slides">
	  	{% set slidetop= elements.get_slide_top()%}
		{%for key,item in slidetop%}
	         	<!--<li class="item {%if key==0%}active{%endif%}"><a href="{{item.link_page}}"><img src="{{url.get('crop/728x90/')}}{{item.img_path}}"></a></li>-->
	         	<li class="slide">
			      <div class="slide-partial slide-left"><img src="{{url.get('split/0/')}}{{item.img_path}}"/></div>
			      <div class="slide-partial slide-right"><img src="{{url.get('split/1/')}}{{item.img_path}}"/></div>
			      <h1 class="title" ><span class="title-text" style="background: #cccccc7a;">{{item.description}}</span></h1>
			    </li>
		{%endfor%}	    
	  </ul>
	  <ul id="slide-select">
	    <li class="btn prev"><</li>
	    {%for key,item in slidetop%}
	    	<li class="selector"></li>
	    {%endfor%}	
	    <li class="btn next">></li>
	  </ul>
	</div>
</div>
<div class="row pd_b30 bg_main2" >
	<div class="container">
		<div class="row">
			<div class="welcome"><h3>Chào mừng bạn đến với Linh Anh Spa</h3></div>
			<div class="box_center">
				<div class="ico-border"> <i class="ico-bg flower"></i> </div>
			</div>	
			<div class="box_center">
				<span class="slogan pd10">Trải nghiệm nghệ thuật chăm sóc</span>
			</div>			
		</div>		
		<div class="row mg_t30">
			<div class="col-md-3 col-sm-3 col-xs-6 pd_b30">
				<div class="box_center">
					<div class="hover15 column">
					  <div>
					  <a  href="{{url.get('c/cham-soc-da')}}">
					    <figure><img src="{{url.get('template1/images/ico-pic1.jpg')}}"/>
					    <span class="service"><h4 class="al_c">Spa</h4></span>
					    </figure>
					    </a>					    
					  </div>
					</div>
				</div>
				
			</div>
			<div class="col-md-3 col-sm-3 col-xs-6 pd_b35">
				<div class="box_center">
					<div class="hover15 column">
					  <div>
					  	 <a  href="{{url.get('c/nail')}}">
					    <figure><img src="{{url.get('template1/images/ico-pic2.jpg')}}"/>
					    <span class="service"><h4 class="al_c">Hair & Nail</h4></span>
					    </figure>					
					    </a>    
					  </div>
					</div>
				</div>
				
			</div>
			<div class="col-md-3 col-sm-3 col-xs-6 pd_b35">
				<div class="box_center">
					<div class="hover15 column">
					  <div>
					  	<a  href="{{url.get('c/phun-xam')}}">
						    <figure><img src="{{url.get('template1/images/ico-pic4.png')}}"/>
						    	<span class="service"><h4 class="al_c">Phun xăm</h4></span>
						    </figure>
					    </a>
					  </div>
					</div>
				</div>
				
			</div>
			<div class="col-md-3 col-sm-3 col-xs-6 pd_b35">
				<div class="box_center">
					<div class="hover15 column">
					  <div>
					  	<a  href="{{url.get('c/san-pham')}}">
						    <figure><img src="{{url.get('template1/images/ico-pic3.jpg')}}"/>
						    <span class="service"><h4 class="al_c">Mỹ phẩm</h4></span>
						    </figure>
					    </a>
					  </div>
					</div>
				</div>
				
			</div>
		</div>
	</div>
</div>
<div class="row pd_tb20 pd_b30 bg_main" >
	<div class="container">
		<div class="row colo_main2 mg_b20">
			<div class="welcome"><h3>Mỹ phẩm & Voucher</h3></div>
			<div class="box_center">
				<div class="ico-border"> <i class="ico-bg flower"></i> </div>
			</div>	
			<div class="box_center">
				<span class="slogan pd10">Ưu đãi, tiết kiệm</span>
			</div>			
		</div>	
		<div class="row">
		
			<!--<div class="col-md-3 prod1">				
				<div class="pro_bg">
					<div class="pro_con">
						<span class="price">
							<del>500.000VNĐ</del>
							<ins>450.000VNĐ</ins>
						</span>
						<div class="img-thumb">
							<a href="#"><img src="{{url.get('images/products/1/gift1.jpg')}}"/>
							<span class="img-overlay"></span>
							</a>
						</div>
						<div class="pro-detail">
							<h4>Tile product</h4>
							<a class="btn_sel" href="#">Mua ngay</a>
						</div>
					</div>				
				</div>
			</div>
			<div class="col-md-3 prod1">
				<div class="pro_bg">
					<div class="pro_con">
						<span class="price">
							<del>500.000VNĐ</del>
							<ins>450.000VNĐ</ins>
						</span>
						<div class="img-thumb">
							<a href="#"><img src="{{url.get('images/products/1/gift1.jpg')}}"/>
							<span class="img-overlay"></span>
							</a>
						</div>
						<div class="pro-detail">
							<h4>Tile product</h4>
							<a class="btn_sel" href="#">Mua ngay</a>
						</div>
					</div>
				</div>	
			</div>
			<div class="col-md-3 prod1">
				<div class="pro_bg">
					<div class="pro_con">
						<span class="price">
							<del>500.000VNĐ</del>
							<ins>450.000VNĐ</ins>
						</span>
						<div class="img-thumb">
							<a href="#"><img src="{{url.get('images/products/1/gift1.jpg')}}"/>
							<span class="img-overlay"></span>
							</a>
						</div>
						<div class="pro-detail">
							<h4>Tile product</h4>
							<a class="btn_sel" href="#">Mua ngay</a>
						</div>
					</div>
				</div>
			</div>-->
			{%for item in disphome%}
			<div class="col-md-3 prod1">
				<div class="pro_bg">
					<div class="pro_con">
						<span class="price">
							<del>{{elements.currency_format(item['price_seller'])}}VNĐ</del>
							<ins class="col_blue">{{elements.currency_format(item['price_exp'])}}VNĐ</ins>
						</span>
						<div class="img-thumb">
							<a href="{{url.get('sp/')}}{{item['pro_no']}}_{{item['pro_id']}}">
								<img src="{{url.get()}}{{item['img_path']}}"/>
							<span class="img-overlay"></span>
							</a>
						</div>
						<div class="pro-detail">
							<h4>{{item['pro_name']}}</h4>
							<a class="btn_sel" href="{{url.get('sp/')}}{{item['pro_no']}}_{{item['pro_id']}}">Mua ngay</a>
						</div>
					</div>
				</div>
			</div>
			{%endfor%}
		</div>
	</div>
</div>
<div class="row pd_b30 bg_main2" >
	<div class="container">
		<div class="row">
			<div class="welcome"><h3>Combo</h3></div>
			<div class="box_center">
				<div class="ico-border"> <i class="ico-bg flower"></i> </div>
			</div>	
			<div class="box_center">
				<span class="slogan pd10">Làm đẹp không lo về giá</span>
			</div>			
		</div>	
		<div class="row">
			{%for item in combo%}
			<div class="col-md-4 col-sm-4 col-xs-12 combo">
				<div class="combo_con">
					<div class="img_thum">
						<a href="{{url.get('sp/')}}{{item['pro_no']}}_{{item['pro_id']}}"><img src="{{url.get()}}{{item['img_path']}}"/></a>
						<div class="title"><h5>{{item['pro_name']}}</h5></div>
					</div>
					
					<div class="detail"> 
						<div class="price_circl">
							<div class="ico-border"> <i class="ico-bg flower"></i> </div>
							<label>{{elements.currency_format(item['price_exp'])}}đ</label>
							<hr/>
						</div>
						<ul>
							{%for cbo in item['combo_name']%}
								<li>{{cbo}}</li>							
							{%endfor%}
						</ul>
						<a class="btn_mua" href="{{url.get('sp/')}}{{item['pro_no']}}_{{item['pro_id']}}">Mua ngay</a>
					</div>					
				</div>
			</div>
			{%endfor%}			
		</div>
	</div>
</div>
<div class="row pd_tb20 pd_b30 bg_main" >
	<div class="container">
		<div class="row colo_main2 mg_b20">
			<div class="welcome"><h3>Kinh nghiệm làm đẹp</h3></div>
			<div class="box_center">
				<div class="ico-border"> <i class="ico-bg flower"></i> </div>
			</div>	
			<div class="box_center">
				<span class="slogan pd10">Sẽ chia kinh nghiệm</span>
			</div>			
		</div>
		<div class="row">
			{%for item in lamdep%}
				<div class="col-md-4 col-sm-4 col-xs-12 news">
				<!--<div class="news_con"-->
					<div class="img_thumb">
						<a href="{{url.get('t/')}}{{item['news_no']}}_{{item['news_id']}}">
						<img src="{%if item['img_path']|length ==0%}{{url.get('crop/176x118/template1/images/post00.png')}}{%else%}{{url.get('crop/424x272/')}}{{item['img_path']}}{%endif%}"/>
						</a>
						<div class="desc">
							<p> {{item['des']}}</p>
						</div>
					</div>	
					<a class="title" href="{{url.get('t/')}}{{item['news_no']}}_{{item['news_id']}}">
						<h4 >{{item['news_name']}}</h4>
					</a>				
					<hr/>
				<!--</div>-->
				</div>
			{%endfor%}
			
			<!--<div class="col-md-4 col-sm-4 col-xs-6 news">				
					<div class="img_thumb">
						<a href="#">
						<img src="{{url.get('images/news/1/dt-gallery11.jpg')}}"/>
						</a>
						<div class="desc">
							<p> Nội dung trích dẫn <br>được viết ở đây</p>
						</div>
					</div>	
					<a class="title" href="#">
						<h4 >Câu chuyện thành công</h4>
					</a>				
					<hr/>				
			</div>
			<div class="col-md-4 col-sm-4 col-xs-6 news">				
					<div class="img_thumb">
						<a href="#">
						<img src="{{url.get('images/news/1/dt-gallery11.jpg')}}"/>
						</a>
						<div class="desc">
							<p> Nội dung trích dẫn <br>được viết ở đây</p>
						</div>
					</div>	
					<a class="title" href="#">
						<h4 >Câu chuyện thành công</h4>
					</a>				
					<hr/>				
			</div>-->
		</div>
			
	</div>
</div>