<div class="right_col" role="main">
          <div class="">
            
			
            <div class="clearfix"></div>

            <div class="row">              
			  <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Danh sách<!--<small>Users</small>--></h2>                    
                    <ul class="nav navbar-right panel_toolbox">
                      <li><button type="button" class="btn btn-primary btn-sm" id="btn_new">Thêm mới</button></li>
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                      
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <!--<p class="text-muted font-13 m-b-30">
                      Responsive is an extension for DataTables that resolves that problem by optimising the table's layout for different screen sizes through the dynamic insertion and removal of columns from the table.
                    </p>-->
					
                    <table id="datatable-responsive" class="table table-striped table-bordered dt-responsive nowrap" cellspacing="0" width="100%">
                      <thead>
                        <tr>      
                          <th>Danh mục</th>                    
                          <th>Nguồn download</th>
                          <th>Sử dụng</th> 
                          <th>Sửa</th>
                          <th>Xóa</th>                         
                        </tr>
                      </thead>
                      <tbody>
                      {%if list != null %}
                      {% for item in list %}
                      	<tr> 
                          <td>{{item['ctg_name']}}</td>                       
                          <td>{{item['link']}}</td>                          
                          <td>
                            <span class="fa {%if item['status'] == 0%}fa-square-o{%else%}fa-check-square{%endif%}" style="font-size: 16px;"></span>
                          </td>  
                          <td>
                            <button class="btn btn-warning btn-xs btn_edit" id="edit_{{item['id']}}">Sửa</button>
                          </td>
                          <td>
                            <button class="btn btn btn-danger btn-xs btn_delete" id="del_{{item['id']}}">Xóa</button>
                          </td>
                        </tr>
                      {% endfor %}  
                      {%endif%}                      
                      </tbody>
                    </table>
					
					
                  </div>
                </div>
              </div>
            	
            </div>
          </div>
        
</div>

<script>
$(document).ready(function() {
    $(document).off('click','.btn_edit'); 
    $(document).on('click','.btn_edit',function(event){
        var id = $(this).attr('id');
        id = id.replace("edit_","");      
        Pho_html_ajax('GET',"{{url.get('downloadctg/edit/')}}"+ id ,null,function(html){
            Pho_modal(html,"Sửa Danh mục",700);
        });
    });
    $(document).off('click','#btn_new'); 
    $(document).on('click','#btn_new',function(event){
        Pho_html_ajax('POST',"{{url.get('downloadctg/edit/0')}}" ,null,function(html){
                
          Pho_modal(html,"Thêm danh mục download",700);
        });
    });
    $(document).off('click','.btn_delete'); 
    $(document).on('click','.btn_delete',function(event){
          var id = $(this).attr('id');
            id = id.replace("del_","");     
      Pho_message_confirm("Thông báo","Bạn có chắc chắn muốn xóa dòng này ?",function(){
            
        Pho_json_ajax('GET',"{{url.get('downloadctg/delete/')}}" + id,null ,function(datas){
          if(datas.status == "OK"){
            Pho_direct("{{url.get('downloadctg/index')}}");
          }else{
            Pho_message_box_error("Lỗi",datas.msg);
          }                  
        });
      });
          
    });
		$(document).off('click','.dialog_close'); 
    $(document).on('click','.dialog_close',function(event){         
      Pho_modal_close("modal1");
    });
    $(document).off('click','#btn_save'); 
    $(document).on('click','#btn_save',function(event){
          /*var msg = check_validate_update();
          if(msg !=""){
            Pho_message_box_error("Lỗi",msg);
            return;
          }*/
        var arr = $('#form_ctg').serializeArray();  
         
        Pho_json_ajax('POST',"{{url.get('downloadctg/update')}}" ,arr,function(datas){
          if(datas.status =="OK"){
            Pho_modal_close("modal1");          
            Pho_direct("{{url.get('downloadctg/index')}}");
          }else{
            Pho_message_box_error("Lỗi",datas.msg);
          }
                
        });
    });
});
</script>
        
