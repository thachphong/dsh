
<html lang="en" id="site" dir="ltr">
	<head>
        <meta charset="utf-8">
       
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Your invoices">
        <meta name="author" content="Phalcon Team">
        <link rel='stylesheet' id='Roboto-css'  href='http://fonts.googleapis.com/css?family=Roboto' type='text/css' media='all' />        
        {{ stylesheet_link('templateadm/css/bootstrap.min.css') }}
        {{ stylesheet_link('templateadm/css/jquery.modal.css') }}
        
        {{ javascript_include('templateadm/js/jquery-1.9.1.js') }}
        
        {{ javascript_include('templateadm/js/jquery.modal.js') }}
        
    </head>
	<body>		
        <!--<div id="page">-->      
         {{ partial('includes/pho_ajax') }}         
        {{ content() }}   
        <!--</div>-->
	</body>
</html>
