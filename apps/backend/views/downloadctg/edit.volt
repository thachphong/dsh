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
<div class="row" style="width: 700px">
              <div class="col-md-12 col-sm-12 col-xs-12">                
                  <div class="x_content">
                    <br />
                    <form id="form_ctg" action="" class="form-horizontal form-label-left" enctype="multipart/form-data">
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Danh mục</label>
                        <input type="hidden" name="id" value="{{data.id}}">
                        <div class="col-md-6 col-sm-6 col-xs-12">
                        	<select class="form-control" name="menu_id">                        	 
                          	 <option></option>
                             {%for ctg in categorys%}
                              {%if ctg['cnt_child'] > 0%}
                                <option   class="optionGroup {%if ctg['ctg_level'] == 1%}opt_blue{%elseif ctg['ctg_level'] == 2%}opt_red{%endif%}" value="{{ctg['ctg_id']}}" {%if ctg['ctg_id'] == data.menu_id%}selected="selected"{%endif%}>{%if ctg['ctg_level'] == 2%}&nbsp;&nbsp;&nbsp;{%elseif ctg['ctg_level'] == 3%}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{%endif%}{{ctg['ctg_name']}}</option>
                              {%else%}
                                <option class="{%if ctg['ctg_level'] == 1%}opt_blue{%elseif ctg['ctg_level'] == 2%}opt_red{%endif%}"  value="{{ctg['ctg_id']}}" {%if ctg['ctg_id'] == data.menu_id%}selected="selected"{%endif%}>{%if ctg['ctg_level'] == 2%}&nbsp;&nbsp;&nbsp;{%elseif ctg['ctg_level'] == 3%}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{%endif%}{{ctg['ctg_name']}}</option>
                              {%endif%}
                             {%endfor%}
                           </select>                          
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Nguồn download</label>
                        <div class="col-md-8 col-sm-8 col-xs-12">
                          <input type="text"  class="form-control" name="link" value="{{data.link}}">
                        </div>
                      </div> 
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Sử dụng</label>
                        <div class="col-md-3 col-sm-3 col-xs-12">
                          <select class="form-control" name="status">
                          	 <option value="0" {%if data.status == 0%}selected="selected"{%endif%}>Không</option>
                          	 <option value="1" {%if data.status == 1%}selected="selected"{%endif%}>Có</option>
                          </select>                          
                        </div>
                      </div>                      
                      <div class="ln_solid"></div>
                      <div class="form-group">
                        <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3" style="text-align: center">
                          <button class="dialog_close btn btn-primary" type="button">Thoát</button>
                          <button class="btn btn-success" id="btn_save" type="button">Cập nhật</button>
                        </div>
                      </div>

                    </form>
                  </div>
                </div>
              </div>
           <!-- </div>-->
<script>
	$(document).ready(function() {
		
		
		$(document).off('change','#page_flg'); 
        $(document).on('change','#page_flg',function(event){
        	var val = $(this).val();
        	//change_option(val);
        });
	});
	
</script>