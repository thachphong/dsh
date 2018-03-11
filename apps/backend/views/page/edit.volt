
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
                    <h2>Thêm Trang</h2>
                    
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <div class="row">
                      <div class="col-md-12 col-sm-12 col-xs-12">
                
                  <div class="x_content">
                    <br />
                    <form id="form_ctg" action="" class="form-horizontal form-label-left" enctype="multipart/form-data">
                      <div class="form-group">
                        <label class="control-label col-md-2 col-sm-2 col-xs-12" for="page_name">Tên Trang<span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input type="text" id="page_name" required="required" name="page_name" class="form-control col-md-7 col-xs-12" value="{{page.page_name}}">                          
                          <input type="hidden"  name="page_id" value="{{page.page_id}}">                        
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">Hiện/Ẩn</label>
                        <div class="col-md-2 col-sm-2 col-xs-12">
                          <select class="form-control" name="del_flg">
                             <option value="0" {%if page.del_flg == 0%}selected="selected"{%endif%}>Hiện</option>
                             <option value="1" {%if page.del_flg == 1%}selected="selected"{%endif%}>Ẩn</option>
                          </select>                          
                        </div>
                        <!--<label class="control-label col-md-2 col-sm-2 col-xs-12">Hiện ở trang chủ</label>
                        <div class="col-md-2 col-sm-2 col-xs-12">
                          <select class="form-control" name="disp_home">
                             <option value="0" <%if $disp_home == 0%>selected="selected"<%/if%>>Ẩn</option>
                             <option value="1" <%if $disp_home == 1%>selected="selected"<%/if%>>Hiện</option>
                          </select>                          
                        </div>-->
                      </div> 
                      <!--<div class="form-group">
                        <div class="col-md-2 col-sm-2 col-xs-12">
                          <a class="btn btn-primary" type="button" id="btn_upload" style="float: right">Ảnh đại diện</a>
                          
                          <input  type="file" id="upload_file" style="display: none" accept=".JPG,.PNG,.GIF"/>
                          <input  type="hidden" name="img_path" id="img_path" value="<%$img_path%>"/>
                        </div>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <img class="img-rounded" height="100" src="<%$smarty.const.ACW_BASE_URL_DATA%><%$img_path%>" <%if strlen($img_path)==0%> style="display:none"<%/if%> id="img_disp">       
                        </div>
                      </div>-->
                      <div class="form-group">                        
                        <!--<label class="control-label col-md-2 col-sm-2 col-xs-12" for="ctg_name">Nội dung</label>-->
                        <div class="col-md-12 col-sm-12 col-xs-12">
                          <textarea  id="pro_content" name="content">{{page.content}}</textarea>
                        </div>
                      </div>                    
                      <div class="ln_solid"></div>
                      <div class="form-group">
                        <div class="col-md-12 col-sm-12" style="text-align: center">
                          <a class="dialog_close btn btn-primary" href="{{url.get('page')}}">Thoát</a>
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
        <!-- /page content -->
    
     
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
      Pho_json_ajax('POST',"{{url.get('page/update')}}" ,arr,function(datas){
        if(datas.status =="OK"){
          //Pho_modal_close("modal1");
          //Pho_message_box("Thông báo",datas.msg);
          Pho_direct("{{url.get('page')}}");
        }else{
          Pho_message_box_error("Lỗi",datas.msg);
        }
                
            });
        });
        var check_validate_update = function(){
          if($('#page_name').val()==''){
            return "Bạn chưa nhập tên trang !";
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
          Pho_upload("{{url.get('phofile/upload')}}" ,form_data,function(datas){
        //if(datas.status =="OK"){
           //console.log(datas);
        var file_name = datas.link.replace(base_url,"");  
        $('#img_disp').attr('src',datas.link);  
        $('#img_disp').show();  
        $('#img_path').val(file_name);    
        //}else{
          //Pho_message_box_error("Lỗi",datas.msg);
        //}
                
            });
        }); 

        
    
    });
</script>
     
    
  
</body>
</html>
