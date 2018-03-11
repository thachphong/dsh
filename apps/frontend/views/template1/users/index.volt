{{ partial('includes/search') }}
<div class="row">
   <div class="container" id="content">            
      <div class="col-md-8 col-sm-12 col-xs-12">
         <div class="row margin_top" >
            <div class="pn_title">
               <span class="bg_icon" style="padding: 6px 4px 4px 2px;"><i class="fa fa-list"></i></span>
               <h1>TIN RAO MỚI</h1>
               <a class="read_more" href="{{url.get('tim-moi')}}">>> Xem thêm tin rao mới</a>
            </div>
            <div class="new_list">
               {%for item in newlist%}
                  <div class="row margin_top pn_background pn_border">
                     <div class="col-md-3 col-sm-3 col-xs-12 post_img">
                        <img src="{{url.get('crop/176x118/')}}{{item['img_path']}}" class="img_newlist">
                     </div>
                     <div class="col-md-9 col-sm-9 col-xs-12">
                        <a href="{{url.get(item['post_no'])}}{{item['post_id']}}" class="post_title">{{item['post_name']}}</a>
                        <div class="icon_post"><label><i class="fa fa-usd"></i>Giá<span>: </span></label><strong>{{item['price']}} {{item['m_unit_name']}}</strong></div>
                        <div class="icon_post"><label><i class="fa fa-university"></i>Diện tích<span>: </span></label>{{item['acreage']}} m2</div>
                        <div class="icon_post"><label><i class="fa fa-map-marker"></i>Vị trí<span>: </span></label>
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
                  <img src="{{url.get('crop/354x236/')}}{{noingoaithat[0]['img_path']}}">
                  <a href=""><h4>{{noingoaithat[0]['news_name']}}</h4></a>
               </div>
               {%endif%}
               <div class="col-md-6 col-sm-6 col-xs-12">
                  <ul class="boxright">
                  {%for key,item in noingoaithat%}
                     {%if key >0%}
                        <li> <i class="fa fa-circle"></i><a href="{{url.get('tim-tuc/')}}{{item['news_no']}}_{{item['news_id']}}">{{item['news_name']}}</a></li>
                     {%endif%}
                  {%endfor%}
                  </ul>
               </div>
               
            </div>
         </div>  
         <div class="row margin_top" >
            <div class="pn_title">
               <span class="bg_icon" style="padding: 6px 4px 4px 2px;"><i class="fa fa-cubes"></i></span>
               <h1>Kiến trúc không gian</h1>              
            </div>
            <div class="newsboxrow pn_background pn_border">
               {%if kientruc|length >0 %}
               <div class="col-md-6 col-sm-6 col-xs-12 boxleft">
                  <img src="{{url.get('crop/354x236/')}}{{kientruc[0]['img_path']}}">
                  <a href=""><h4>{{kientruc[0]['news_name']}}</h4></a>
               </div>
               {%endif%}
               <div class="col-md-6 col-sm-6 col-xs-12">
                  <ul class="boxright">
                  {%for key,item in kientruc%}
                     {%if key >0%}
                        <li> <i class="fa fa-circle"></i><a href="{{url.get('tim-tuc/')}}{{item['news_no']}}_{{item['news_id']}}">{{item['news_name']}}</a></li>
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
                     <img src="{{url.get('crop/338x225/')}}{{phongthuy[0]['img_path']}}">
                     <a class="post_name" href=""><h4>{{phongthuy[0]['news_name']}}</h4></a>                  
                  {%endif%}
                  <hr/>
                  <ul class="boxright">
                  {%for key,item in phongthuy%}
                     {%if key >0%}
                        <li> <i class="fa fa-circle"></i><a href="{{url.get('tim-tuc/')}}{{item['news_no']}}_{{item['news_id']}}">{{item['news_name']}}</a></li>
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
                     <img src="{{url.get('crop/338x225/')}}{{tuvanluat[0]['img_path']}}">
                     <a class="post_name" href=""><h4>{{tuvanluat[0]['news_name']}}</h4></a>                  
                  {%endif%}
                  <hr/>
                  <ul class="boxright">
                  {%for key,item in tuvanluat%}
                     {%if key >0%}
                        <li> <i class="fa fa-circle"></i><a href="{{url.get('tim-tuc/')}}{{item['news_no']}}_{{item['news_id']}}">{{item['news_name']}}</a></li>
                     {%endif%}
                  {%endfor%}
                  </ul>
                  </div>
               </div>
            </div>
         </div>    
      </div>
      <div class="col-md-4 col-sm-12 col-xs-12">
         <div class="row margin_top">
            <div class="pn_title">
               <span class="bg_icon" style="padding: 6px 4px 4px 2px;"><i class="fa fa-list"></i></span>
               <h3>Tin đặc biệt</h3>
            </div>
            <div class="viplist">
               {%for item in viplist%}
                  <div class="vipitem pn_background pn_border">
                     <img src="{{url.get('crop/50x50/')}}{{item['img_path']}}">
                     <div >
                        <a href="{{url.get(item['post_no'])}}{{item['post_id']}}">{{item['post_name']}}</a>
                        <div style="text-align:right">
                        <span><strong>{{item['price']}}</strong> {{item['m_unit_name']}}</span>
                        </div>
                     </div>
                  </div>
               {%endfor%}
            </div>
         </div>
         <div class="row margin_top">
            <div class="pn_title">
               <span class="bg_icon" style="padding: 6px 4px 4px 2px;"><i class="fa fa-list"></i></span>
               <h3>Tin xem nhiều</h3>
            </div>
            
            <div class="newsboxrow pn_background pn_border">
               <div class="colbox ">
                     <ul class="boxright">
                     {%for key,item in xemnhieu%}
                           <li> <i class="fa fa-circle"></i><a href="{{url.get('tim-tuc/')}}{{item['news_no']}}_{{item['news_id']}}">{{item['news_name']}}</a></li>
                           {%if key < (xemnhieu|length -1 )%}
                              <hr class="row_line" />
                           {%endif%}
                     {%endfor%}
                     </ul>
               </div>
            </div>  
         </div>
         <div class="row margin_top">
            <div class="pn_title">
               <span class="bg_icon" style="padding: 6px 4px 4px 2px;"><i class="fa fa-list"></i></span>
               <h3>Dự án nổi bật</h3>
            </div>
            <div>
            </div>
         </div>
      </div>
   </div>
</div>