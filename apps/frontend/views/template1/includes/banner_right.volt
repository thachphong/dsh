<div class="banner_right">
	{%if banners[2] is defined %}
   		<a href="{{url.get(banners[2].link_page)}}">
   			<img src="{{url.get(banners[2].img_path)}}" style="margin-bottom: 5px"/>
   		</a>
     {%endif%}
     {%if banners[3]is defined %}
   		<a href="{{url.get(banners[3].link_page)}}">
   			<img src="{{url.get(banners[3].img_path)}}"/>
   		</a>
   	{%endif%}
</div>
<script type="text/javascript">
	$('.banner_left').css('top','428px');
	$('.banner_right').css('top','428px');
	  $(window).scroll(function() {
		    var height = $(window).scrollTop();
		    
		    $('.banner_left').removeAttr("style");
		    $('.banner_right').removeAttr("style");
		    if(height  < 338) {
		        // do something
		        $('.banner_left').css('top',(438-height)+'px');
		        $('.banner_right').css('top',(438-height)+'px');
		    }else{
		    	$('.banner_left').css('top','0px');
		    	$('.banner_right').css('top','0px');
		    }
		    var wheight = $(document).height();
		    var screen_height = window.innerHeight;
		    var bottom = wheight - screen_height - 278;
		    //console.log('height:'+height);
		    //console.log('bottom:'+bottom);
		    //console.log('bottom2:'+(height-bottom));
		    if(height > bottom ){
		    	$('.banner_left').removeAttr("style");
		    	$('.banner_left').css('bottom',(height-bottom)+'px');
		    	$('.banner_right').removeAttr("style");
		    	$('.banner_right').css('bottom',(height-bottom)+'px');
		    }
		    //console.log(window.innerHeight);
		    
		    //248 bottom
		    
		}); 	
</script>