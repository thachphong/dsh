{{ stylesheet_link('froala/css/froala_style.css')}}
<div class="row pos_rl" >
	<div class="bg_frame_search">
	    <div class="container">  
	    	<div class="col-md-7 col-sm-6 col-xs-12">
		    	<span class="page_title fs35" style="font-size: 25px !important;">{{news_name}}</span>
		    	<div class="row brdcrumb">
		    	<a href="{{baseurl}}">Trang chủ</a>	
				{%for br in breadcrumbs%}
					<span>></span>
					<a href="{{baseurl}}c/{{br['ctg_no']}}">{{br['ctg_name']}}</a>
				{%endfor%}
				<span>> {{news_name}}</span>	
				</div>	    		
			</div>	
			<div class=" col-md-5 col-sm-6 col-xs-12 box_search">
				<form method="get" class="searchform" action="{{url.get('search')}}">				    
				    <input id="s-keyword" name="s" type="text" value="" class="input_search text_input" placeholder="Tìm sản phẩm và dịch vụ">
					<input type="submit" value="" style="font-family:FontAwesome" class="btn_search">
				</form>	
			</div>
	    </div>
    </div>
</div>
<div class="row">
   <div class="container">   
     <!-- <div class="col-md-8 col-sm-12 col-xs-12 margin_top no_padding_left">-->
         <div class="row margin_top pn_background pn_border post_pn" >
            <div class="post_head">
               <h1>{{news_name}}</h1>
               <div class="khuvuc" style="font-style: italic;color:#575353">
                  {{add_date}}
               </div>
            </div>
            <hr class="line" />
            <div class="fr-element fr-view">
                     {{content}}
            </div>
            <hr class="line" />
            <div class="row">
            	<div><label class="chiase">Chia sẻ:</label></div>
            	<ul class="mxh">
            		<li><a href="https://www.facebook.com/sharer/sharer.php?u={{url.get('t/')}}{{news_no}}_{{news_id}}" target="_blank"><img src="{{url.get('template1/images/facebook.png')}}"/></a>
            		</li>
            		<li><a href="https://twitter.com/intent/tweet?text={{news_name}}&url={{url.get('t/')}}{{news_no}}_{{news_id}}" target="_blank"><img src="{{url.get('template1/images/twitter.png')}}"/></a>
            		</li>
            		<li><a href="https://plus.google.com/share?url={{url.get('t/')}}{{news_no}}_{{news_id}}" target="_blank"><img src="{{url.get('template1/images/googleplus.png')}}"/></a>
            		</li>
            		<li><a href="http://pinterest.com/pin/create/button/?url={{url.get('t/')}}{{news_no}}_{{news_id}}&description={{news_name}}&media={{url.get('')}}{{img_path}}" target="_blank"><img src="{{url.get('template1/images/pinterest.png')}}"/></a>
            		</li>
            		<li><a href="https://mail.google.com/mail/u/0/?view=cm&fs=1&to&su={{news_name}}&body={{url.get('t/')}}{{news_no}}_{{news_id}}&ui=2&tf=1" target="_blank"><img src="{{url.get('template1/images/email.png')}}" class="email"/></a>
            		</li>
            	</ul>
            	
            </div>
         </div>
         <div class="row margin_top" >           
            <div class="pn-title">
					<h3 class="ctg_title">Bài viết liên quan </h3>
			</div>
            {%for key,item in relations%}
            <div class="col-md-6 col-sm-6 col-xs-12 {%if key%2==0 %}col_left{%else%}col_right{%endif%}" >
               <div class="relation_item pn_background pn_border">
                  <a href="{{url.get('t/')}}{{item['news_no']}}_{{item['news_id']}}"><img  src="{{url.get('crop/120x79/')}}{{item['img_path']}}" alt="{{item['news_name']}}" title="{{item['news_name']}}"></a>
                  <a class="linkpost" href="{{url.get('t/')}}{{item['news_no']}}_{{item['news_id']}}">{{item['news_name']}}</a>
               </div>
            </div>
            {%endfor%}
         </div>
         <div class="row margin_top" >
            <!--<div class="pn_title">
               <span class="bg_icon" style="padding: 6px 4px 4px 2px;"><i class="fa fa-list"></i></span>
               <h1>Bình luận</h1>               
            </div>-->
            <hr/>
            <div class="row margin_top pn_background pn_border">
                  
                  <div class="fb-comments" data-href="{{url.get('t/')}}{{news_no}}_{{news_id}}" data-width="100%" data-numposts="20" style="width: 100%"></div>
                                 <div id="fb-root"></div>
                                    <script>(function(d, s, id) {
                                      var js, fjs = d.getElementsByTagName(s)[0];
                                      if (d.getElementById(id)) return;
                                      js = d.createElement(s); js.id = id;
                                      js.src = "//connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v2.9&appId=807407399380069";
                                      fjs.parentNode.insertBefore(js, fjs);
                                    }(document, 'script', 'facebook-jssdk'));</script>
                  
                 
                  
              
            </div>
            
         </div>

      <!--</div>     -->
   </div>   
</div>
