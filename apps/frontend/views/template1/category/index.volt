<div class="row brc_bg" >
	<div class="">
	    <div class="container ">  
	    	<div class="col-md-12 col-sm-12 col-xs-12">
		    	<!--<span class="page_title">{{ctg_name}}</span>-->
		    	<div class="row brdcrumb">
		    	<a href="{{baseurl}}">Trang chủ</a>	
				{%for br in breadcrumbs%}
					<span>></span>
					<a href="{{baseurl}}c/{{br['ctg_no']}}">{{br['ctg_name']}}</a>
				{%endfor%}
				<span>> {{ctg_name}}</span>	
				</div>	    		
			</div>				
	    </div>
    </div>
</div>
<!--<div class="row breadcrumb">
	<div class="container">
		<a href="{{baseurl}}">Trang chủ</a>	
		{%for br in breadcrumbs%}
			<span>></span>
			<a href="{{baseurl}}c/{{br['ctg_no']}}">{{br['ctg_name']}}</a>
		{%endfor%}
		<span>> {{ctg_name}}</span>			
	</div>
</div>-->
<div class="row" >
	<div class="container margin-top10" id="content"> 
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
	  </div>	           
      <div class="col-md-80 col-sm-75 col-xs-12 margin_top no_padding">
         <!--<div class="row" >
            <div class="pn_title border_bottom padding-left10 panel_bg">               
               <h1>{{ctg_name}}</h1>
               <label class="read_more" style="font-weight:normal">có <strong>{{total_post}}</strong> sản phẩm</label>
            </div>
        </div>-->
        <div class="row pro_list">
        	<div class="pn-header-dm">				
				<h3 class="title-dm">{{ctg_name}}</h3>				
			</div>
			<div class="row">
					{%for item in list%}					
					<div class="col-md-3 col-sm-3 col-xs-12 pro_list_item">
						<a href="{{url.get('sp/')}}{{item['pro_no']}}_{{item['pro_id']}}">	
						<div class="div_img">			
							{%for key,img in item['img_path']%}
								{%if key < 2%}
								<img src="{{url.get('')}}{{img}}" class="{%if key >0%}img_sec{%else%}img_first{%endif%}" title="{{item['pro_name']}}" alt="{{item['pro_name']}}"/>
								{%endif%}
							{%endfor%}
						</div>						
						<div class="row div_desc">
							<span class="lst-it-title">{{item['pro_name']}}</span>
							<div><del class="font_size14">{{elements.currency_format(item['price_seller'])}} đ</del>
						    <strong class="font_size14 col_blue">{{elements.currency_format(item['price_exp'])}} đ</strong></div>							
						</div>	
								
						</a>
						<div class="row">
							<a class="icon-cart"></a>
						</div>	
					</div>
					
					{%endfor%}
				</div>
		</div>           
                 
         {%if total_page > 1%}
         <div class="row margin-top-10" >
            <div class="col-md-12 col-sm-12 col-xs-12" style="display: flex;justify-content: center;">
               <ul class="page_number">
                  {%if page > 1%}
                     <li class="hide_mobile"><a href="{{url.get('')}}{{ctg_no}}?page=1">Trang đầu</a></li>
                     <li class="hide_mobile"><a href="{{url.get('')}}{{ctg_no}}?page={{(page-1)}}">Trang trước</a></li>
                     <li class="hide_desk"><a href="{{url.get('')}}{{ctg_no}}?page=1"><<</a></li>
                     <li class="hide_desk"><a href="{{url.get('')}}{{ctg_no}}?page={{(page-1)}}"><</a></li>
                     
                  {%endif%}                 
                  {%for i in  start..end%} 
                    <li {%if page == i%}class="active"{%endif%}><a href="{{url.get('')}}{{ctg_no}}?page={{i}}">{{i}}</a></li>
                  {%endfor%}
                  {%if page < total_page%}
                     <li class="hide_mobile"><a href="{{url.get('')}}{{ctg_no}}?page={{page+1}}">Trang sau</a></li>
                     <li class="hide_mobile"><a href="{{url.get('')}}{{ctg_no}}?page={{total_page}}">Trang cuối</a></li>
                     <li class="hide_desk"><a href="{{url.get('')}}{{ctg_no}}?page={{page+1}}">></a></li>
                     <li class="hide_desk"><a href="{{url.get('')}}{{ctg_no}}?page={{total_page}}">>></a></li>
                  {%endif%}       
               </ul>
            </div>
         </div>
         {%endif%}
            
      </div>
  
   </div>

</div>