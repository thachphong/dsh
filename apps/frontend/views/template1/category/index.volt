<div class="row breadcrumb">
	<div class="container">
		<a href="{{baseurl}}">Trang chủ</a>	
		{%for br in breadcrumbs%}
			<span>></span>
			<a href="{{baseurl}}{{br['ctg_no']}}">{{br['ctg_name']}}</a>
		{%endfor%}
		<span>> {{ctg_name}}</span>			
	</div>
</div>
<div class="row content_bg" >
	<div class="container panel_bg margin-top10" id="content">            
      <div class="col-md-12 col-sm-12 col-xs-12 margin_top">
         <div class="row margin_top" >
            <div class="pn_title">               
               <h1>{{ctg_name}}</h1>
               <label class="read_more" style="font-weight:normal">có <strong>{{total_post}}</strong> tin bất động sản</label>
            </div>
            <hr/>
            <div class="row pro_list">
					{%for item in list%}					
					<div class="col-md-3 col-sm-3 col-xs-6 pro_list_item">
						<a href="{{url.get('sp/')}}{{item['pro_no']}}_{{item['pro_id']}}">					
						<img src="{{url.get('')}}{{item['img_path']}}"/>
						<div>
							<span class="lst-it-title">{{item['pro_name']}}</span>
						</div>
						<div>
							<div>Giá bán lẻ: <strong class="font_size14 col_red">{{elements.currency_format(item['price_exp'])}} đ</strong></div>
							<div>Giá CTV: <strong class="font_size14 col_blue">{{elements.currency_format(item['price_seller'])}} đ</strong></div>
						</div>						
						</a>
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