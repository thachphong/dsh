
<div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">               
                  <div class="x_content">
                    <br />
                    <form id="form_ctg" action="" class="form-horizontal form-label-left" enctype="multipart/form-data">
                      {%if ctg_level > 1%}
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Danh mục cấp 1<span class="required">*</span></label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <select class="form-control select2" name="parent_id_1" id="parent_id_1">
                             <option value=""></option>
                             {%for item in parent_list1%}
                              <option value="{{item['ctg_id']}}" {%if parent_id_1 == item['ctg_id']%}selected="selected"{%endif%}>{{item['ctg_name']}}</option>
                             {%endfor%}                            
                          </select>                          
                        </div>
                      </div>
                      {%endif%}
                      {%if ctg_level > 2%}
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Danh mục cấp 2<span class="required">*</span></label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <select class="form-control select2" name="parent_id_2" id="parent_id_2">
                             <option value=""></option> 
                          </select>                          
                        </div>
                      </div>
                      {%endif%} 
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="ctg_name">Tên Danh mục<span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input type="text" id="ctg_name" required="required" name="ctg_name" class="form-control col-md-7 col-xs-12" value="{{ctg_name}}">
                          <input type="hidden"  name="ctg_id" value="{{ctg_id}}">
                          <input type="hidden"  name="ctg_level" value="{{ctg_level}}">
                          <input type="hidden"  name="news_flg" value="{{news_flg}}">
                        </div>
                      </div>
                      {% if news_flg != 1%}
                      <!-- <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Loại bất động sản</label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <select class="form-control" name="m_type_id">
                             <option value="" ></option>
                             {%for row in mtypelist%}
                                <option value="{{row.m_type_id}}" {%if m_type_id == row.m_type_id%}selected="selected"{%endif%}>{{row.m_type_name}}</option>                             
                             {%endfor%} 
                          </select>                          
                        </div>
                      </div> -->
                      {%endif%}
                      <div class="form-group">
                        <label for="middle-name" class="control-label col-md-3 col-sm-3 col-xs-12">Thứ tự hiển thị</label>
                        <div class="col-md-3 col-sm-3 col-xs-12">
                          <input id="ctg_sort" class="form-control col-md-7 col-xs-12" type="number" name="ctg_sort" value="{{sort}}" >
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Hiện/Ẩn</label>
                        <div class="col-md-3 col-sm-3 col-xs-12">
                          <select class="form-control" name="del_flg">
                             <option value="0" {%if del_flg == 0%}selected="selected"{%endif%}>Hiện</option>
                             <option value="1" {%if del_flg == 1%}selected="selected"{%endif%}>Ẩn</option>
                          </select>                          
                        </div>
                      </div>                      
                      <div class="ln_solid"></div>
                      <div class="form-group">
                        <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                          <button class="dialog_close btn btn-primary" type="button">Thoát</button>
                          <button class="btn btn-success" id="btn_save" type="button">Cập nhật</button>
                        </div>
                      </div>

                    </form>
                  </div>
                </div>
              <!--</div>-->
            </div>
<script>
	var list_level2= '{%if parent_list2 is defined%}{{parent_list2}}{%endif%}';
  if(list_level2.length > 0){
    list_level2 = JSON.parse(list_level2);
  }
  $(document).ready(function() {
  	  	$(document).off('change','#parent_id_1'); 
        $(document).on('change','#parent_id_1',function(event){
           var val = $("#parent_id_1 option:selected").text();        
           change_option_2($(this).val());
        });
	    {%if parent_id_2 > 0%}
	       change_option_2({{parent_id_1}},{{parent_id_2}});
	       //console()
	    {%endif%}
  		function change_option_2(val,sel=0){
		    var str_op = '<option value=""></option>';
		     console.log(list_level2); 
		    for(i=0;i<list_level2.length;i++){
		        //console.log(list_level2[i].parent_id);
		        if(val == list_level2[i].parent_id){
		          if(sel == list_level2[i].ctg_id){
		            str_op += '<option value="'+list_level2[i].ctg_id+'" selected>'+list_level2[i].ctg_name+'</option>';
		          }else{
		            str_op += '<option value="'+list_level2[i].ctg_id+'">'+list_level2[i].ctg_name+'</option>';
		          }         
		        }
		    };
		    $('#parent_id_2').empty();
		    $('#parent_id_2').append(str_op);
		};	
  });
</script>