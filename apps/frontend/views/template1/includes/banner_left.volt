<div class="banner_left">
{%if banners[0] is defined %}
   		<a href="{{url.get(banners[0].link_page)}}">
   			<img src="{{url.get(banners[0].img_path)}}" style="margin-bottom: 5px"/>
   		</a>
{%endif%}
{%if banners[1]is defined %}
   		<a href="{{url.get(banners[1].link_page)}}">
   			<img src="{{url.get(banners[1].img_path)}}"/>
   		</a>
{%endif%}
</div>