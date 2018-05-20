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
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">Danh mục</label>
                        <input type="hidden" name="id" value="{{data.id}}">
                        <div class="col-md-6 col-sm-6 col-xs-12">
                        	<select class="form-control" name="dl_category_id">                        	 
                          	 <option></option>
                             {%for ctg in categorys%}
                              {%if ctg['cnt_child'] > 0%}
                                <option   class="optionGroup {%if ctg['ctg_level'] == 1%}opt_blue{%elseif ctg['ctg_level'] == 2%}opt_red{%endif%}" value="{{ctg['ctg_id']}}" {%if ctg['ctg_id'] == data.dl_category_id%}selected="selected"{%endif%}>{%if ctg['ctg_level'] == 2%}&nbsp;&nbsp;&nbsp;{%elseif ctg['ctg_level'] == 3%}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{%endif%}{{ctg['ctg_name']}}</option>
                              {%else%}
                                <option class="{%if ctg['ctg_level'] == 1%}opt_blue{%elseif ctg['ctg_level'] == 2%}opt_red{%endif%}"  value="{{ctg['ctg_id']}}" {%if ctg['ctg_id'] == data.dl_category_id%}selected="selected"{%endif%}>{%if ctg['ctg_level'] == 2%}&nbsp;&nbsp;&nbsp;{%elseif ctg['ctg_level'] == 3%}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{%endif%}{{ctg['ctg_name']}}</option>
                              {%endif%}
                             {%endfor%}
                           </select>                          
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">Ref Link</label>
                        <div class="col-md-10 col-sm-10 col-xs-12">
                          <input type="text"  class="form-control" name="ref_link" value="{{data.ref_link}}">
                        </div>
                      </div> 
                      <div class="form-group">
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">Key</label>
                        <div class="col-md-4 col-sm-4 col-xs-12">
                         <select class="form-control" name="key">                           
                             <option value=""></option>
                             <option value="title">title</option>
                             <option value="image"></option>
                             <option value="content">content</option>
                             <option value="des">des</option>
                             <option value="del">del</option>
                             <option value="price">price</option>
                             <option value="code">code</option>
                             <option value="category_link">category_link</option>
                          </select>
                        </div>
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">Xpath</label>
                        <div class="col-md-4 col-sm-4 col-xs-12">
                          <input type="text"  class="form-control" name="xpath" value="{{data.xpath}}">
                        </div>
                      </div> 
                      <div class="form-group">
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">From string</label>
                        <div class="col-md-4 col-sm-4 col-xs-12">
                          <input type="text"  class="form-control" name="from_string" value="{{data.from_string}}">
                        </div>
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">to string</label>
                        <div class="col-md-4 col-sm-4 col-xs-12">
                          <input type="text"  class="form-control" name="to_string" value="{{data.to_string}}">
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">Elem remove</label>
                        <div class="col-md-4 col-sm-4 col-xs-12">
                          <select class="form-control" name="element_remove">
                             <option value="0" {%if data.element_remove == 0%}selected="selected"{%endif%}>NO</option>
                             <option value="1" {%if data.element_remove == 1%}selected="selected"{%endif%}>YES</option>
                          </select>                          
                        </div>
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">Sử dụng</label>
                        <div class="col-md-4 col-sm-4 col-xs-12">
                          <select class="form-control" name="stop_flg">
                          	 <option value="0" {%if data.stop_flg == 0%}selected="selected"{%endif%}>Có</option>
                          	 <option value="1" {%if data.stop_flg == 1%}selected="selected"{%endif%}>Không</option>
                          </select>                          
                        </div>
                      </div>  
                      <div class="form-group">
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">Sort</label>
                        <div class="col-md-4 col-sm-4 col-xs-12">                          
                            <input type="text"  class="form-control" name="sort" value="{{data.sort}}">
                        </div>
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">Category flg</label>
                        <div class="col-md-4 col-sm-4 col-xs-12">
                          <select class="form-control" name="ctg_flg">
                             <option value="0" {%if data.ctg_flg == 0%}selected="selected"{%endif%}>NO</option>
                             <option value="1" {%if data.ctg_flg == 1%}selected="selected"{%endif%}>YES</option>
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