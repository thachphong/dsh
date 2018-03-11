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
    {{ partial('includes/editor') }}
    <style>
  .dvtinh{
    margin-top: 7px;
      display: block;
  }
  .optionGroup {
      font-weight: bold;
      font-style: italic;
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
        {{ content() }}
        
        <!-- /page content -->
        <div class="right_col" role="main" style="min-height: 600px">
          <div class="">           
            <div class="clearfix"></div>

            <div class="row">              
        <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Thêm Tin </h2>
                    
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <div class="row">
                      <div class="col-md-12 col-sm-12 col-xs-12">
                
                  <div class="x_content">
                    <br />
                    <form id="form_ctg" action="" class="form-horizontal form-label-left" enctype="multipart/form-data">
                      <div class="row">
                        <div class="col-md-8">
                            <div class="form-group">
                              <label class="control-label col-md-2 col-sm-2 col-xs-12" for="news_name">Tiêu đề tin<span class="required">*</span>
                              </label>
                              <div class="col-md- col-sm-10 col-xs-12">
                                <input type="text" id="news_name" required="required" name="news_name" class="form-control col-md-10 col-xs-12" value="{{news_name}}">                          
                                <input type="hidden"  name="news_id" value="{{news_id}}"> 
                                <input type="hidden" name="folder_tmp" value="{{folder_tmp}}">                       
                              </div>
                            </div>
                            <div class="form-group">
                              <label class="control-label col-md-2 col-sm-2 col-xs-12" for="ctg_id">Danh mục<span class="required">*</span>
                              </label>
                              <div class="col-md-6 col-sm-6 col-xs-12">
                                <select class="form-control" name="ctg_id" id="ctg_id">
                                   <option ></option>
                                   {%for ctg in ctg_list%}
                                    {%if ctg['cnt_child'] > 0%}
                                      <option   class="optionGroup" value="{{ctg['ctg_id']}}" {%if ctg['ctg_id']== ctg_id%}selected="selected"{%endif%}>
                                      {%if ctg['ctg_level'] == 2%}&nbsp;&nbsp;&nbsp;
                                      {% elseif ctg['ctg_level'] == 3 %}&nbsp;&nbsp;&nbsp&nbsp;&nbsp
                                      {%endif%}{{ctg['ctg_name']}}</option>
                                    {%else%}
                                      <option   value="{{ctg['ctg_id']}}" {%if ctg['ctg_id'] == ctg_id%}selected="selected"{%endif%}>{%if ctg['ctg_level'] == 2%}&nbsp;&nbsp;&nbsp;{% elseif ctg['ctg_level'] == 3%}&nbsp;&nbsp;&nbsp&nbsp;&nbsp{%endif%}{{ctg['ctg_name']}}</option>
                                    {%endif%}
                                   {%endfor%}                           
                                </select>                  
                              </div>
                            </div>
                            <div class="form-group">
                              <label class="control-label col-md-2 col-sm-2 col-xs-12">Hiện/Ẩn</label>
                              <div class="col-md-2 col-sm-2 col-xs-12">
                                <select class="form-control" name="del_flg">
                                   <option value="0" {%if del_flg == 0%}selected="selected"{%endif%}>Hiện</option>
                                   <option value="1" {%if del_flg == 1%}selected="selected"{%endif%}>Ẩn</option>
                                </select>                          
                              </div>
                            </div> 
                        </div>
                        <div class="col-md-4">
                          <div class="form-group">                        
                           <!--  <label class="control-label col-md-2 col-sm-2 col-xs-12" for="img_path">Hình Ảnh</label> -->
                            <div class="col-md-7 col-sm-7 col-xs-12">
                              <input type="hidden" id="img_path" name="img_path" class="form-control col-md-7 col-xs-12" value="{{img_path}}"> 
                              <img src="{%if img_path!=""%}{{url.get()}}{{img_path}}{%endif%}" class="img-rounded" style="height: 120px;width:170px;border: solid 1px #06be17;" id="news_avata" title ="Ảnh đại diện">                         
                            </div>
                            <div class="col-md-5 col-sm-5 col-xs-12">
                              <button class="btn btn-primary" type="button" id="btn_upload">Upload</button>
                              <input  type="file" id="upload_file" style="display: none"/>
                              
                            </div>
                          </div>
                        </div>
                      </div>
                      
                                            
                      
                      <div class="form-group">                        
                        <label class="control-label col-md-1 col-sm-2 col-xs-12" for="img_path">Trích dẫn</label>
                        <div class="col-md-11 col-sm-11 col-xs-12">
                          <textarea type="text" id="des" name="des" class="form-control col-md-7 col-xs-12" style="height:90px">{{des}}</textarea>                          
                        </div>                        
                      </div>
                      <div class="form-group">                        
                        <!--<label class="control-label col-md-2 col-sm-2 col-xs-12" for="ctg_name">Nội dung</label>-->
                        <div class="col-md-12 col-sm-12 col-xs-12">
                          <textarea  id="pro_content" name="content">{{content}}</textarea>
                        </div>
                      </div>                    
                      <div class="ln_solid"></div>
                      <div class="form-group">
                        <div class="col-md-12 col-sm-12" style="text-align: center">
                          <a class="dialog_close btn btn-primary" href="{{url.get('news')}}">Thoát</a>
                          <button class="btn btn-success" id="btn_save" type="button">Cập nhật</button>
                        </div>
                      </div>
                    </form>
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
         <!-- </div>-->
        
        </div>
        <!-- footer content -->       
        {{ partial('includes/footer') }}
        <!-- /footer content -->
        
      </div>
    </div>

<script>
  $(document).ready(function() {
    $('#pro_content').froalaEditor({
    theme: 'royal',
    language: 'vi',
    imageUploadURL:"{{url.get('phofile/upload/')}}{{folder_tmp}}"
    });
            
        
        $(document).off('blur','.number_format'); 
        $(document).on('blur','.number_format',function(event){
          var val = $(this).val();
          if($.isNumeric( val) == false){
            $(this).val("");
            return;
          }
          $(this).val( parseFloat($(this).val().replace(/,/g, ""))
                       // .toFixed(2)
                        .toString()
                        .replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                        );
        });
    $(document).off('click','#btn_save'); 
        $(document).on('click','#btn_save',function(event){
          var msg = check_validate_update();
          if(msg !=""){
            Pho_message_box_error("Lỗi",msg);
            return;
          }
          var arr = $('#form_ctg').serializeArray();
      Pho_json_ajax('POST',"{{url.get('news/update')}}" ,arr,function(datas){
        if(datas.status =="OK"){
          //Pho_modal_close("modal1");
          //Pho_message_box("Thông báo",datas.msg);
          Pho_direct("{{url.get('news')}}");
        }else{
          Pho_message_box_error("Lỗi",datas.msg);
        }
                
            });

        });
        var check_validate_update = function(){
          if($('#news_name').val()==''){
            return "Bạn chưa nhập tiêu đề tin !";
          } 
          if($('#ctg_id').val()==''){
            return "Bạn chưa chọn danh mục !";
          } 
          if($('#img_path').val()==''){
            return "Bạn chưa upload ảnh đại diện!";
          }       
          return "";
        };
        $(document).off('click','#btn_upload'); 
        $(document).on('click','#btn_upload',function(event){
          $('#upload_file').click();
        }); 
        $(document).off('change','#upload_file'); 
        $(document).on('change','#upload_file',function(event){
          var corractpath = $(this).val();
          //var filename = corractpath.replace(/^.*[\\\/]/, '')         
          
          var file_data=$(this).prop("files")[0];
          //console.log(file_data); 
          var form_data=new FormData(this);
            form_data.append("file",file_data);
            var base_url= "{{url.get('')}}";
            //console.log(form_data); 
          Pho_upload("{{url.get('phofile/upload/')}}{{folder_tmp}}" ,form_data,function(datas){
            //if(datas.status =="OK"){
               //console.log(datas);
            var file_name = datas.link.replace(base_url,"");  
            $('#img_path').val(file_name);
            $('#news_avata').attr('src',datas.link);
                    
            //}else{
              //Pho_message_box_error("Lỗi",datas.msg);
            //}
                
            });
        });
    });
</script>
</body>
</html>