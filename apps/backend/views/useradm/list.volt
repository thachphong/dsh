<!-- page content -->
        <div class="right_col" role="main" style="min-height: 600px">
          <div class="">
            <!--<div class="page-title">
              <div class="title_left">
                <h3>Quản lý danh mục </h3>
              </div>

              <div class="title_right">
                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                  <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search for...">
                    <span class="input-group-btn">
                      <button class="btn btn-default" type="button">Go!</button>
                    </span>
                  </div>
                </div>
              </div>
            </div>-->

            <div class="clearfix"></div>

            <div class="row">              
			  <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Danh sách tài khoản<!--<small>Users</small>--></h2>
                    <ul class="nav navbar-rigth panel_toolbox" style="min-width: auto;">
                      <!--<li><button class="btn btn-primary" id="btn_new">Thêm mới</button></li>-->
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                     
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <div class="row">
                    	<div class="col-sm-6">
                    	</div>
                    	<div class="col-sm-6">
                    		
                    		<div class="dataTables_filter" style="margin-bottom: 10px">
                    		<label style="margin: 5px 5px 0px 0;">Tìm</label>
                        	<input type="search" id="table_search" class="form-control input-sm" style="float: right;width: 88%">
                        	</div>                      	
                        </div>
                    </div>
					
                    <table id="datatable-responsive" class="table table-striped table-bordered dt-responsive nowrap" cellspacing="0" width="100%">
					<thead>
                        <tr>
                          <th>Tên đăng nhập</th>
                          <th>Họ và tên</th>
                          <th>Email</th>
                          <th>Điện thoại</th>
                          <th>Loại user</th>                        
                          <th>Phân quyền</th>
                          <th>KHóa tài khoản</th>                          
                        </tr>
                      </thead>
                      <tbody id="fbody">
                      {%for item in list%}
                      	<tr>
                          <td>{{item['user_no']}}</td>
                          <td>{{item['user_name']}}</td>
                          <td>{{item['email']}}</td>
                          <td>{{item['mobile']}}</td>
                          <td>{{item['level_name']}}</td>
                          <!--<td><button class="btn btn-info btn-xs btn_editpass" id="pass_<%$item.user_id%>">Đổi mật khẩu</button></td>-->
                          <td><!--<button class="btn btn-warning btn-xs btn_edit" id="edit_{{item['user_id']}}">Sửa</button>-->
                          {%if item['level']==0%}
                          	  <a class="btn btn-info btn-xs btn_edit" href="{{url.get('useradm/toadmin/')}}{{item['user_id']}}">Nâng cấp thành admin</a>
                          {%else%}
                          	  <a class="btn btn-warning btn-xs btn_edit" href="{{url.get('useradm/tonormal/')}}{{item['user_id']}}">Hạ xuống thường</a>
                          {%endif%}
                          	
                          </td>
                          <td>
                          	{%if item['del_flg']==0%}
                          	  <a class="btn btn-warning btn-xs btn_edit" href="{{url.get('useradm/lock/')}}{{item['user_id']}}">Khóa tài khoản</a>
                            {%else%}
                          	  <a class="btn btn-info btn-xs btn_edit" href="{{url.get('useradm/unlock/')}}{{item['user_id']}}">Mở khóa</a>
                          {%endif%}
                          </td>
                        </tr>
                      {%endfor%}                        
                      </tbody>
                    </table>
                    
                    </div>
					</div>
					
                  </div>
                </div>
              </div>
            	
            </div>
          </div>
        
        </div>
        <!-- /page content -->
<script>
$(document).ready(function() {
	$("#table_search").keyup(function(){		
	    $("#fbody").find("tr").hide();
	    var data = this.value.split(" ");		
	    var jo = $("#fbody").find("tr");	          
	    $.each(data, function(i, v){
	        jo = jo.filter("*:contains('"+v+"')");
	    });	       
	    jo.show();
	});
	$(document).off('click','.btn_edit'); 
        $(document).on('click','.btn_edit',function(event){
        	var id = $(this).attr('id');
	        	id = id.replace("edit_","");			
            	Pho_html_ajax('GET',"<%$smarty.const.ACW_BASE_URL%>user/edit/"+ id ,null,function(html){
            	Pho_modal(html,"Sửa thông tin tài khoản",600);
            });
        });
});
</script>