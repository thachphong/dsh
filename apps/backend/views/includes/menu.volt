   
          <div class="nav_menu">
            <nav>
              <div class="nav toggle">
                <a id="menu_toggle"><i class="fa fa-bars"></i></a>
                
              </div>
			  <div class="col-md-4" style="margin-top: 10px;">
			  	 <button class="btn btn-warning" id="delete_cache">Xóa cache</button>
			  	 <label style="color: #0000ff; display: none;" id="msg_delete_cache">Xóa cache thành công</label>
			  </div>
              <ul class="nav navbar-nav navbar-right" style="width: 40%">
                <li class="">
                  <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    <img src="{{url.get('templateadm/images/user.png')}}" alt="">{{login_info.user_name}}
                    <span class=" fa fa-angle-down"></span>
                  </a>
                  <ul class="dropdown-menu dropdown-usermenu pull-right">
                    <!--<li><a href="javascript:;"> Profile</a></li>
                    <li>
                      <a href="javascript:;">
                        <span class="badge bg-red pull-right">50%</span>
                        <span>Settings</span>
                      </a>
                    </li>
                    <li><a href="javascript:;">Help</a></li>-->
                    <li><a href="{{url.get('loginadm/logout')}}"><i class="fa fa-sign-out pull-right"></i>Thoát</a></li>
                  </ul>
                </li>
              </ul>
            </nav>
          </div>
<script>
$(document).ready(function() {    	
		$(document).off('click','#delete_cache'); 
        $(document).on('click','#delete_cache',function(event){
        	Pho_html_ajax('POST',"{{url.get('admin/delcache')}}" ,{'silde_id':''},function(html){  
            	Pho_message_box("Thông báo","Xóa cache thành công!");
            });
        	
        });
});
</script>
       