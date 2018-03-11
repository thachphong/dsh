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
        <div class="right_col" role="main" style="min-height: 600px">
          <div class="">
            <div class="clearfix"></div>

            <div class="row">              
        <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Danh sách tin<!--<small>Users</small>--></h2>
                    <ul class="nav navbar-rigth panel_toolbox" style="min-width: auto;">
                      <li><button class="btn btn-primary" id="btn_new">Thêm mới</button></li>
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
          <div class="row">
                      <div class="col-sm-12">
                      <thead>
                        <tr>
                          <th>STT</th>
                          <th>Loại dự án</th>
                          <th>Tên dự án</th>
                          <th>Hiện</th>
                          <th>Sửa</th>
                          <th>Xóa</th>                        
                        </tr>
                      </thead>
                      <tbody id="fbody">
                      {%for key,item in news%}
                        <tr>
                          <td>{{key+1}}</td> 
                          <td>{{item['ctg_name']}}</td>
                          <td id="name_{{item['project_id']}}">{{item['project_name']}}</td>
                          <td>                            
                            <span class="fa {%if item['del_flg'] == 1%}fa-square-o{%else%}fa-check-square{%endif%}" style="font-size: 16px;"></span>                            
                          </td>
                          <td>
                            <a class="btn btn-warning btn-xs btn_edit" href="{{url.get('project/edit/')}}{{item['project_id']}}">Sửa</a>
                          </td>
                          <td>
                            <button class="btn btn btn-danger btn-xs btn_delete" id="del_{{item['project_id']}}">Xóa</button>
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

        <!-- footer content -->       
        {{ partial('includes/footer') }}
        <!-- /footer content -->
        
      </div>
    </div>
    <script>
  $(document).ready(function() {
    
    $(document).off('click','#btn_new'); 
        $(document).on('click','#btn_new',function(event){
          location.href="{{url.get('project/edit/0')}}";         
        });
        $(document).off('click','.dialog_close'); 
        $(document).on('click','.dialog_close',function(event){         
      Pho_modal_close("modal1");
        });
        
        $(document).off('click','.btn_delete'); 
        $(document).on('click','.btn_delete',function(event){
          var id = $(this).attr('id');
            id = id.replace("del_","");
          var menu_name = $('#name_'+id).text();
          Pho_message_confirm("Thông báo","Bạn có chắc chắn muốn xóa tin: ["+menu_name+"] ?",function(){
            
        Pho_json_ajax('GET',"{{url.get('project/delete/')}}" + id,null ,function(datas){
          if(datas.status == "OK"){
            Pho_direct("{{url.get('project')}}");
          }else{
            Pho_message_box_error("Lỗi",datas.msg);
          }
                  
              });
          });         
        });
        
        $(document).off('click','.btn_edit'); 
        $(document).on('click','.btn_edit',function(event){
          var id = $(this).attr('id');
            id = id.replace("edit_","");  
            location.href="{{url.get('project/edit/')}}"+id;
        });
        
        
        $("#table_search").keyup(function(){
    //hide all the rows
      //alert('sss');
            $("#fbody").find("tr").hide();

    //split the current value of searchInput
            var data = this.value.split(" ");
    //create a jquery object of the rows
            var jo = $("#fbody").find("tr");
            
    //Recusively filter the jquery object to get results.
            $.each(data, function(i, v){
                jo = jo.filter("*:contains('"+v+"')");
            });
          //show the rows that match.
            jo.show();
       //Removes the placeholder text  
     
        });    
        
    });
</script>
</body>
</html>


         
  

