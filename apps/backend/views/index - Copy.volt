
<html lang="en" id="site" dir="ltr">
	<head>
        <meta charset="utf-8">
       
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Your invoices">
        <meta name="author" content="Phalcon Team">
        <link rel='stylesheet' id='Roboto-css'  href='http://fonts.googleapis.com/css?family=Roboto' type='text/css' media='all' />        
        {{ stylesheet_link('templateadm/css/jquery.modal.css') }}
        {{ stylesheet_link('templateadm/css/bootstrap.min.css') }}
        
        
        {{ javascript_include('templateadm/js/jquery-1.10.2.min.js') }}
        {{ javascript_include('templateadm/js/bootstrap.min.js') }}
        {{ javascript_include('templateadm/js/jquery.modal.js') }}
        
    </head>
	<body>		
        <!--<div id="page">-->      
        {{ partial('includes/pho_ajax') }}
        {{ partial('includes/menu') }}
        <!--</div>-->
        <div align="center">
		{{ content() }}

	

		</div>
			
		<div class="navbar navbar-inverse navbar-fixed-bottom" role="navigation">
		    
		<div class="container">
		    <div class="navbar-text pull-left">Copy right 2016</div>
		</div>
		</div>
	</body>
</html>
