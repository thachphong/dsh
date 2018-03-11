<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Admin! | </title>    
    {{ partial('includes/header') }}
  </head>
  {% set login_info= elements.getuser()%}
  <body class="nav-md">    
    {{ partial('includes/pho_ajax') }}
    <div class="container body">
      <div class="main_container">        
        {{ partial('includes/left') }}
        <!-- top navigation -->
        <div class="top_nav">         
          {{ partial('includes/menu') }}
        </div>
        <!-- /top navigation -->

        <!-- page content -->
        {{ content() }}
        
        <!-- /page content -->

        <!-- footer content -->       
        {{ partial('includes/footer') }}
        <!-- /footer content -->
        
      </div>
    </div>
</body>
</html>
