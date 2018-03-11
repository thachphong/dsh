<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">  
    <title>Admin - login</title>

    {{ partial('includes/header') }}
    
  </head>

  <body class="login">
    <div>
      <a class="hiddenanchor" id="signup"></a>
      <a class="hiddenanchor" id="signin"></a>

      <div class="login_wrapper">
        <div class="animate form login_form">
          <section class="login_content">
            <form id="form_login" action="" method="post" enctype="multipart/form-data">
            
              <h1>{{lang['LOG006']}}</h1>
              <div>
                <input type="text" class="form-control" name="email" placeholder="{{lang['LOG002']}}" required="" />
              </div>
              <div>
                <input type="password" class="form-control" name="password" placeholder="{{lang['LOG003']}}" required="" />
              </div>
              <div>
            
                <input class="btn btn-default submit" type="button" id="action_login" value="{{lang['LOG006']}}" style="float: none"/>
                <!--<a class="reset_pass" href="#">Lost your password?</a>-->
              </div>
        
              <div class="clearfix"></div>
        <!-- if count($acw_error) > 0%><%if isset($acw_error.ip)%><%$acw_error.ip%><%else%><%$acw_error.message%><%/if%><%/if%> -->
              <!--<div class="separator">
                <p class="change_link">New to site?
                  <a href="#signup" class="to_register"> Create Account </a>
                </p>

                <div class="clearfix"></div>
                <br />-->

                <!--<div>
                  <h1><i class="fa fa-paw"></i> Admin!</h1>
                  <p>©2016 All Rights Reserved. Gentelella Alela! is a Bootstrap 3 template. Privacy and Terms</p>
                </div>-->
              </div>
            </form>
          </section>
        </div>

        <div id="register" class="animate form registration_form">
          <section class="login_content">
            <form>
              <h1>Create Account</h1>
              <div>
                <input type="text" class="form-control" placeholder="Username" required="" />
              </div>
              <div>
                <input type="email" name="email" class="form-control" placeholder="Email" required="" />
              </div>
              <div>
                <input type="password" name="password" class="form-control" placeholder="Password" required="" />
              </div>
              <div>
                <a class="btn btn-default submit" href="login/authoradmin" style="float: none">Submit</a>
              </div>

              <div class="clearfix"></div>

              <div class="separator">
                <p class="change_link">Already a member ?
                  <a href="#signin" class="to_register"> Log in </a>
                </p>

                <div class="clearfix"></div>
                <br />

                <div>
                  <h1><i class="fa fa-paw"></i> Gentelella Alela!</h1>
                  <p>©2016 All Rights Reserved. Gentelella Alela! is a Bootstrap 3 template. Privacy and Terms</p>
                </div>
              </div>
            </form>
          </section>
        </div>
      </div>
    </div>
    {{ partial('includes/pho_ajax') }}
  <script>
    
    $(document).ready(function() {
     
        $(document).on('click','#action_login',function(){
            var arr =  {email:$('#email').val(),password:$('#password').val()};//$('#form_login').serializeArray(); 
            var arr = $('#form_login').serializeArray();
            //var $arr = new FormData();//$('#form_login').serializeArray();
            //arr.push({name: 'email', value: $('#email').val()});     
            //arr.push({name: 'password', value: $('#password').val()});     
            console.log(arr);
            //var _data = {email:'admin',password:'admin'};
            Pho_json_ajax('POST',"{{url.get('loginadm/auth')}}" ,arr,function(data){
                if(data.status =='OK'){
                    //Pho_message_box('Thông báo',data.msg, function(){
                        window.location.href="{{url.get('admin')}}";
                    //}); 
                }else{
                    Pho_message_box_error('Lỗi',data.msg);
                }
            });
        });
        $("#password").keydown(function (e) {         
            if (e.keyCode == 13) {
              $('#action_login').click();
            }
    });
        
    });
  </script>
  </body>
</html>
