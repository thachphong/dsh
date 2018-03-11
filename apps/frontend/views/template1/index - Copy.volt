
<!DOCTYPE HTML>

<html>

<head>
    
   <meta charset="UTF-8"/>
    <meta name="google-site-verification" content="Jj-nEMW_PHNHnSVYIA1J5TB6Hutg8i9RECV_67ZzpS4"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{% if post.caption is defined %}
    			{{ post.caption ~'|'}}    			
    		{%elseif title is defined%}
    			{{ title ~' - '}}
			{% endif %}Tin nhanh 24h</title>
    
<!-- This site is optimized with the Yoast SEO plugin v3.2.4 - https://yoast.com/wordpress/plugins/seo/ -->
<meta name="description" content="Mẹo vặt cho mẹ, bí quyết nuôi con, sức khỏe của bé, cách nấu món ngon, sức khỏe gia đình"/>
<meta name="robots" content="noodp"/>
<link rel="canonical" href="http://bloglamme.com"/>
<link rel="next" href="http://bloglamme.com/page/2/"/> 
<meta property="og:locale" content="en_US"/>
<meta property="og:type" content="website"/>
<meta property="og:title" content="Blog Làm Mẹ - Theo bước con lớn khôn"/>
<meta property="og:description" content="Mẹo vặt cho mẹ, bí quyết nuôi con, sức khỏe của bé, cách nấu món ngon, sức khỏe gia đình"/>
<meta property="og:url" content="http://bloglamme.com"/>
<meta property="og:site_name" content="Blog Làm Mẹ - Theo bước con lớn khôn"/>
<!--<script type='application/ld+json'>{"@context":"http:\/\/schema.org","@type":"WebSite","url":"http:\/\/bloglamme.com\/","name":"Blog l\u00e0m m\u1eb9, m\u1eb9o v\u1eb7t cu\u1ed9c s\u1ed1ng, b\u00ed quy\u1ebft n\u1ea5u m\u00f3n ngon","potentialAction":{"@type":"SearchAction","target":"http:\/\/bloglamme.com\/?s={search_term_string}","query-input":"required name=search_term_string"}}
</script>
<script type='application/ld+json'>{"@context":"http:\/\/schema.org","@type":"Person","url":"http:\/\/bloglamme.com","sameAs":[],"name":"Blog L\u00e0m M\u1eb9"}</script>-->
<!-- / Yoast SEO plugin. -->

<!--<link rel="alternate" type="application/rss+xml" title="Blog Làm Mẹ - Theo bước con lớn khôn &raquo; Feed" href="http://bloglamme.com/feed/"/>
<link rel="alternate" type="application/rss+xml" title="Blog Làm Mẹ - Theo bước con lớn khôn &raquo; Comments Feed" href="http://bloglamme.com/comments/feed/"/>-->
		<!--<script type="text/javascript">
			window._wpemojiSettings = {"baseUrl":"http:\/\/s.w.org\/images\/core\/emoji\/72x72\/","ext":".png","source":{"concatemoji":"http:\/\/bloglamme.com\/wp-includes\/js\/wp-emoji-release.min.js?ver=4.3.3"}};
			!function(a,b,c){function d(a){var c=b.createElement("canvas"),d=c.getContext&&c.getContext("2d");return d&&d.fillText?(d.textBaseline="top",d.font="600 32px Arial","flag"===a?(d.fillText(String.fromCharCode(55356,56812,55356,56807),0,0),c.toDataURL().length>3e3):(d.fillText(String.fromCharCode(55357,56835),0,0),0!==d.getImageData(16,16,1,1).data[0])):!1}function e(a){var c=b.createElement("script");c.src=a,c.type="text/javascript",b.getElementsByTagName("head")[0].appendChild(c)}var f,g;c.supports={simple:d("simple"),flag:d("flag")},c.DOMReady=!1,c.readyCallback=function(){c.DOMReady=!0},c.supports.simple&&c.supports.flag||(g=function(){c.readyCallback()},b.addEventListener?(b.addEventListener("DOMContentLoaded",g,!1),a.addEventListener("load",g,!1)):(a.attachEvent("onload",g),b.attachEvent("onreadystatechange",function(){"complete"===b.readyState&&c.readyCallback()})),f=c.source||{},f.concatemoji?e(f.concatemoji):f.wpemoji&&f.twemoji&&(e(f.twemoji),e(f.wpemoji)))}(window,document,window._wpemojiSettings);
		</script>-->
		<style type="text/css">
