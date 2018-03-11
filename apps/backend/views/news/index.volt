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
    <!-- page content -->
	<style type="text/css">
	.optionGroup{
	    font-weight: bold;
	    font-style: italic;
	}
	.pager .active a{
			 background-color: rgba(10, 75, 166, 0.86);
	    		color: #fff;
		}
		.pager .active a:hover{		 
	    	color: #000;
		}
	</style>
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
                          <th>Danh mục</th>
                          <th>Tiêu đề</th>
                          <th>Hiện</th>
                          <th>Sửa</th>
                          <th>Xóa</th>                        
                        </tr>
                      </thead>
                      <tbody id="fbody">
                      {%for key,item in news%}
                        <tr>
                          <td>{{item['news_id']}}</td> 
                          <td>{{item['ctg_name']}}</td>
                          <td id="name_{{item['news_id']}}">{{item['news_name']}}</td>
                          <td>                            
                            <span class="fa {%if item['del_flg'] == 1%}fa-square-o{%else%}fa-check-square{%endif%}" style="font-size: 16px;"></span>                            
                          </td>
                          <td>
                            <a class="btn btn-warning btn-xs btn_edit" href="{{url.get('news/edit/')}}{{item['news_id']}}">Sửa</a>
                          </td>
                          <td>
                            <button class="btn btn btn-danger btn-xs btn_delete" id="del_{{item['news_id']}}">Xóa</button>
                          </td>
                        </tr>
                      {%endfor%}                        
                      </tbody>
                    </table>
                    {%if total_page > 1%}
			         <div class="row margin_top" >
			            <div class="col-md-12 col-sm-12 col-xs-12" style="display: flex;justify-content: center;">
			               <ul class="pager">
			                  {%if page > 1%}
			                     <li><a href="{{url.get('')}}{{ctg_no}}&page=1">Trang đầu</a></li>
			                     <li><a href="{{url.get('')}}{{ctg_no}}&page={{(page-1)}}">Trang trước</a></li>
			                  {%endif%}                 
			                  
			                  {%for i in  start..end%} 
			                    <li {%if page == i%}class="active"{%endif%}><a href="{%if page != i%}{{url.get('')}}{{ctg_no}}&page={{i}}{%else%}#{%endif%}">{{i}}</a></li>
			                  {%endfor%}
			                  {%if page < total_page%}
			                     <li><a href="{{url.get('')}}{{ctg_no}}&page={{page+1}}">Trang sau</a></li>
			                     <li><a href="{{url.get('')}}{{ctg_no}}&page={{total_page}}">Trang cuối</a></li>
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
          location.href="{{url.get('news/edit/0')}}";         
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
            
        Pho_json_ajax('GET',"{{url.get('news/delete/')}}" + id,null ,function(datas){
          if(datas.status == "OK"){
            Pho_direct("{{url.get('news')}}");
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
            location.href="{{url.get('news/edit/')}}"+id;
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


         
  

