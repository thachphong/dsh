<style type="text/css">
.optionGroup {
      font-weight: bold;
      font-style: italic;
  }
  .opt_blue{
    color: #0202fd;
  }
  .opt_red{
    color: #dc010c;
  }
</style>
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
                    <h2>Download theo URL<!--<small>Users</small>--></h2>
                    
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <div class="row">                    	
                    	<div class="col-sm-12">                    		
                    		<div class="form-group">
                    		  <label class="col-md-1">Danh mục</label>
                          <div class="col-md-3 col-sm-3 col-xs-12">
                          
                           <select class="form-control" name="ctg_id" id="ctg_id">
                             <option ></option>
                             {%for ctg in categorys%}
                              {%if ctg['cnt_child'] > 0%}
                                <option   class="optionGroup {%if ctg['ctg_level'] == 1%}opt_blue{%elseif ctg['ctg_level'] == 2%}opt_red{%endif%}" value="{{ctg['ctg_id']}}" >{%if ctg['ctg_level'] == 2%}&nbsp;&nbsp;&nbsp;{%elseif ctg['ctg_level'] == 3%}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{%endif%}{{ctg['ctg_name']}}</option>
                              {%else%}
                                <option class="{%if ctg['ctg_level'] == 1%}opt_blue{%elseif ctg['ctg_level'] == 2%}opt_red{%endif%}"  value="{{ctg['ctg_id']}}" >{%if ctg['ctg_level'] == 2%}&nbsp;&nbsp;&nbsp;{%elseif ctg['ctg_level'] == 3%}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{%endif%}{{ctg['ctg_name']}}</option>
                              {%endif%}
                             {%endfor%}                            
                            </select>                          
                          </div>
                          <label class="col-md-1">URL</label>
                          <div class="col-md-6">
                        	 <input type="search" id="link_dl" class="col-md-2 form-control" name="link_dl" >
                          </div>
                          <div class="col-md-1">
                            <input type="button" value="Download" id="btn_download" class="btn btn-info">
                          </div> 
                        </div>                  	
                      </div>
                    </div>
                    </div>
                    
					        </div>
                  <div class="x_panel">
                    <div class="x_title">
                      <h2>Download theo Danh mục</h2>                      
                      <div class="clearfix"></div>
                    </div>
                    <div class="x_content">
                      <div class="row">
                        <div class="col-sm-12"> 
                          <div class="form-group">
                            <label class="col-md-1">Danh mục</label>
                            <div class="col-md-3 col-sm-3 col-xs-12">
                            
                             <select class="form-control" name="ctg_id2" id="ctg_id2">
                               <option ></option>
                               {%for ctg in categorys%}
                                {%if ctg['cnt_child'] > 0%}
                                  <option   class="optionGroup {%if ctg['ctg_level'] == 1%}opt_blue{%elseif ctg['ctg_level'] == 2%}opt_red{%endif%}" value="{{ctg['ctg_id']}}" >{%if ctg['ctg_level'] == 2%}&nbsp;&nbsp;&nbsp;{%elseif ctg['ctg_level'] == 3%}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{%endif%}{{ctg['ctg_name']}}</option>
                                {%else%}
                                  <option class="{%if ctg['ctg_level'] == 1%}opt_blue{%elseif ctg['ctg_level'] == 2%}opt_red{%endif%}"  value="{{ctg['ctg_id']}}" >{%if ctg['ctg_level'] == 2%}&nbsp;&nbsp;&nbsp;{%elseif ctg['ctg_level'] == 3%}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{%endif%}{{ctg['ctg_name']}}</option>
                                {%endif%}
                               {%endfor%}                            
                              </select>                          
                            </div>
                            <label class="col-md-3">Số sản phẩm mỗi lần download</label>
                            <div class="col-md-1">
                             <input type="search" id="max_dl" class="col-md-2 form-control" name="max_dl" value="40" >
                            </div>
                            <div class="col-md-1">
                              <input type="button" value="Download" id="btn_download2" class="btn btn-info">
                            </div> 
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
					        <div class="x_panel">
                    <div class="x_title">
                      <h2>Download Danh mục theo URL</h2>                      
                      <div class="clearfix"></div>
                    </div>
                    <div class="x_content">
                      <div class="row">
                        <div class="col-sm-12"> 
                          <div class="form-group">
                            <label class="col-md-1">Danh mục</label>
                            <div class="col-md-3 col-sm-3 col-xs-12">
                            
                             <select class="form-control" name="ctg_id3" id="ctg_id3">
                               <option ></option>
                               {%for ctg in categorys%}
                                {%if ctg['cnt_child'] > 0%}
                                  <option   class="optionGroup {%if ctg['ctg_level'] == 1%}opt_blue{%elseif ctg['ctg_level'] == 2%}opt_red{%endif%}" value="{{ctg['ctg_id']}}" >{%if ctg['ctg_level'] == 2%}&nbsp;&nbsp;&nbsp;{%elseif ctg['ctg_level'] == 3%}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{%endif%}{{ctg['ctg_name']}}</option>
                                {%else%}
                                  <option class="{%if ctg['ctg_level'] == 1%}opt_blue{%elseif ctg['ctg_level'] == 2%}opt_red{%endif%}"  value="{{ctg['ctg_id']}}" >{%if ctg['ctg_level'] == 2%}&nbsp;&nbsp;&nbsp;{%elseif ctg['ctg_level'] == 3%}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{%endif%}{{ctg['ctg_name']}}</option>
                                {%endif%}
                               {%endfor%}                            
                              </select>                          
                            </div>
                            <label class="col-md-1">URL</label>
                            <div class="col-md-6">
                             <input type="search" id="ctg_url" class="col-md-3 form-control" name="ctg_url" value="" >
                            </div>
                            <div class="col-md-1">
                              <input type="button" value="Download" id="btn_download3" class="btn btn-info">
                            </div> 
                          </div>
                        </div>
                      </div>
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

	$(document).off('click','#btn_download'); 
  $(document).on('click','#btn_download',function(event){
       Pho_json_ajax('POST',"{{url.get('download/downloadurl')}}" ,{'link_dl':$('#link_dl').val(),'ctg_id':$('#ctg_id').val()},function(data){
                if(data.status =='OK'){
                    Pho_message_box('Thông báo',data.msg, function(){
                        //window.location.href="{{url.get('download')}}";
                        $('input[name="link_dl"]').val('');
                    }); 
                }else{
                    Pho_message_box_error('Lỗi',data.msg);
                }
      });
  });
  $(document).off('click','#btn_download2'); 
  $(document).on('click','#btn_download2',function(event){
       Pho_json_ajax('POST',"{{url.get('download/downloadctg')}}" ,{'max_dl':$('#max_dl').val(),'ctg_id':$('#ctg_id2').val()},function(data){
                if(data.status =='OK'){
                    Pho_message_box('Thông báo',data.msg, function(){
                        //window.location.href="{{url.get('download')}}";
                        $('input[name="link_dl"]').val('');
                    }); 
                }else{
                    Pho_message_box_error('Lỗi',data.msg);
                }
      });
  });
  $(document).off('click','#btn_download3'); 
  $(document).on('click','#btn_download3',function(event){
       Pho_json_ajax('POST',"{{url.get('download/downloadctg')}}" ,{'ctg_url':$('#ctg_url').val(),'ctg_id':$('#ctg_id3').val()},function(data){
                if(data.status =='OK'){
                    Pho_message_box('Thông báo',data.msg, function(){
                        //window.location.href="{{url.get('download')}}";
                        //$('input[name="link_dl"]').val('');
                    }); 
                }else{
                    Pho_message_box_error('Lỗi',data.msg);
                }
      });
  });
});
</script>