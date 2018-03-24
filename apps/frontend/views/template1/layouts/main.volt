<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
	  <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1,maximum-scale=1">
	  {% set define= elements.get_define()%}
      
      <meta name="description" content=" content="{{define['web_des']}}">
	  <meta property="og:site_name" content="{{sitename}}">
	  <meta name="og:type" content="product" />
      <meta property="og:title" content="{{define['web_title']}} | {{sitename}}">
      <meta property="og:description" content="{{define['web_des']}}">  
      <meta name="keywords" content="{{define['web_keywords']}}" />
      <meta property="og:url" content="{{baseurl}}" />
     <!-- <meta property="og:image" content="/images/logo.png"> -->
      
      <title>{{define['web_title']}} | {{sitename}}</title>
      {{ partial('includes/header') }}        
   </head>
   <body>
      {{ partial('includes/menu') }}
      {{ content() }}
      {{ partial('includes/footer') }}
   </body>
</html>