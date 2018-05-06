<div class="right_col" role="main" style="min-height: 600px">
          <div class="">
            <div class="clearfix"></div>

            <div class="row">              
        <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Danh sách danh mục <!--<small>Users</small>--></h2>
                    <ul class="nav navbar-rigth panel_toolbox" style="min-width: auto;">
                      <li><label style="padding-top: 5px;">Tìm</label></li>
                      <li><input type="search" id="table_search" class="form-control input-sm" style="float: right;width: 88%"></li>
                      
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <div class="row">
                      <div class="col-sm-8">
                      <ul class="nav navbar-left panel_toolbox" > 
                      {%if level_flg > 1%} 
                        <li><label style="padding: 5px 10px  ">Danh mục cấp 1</label></li>                      
                        <li><select class="form-control" id="level_1">
                            <option value=""></option>
                            {%for pa in parent_list1%}
                            	{%if lv1 == pa['ctg_id']%}
                              		<option value="{{pa['ctg_id']}}" selected>{{pa['ctg_name']}}</option>
                              	{%else%}
                              		<option value="{{pa['ctg_id']}}">{{pa['ctg_name']}}</option>
                              	{%endif%}
                            {%endfor%}
                        </select>
                        </li>
                      {%endif%}
                      {%if level_flg > 2%}                     
                        <li><label style="padding: 5px 10px ">Danh mục cấp 2</label></li>                      
                        <li><select class="form-control" id="level_2">
                          <option value=""></option>                            
                        </select>
                        </li>
                        {%endif%}
                      </ul>
                      </div>
                      <div class="col-sm-4">
                        
                        <div class="dataTables_filter" style="margin-bottom: 10px">
                          <button class="btn btn-primary" id="btn_new">Thêm mới</button>
                          </div>                        
                        </div>
                    </div>
          
                    <!--<table id="datatable-responsive" class="table table-striped table-bordered dt-responsive nowrap" cellspacing="0" width="100%">-->
                    <div class="row">
                      <div class="col-sm-12">
                    <table id="datatable-fixed-header" class="table table-striped table-bordered">
                      <thead>
                        <tr>
                          <th>STT</th>
                          <th>Mã danh mục</th>
                          {%if news_flg != 1%}
                         <!--  <th>Loại bất động sản</th> -->
                          {%endif%}
                          {%if level_flg == 2%}
                              <th >Danh mục cấp 1</th>    
                          {%elseif level_flg == 3%}
                              <th >Danh mục cấp 1</th>
                              <th >Danh mục cấp 2</th>
                          {%endif%}                          
                          <th>Tên Danh mục</th>
                          <th>Hiện</th>
                          <th>Sửa</th>   
                          <th>Xóa</th>                         
                        </tr>
                      </thead>
                      <tbody id="fbody">
                      {%for item in category%}
                        <tr>
                          <td>{{item['sort']}}</td>
                          <td>{{item['ctg_code']}}</td>
                          {%if news_flg != 1%}
                          <!-- <th>item['m_type_name']</th> -->
                          {%endif%} 
                          {%if level_flg == 2%}
                              <td>{{item['ctg_name_1']}}</td>   
                          {%elseif level_flg == 3%}
                              <td>{{item['ctg_name_2']}}</td>
                              <td>{{item['ctg_name_1']}}</td>
                          {%endif%}
                           
                          <td >{{item['ctg_name']}}({{item['cnt_pro']}})</td>
                          <td>
                            
                            <span class="fa {%if item['del_flg'] == 1%}fa-square-o{%else%}fa-check-square{%endif%}" style="font-size: 16px;"></span>
                            
                          </td>
                          <td>
                            <button class="btn btn-warning btn-xs btn_edit" id="edit_{{item['ctg_id']}}">Sửa</button>
                          </td>
                          <td>
                            <button class="btn btn btn-danger btn-xs btn_delete" id="del_{{item['ctg_id']}}">Xóa</button>
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
<script>
  $(document).ready(function() {
    var news_flg ="{{news_flg}}";
    var action ="";
    var list_level2= '{%if parent_list2 is defined %}{{parent_list2}}{%endif%}';
    if(list_level2.length > 0){
      list_level2 = JSON.parse(list_level2);
    }
    
    var change_option_2= function(val,val_sel){
      var str_op = '<option value=""></option>';
      //console.log(val);
      //console.log(list_level2);
      for(i=0;i<list_level2.length;i++){
        //console.log(list_level2[i].parent_id);
        if(val == list_level2[i].parent_id){    
        	if(val_sel == list_level2[i].ctg_id){
        		str_op += '<option value="'+list_level2[i].ctg_id+'" selected>'+list_level2[i].ctg_name+'</option>';
        	}else{
        		str_op += '<option value="'+list_level2[i].ctg_id+'">'+list_level2[i].ctg_name+'</option>';
        	} 
        }
      };      
      //console.log(str_op);
      $('#level_2').empty();
      $('#level_2').append(str_op);
    };
    
    if(news_flg ==1){
      action ="/ctgnews";
    }
    $(document).off('click','#btn_new'); 
    $(document).on('click','#btn_new',function(event){
          Pho_html_ajax('POST',"{{url.get('category/new')}}" ,{'ctg_level':'{{level_flg}}','news_flg':'{{news_flg}}'},function(html){
                /*Pho_modal({
                template:html,
                closeClick: false,
                closable: true, 
                modalid:"modal1",
                size:'large'
              
              });*/
              Pho_modal(html,"Thêm Danh mục",600);
            });
          
        });
        $(document).off('click','.dialog_close'); 
        $(document).on('click','.dialog_close',function(event){         
      Pho_modal_close("modal1");
        });
        $(document).off('click','#btn_save'); 
        $(document).on('click','#btn_save',function(event){
          var arr = $('#form_ctg').serializeArray();  
          //arr.push({name:'sel_lelvel_1',value:$('#level_1').val()});
          //arr.push({name:'sel_lelvel_2',value:$('#level_1').val()});
          var lv_str ="";
          if($('#level_1').val() >0 ){
          	  lv_str = "?lv1=" + $('#level_1').val();
          	  if($('#level_2').val() >0 ){
          	  	lv_str += "&lv2=" + $('#level_2').val();
          	  }
          }
      Pho_json_ajax('POST',"{{url.get('category/update')}}" ,arr,function(datas){
        if(datas.status =="OK"){
          Pho_modal_close("modal1");
          //Pho_message_box("Thông báo",datas.msg);
          Pho_direct("{{url.get('category/list/')}}{{level_flg}}/{{news_flg}}"+lv_str );
        }else{
          Pho_message_box_error("Lỗi",datas.msg);
        }
                
            });
        });
        $(document).off('click','.btn_delete'); 
        $(document).on('click','.btn_delete',function(event){
          var id = $(this).attr('id');
            id = id.replace("del_","");
          Pho_message_confirm("Thông báo","Bạn có chắc chắn muốn xóa danh mục này ?",function(){
            
            Pho_json_ajax('GET',"{{url.get('category/delete/')}}" + id,null ,function(datas){
              if(datas.status == "OK"){
                //Pho_modal_close("modal1");
                //Pho_message_box("Thông báo",datas.msg);
                location.href="{{url.get('category/list/')}}{{level_flg}}/{{news_flg}}";
              }else{
                console.log(datas.msg);
                Pho_message_box_error("Lỗi",datas.msg);
              }
                      
            });
          });
          
        });
        $(document).off('click','.btn_edit'); 
        $(document).on('click','.btn_edit',function(event){
          var id = $(this).attr('id');
            id = id.replace("edit_","");      
            Pho_html_ajax('GET',"{{url.get('category/edit/')}}"+ id ,null,function(html){
                /*Pho_modal({
                template:html,
                closeClick: false,
                closable: true, 
                modalid:"modal1",
                size:'large'              
              });*/
              Pho_modal(html,"Sửa Danh mục",700);
            });
        });
        $(document).off('click','.add_child'); 
        $(document).on('click','.add_child',function(event){
          var id = $(this).attr('id');
            id = id.replace("add_","");     
            Pho_html_ajax('GET',"{{url.get('category/addchild/')}}"+ id ,null,function(html){
                /*Pho_modal({
                template:html,
                closeClick: false,
                closable: true, 
                modalid:"modal1",
                size:'large'
              
              });*/
              Pho_modal(html,"Thêm Danh mục",600);
            });
        });
        $(document).off('change','#level_1'); 
        $(document).on('change','#level_1',function(event){
          var val = $("#level_1 option:selected").text();
          find_table(val);
          
        });
        $("#table_search").keyup(function(){  
            find_table(this.value);
      });
      $(document).off('change','#level_1'); 
        $(document).on('change','#level_1',function(event){
          var val = $("#level_1 option:selected").text();
          //alert(val);
          //console.log($(this).val());
          change_option_2($(this).val(),'');
          find_table(val);
          
        });
        $(document).off('change','#level_2'); 
        $(document).on('change','#level_2',function(event){
          var val = $("#level_1 option:selected").text();
          var val_2 = $("#level_2 option:selected").text();
          find_table(val);
          find_table_2(val_2);          
        });
        
        find_table($("#level_1 option:selected").text());
        function find_table(str_val){
		      $("#fbody").find("tr").hide();

		      //split the current value of searchInput
		            var data = str_val.split(" ");
		      //create a jquery object of the rows
		            var jo = $("#fbody").find("tr");            
		      //Recusively filter the jquery object to get results.
		            $.each(data, function(i, v){
		                jo = jo.filter("*:contains('"+v+"')");
		            });
		          //show the rows that match.
		            jo.show();
		}
		function find_table_2(str_val){
	      var jo = $("#fbody").find("tr:visible");
	      $("#fbody").find("tr").hide();
	          var data = str_val.split(" ");
	          $.each(data, function(i, v){
	             jo = jo.filter("*:contains('"+v+"')");
	          });         
	          jo.show();
	    }   
		{%if lv2!=''%}      	 
	      	 change_option_2({{lv1}},{{lv2}});
	      	 var val = $("#level_1 option:selected").text();
	          var val_2 = $("#level_2 option:selected").text();
	          find_table(val);
	          find_table_2(val_2);     
    	{%endif%}  
    });
    	
</script>