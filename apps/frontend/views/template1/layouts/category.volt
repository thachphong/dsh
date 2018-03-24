<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <meta http-equiv=”Content-Type” content=”text/html; charset=ISO-8859-1″>
	  <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1,maximum-scale=1">
	  {% set define= elements.get_define()%}
	 
	  <meta name="description" content=" content="{{description}}, kinh doanh online không cần vốn, chiết khấu cao, dropshoping việt Nam">
	  <meta property="og:site_name" content="{{sitename}}">
	  <meta name="og:type" content="product" />
      <meta property="og:title" content="{{title}} | {{sitename}}">
      <meta property="og:description" content="{{description}}, kinh doanh online không cần vốn, chiết khấu cao, dropshoping việt Nam">       <meta property="og:url" content="{{baseurl}}{{ctg_no}}" />

     <!-- <meta property="og:image" content="/images/logo.png"> -->
      <title>{{title}} | {{sitename}}</title>
      {{ partial('includes/header') }}        
   </head>
   <body>
      {{ partial('includes/menu') }}
      {{ content() }}
      {{ partial('includes/footer') }}
   </body>
</html>