{{ stylesheet_link('froala/css/froala_style.css')}}
<div class="row">
	{% set banners= elements.get_banner()%}
   {{ partial('includes/banner_left') }}
   <div class="container">
   
      <div class="col-md-8 col-sm-12 col-xs-12 margin_top no_padding_left">
         <div class="row margin_top pn_background pn_border post_pn" >
         <div class="row">
         
         	<div class="col-md-6 col-sm-6 col-xs-12" style="padding-left: 0">
         		<img class="duan_img" src="{{url.get('crop/303x173/')}}{{img_path}}" title="{{project_name}}" alt="{{project_name}}"/>
         	</div>
         	<div class="col-md-6 col-sm-6 col-xs-12" style="padding-left: 0">
         		<div class="post_head">
         			<h1>{{project_name}}</h1>
         		</div>
         		<div class="row">
         			<label class="duan_title">Chủ đầu tư:</label><span class="duan_text">{{boss_name}}</span>
         		</div>
         		<div class="row">
         		    <label class="duan_title">Địa chỉ:</label><span class="duan_text">{{address}}</span>
         		</div>
               <div class="row">
                   <label class="duan_title">Tổng diện tích:</label><span class="duan_text">{{acreage}} m2</span>
               </div>
               <div class="row">
                   <label class="duan_title">Mật độ xây dựng:</label><span class="duan_text">{{percent}} %</span>
               </div>
               <div class="row">
                   <label class="duan_title">Loại hình phát triển:</label><span class="duan_text">{{ctg_name}}</span>
               </div>
               <div class="row">
                   <label class="duan_title">Quy mô dự án:</label><span class="duan_text">{{scale}}</span>
               </div>
         	</div> 
         </div>           
            <hr class="line" />
            <!--<div class="post_head">
                <h2 class="duan_tongquan">Tổng quan</h2>
            </div>-->
            <div class="fr-element fr-view">
                     {{content}}
            </div>
            <hr class="line" />
            <div class="row">
            	<div><label class="chiase">Chia sẻ:</label></div>
            	<ul class="mxh">
            		<li><a href="https://www.facebook.com/sharer/sharer.php?u={{url.get('da/')}}{{project_no}}_{{project_id}}" target="_blank"><img src="{{url.get('template1/images/facebook.png')}}"/></a>
            		</li>
            		<li><a href="https://twitter.com/intent/tweet?text={{project_name}}&url={{url.get('da/')}}{{project_no}}_{{project_id}}" target="_blank"><img src="{{url.get('template1/images/twitter.png')}}"/></a>
            		</li>
            		<li><a href="https://plus.google.com/share?url={{url.get('da/')}}{{project_no}}_{{project_id}}" target="_blank"><img src="{{url.get('template1/images/googleplus.png')}}"/></a>
            		</li>
            		<li><a href="http://pinterest.com/pin/create/button/?url={{url.get('da/')}}{{project_no}}_{{project_id}}&description={{project_name}}&media={{url.get('')}}{{img_path}}" target="_blank"><img src="{{url.get('template1/images/pinterest.png')}}"/></a>
            		</li>
            		<li><a href="https://mail.google.com/mail/u/0/?view=cm&fs=1&to&su={{project_name}}&body={{url.get('da/')}}{{project_no}}_{{project_id}}&ui=2&tf=1" target="_blank"><img src="{{url.get('template1/images/email.png')}}" class="email"/></a>
            		</li>
            	</ul>
            </div>
         </div>
         <div class="row margin_top" >
            <div class="pn_title">
               <span class="bg_icon" style="padding: 6px 4px 4px 2px;"><i class="fa fa-list"></i></span>
               <h1>Dự án liên quan</h1>               
            </div>
            {%for key,item in relations%}
            <div class="col-md-6 col-sm-6 col-xs-12 {%if key%2==0 %}col_left{%else%}col_right{%endif%}" >
               <div class="relation_item pn_background pn_border">
                  <a href="{{url.get('da/')}}{{item['project_no']}}_{{item['project_id']}}"><img  src="{{url.get('crop/120x79/')}}{{item['img_path']}}" alt="{{item['project_name']}}" title="{{item['project_name']}}"></a>
                  <a class="linkpost" href="{{url.get('da/')}}{{item['project_no']}}_{{item['project_id']}}">{{item['project_name']}}</a>
               </div>
            </div>
            {%endfor%}
         </div>
         <div class="row margin_top" >
            <div class="pn_title">
               <span class="bg_icon" style="padding: 6px 4px 4px 2px;"><i class="fa fa-list"></i></span>
               <h1>Bình luận</h1>               
            </div>
            <div class="row margin_top pn_background pn_border">
               <ul class="nav nav-tabs" id="comment_tab">
                 <li class="active"><a data-toggle="tab" href="#tab1">Facebook</a></li>
                 <li><a data-toggle="tab" href="#tab2" >Google+</a></li>                 
               </ul>
               <div class="tab-content">
                  <div id="tab1" class="tab-pane fade in active">
                  <div class="fb-comments" data-href="{{url.get('da/')}}{{project_no}}_{{project_id}}" data-width="100%" data-numposts="20"></div>
                                 <div id="fb-root"></div>
                                    <script>(function(d, s, id) {
                                      var js, fjs = d.getElementsByTagName(s)[0];
                                      if (d.getElementById(id)) return;
                                      js = d.createElement(s); js.id = id;
                                      js.src = "//connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v2.9&appId=807407399380069";
                                      fjs.parentNode.insertBefore(js, fjs);
                                    }(document, 'script', 'facebook-jssdk'));</script>
                  </div>
                  <div id="tab2" class="tab-pane fade">
                     <div id="google_comments" style="width:100%"></div>
                     <script src="https://apis.google.com/js/plusone.js" type="text/javascript" >{lang: 'vi'}</script>
                     <script>gapi.comments.render('google_comments',{
                        href:window.location.href,
                        width:"725",
                        first_party_property: 'BLOGGER',
                        view_type: 'FILTERED_POSTMOD'}
                        );
                        function fix_google()
                        {                           
                           $("#google_comments").css({"width":"100%"});                           
                           $("#google_comments iframe").css("width","100%");
                        }
                        setTimeout(fix_google,4000);
                     </script>
                  </div>
                  
               </div>
            </div>
            
         </div>

      </div>
      {{ partial('includes/right') }}
   </div>
   {% set banners= elements.get_banner()%}
   {{ partial('includes/banner_right_2') }}
</div>
