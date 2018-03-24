<div class="row breadcrumb">
	<div class="container">
		<a href="{{baseurl}}">Trang chủ</a>		
		<span>> {{page.page_name}}</span>			
	</div>
</div>
<div class="row content_bg">	
   <div class="container panel_bg margin-top10">
      <div class="col-md-12 col-sm-12 col-xs-12 margin_top ">
      	 <div class="row margin_top" >
         <!--<div class="pn_posts">-->
            <div class="pn_title">               
               <h1>{{page.page_name}} </h1>
            </div> 
            <hr class="line" />           
            <div class="pn_content pn_background pn_border margin_top"> 
               <div class="row">
                  <div class="fr-element fr-view">
                    {{page.content}}
                  </div>
                  <hr class="line" />
		            <div class="row">
		            	<div><label class="chiase">Chia sẻ:</label></div>
		            	<ul class="mxh">
		            		<li><a href="https://www.facebook.com/sharer/sharer.php?u={{url.get('p/')}}{{page.page_no}}" target="_blank"><img src="{{url.get('template1/images/facebook.png')}}"/></a>
		            		</li>
		            		<li><a href="https://twitter.com/intent/tweet?text={{page.page_name}}&url={{url.get('p/')}}{{page.page_no}}" target="_blank"><img src="{{url.get('template1/images/twitter.png')}}"/></a>
		            		</li>
		            		<li><a href="https://plus.google.com/share?url={{url.get('p/')}}{{page.page_no}}" target="_blank"><img src="{{url.get('template1/images/googleplus.png')}}"/></a>
		            		</li>
		            		<li><a href="http://pinterest.com/pin/create/button/?url={{url.get('p/')}}{{page.page_no}}&description={{page.page_name}}" target="_blank"><img src="{{url.get('template1/images/pinterest.png')}}"/></a>
		            		</li>
		            		<li><a href="https://mail.google.com/mail/u/0/?view=cm&fs=1&to&su={{page.page_name}}&body={{url.get('p/')}}{{page.page_no}}&ui=2&tf=1" target="_blank"><img src="{{url.get('template1/images/email.png')}}" class="email"/></a>
            		</li>
		            	</ul>
		            </div>
               </div>
               
            </div>
         </div>
      </div>     
   </div>  
</div>
