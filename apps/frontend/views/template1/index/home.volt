{{ partial('includes/search') }}
{% set banners= elements.get_banner()%}
<div class="row">
   {{ partial('includes/banner_left') }}
   <div class="container" id="content">
      <div class="col-md-8 col-sm-12 col-xs-12 margin_top no_padding_left">
      	 <div class="row margin_top" >
            <div class="pn_title">
               <span class="bg_icon" style="padding: 6px 4px 4px 2px;"><i class="fa fa-cubes"></i></span>
               <h1>Tin tức</h1>              
            </div>
            <div class="newsboxrow pn_background pn_border">
               {%if kientruc|length >0 %}
               <div class="col-md-6 col-sm-6 col-xs-12 boxleft">
               	{%for key,item in kientruc%}
               	  <div id="li_{{key}}" class="news-list-thumb" {%if key !=0%}style="display:none"{%endif%}>
               	  <a href="{{url.get('t/')}}{{item['news_no']}}_{{item['news_id']}}">
                  <img src="{{url.get('crop/354x236/')}}{{item['img_path']}}" alt="{{item['news_name']}}" title="{{item['news_name']}}">
                  </a>
                  <a href="{{url.get('t/')}}{{item['news_no']}}_{{item['news_id']}}"><h4 class="colblue">{{item['news_name']}}</h4></a>
                  </div>
                {%endfor%}
               </div>
               {%endif%}
               <div class="col-md-6 col-sm-6 col-xs-12" style="height: 299;margin-top: 5px;display: block; overflow: none" id="tintuc_new_list">
               		<!--<div id="tintuc_new_list" style="height: 300;margin-top: 5px;display: block; overflow: none">-->
	                  <ul class="boxright" id="tintuc">
	                  {%for key,item in kientruc%}	                    
	                        <li data_item="{{key}}" style="height: 45px; width: 100%"> <i class="fa fa-circle"></i><a href="{{url.get('t/')}}{{item['news_no']}}_{{item['news_id']}}" class="colblue">{{item['news_name']}}</a></li>	                    
	                  {%endfor%}
	                 </ul>
                  <!--</div>-->
               </div>
               
            </div>            
         </div>
         <div class="row margin_top" >
            <div class="pn_title">
               <span class="bg_icon" style="padding: 6px 4px 4px 2px;"><i class="fa fa-list"></i></span>
               <h1>TIN RAO MỚI</h1>
               <a class="read_more" href="{{url.get('tin-moi')}}">>> Xem thêm tin rao mới</a>
            </div>
            <div class="new_list">
               {%for item in newlist%}
                  <div class="row margin_top_5 pn_background pn_border">
                     <div class="col-md-3 col-sm-3 col-xs-3 post_img">
                        <a href="{{url.get('b/')}}{{item['post_no']}}_{{item['post_id']}}">
                        <img src="{%if item['img_path']|length ==0%}{{url.get('crop/176x118/template1/images/post00.png')}}{%else%}{{url.get('crop/140x100/')}}{{item['img_path']}}{%endif%}" class="img_newlist" alt="{{item['post_name']}}" title="{{item['post_name']}}">
                        {%if item['youtube_key']|length > 0%}
                        	<img class="icon_play" src="{{url.get('/template1/images/playicon.png')}}">
                        {%endif%}
                        </a>
                     </div>
                     <div class="col-md-9 col-sm-9 col-xs-9">
                        <a href="{{url.get('b/')}}{{item['post_no']}}_{{item['post_id']}}" class="post_title {%if item['post_level']==3%}sieu_vip{%elseif item['post_level']==2%}vip{%elseif item['post_level']==1%}hot{%endif%}">{%if item['post_level']==3%}<i class="fa fa-star"></i>{%endif%}{{item['post_name']}}</a>
                        <div class="icon_post"><label><!--<i class="fa fa-usd"></i>-->Giá<span>: </span></label><strong>{%if item['price'] is defined%}{{item['price']}} {{item['m_unit_name']}}{%else%}Thỏa thuận{%endif%}</strong>
                        <strong class="icon_dientich"><!--<i class="fa fa-university"></i>-->Diện tích<span>: </span></strong>{%if item['acreage'] is defined%}{{item['acreage']}} m2{%else%}Không xác định{%endif%}
                        </div>
                        <div class="icon_post"></div>
                        <div class="icon_post"><label><!--<i class="fa fa-map-marker"></i>-->Địa chỉ<span>: </span></label>{%if item['m_ward_name'] is defined%}{{item['m_ward_name']}} - {%endif%}
                        {{item['m_district_name']}} - {{item['m_provin_name']}}</div>
                        <span class="post_date">{{item['start_date']}}</span>
                     </div>
                  </div>
               {%endfor%}
            </div>
            <!-- <div class="row margin_top pn_background pn_border" style="text-align:right">
               <strong><a>>> Xem thêm tin rao mới</a></strong>
               
            </div> -->
         </div>          
         <div class="row margin_top" >
            <div class="pn_title">
               <span class="bg_icon" style="padding: 6px 4px 4px 2px;"><i class="fa fa-posteare"></i></span>
               <h1>Nội - ngoại thất</h1>               
            </div>
            <div class="newsboxrow pn_background pn_border">
               {%if noingoaithat|length >0 %}
               <div class="col-md-6 col-sm-6 col-xs-12 boxleft">
               	  <a href="{{url.get('t/')}}{{noingoaithat[0]['news_no']}}_{{noingoaithat[0]['news_id']}}">
                  <img src="{{url.get('crop/354x236/')}}{{noingoaithat[0]['img_path']}}" alt="{{noingoaithat[0]['news_name']}}" title="{{noingoaithat[0]['news_name']}}">
                  </a>
                  <a href="{{url.get('t/')}}{{noingoaithat[0]['news_no']}}_{{noingoaithat[0]['news_id']}}"><h4>{{noingoaithat[0]['news_name']}}</h4></a>
               </div>
               {%endif%}
               <div class="col-md-6 col-sm-6 col-xs-12">
                  <ul class="boxright">
                  {%for key,item in noingoaithat%}
                     {%if key >0%}
                        <li> <i class="fa fa-circle"></i><a href="{{url.get('t/')}}{{item['news_no']}}_{{item['news_id']}}">{{item['news_name']}}</a></li>
                     {%endif%}
                  {%endfor%}
                  </ul>
               </div>
               
            </div>
         </div>  
         
         <div class="row margin_top" >
            <div class="col-md-6 col-sm-6 col-xs-12 col_left">
               <div class="pn_title">
                  <span class="bg_icon" style="padding: 6px 4px 4px 2px;"><i class="fa fa-adjust"></i></span>
                  <h1>Phong Thủy</h1>                 
               </div>
               <div class="newsboxrow pn_background pn_border">
                  <div class="colbox">
                  {%if phongthuy|length >0 %}   
                  	<a href="{{url.get('t/')}}{{phongthuy[0]['news_no']}}_{{phongthuy[0]['news_id']}}">
                     <img src="{{url.get('crop/308x225/')}}{{phongthuy[0]['img_path']}}" alt="{{phongthuy[0]['news_name']}}" title="{{phongthuy[0]['news_name']}}">
                    </a>
                     <a class="post_name" href="{{url.get('t/')}}{{phongthuy[0]['news_no']}}_{{phongthuy[0]['news_id']}}"><h4>{{phongthuy[0]['news_name']}}</h4></a>                  
                  {%endif%}
                  <hr/>
                  <ul class="boxright">
                  {%for key,item in phongthuy%}
                     {%if key >0%}
                        <li> <i class="fa fa-circle"></i><a href="{{url.get('t/')}}{{item['news_no']}}_{{item['news_id']}}">{{item['news_name']}}</a></li>
                     {%endif%}
                  {%endfor%}
                  </ul>
                  </div>
               </div>
            </div>
            <div class="col-md-6 col-sm-6 col-xs-12 col_right">
               <div class="pn_title">
                  <span class="bg_icon" style="padding: 6px 4px 4px 2px;"><i class="fa fa-balance-scale"></i></span>
                  <h1>Tư vấn luật</h1>                
               </div>
               <div class="newsboxrow pn_background pn_border">
                  <div class="colbox">
                  {%if tuvanluat|length >0 %}  
                  	<a href="{{url.get('t/')}}{{tuvanluat[0]['news_no']}}_{{tuvanluat[0]['news_id']}}">
                     <img src="{{url.get('crop/308x225/')}}{{tuvanluat[0]['img_path']}}" alt="{{tuvanluat[0]['news_name']}}" title="{{tuvanluat[0]['news_name']}}">
                    </a>
                     <a class="post_name" href="{{url.get('t/')}}{{tuvanluat[0]['news_no']}}_{{tuvanluat[0]['news_id']}}"><h4>{{tuvanluat[0]['news_name']}}</h4></a>                  
                  {%endif%}
                  <hr/>
                  <ul class="boxright">
                  {%for key,item in tuvanluat%}
                     {%if key >0%}
                        <li> <i class="fa fa-circle"></i><a href="{{url.get('t/')}}{{item['news_no']}}_{{item['news_id']}}">{{item['news_name']}}</a></li>
                     {%endif%}
                  {%endfor%}
                  </ul>
                  </div>
               </div>
            </div>
         </div> 
         <div class="row margin_top" >
         	<!--<marquee id="marq" scrollamount="3" direction="left" loop="50" scrolldelay="0" behavior="slide" onmouseover="this.stop()" onmouseout="this.start()">
         		{%for item in slides%}
         		<a href="{{item.link_page}}"><img src="{{url.get(item.img_path)}}" style="width: 200px;height:120px"></a>
         		{%endfor%}
         	</marquee>-->
         	<div class="imgscroll">
	         	<ul id="imgs" >
				    {%for item in slides%}
	         		<li><a href="{{item.link_page}}"><img src="{{url.get('crop/140x90/')}}{{item.img_path}}" style="width: 140px;height:90px"></a></li>
	         		{%endfor%}
	  			</ul>
  			</div>
         </div>   
      </div>
      
      {{ javascript_include('template1/js/ImageScroll.js') }}
      {{ javascript_include('template1/js/jcarousellite.js') }}
