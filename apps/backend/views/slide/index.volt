<div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3>Quản lý Sile <!--<small>Some examples to get you started</small>--></h3>
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
            </div>
            
                  	
                 
			
            <div class="clearfix"></div>

            <div class="row">              
			  <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Danh sách Sile<!--<small>Users</small>--></h2>                    
                    <ul class="nav navbar-right panel_toolbox">
                      <li><button type="button" class="btn btn-primary btn-sm" id="btn_new">Thêm mới</button></li>
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <!--<li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        <ul class="dropdown-menu" role="menu">
                          <li><a href="#">Settings 1</a>
                          </li>
                          <li><a href="#">Settings 2</a>
                          </li>
                        </ul>
                      </li>-->
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
                          <th>slide_id</th>
                          <th>slide_type</th>
                          <th>path</th>
                          <th>add_date</th>
                          <th>add_user</th>
                          <th>upd_date</th>
                          <th>upd_user</th>                          
                        </tr>
                      </thead>
                      <tbody>
                      {%if list != null %}
                      {% for slide in list %}
                      	<tr>
                          <td>{{slide.slide_id}}</td>
                          <td>{{slide.slide_type}}</td>
                          <td>{{slide.path}}</td>
                          <td>{{slide.add_date}}</td>
                          <td>{{slide.add_user}}</td>
                          <td>{{slide.upd_date}}</td>
                          <td>{{slide.upd_user}}</td>   
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
{{ javascript_include('templateadm/js/bootstrap.file-input.js') }}
    <script>    
    
    $(document).ready(function() {
		$(document).off('click','#btn_new'); 
        $(document).on('click','#btn_new',function(event){
        	Pho_html_ajax('POST',"{{url.get('slide/edit')}}" ,{'silde_id':''},function(html){
                Pho_modal({
		        		template:html,
				        closeClick: false,
				        closable: true, 
				        modalid:"modal1",
				        size:'large'
		        	
            });
            });
        	
        });
        $(document).off('click','.dialog_close'); 
        $(document).on('click','.dialog_close',function(event){
        	//$('#modal1').hide();
        	/*modal({
			type: 'info',
			title: 'xxxx',
			text: 'aaaaaaa'
			});*/
			Pho_modal_close("modal1");
        });
    });
</script>
        
