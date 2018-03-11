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
                    <h2>Danh sách {{title}}<!--<small>Users</small>--></h2>
                    <ul class="nav navbar-rigth panel_toolbox" style="min-width: auto;">
                      {%if banner_flg==0%}
                      <li><button class="btn btn-primary" id="btn_new">Thêm mới</button></li>
                      {%endif%}
                     <!-- <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>-->
                      <!--<li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        <ul class="dropdown-menu" role="menu">
                          <li><a href="#">Settings 1</a>
                          </li>
                          <li><a href="#">Settings 2</a>
                          </li>
                        </ul>
                      </li>-->
                      <!--<li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>-->
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
                          <th>Ảnh</th> 
                          <th>Link đến trang</th>                       
                          <th>Hiện</th>
                          <th>Sửa</th> 
                          {%if banner_flg==0%}  
                          <th>Xóa</th> 
                          {%endif%}                        
                        </tr>
                      </thead>
                      <tbody id="fbody">
                      {%for key,item in slides%}
                      	<tr>
                          <td>{{key+1}}</td>
                          
                           
                          <td>
                          	<img id="img_disp" class="img-rounded" src="{{url.get('')}}{{item.img_path}}" width="220" height="100"/>
                          </td> 
                          <td>{{item.link_page}}</td>                        
                          <td>
                          	
                          	<span class="fa {%if item.del_flg == 1%}fa-square-o{%else%}fa-check-square{%endif%}" style="font-size: 16px;"></span>
                          	
                          </td>
                          <td>
                          	<button class="btn btn-warning btn-xs btn_edit" id="edit_{{item.slide_id}}">Sửa</button>
                          </td>
                          {%if banner_flg==0%}
                          <td>
                          	<button class="btn btn btn-danger btn-xs btn_delete" id="del_{{item.slide_id}}">Xóa</button>
                          </td>
                          {%endif%}
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
        	Pho_html_ajax('POST',"{{url.get('slide/edit/0')}}" ,{'banner_flg':'{{banner_flg}}'},function(html){
                
            	Pho_modal(html,"Thêm {{title}}",700);
            });
        	
        });
        $(document).off('click','.dialog_close'); 
        $(document).on('click','.dialog_close',function(event){        	
			Pho_modal_close("modal1");
        });
        $(document).off('click','#btn_save'); 
        $(document).on('click','#btn_save',function(event){
        	var msg = check_validate_update();
        	if(msg !=""){
        		Pho_message_box_error("Lỗi",msg);
        		return;
        	}
        	var arr = $('#form_ctg').serializeArray();	
         
			   Pho_json_ajax('POST',"{{url.get('slide/update')}}" ,arr,function(datas){
				if(datas.status =="OK"){
					Pho_modal_close("modal1");					
					Pho_direct("{{url.get('slide/list/')}}{{banner_flg}}");
				}else{
					Pho_message_box_error("Lỗi",datas.msg);
				}
                
            });
        });
        var check_validate_update = function(){        	
        	if($('#img_path').val()==''){
        		return "Bạn chưa upload ảnh !";
        	}      	
        	return "";
        };
        $(document).off('click','.btn_delete'); 
        $(document).on('click','.btn_delete',function(event){
        	var id = $(this).attr('id');
	        	id = id.replace("del_","");
	        var menu_name = $('#name_'+id).text();
        	Pho_message_confirm("Thông báo","Bạn có chắc chắn muốn xóa ảnh này ?",function(){
        		
				Pho_json_ajax('GET',"{{url.get('slide/delete/')}}" + id,null ,function(datas){
					if(datas.status == "OK"){
						Pho_direct("{{url.get('slide/list/')}}{{banner_flg}}");
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
            	Pho_html_ajax('GET',"{{url.get('slide/edit/')}}"+ id ,null,function(html){
                /*Pho_modal({
		        		template:html,
				        closeClick: false,
				        closable: true, 
				        modalid:"modal1",
				        size:'large'
		        	
            	});*/
            	Pho_modal(html,"Sửa {{title}}",700);
            });
        });
        
        
        $("#table_search").keyup(function(){		
	          $("#fbody").find("tr").hide();
	          var data = this.value.split(" ");	
	          var jo = $("#fbody").find("tr");
	          $.each(data, function(i, v){
	              jo = jo.filter("*:contains('"+v+"')");
	          });	        
	          jo.show();
	    })

        
});
</script>