<script type="text/javascript">
$(document).ready(function() {
	  $('#imgs').imageScroll({
	    orientation:"left",
	    speed:1000,
	    interval:1000,
	    hoverPause:true,
	    callback:function(){
	      var ordinal = $(this).find("img").first().attr("src");
	      // console.log(ordinal); 
	      $(this).next("span").text("CallbackDisplay: hidden "+ordinal+"!");
	    }
	  });
	  /*$("#tintuc").simplyScroll({
                    customClass: 'vert',
                    orientation: 'vertical',
                    auto: true,
                    manualMode: 'end',
                    frameRate:10 ,
                    speed: 1
                });*/

		var autocroll= function () {
			var i = 0;
			var len = 7;
			var count = 8;
			var first = true;
			var o = $("#tintuc_new_list").jCarouselLite({
					vertical: true,
					hoverPause: false,
					visible: len,
					start: 1,
					warp: "circle",
					auto: 1,
					speed: 1000,
					beforeStart: function (a) {
						if (!first)
						$(a).parent().delay(1000);
					},
					afterEnd: function (a,b) {
						if (first) {
						first = false;
						}	
															
						$(".news-list-thumb").css("display", "none");
						var data_item = $(a).last().attr('data_item');
						console.log(data_item);	
						$("#li_" + (data_item)).css("display", "block");
						//i++; if (i > count) i = 0;
						$(a).parent().delay(6500);
					}
				});
			};
		autocroll();
	
});
</script>
<script type="text/javascript">

</script>

      {{ partial('includes/right') }}
   </div>
   <div class="row" style="margin-top:10px">
    	<div class="container">  
    		<div class="row">
	    		<div class="pn_title">
	               <span class="bg_icon" style="padding: 6px 4px 4px 2px;"><i class="fa fa-list"></i></span>
	               <h3>Nhà đất theo Tỉnh/Thành Phố</h3>
	            </div>
	            
	            <div class="newsboxrow pn_background pn_border tp_list">
	            	
	              <!-- <div class="colbox " >
	                     <ul class="boxright">-->
	                     {{ elements.getthanhpho() }}
	                     <!--</ul>
	               </div>-->
	            </div>
            </div>
        </div>
	</div>
   {{ partial('includes/banner_right') }}
</div>