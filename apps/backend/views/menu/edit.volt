<style type="text/css">
.optionGroup{
    font-weight: bold;
    font-style: italic;
}
</style>
<div class="row" style="width: 700px">
              <div class="col-md-12 col-sm-12 col-xs-12">
                
                  <div class="x_content">
                    <br />
                    <form id="form_ctg" action="" class="form-horizontal form-label-left" enctype="multipart/form-data">
                      {%if menu_level > 1%}
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Menu cấp 1<span class="required">*</span></label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <select class="form-control select2" name="parent_id_1" id="parent_id_1">
                             <option value=""></option>
                             {%for item in parent_list1 %}
                              <option value="{{item['menu_id']}}" {%if parent_id_1 == item['menu_id']%}selected="selected"{%endif%}>{{item['menu_name']}}</option>
                             {%endfor%}                           
                          </select>                          
                        </div>
                      </div>
                      {%endif%}
                      {%if menu_level > 2%}
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Menu cấp 2<span class="required">*</span></label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <select class="form-control select2" name="parent_id_2" id="parent_id_2">
                             <option value=""></option> 
                          </select>                          
                        </div>
                      </div>
                      {%endif%} 
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="ctg_name">Tên menu<span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input type="text" id="ctg_name" required="required" name="menu_name" class="form-control col-md-7 col-xs-12" value="{{menu_name}}">
                         
                          <input type="hidden"  name="menu_id" value="{{menu_id}}">
                          <input type="hidden"  name="menu_level" value="{{menu_level}}">
                          <input type="hidden"  name="position" value="{{position}}">                          
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Loại</label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <select class="form-control select2" name="page_flg" id="page_flg">
                             <option ></option>
                             <option value="2" {%if page_flg == 2%}selected="selected"{%endif%}>Danh mục sản phẩm</option>
                             <option value="1" {%if page_flg == 1%}selected="selected"{%endif%}>Trang</option>
                             <option value="3" {%if page_flg == 3%}selected="selected"{%endif%}>Tin tức</option>
                             <option value="4" {%if page_flg == 4%}selected="selected"{%endif%}>Dự án</option>
                          </select>                          
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Trang/Danh mục</label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <select class="form-control select2" name="link" id="menu_link">                             
                          </select>                          
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="middle-name" class="control-label col-md-3 col-sm-3 col-xs-12">Thứ tự hiển thị</label>
                        <div class="col-md-3 col-sm-3 col-xs-12">
                          <input id="ctg_sort" class="form-control col-md-7 col-xs-12" type="number" name="menu_sort" value="{{sort}}" >
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
              </div>
           <!-- </div>-->
<script>
  var ctg_list =JSON.parse( "{{ctg_list}}");
  var page_list =JSON.parse( "{{page_list}}");
  var news_list =JSON.parse( "{{news_list}}");
  var project_list =JSON.parse( "{{project_list}}");
  var link_val ="{{link}}";
  var list_level2= '{%if parent_list2 is defined%}{{parent_list2}}{%endif%}';
  if(list_level2.length > 0){
    list_level2 = JSON.parse(list_level2);
  }
  $(document).ready(function() {
    
    var page_flg = $('#page_flg').val();
    if(page_flg != null){     
      change_option(page_flg,link_val);
    }
    $(document).off('change','#page_flg'); 
        $(document).on('change','#page_flg',function(event){
          var val = $(this).val();
          change_option(val);
        });
        $(document).off('change','#parent_id_1'); 
        $(document).on('change','#parent_id_1',function(event){
          var val = $("#parent_id_1 option:selected").text();        
          change_option_2($(this).val());
        });
    {%if parent_id_2 > 0%}
      change_option_2({{parent_id_1}},{{parent_id_2}});
    {%endif%}
  });
  function change_option_2(val,sel=0){
    var str_op = '<option value=""></option>';
      
    for(i=0;i<list_level2.length;i++){
        //console.log(list_level2[i].parent_id);
        if(val == list_level2[i].parent_id){
          if(sel == list_level2[i].menu_id){
            str_op += '<option value="'+list_level2[i].menu_id+'" selected>'+list_level2[i].menu_name+'</option>';
          }else{
            str_op += '<option value="'+list_level2[i].menu_id+'">'+list_level2[i].menu_name+'</option>';
          }         
        }
    };
    $('#parent_id_2').empty();
    $('#parent_id_2').append(str_op);
  };
  function change_option(val,v_link_val=''){          
          $("#menu_link").empty();
          var str_opt ="";
          //console.log(val);
          if(val == "2"){
            $.each( ctg_list, function( key, value ) {
              var grpclass ="";
              var space ="";
              if(value.cnt_child > 0){
                  grpclass='class="optionGroup"';
              }
              if(value.ctg_level == 2){
                  space ="&nbsp;&nbsp;&nbsp;";
              }
              if(v_link_val.length > 0 && value.ctg_no == v_link_val){
                //console.log(v_link_val);
                str_opt += '<option '+grpclass+' value="'+value.ctg_no+'" selected="selected">'+space+value.ctg_name + "</option>";
              }else{
                str_opt += '<option '+grpclass+' value="'+value.ctg_no+'">'+space+value.ctg_name + "</option>";
              }         
          
        });
          }else if(val == 1){
            //console.log(v_link_val);
            $.each( page_list, function( key, value ) {
              //console.log(value.page_no);
              //console.log(v_link_val.length);
              if(v_link_val.length > 0 && value.page_no == v_link_val){
                //console.log(v_link_val);
                str_opt += '<option value="'+value.page_no+'" selected="selected">'+value.page_name + "</option>";
              }else{
                str_opt += '<option value="'+value.page_no+'">'+value.page_name + "</option>";
              }         
          
        	});
          }else if(val == 3){
            $.each( news_list, function( key, value ) {             
              if(v_link_val.length > 0 && value.ctg_no == v_link_val){
                //console.log(v_link_val);
                str_opt += '<option value="'+value.ctg_no+'" selected="selected">'+value.ctg_name + "</option>";
              }else{
                str_opt += '<option value="'+value.ctg_no+'">'+value.ctg_name + "</option>";
              }         
          
        	});
          }else if(val == 4){
            $.each( project_list, function( key, value ) {             
              if(v_link_val.length > 0 && value.ctg_no == v_link_val){
                //console.log(v_link_val);
                str_opt += '<option value="'+value.ctg_no+'" selected="selected">'+value.ctg_name + "</option>";
              }else{
                str_opt += '<option value="'+value.ctg_no+'">'+value.ctg_name + "</option>";
              }         
          
        	});
          }
          $("#menu_link").append(str_opt);
          
          
            //console.log(v_link_val);
            //$("#menu_link").val(v_link_val);
          //}
        };
</script>