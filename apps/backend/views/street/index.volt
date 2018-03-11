<style>
	.pager .active a{
		 background-color: rgba(10, 75, 166, 0.86);
    		color: #fff;
	}
	.pager .active a:hover{		 
    	color: #000;
	}
</style>
<div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              
            </div>
            
            <div class="clearfix"></div>

            <div class="row">              
			  <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Danh sách đường phố</h2>                    
                    <ul class="nav navbar-right panel_toolbox">
                      <li><button type="button" class="btn btn-primary btn-sm" id="btn_new">Thêm mới</button></li>
                                          
                      
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <form method="GET" action="{{url.get('street')}}">
                    <div class="row form-group">
                    	<label class="col-sm-2">Tỉnh/Thành Phố</label>
                    	<div class="col-sm-2">
                    		<select class="form-control" name="m_provin_id" id="m_provin_id">
                    			<option value=""></option>
								{%for item in provincials%}
									<option value="{{item.m_provin_id}}" {%if m_provin_id == item.m_provin_id%}selected{%endif%}>{{item.m_provin_name}}</option>
								{%endfor%}
                    		</select>                		
                    	</div>                    	
                    	<label class="col-sm-1">Quận/Huyện</label>
                    	<div class="col-sm-3">
                    		<select id="m_district_id" class="form-control" name="m_district_id">
								<option value=""></option>
							</select>
                    	</div> 
                    	<div class="col-sm-1">
							<input class="btn btn-info" id="btn_find" type="submit" value="Tìm">
						</div>                   	                   	
                    </div>					
					</form>
					
                    <table id="datatable-responsive" class="table table-striped table-bordered dt-responsive nowrap" cellspacing="0" width="100%">
                      <thead>
                        <tr>
                          <th>Mã đường phố</th>
                          <th>Tỉnh/Thành Phố</th>
                          <th>Quận Huyện</th>
                          <th>Tên đường phố</th>
                          <th>Sửa</th>
                          <th>Xóa</th>                         
                        </tr>
                      </thead>
                      <tbody>
                      {%if list is defined %}
                      {% for item in list %}
                      	<tr>             
                      	  <td>{{item['m_street_id']}}</td>             
                          <td>{{item['m_provin_name']}}</td>
                          <td>{{item['m_district_name']}}</td>
                          <td id="name_{{item['m_street_id']}}">{{item['m_street_name']}}</td>
                          <td>
                          	<button class="btn btn-warning btn-xs btn_edit" id="edit_{{item['m_street_id']}}">Sửa</button>
                          </td>                         
                          <td>
                          	<button class="btn btn btn-danger btn-xs btn_delete" id="del_{{item['m_street_id']}}">Xóa</button>
                          </td>                    
                        </tr>
                      {% endfor %}  
                      {%endif%}                      
                      </tbody>
                    </table>
					{%if total_page > 1%}
         <div class="row margin_top" >
            <div class="col-md-12 col-sm-12 col-xs-12" style="display: flex;justify-content: center;">
               <ul class="pager">
                  {%if page > 1%}
                     <li><a href="{{url.get('')}}{{ctg_no}}page=1">Trang đầu</a></li>
                     <li><a href="{{url.get('')}}{{ctg_no}}page={{(page-1)}}">Trang trước</a></li>
                  {%endif%}                 
                  
                  {%for i in  start..end%} 
                    <li {%if page == i%}class="active"{%endif%}><a href="{%if page != i%}{{url.get('')}}{{ctg_no}}page={{i}}{%else%}#{%endif%}">{{i}}</a></li>
                  {%endfor%}
                  {%if page < total_page%}
                     <li><a href="{{url.get('')}}{{ctg_no}}page={{page+1}}">Trang sau</a></li>
                     <li><a href="{{url.get('')}}{{ctg_no}}page={{total_page}}">Trang cuối</a></li>
                  {%endif%}       
               </ul>
            </div>
         </div>
         {%endif%}
					
                  </div>
                </div>
              </div>
            	
            </div>
          </div>
        
</div>
<script>    
    
    $(document).ready(function() {
    	var district_list = Array();
    	{%for item in districts%}
			district_list.push(['{{item.m_district_id}}',"{{item.m_district_name}}",'{{item.m_provin_id}}']);
		{%endfor%}
		$(document).off('change','#m_provin_id');
		$(document).on('change','#m_provin_id',function(){			
			change_district_option('');			
		});
		var change_district_option= function(district_id){
			var val = $('#m_provin_id').val();
			var option = '<option value=""></option>';
			$.each(district_list,function(key,item){
				//console.log(item);
				if(val == item[2]){
					if(district_id == item[0] ){
						option +='<option value="'+item[0]+'" selected >'+item[1]+'</option>';
					}else{
						option +='<option value="'+item[0]+'" >'+item[1]+'</option>';
					}					
				}
			});
			$('#m_district_id').empty();
			$('#m_district_id').append(option);
		};
		change_district_option('{{m_district_id}}');
		$(document).off('click','#btn_new'); 
        $(document).on('click','#btn_new',function(event){
        	Pho_html_ajax('POST',"{{url.get('street/new')}}" ,{'silde_id':''},function(html){
                /*Pho_modal({
		        		template:html,
				        closeClick: false,
				        closable: true, 
				        modalid:"modal1",
				        size:'large'
		        	
            });*/
            	Pho_modal(html,"Thêm mới đường phố",700);
            });
        	
        });
        $(document).off('click','.btn_delete'); 
        $(document).on('click','.btn_delete',function(event){
        	var id = $(this).attr('id');
	        	id = id.replace("del_","");
	        var menu_name = $('#name_'+id).text();
        	Pho_message_confirm("Thông báo",'Bạn có chắc chắn muốn xóa đường phố "'+menu_name+'" ?',function(){
        		
				Pho_json_ajax('GET',"{{url.get('street/delete/')}}" + id,null ,function(datas){
					if(datas.status == "OK"){
						Pho_direct("{{url.get('street')}}");
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
            	Pho_html_ajax('GET',"{{url.get('street/edit/')}}"+ id ,null,function(html){  
            	Pho_modal(html,"Sửa đường phố",700);
            });
        });
        $(document).off('click','.dialog_close'); 
        $(document).on('click','.dialog_close',function(event){        	
			Pho_modal_close("modal1");
			Pho_direct(location.href);
        });
    });
</script>