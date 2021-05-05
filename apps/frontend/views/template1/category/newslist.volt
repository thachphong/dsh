<div class="row pos_rl" >
	<div class="bg_frame_search">
	    <div class="container">  
	    	<div class="col-md-6 col-sm-6 col-xs-12">
		    	<span class="page_title">{{ctg_name}}</span>
		    	<div class="row brdcrumb">
		    	<a href="{{baseurl}}">Trang chủ</a>	
				{%for br in breadcrumbs%}
					<span>></span>
					<a href="{{baseurl}}c/{{br['ctg_no']}}">{{br['ctg_name']}}</a>
				{%endfor%}
				<span>> {{ctg_name}}</span>	
				</div>	    		
			</div>	
			<div class=" col-md-6 col-sm-6 col-xs-12 box_search">
				<form method="get" class="searchform" action="{{url.get('search')}}">				    
				    <input id="s-keyword" name="s" type="text" value="" class="input_search text_input" placeholder="Tìm sản phẩm và dịch vụ">
					<input type="submit" value="" style="font-family:FontAwesome" class="btn_search">
				</form>	
			</div>
	    </div>
    </div>
</div>
<div class="row">  
   <div class="container" id="content">  
   	  <div class="col-md-20 col-sm-25 col-xs-12 no_padding_left row-margin-bottom">
	  	 <div class="row panel_bg hide_mobile">
	  	 	<div class="pn-header-top">
				<div class="pn-title">
					<h3 class="ctg_title">Tất Cả Danh Mục </h3>
				</div>
			</div>
			<div class="row" >
				<ul class="verti_menu" style="display: block!important;z-index: 1">
					{%for mn in rel_menu%}
						<li><a href="{{baseurl}}c/{{mn['ctg_no']}}">{{mn['ctg_name']}}</a></li>
					{%endfor%}
				</ul>
			</div>
	  	 </div>
	  	 {%if disp_dm =='1'%}
	  	 <div class="row margin-top-10 hide_desk">
			<div class="pn-danhmuc">
				<div class="pn-title">
					<h2>Danh mục </h2>
				</div>				
			</div>
			<div class="row pro_list panel_bg">
					{%for item in rel_menu%}					
					<div class="col-sm-3 col-xs-6 ctg_item">
						<a href="{{baseurl}}c/{{item['ctg_no']}}">	
						<div class="div_img">
							<img src="{{baseurl}}{{item['img_path']}}"/>
						</div>
						<div>
							<span class="lst-it-title">{{item['ctg_name']}}</span>
						</div>											
						</a>
					</div>
					
					{%endfor%}
			</div>
		</div>
		{%endif%}
		<div class="row pn-header-top">
				<div class="pn-title">
					<h4 class="ctg_title">Sản phẩm bán chạy</h4>
				</div>
		</div>
		<div class="row pro_list">
			{{elements.getGoodsell()}}
		</div>
	  </div>	          
      <div class="col-md-80 col-sm-75 col-xs-12 margin_top no_padding">
         <div class="row margin_top" >            
            <div class="row news_list">
               {%for item in news%}
                  <!--<div class="row margin_top pn_background pn_border">
                     <div class="col-md-3 col-sm-3 col-xs-3 post_img">
                        <a href="{{url.get('t/')}}{{item['news_no']}}_{{item['news_id']}}">
                        <img src="{%if item['img_path']|length ==0%}{{url.get('crop/176x118/template1/images/post00.png')}}{%else%}{{url.get('crop/140x100/')}}{{item['img_path']}}{%endif%}" class="img_newlist"></a>
                     </div>
                     <div class="col-md-9 col-sm-9 col-xs-9">
                        <a href="{{url.get('t/')}}{{item['news_no']}}_{{item['news_id']}}" class="news_title">{{item['news_name']}}</a>
                        <div class="icon_post desc_news">{{item['des']}}</div>
                        
                     </div>
                  </div>-->
                  <div class="col-md-6 col-sm-6 col-xs-6 news">
				<!--<div class="news_con"-->
							<div class="img_thumb">
								<a href="{{url.get('t/')}}{{item['news_no']}}_{{item['news_id']}}">
								<img src="{%if item['img_path']|length ==0%}{{url.get('crop/176x118/template1/images/post00.png')}}{%else%}{{url.get('crop/424x272/')}}{{item['img_path']}}{%endif%}"/>
								</a>
								<div class="desc">
									<p>{{item['des']}}</p>
								</div>
							</div>	
							<a class="title" href="{{url.get('t/')}}{{item['news_no']}}_{{item['news_id']}}">
								<h4 >{{item['news_name']}}</h4>
							</a>				
							<hr/>
						<!--</div>-->
					</div>
               {%endfor%}
            </div>           
         </div> 
         {%if total_page > 1%}
         <div class="row margin_top" >
            <div class="col-md-12 col-sm-12 col-xs-12" style="display: flex;justify-content: center;">
               <ul class="page_number">
                  {%if page > 1%}
                     <li><a href="{{url.get('')}}{{ctg_no}}?page=1">Trang đầu</a></li>
                     <li><a href="{{url.get('')}}{{ctg_no}}?page={{(page-1)}}">Trang trước</a></li>
                  {%endif%}                 
                  
                  {%for i in  start..end%} 
                    <li {%if page == i%}class="active"{%endif%}><a href="{{url.get('')}}{{ctg_no}}?page={{i}}">{{i}}</a></li>
                  {%endfor%}
                  {%if page < total_page%}
                     <li><a href="{{url.get('')}}{{ctg_no}}?page={{page+1}}">Trang sau</a></li>
                     <li><a href="{{url.get('')}}{{ctg_no}}?page={{total_page}}">Trang cuối</a></li>
                  {%endif%}       
               </ul>
            </div>
         </div>
         {%endif%}
            
      </div>
     
   </div>
   
</div>