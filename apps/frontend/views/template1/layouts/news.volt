<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
	  <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1,maximum-scale=1">
	  {% set define= elements.get_define()%}
	  <meta property="og:site_name" content="diaocviet.vn">
      <meta property="og:title" content="{{news_name}}">
      <meta property="og:description" content="{{des}}">  
      <meta property="og:image" content="{{url.get('')}}{{img_path}}">
      <title>{{news_name}}</title>
      {{ partial('includes/header') }}        
   </head>
   <body>
      {{ partial('includes/menu') }}
      {{ content() }}
      {{ partial('includes/footer') }}
   </body>
</html>