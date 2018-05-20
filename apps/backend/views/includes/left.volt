        <div class="col-md-3 left_col">
          <div class="left_col scroll-view">
            <div class="navbar nav_title" style="border: 0;">
              <a href="index.html" class="site_title" style="background: #172d44"><i class="fa fa-paw"></i> <span>Admin tool!</span></a>
            </div>

            <div class="clearfix"></div>

            <!-- menu profile quick info -->
            <!--<div class="profile clearfix">
              <div class="profile_pic">
                <img src="{{url.get('templateadm/images/user.png')}}" alt="..." class="img-circle profile_img">
              </div>
              <div class="profile_info">
                <span>Welcome,</span>
                <h2>{{login_info.user_name}}</h2>
              </div>
            </div>-->
            <!-- /menu profile quick info -->
       

            <!-- sidebar menu -->
            <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
              <div class="menu_section">
                <!--<h3>General</h3>-->
                <ul class="nav side-menu">
                  <li><a href="{{url.get('')}}" target="_blank"><i class="fa fa-home"></i> Xem website <span class="fa"></span></a>
                    <!--<ul class="nav child_menu">
                      <li><a href="index.html">Dashboard</a></li>
                      <li><a href="index2.html">Dashboard2</a></li>
                      <li><a href="index3.html">Dashboard3</a></li>
                    </ul>-->
                  </li>
                  <li><a ><i class="fa fa-bars"></i> Menu <span class="fa fa-chevron-down"></span></a>
                      <ul class="nav child_menu">
                        <li><a href="{{url.get('menu/list/1/0')}}">Memu chính cấp 1</a></li>
                        <li><a href="{{url.get('menu/list/2/0')}}">Memu chính cấp 2</a></li>
                        <li><a href="{{url.get('menu/list/3/0')}}">Memu chính cấp 3</a></li>
                        <li><a href="{{url.get('menu/list/1/1')}}">Memu phụ</a></li>                       
                      </ul> 
                  </li>                  
                  <li><a ><i class="fa fa-cube"></i>Danh mục - Sản phẩm <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="{{url.get('category/list/1/0')}}">Danh mục cấp 1</a></li>
                      <li><a href="{{url.get('category/list/2/0')}}">Danh mục cấp 2</a></li>
                      <li><a href="{{url.get('category/list/3/0')}}">Danh mục cấp 3</a></li>
                      <li><a href="{{url.get('product')}}">Sản phẩm</a></li>   
                      <li><a href="{{url.get('product?del_flg=1')}}">Duyệt Sản phẩm</a></li>                    
                    </ul>
                  </li>
                  <li><a href="{{url.get('page')}}"><i class="fa fa-file-powerpoint-o"></i> Trang <span class="fa"></span></a></li>
                  <li><a><i class="fa fa-newspaper-o"></i> Tin tức <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="{{url.get('category/list/1/1')}}">Danh mục tin cấp 1</a></li>
                      <li><a href="{{url.get('category/list/2/1')}}">Danh mục tin cấp 2</a></li>
                      <li><a href="{{url.get('news')}}">Tin tức</a></li>                     
                    </ul>
                  </li>
                  <!--<li><a><i class="fa fa-newspaper-o"></i> Dự án <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="{{url.get('category/project')}}">Loại dự án</a></li>
                      <li><a href="{{url.get('project')}}">Dự án</a></li>
                    </ul>
                  </li>-->
                  <li><a><i class="fa fa-sliders"></i> Slide - Banner <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="{{url.get('slide/list/0')}}">Slide</a></li>
                      <li><a href="{{url.get('slide/list/1')}}">Banner</a></li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-sliders"></i>Thông tin đường phố<span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="{{url.get('street')}}">Đường phố</a></li>
                    </ul>
                  </li>
                  <li><a href="{{url.get('useradm/list')}}"><i class="fa fa-group"></i> Tài khoản <span class="fa"></span></a></li>                  
                  <li><a><i class="fa fa-gear"></i> Cài đặt <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="{{url.get('define/list/1')}}">Thông tin công ty</a></li>                      			  <li><a href="{{url.get('define/list/5')}}">Đơn gia đăng tin</a></li>
                      <li><a href="{{url.get('define/list/2')}}">Fan page</a></li>
                      <li><a href="{{url.get('define/list/3')}}">Thông tin website</a></li>
                      
                      <li><a href="{{url.get('define/list/4')}}">Khác</a></li>
                      <!--<li><a href="{{url.get('define/logo')}}">Logo</a></li>-->
                      <!-- <li><a href="{{url.get('define/email')}}">Email nhận thông báo</a></li> -->                  
                      <!--<li><a href="tables_dynamic.html">Message</a></li>-->
                    </ul>
                  </li>
                  <li><a><i class="fa fa-chevron-down"></i> Auto Download <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="{{url.get('download/dlbyurl')}}">Download</a></li>                             
                      <li><a href="{{url.get('downloadctg/index')}}">Categpry Download</a></li>
                      <li><a href="{{url.get('downloadstructure/index')}}">Structure Download</a></li>
                      
                    </ul> 
                  </li>
                
                  <!-- <li><a ><i class="fa fa-gears"></i> Template <span class="fa fa-chevron-down"></span></a>
                      <ul class="nav child_menu">
                          <li><a href="{{url.get('template/list')}}">Template </a></li>                       
                        <li><a href="{{url.get('template')}}">Template general</a></li>
                        <li><a href="{{url.get('template/mod')}}">Template module</a></li>
                        <li><a href="{{url.get('templatecontent')}}">Template content</a></li>                 
                        <li><a href="{{url.get('template/create')}}">Create</a></li>
                      </ul>   
                  </li> -->
                  
                </ul>
              </div>
            </div>
            <!-- /sidebar menu -->

            <!-- /menu footer buttons -->
            <div class="sidebar-footer hidden-small">
              <a data-toggle="tooltip" data-placement="top" title="Settings">
                <span class="glyphicon glyphicon-cog" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="FullScreen">
                <span class="glyphicon glyphicon-fullscreen" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="Lock">
                <span class="glyphicon glyphicon-eye-close" aria-hidden="true"></span>
              </a>
              <a data-toggle="tooltip" data-placement="top" title="Logout" href="login.html">
                <span class="glyphicon glyphicon-off" aria-hidden="true"></span>
              </a>
            </div>
            <!-- /menu footer buttons -->
          </div>
        </div>

       
