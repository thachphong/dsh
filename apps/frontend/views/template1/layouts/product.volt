<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
	  <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1,maximum-scale=1">
	  {% set define= elements.get_define()%}	
      <meta property="og:title" content="{{pro_name}} | {{sitename}}">
      <meta name="description" content=" content="{{pro_name}}, {{pro_desc}}, kinh doanh không cần vốn, Chiết khấu cao, dropshoping Việt Nam">
	  <meta property="og:site_name" content="{{sitename}}">
	  <meta name="og:type" content="product" />
      <meta property="og:title" content="{{pro_name}} | {{sitename}}">
      <meta property="og:description" content="{{pro_name}}, {{pro_desc}}, kinh doanh không cần vốn, Chiết khấu cao, dropshoping Việt Nam">  
      <!--<meta name="keywords" content="" />-->
      <meta property="og:url" content="{{baseurl}}sp/{{pro_no}}_{{pro_id}}" />      
      <meta property="og:image" content="{{baseurl}}{{imglist[0].img_path}}">
      <title>{{pro_name}} | {{sitename}}</title>
      {{ partial('includes/header') }} 
      {{ javascript_include('template1/js/jquery.elevatezoom.js') }}  
      {{ stylesheet_link('froala/css/froala_style.css') }} 
   </head>
   <body>
      {{ partial('includes/menu') }}
      {{ content() }}
      {{ partial('includes/footer') }}
   </body>
</html>