img.wp-smiley,
img.emoji {
	display: inline !important;
	border: none !important;
	box-shadow: none !important;
	height: 1em !important;
	width: 1em !important;
	margin: 0 .07em !important;
	vertical-align: -0.1em !important;
	background: none !important;
	padding: 0 !important;
}
</style>
<link rel='stylesheet' id='roboto-condensed-css' href='http://fonts.googleapis.com/css?family=Roboto+Condensed%3A300italic%2C400italic%2C700italic%2C400%2C700%2C300&#038;subset=latin%2Cvietnamese&#038;ver=4.3.3' type='text/css' media='all'/>
<link rel='stylesheet' id='open-sans-css' href='https://fonts.googleapis.com/css?family=Open+Sans%3A300italic%2C400italic%2C600italic%2C300%2C400%2C600&#038;subset=latin%2Clatin-ext&#038;ver=4.3.3' type='text/css' media='all'/>

{{ stylesheet_link('template3/css/bootstrap-3.3.4.min.css') }}
{{ stylesheet_link('template3/css/owl.carousel-2.0.min.css') }}
{{ stylesheet_link('template3/css/owl.theme.default-2.0.min.css') }}
{{ stylesheet_link('template3/css/animate-4.3.3.min.css') }}
{{ stylesheet_link('template3/css/font-awesome-4.3.0.min.css') }}
{{ stylesheet_link('template3/css/style.css') }}

{{ javascript_include('template3/js/jquery-1.11.3.js') }}

{{ javascript_include('template3/js/jquery-1.9.1.js') }}

{{ javascript_include('template3/js/jquery-migrate-1.2.1.min.js') }}
{{ javascript_include('template3/js/q2w3-fixed-widget-4.0.6.min.js') }}

<!--<link rel="EditURI" type="application/rsd+xml" title="RSD" href="http://bloglamme.com/xmlrpc.php?rsd"/>
<link rel="wlwmanifest" type="application/wlwmanifest+xml" href="http://bloglamme.com/wp-includes/wlwmanifest.xml"/>-->
	<!--[if lt IE 9]>
		<script src="http://bloglamme.com/wp-content/themes/tintonghop/framework/core/js/html5.js" type="text/javascript"></script>
		<script src="http://bloglamme.com/wp-content/themes/tintonghop/framework/core/js/css3-mediaqueries.js" type="text/javascript"></script>
	<![endif]-->
	<!--[if lte IE 9]>
		<link rel="stylesheet" type="text/css" href="http://bloglamme.com/wp-content/themes/tintonghop/framework/core/css/ie.css" />
	<![endif]-->
    <link rel="shortcut icon" href="{{url.get()}}template3/images/speech-balloon-orange-b-icon.png"/>
    
</head>
<body class="home blog">
    <div class="wrapper">
        <div id="header-wrapper">
            <header id="header" class="header">
                <div class="logo-banner">
                    <div class="wrapper-logo-banner">
                        <div class="container">
                            <div class="row">
                                <div class="col-lg-4 col-sm-4 col-xs-12">
                                    <div id="logo">
                                        <a title="Blog Làm Mẹ &#8211; Theo bước con lớn khôn" href="http://bloglamme.com" rel="home">
                                            <img src="{{url.get()}}template3/images/logo.png" alt="Blog Làm Mẹ &#8211; Theo bước con lớn khôn">
                                        </a>
                                        <h1 class="site-title">Blog Làm Mẹ - Theo bước con lớn khôn</h1>                                    </div>
                                </div>
                                <div class="col-lg-8 col-sm-8 hidden-xs">
                                    <p><a href="http://sallyspa.com.vn/sach-mun-het-tham-yen-tam-lang-min-nho-te-bao-goc-mts.html" target="_blank"><img style="display: block;" src="http://bloglamme.com/wp-content/uploads/2016/04/sally-beauty-728x90.jpg" alt="" width="720px" height="90px;" border="0px"/></a></p>                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                {{ partial('includes/menu') }}
            </header><!-- /header -->
        </div>    
	<div id="main">
		{{ partial('includes/newsfeed') }}
        {{ content() }}
    </div>
    {{ partial('includes/footer') }}   
    <script>
    	jQuery(document).ready(function(){
    		$('#menu_'+{{menu_id}}).addClass('current-menu-item');
    		$(document).on('click','#buttom-search',function(){
    			//alert('11');
    			var url = "{{url.get('search/')}}"+$('#s_name').val();
    			window.location.href=url;
    			console.log(url);
    			return;
    		});
    		$("#s_name").keydown(function (e) {    			
		        if (e.keyCode == 13) {
		        	/*alert('dd');
		        	$('#buttom-search').click();*/
		        	var url = "{{url.get('search/')}}"+$('#s_name').val();
	    			window.location.href=url;
	    			console.log(url);
	    			return;
		        }
		    });
    	});
    </script> 
</body>
<!--<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-74123414-1', 'auto');
  ga('send', 'pageview');

</script>-->
</div>
</div>
</html>
