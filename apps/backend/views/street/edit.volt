<div class="row" style="width: 700px">
              <div class="col-md-12 col-sm-12 col-xs-12">
               
                  <div class="x_content">
                    <br />
                    <form id="form_ctg" action="" class="form-horizontal form-label-left" enctype="multipart/form-data">
                      <div class="form-group" style="text-align: center">
                      	<strong style="color: #0000ff;display: none;" id="thongbao">Thêm thành công, mời bạn tiếp tục thêm mới</strong>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" >Tỉnh/Thành phố<span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                            <select class="form-control" name="" id="ef_provin_id">
                    			<option value=""></option>
								{%for item in provincials%}
									<option value="{{item.m_provin_id}}" {%if m_provin_id == item.m_provin_id%}selected{%endif%}>{{item.m_provin_name}}</option>
								{%endfor%}
                    		</select>                  
                        </div>                        
                        <div class="col-md-1 col-sm-1 col-xs-12">
                        	
                        </div>
                        
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Quận/Huyện</label>
                        <div class="col-md-7 col-sm-7 col-xs-12">
                           <select id="ef_district_id" class="form-control" name="m_district_id" >
								<option value=""></option>
							</select>
                        </div>
                      </div> 
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Đường phố</label>
                        <div class="col-md-7 col-sm-7 col-xs-12">
                          <input type="text"  class="form-control" name="street_name" id="street_name" value="{{m_street_name}}">
                          <input type="hidden"  class="form-control" id="m_street_id" name="m_street_id" value="{{m_street_id}}">
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
          
<script>
	
	
	$(document).ready(function() {
		var district_list = Array();
    	{%for item in districts%}
			district_list.push(['{{item.m_district_id}}',"{{item.m_district_name}}",'{{item.m_provin_id}}']);
		{%endfor%}
		$(document).off('change','#ef_provin_id');
		$(document).on('change','#ef_provin_id',function(){			
			change_district_option('');			
		});
		var change_district_option= function(district_id){
			var val = $('#ef_provin_id').val();
			var option = '<option value=""></option>';
			$.each(district_list,function(key,item){
				//console.log(item);
				if(val == item[2]){
					if(district_id == item[0] ){
						option +='<option value="'+item[0]+'" selected >'+item[1]+'</option>';
					}else{
						option +='<option value="'+item[0]+'" >'+item[1]+'</option>';
					}					
				}
			});
			$('#ef_district_id').empty();
			$('#ef_district_id').append(option);
		};
		change_district_option('{{m_district_id}}');	
		
		$(document).off('click','#btn_save'); 
        $(document).on('click','#btn_save',function(event){
          if($('#ef_district_id').val()==''){
          	  Pho_message_box("Lỗi","Bạn chưa chọn quận/huyện !");
          	  return;
          }
          if($('#street_name').val()==''){
          	  Pho_message_box("Lỗi","Bạn chưa nhập tên đường phố !");
          	  return;
          }
          var arr = $('#form_ctg').serializeArray();  
	      Pho_json_ajax('POST',"{{url.get('street/update')}}" ,arr,function(datas){
		        if(datas.status =="OK"){
		        	if($('#m_street_id').val()!=''){
		        		Pho_direct(location.href);
		        	}else{
		        		$('#thongbao').show();	
		        		$('#street_name').val('');	
		        	}
		        	          
		        }else{
		             Pho_message_box_error("Lỗi",datas.msg);
		        }
	                
            });
        });
		
       
	});
	
</script>