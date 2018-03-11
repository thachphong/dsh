<!-- page content -->
        <div class="right_col" role="main" style="min-height: 600px">
          <div class="">           

            <div class="clearfix"></div>

            <div class="row">              
        <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Danh sách trang<!--<small>Users</small>--></h2>
                    <ul class="nav navbar-rigth panel_toolbox" style="min-width: auto;">
                      <li><button class="btn btn-primary" id="btn_new">Thêm mới</button></li>
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
          <div class="row">
                      <div class="col-sm-12">
                      <thead>
                        <tr>
                          <th>STT</th>
                          <th>Tên Trang</th>
                          <!-- <th>Hiển ở trang chủ</th> -->
                          <th>Hiện</th>
                          <th>Sửa</th>
                          <th>Xóa</th>                        
                        </tr>
                      </thead>
                      <tbody id="fbody">
                      {%for key,item in pages%}
                        <tr>
                          <td>{{key+1}}</td> 
                          <td id="name_{{item['page_id']}}">{{item['page_name']}}</td>                          
                          <td>                            
                            <span class="fa {%if item['del_flg'] == 1%}fa-square-o{%else%}fa-check-square{%endif%}" style="font-size: 16px;"></span>                            
                          </td>
                          <td>
                            <a class="btn btn-warning btn-xs btn_edit" href="{{url.get('page/edit/')}}{{item['page_id']}}">Sửa</a>
                          </td>
                          <td>
                            <button class="btn btn btn-danger btn-xs btn_delete" id="del_{{item['page_id']}}">Xóa</button>
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
    
    $(document).off('click','#btn_new'); 
        $(document).on('click','#btn_new',function(event){
            location.href="{{url.get('page/edit/0')}}";         
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
          Pho_message_confirm("Thông báo","Bạn có chắc chắn muốn xóa sản phẩm: ["+menu_name+"] ?",function(){
            
        Pho_json_ajax('GET',"{{url.get('page/delete/')}}" + id,null ,function(datas){
          if(datas.status == "OK"){
            Pho_direct("{{url.get('page')}}");
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
            location.href="{{url.get('page/edit/')}}"+id;
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