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
	.opt_blue{
		color: #0202fd;
	}
	.opt_red{
		color: #dc010c;
	}
	table.list_file tr td{
		padding: 5px 10px 5px 5px;
		border-bottom: 1px solid #ddd;
	}
	table.list_file{
		margin-bottom: 10px;
	}
  .icon_move{
    display: block;
    bottom: 50px;
    position: fixed;
    z-index: 99;
    width: 50px;
    height: 50px;
    right: 40px;
  }
	.top{
    background-image: url("{{url.get('templateadm/images/top.png')}}");     
    background-repeat: no-repeat;   
    background-position: center; 
  }
  .down{
    background-image: url("{{url.get('templateadm/images/down.png')}}");     
    background-repeat: no-repeat;   
    background-position: center; 
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
                    <h2>Thêm sản phẩm</h2>
                    
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <div class="row">
                    	<div class="col-md-12 col-sm-12 col-xs-12">
                
                  <div class="x_content">
                    <br />
                    <form id="form_ctg" action="" class="form-horizontal form-label-left" enctype="multipart/form-data">
                      <div class="form-group">
                        <label class="control-label col-md-2 col-sm-2 col-xs-12" for="pro_name">Tên Sản phẩm<span class="required">*</span>
                        </label>
                        <div class="col-md-4 col-sm-4 col-xs-12">
                          <input type="text" id="pro_name" required="required" name="pro_name" class="form-control col-md-7 col-xs-12" value="{{pro_name}}">                          
                          <input type="hidden"  name="pro_id" value="{{pro_id}}">  
                          <input type="hidden"  name="pro_code" value="{{pro_code}}"> 
                          <input type="hidden"  name="folder_tmp" id="folder_tmp" value="{{folder_tmp}}">                        
                        </div>
                        <label class="control-label col-md-2 col-sm-2 col-xs-12" for="ctg_id">Danh mục<span class="required">*</span>
                        </label>
                        <div class="col-md-4 col-sm-4 col-xs-12">
                          
                           <select class="form-control" name="ctg_id" id="ctg_id">
                          	 <option ></option>
                          	 {%for ctg in ctg_list%}
                          	 	{%if ctg['cnt_child'] > 0%}
                          	 		<option   class="optionGroup {%if ctg['ctg_level'] == 1%}opt_blue{%elseif ctg['ctg_level'] == 2%}opt_red{%endif%}" value="{{ctg['ctg_id']}}" {%if ctg['ctg_id'] == ctg_id%}selected="selected"{%endif%}>{%if ctg['ctg_level'] == 2%}&nbsp;&nbsp;&nbsp;{%elseif ctg['ctg_level'] == 3%}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{%endif%}{{ctg['ctg_name']}}</option>
                          	 	{%else%}
                          	 		<option class="{%if ctg['ctg_level'] == 1%}opt_blue{%elseif ctg['ctg_level'] == 2%}opt_red{%endif%}"  value="{{ctg['ctg_id']}}" {%if ctg['ctg_id'] == ctg_id%}selected="selected"{%endif%}>{%if ctg['ctg_level'] == 2%}&nbsp;&nbsp;&nbsp;{%elseif ctg['ctg_level'] == 3%}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{%endif%}{{ctg['ctg_name']}}</option>
                          	 	{%endif%}
                          	 {%endfor%}                          	 
                          </select>                          
                        </div>
                      </div>
                                           
                      <div class="form-group">                       
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">Trạng thái</label>
                        <div class="col-md-2 col-sm-2 col-xs-12">
                          <select class="form-control" name="status">
                          	 <option value="0" {%if status == 0%}selected="selected"{%endif%}>Còn hàng</option>
                          	 <option value="1" {%if status == 1%}selected="selected"{%endif%}>Hết hàng</option>
                          </select>
                        </div>
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">SP bán chạy</label>
                        <div class="col-md-2 col-sm-2 col-xs-12">
                          <select class="form-control" name="good_sell">
                          	 <option value="" ></option>
                          	 <option value="1" {%if good_sell == "1"%}selected="selected"{%endif%}>Có</option>
                          	 <option value="0" {%if good_sell == "0"%}selected="selected"{%endif%}>Không</option>
                          </select>
                        </div>
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">Full box</label>
                        <div class="col-md-2 col-sm-2 col-xs-12">
                          <select class="form-control" name="full_box">
                             <option value="" ></option>
                          	 <option value="1" {%if full_box == "1"%}selected="selected"{%endif%}>Có</option>
                          	 <option value="0" {%if full_box == "0"%}selected="selected"{%endif%}>Không</option>
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
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">Hiện thị trang chủ</label>
                        <div class="col-md-2 col-sm-2 col-xs-12">
                          <select class="form-control" name="disp_home">
                             <option value="0" {%if disp_home == 0%}selected="selected"{%endif%}>Ẩn</option>
                             <option value="1" {%if disp_home == 1%}selected="selected"{%endif%}>Hiện</option>
                          </select>                          
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">Nguồn sản phẩm</label>
                        <div class="col-md-7 col-sm-7 col-xs-12">
                          <input type="text" id="src_link" name="src_link" class="form-control col-md-7 col-xs-12" value="{{src_link}}">                              
                        </div> 
                         <div class="col-md-1">
                              <a class="btn btn-default btn-warning" type="button" href="{{src_link}}" target="_blank">Xem</a>
                        </div> 
                        <label class="control-label col-md-2 col-sm-2 col-xs-12"><input type="checkbox" id="not_src"> không có nguồn</label>
                                            
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">Kích thước</label>
                        <div class="col-md-6 col-sm-5 col-xs-12">
                        	<a class="btn btn-default btn-xs btn_size" type="button" id="btn_S">S</a>
                        	<a class="btn btn-default btn-xs btn_size" type="button" id="btn_M">M</a>
                        	<a class="btn btn-default btn-xs btn_size" type="button" id="btn_L">L</a>
                        	<a class="btn btn-default btn-xs btn_size" type="button" id="btn_XL">XL</a>
                        	<a class="btn btn-default btn-xs btn_size" type="button" id="btn_XXL">XXL</a>
                        	<a class="btn btn-default btn-xs btn_size" type="button" id="btn_XXXL">XXXL</a>
                        	<a class="btn btn-default btn-xs btn_size" type="button" id="btn_26">26</a>
                        	<a class="btn btn-default btn-xs btn_size" type="button" id="btn_27">27</a>
                        	<a class="btn btn-default btn-xs btn_size" type="button" id="btn_28">28</a>
                        	<a class="btn btn-default btn-xs btn_size" type="button" id="btn_29">29</a>
                        	<a class="btn btn-default btn-xs btn_size" type="button" id="btn_30">30</a>
                        	<a class="btn btn-default btn-xs btn_size" type="button" id="btn_31">31</a>
                        	<a class="btn btn-default btn-xs btn_size" type="button" id="btn_32">32</a>
                        </div>
                        <div class="col-md-4 col-sm-5 col-xs-12">
                          <input type="text" id="sizelist" name="sizelist" class="form-control" value="{{sizelist}}"> 
                        </div>              
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-2 col-sm-2 col-xs-12">Description</label>
                        <div class="col-md-10 col-sm-10 col-xs-12">
                          <input type="text" id="description" name="description" class="form-control" value="{{description}}">
                        </div>              
                      </div>
                      <div class="form-group">
                        <div class="col-md-2 col-sm-2 col-xs-12">
                          <a class="btn btn-primary" type="button" id="btn_add_size" style="float: right">Thêm Giá</a>
                        </div>
                        <div class="col-md-10 col-sm-10 col-xs-12">
                          <table class="list_file" id="list_size">
                            <colgroup>
                                <col width="7%">
                                <col width="18%">
                                <col width="7%">
                                <col width="18%">
                                <col width="7%">
                                <col width="18%">
                                <col width="7%">
                                <col width="18%">
                            </colgroup>
                            {%if new_flg ==1%} 
                            <tr>
                              <td>Size</td>
                              <td><input type="text" name="pro_size[]" class="form-control size_format" value="-">
                              	  <input type="hidden" name="pro_price_id[]" value="0">
                              </td>
                              <td>Giá nhập</td>
                              <td><input type="text" name="price_imp[]" class="col-md-3 form-control number_format imp" value=""></td>
                              <td>Giá CTV</td>
                              <td><input type="text" name="price_seller[]" class="col-md-3 form-control number_format" value=""></td>
                              <td>Giá bán lẻ</td>
                              <td><input type="text" name="price_exp[]" class="col-md-3 form-control number_format" value=""></td>
                            </tr>
                            {%endif%}
                            {%for pri in price_list%}                           
                            <tr>
                              <td>Size</td>
                              <td><input type="text" name="pro_size[]" class="form-control size_format" value="{{pri['size']}}">
                              	  <input type="hidden" name="pro_price_id[]" value="{{pri['pro_price_id']}}">
                              </td>
                              <td>Giá nhập</td>
                              <td><input type="text" name="price_imp[]" class="col-md-3 form-control number_format imp" value="{{elements.currency_format(pri['price_imp'],',')}}"></td>
                              <td>Giá CTV</td>
                              <td><input type="text" name="price_seller[]" class="form-control number_format" value="{{elements.currency_format(pri['price_seller'],',')}}"></td>
                              <td>Giá bán lẻ</td>
                              <td><input type="text" name="price_exp[]" class="form-control number_format" value="{{elements.currency_format(pri['price_exp'],',')}}"></td>
                            </tr>
                            {%endfor%}
                          </table>
                        </div>                          
                      </div>                    
                     
                      <div class="form-group">
                      	<div class="col-md-2 col-sm-2 col-xs-12">
                      		<a class="btn btn-primary" type="button" id="btn_upload" style="float: right">Thêm Ảnh</a>
                        	
                        	<input  type="file" id="upload_file" multiple="true" style="display: none" accept=".JPG,.PNG,.GIF"/>
                      	</div>
                      	<div class="col-md-8 col-sm-8 col-xs-12">
                      		<table class="list_file" id="list_file">
                      			{%for img in img_list%}                      			
                      			<tr id="tr_{{img.pro_img_id}}">                      				
                      				<td><img class="img-rounded" id="img_{{img.pro_img_id}}" height="60" src="{{url.get(img.img_path)}}">                      					
                      				</td>
                      				<td>
                      					<a class="btn btn-danger btn-xs btn_del_img" id="del_{{img.pro_img_id}}" type="button">Xóa hình</a>
                      				</td>
                      				<td><label><input type="radio" name="chk" value="0" id="radio_{{img.pro_img_id}}" {%if img.avata_flg ==1%}checked="true"{%endif%} >làm ảnh đại diện</label> 
                                <input type="hidden" name="img_list[{{img.pro_img_id}}]" value="{{img.img_path}}">
                      				</td>
                      				<td>Màu</td>
                      				<td><input type="text" name="color[{{img.pro_img_id}}]" value="{{img.color}}"></td>
                      			</tr>
                      			{%endfor%}
                      		</table>
                      	</div>                      		
                      </div>
                      <div class="form-group">
                      	<div class="col-md-12 col-sm-12 col-xs-12">    
                      	  <div class="" role="tabpanel" data-example-id="togglable-tabs">
		                      <ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
		                        <li role="presentation" class="active"><a href="#tab_content1" id="home-tab" role="tab" data-toggle="tab" aria-expanded="true">Mô tả</a>
		                        </li>
		                        <li role="presentation" class=""><a href="#tab_content2" role="tab" id="profile-tab" data-toggle="tab" aria-expanded="false">Thông số kỹ thuật</a>		                        
		                        </li>	
		                        <li role="presentation" class=""><a href="#tab_content3" role="tab" id="profile-tab" data-toggle="tab" aria-expanded="false">Khuyến mãi</a>		                        
		                        </li>	                        
		                      </ul>
		                      <div id="myTabContent" class="tab-content">
		                        <div role="tabpanel" class="tab-pane fade active in" id="tab_content1" aria-labelledby="home-tab">
		                          <textarea  id="pro_content" name="content">{{content}}</textarea>
		                        </div>
		                        <div role="tabpanel" class="tab-pane fade" id="tab_content2" aria-labelledby="profile-tab">
		                          <textarea  id="tech" name="technology">{{technology}}</textarea>
		                        </div>
		                        <div role="tabpanel" class="tab-pane fade" id="tab_content3" aria-labelledby="profile-tab">
		                          <textarea  id="khuyenmai" name="promotions">{{promotions}}</textarea>
		                        </div>		                        
		                      </div>
		                    </div>
                    	</div>	
                      </div>                    
                      <div class="ln_solid"></div>
                      <div class="form-group">
                        <div class="col-md-12 col-sm-12" style="text-align: center">
                          <a class="dialog_close btn btn-primary" href="{{url_refer}}">Thoát</a>
                          <a class="btn btn-success" id="btn_save" >Cập nhật</a>
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
        
           <a class="icon_move top"></a>
       
        </div>
        <!-- /page content -->
<script>
	$(document).ready(function() {
		var cnt_add = 0;
		$('#pro_content').froalaEditor({
		theme: 'royal',
		language: 'vi',
		imageUploadURL:"{{url.get('phofile/upload/')}}{{folder_tmp}}",
		imageManagerLoadURL: "{{url.get('phofile/list/')}}?id={{pro_id}}&folder_tmp={{folder_tmp}}&folder_name=products",
	  });
	  $('#tech').froalaEditor({
		theme: 'royal',
		language: 'vi',
		imageUploadURL:"{{url.get('')}}phofile/upload/{{folder_tmp}}"
	  });
	  $('#khuyenmai').froalaEditor({
		theme: 'royal',
		language: 'vi',
		imageUploadURL:"{{url.get('')}}phofile/upload/{{folder_tmp}}"
	  });
		        
        
        $(document).off('blur','.number_format'); 
        $(document).on('blur','.number_format',function(event){
        	var val = $(this).val().replace(/,/g,'');
        	if($.isNumeric( val) == false){
        		$(this).val("");
        		return;
        	}
        	$(this).val( number_format($(this).val())   );
		    if($(this).hasClass('imp')){
		    	var per_exp={{percent_exp}};
		    	var per_seller={{percent_seller}};
		    	var td_seller = $(this).parent().next().next();
		    	var td_exp = $(td_seller).next().next();
		    	var input_seller = $(td_seller).find('input')[0];
		    	var input_exp = $(td_exp).find('input')[0];
		    	var round_num =100;
		    	if(parseFloat(val)>=30000){
		    		round_num =1000;
		    	}
		    	var price_seller = Math.round((parseFloat(val) + parseFloat(val)*per_exp/100)/round_num)*round_num;
		    	$(input_seller).val(number_format(price_seller));
		    	$(input_exp).val(number_format(Math.round((price_seller + price_seller*per_seller/100)/round_num)*round_num));
		    }
        });
        var number_format= function(val){
        	console.log(val);
        	if(val == null || val.length==0) return '';
        	return parseFloat(val.toString().replace(/,/g, ""))
		                   // .toFixed(2)
		                    .toString()
		                    .replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }
		$(document).off('click','#btn_save'); 
        $(document).on('click','#btn_save',function(event){
        	var msg = check_validate_update();
        	if(msg !=""){
        		Pho_message_box_error("Lỗi",msg);
        		return;
        	}
        	var arr = $('#form_ctg').serializeArray();
        	console.log(get_avata_id());
        	arr.push({name:'avata_id',value:get_avata_id()});
        	//arr.append('avata_id',get_avata_id());
        	console.log(arr);
			    Pho_json_ajax('POST',"{{url.get('')}}product/update" ,arr,function(datas){
				if(datas.status =="OK"){
					//Pho_modal_close("modal1");
					//Pho_message_box("Thông báo",datas.msg);
					Pho_direct("{{url_refer}}");
				}else{
					Pho_message_box_error("Lỗi",datas.msg);
				}
                
            });
        });
        var check_validate_update = function(){
        	if($('#pro_name').val()==''){
        		return "Bạn chưa nhập tên sản phẩm !";
        	}
        	if($('#ctg_id').val()==''){
        		return "Bạn chưa chọn danh mục !";
        	}
        	if($('#price_seller').val()==''){
        		return "Bạn chưa nhập giá CTV!";
        	}
        	if($('#price_imp').val()==''){
        		return "Bạn chưa nhập giá nhập!";
        	}
        	if($('#price_exp').val()==''){
        		return "Bạn chưa nhập giá bán lẻ!";
        	}
        	if($("#list_file").find('img').length==0){
        		return "Bạn chưa upload ảnh cho sản phẩm!";
        	}
        	if($("#src_link").val()=='' && $('#not_src').prop('checked')==false){
        		return "Bạn chưa nhập nguồn sản phẩm";
        	}
        	/*if($("#description").val()==''){
        		return "Bạn chưa nhập Description";
        	}*/
          var msg ="";
          $('#list_size').find('tr').each(function(){
              var size_input = $(this).find('.size_format')[0];
              var price_input = $(this).find('.number_format')[0];
              console.log(size_input);
              var size_vl = $(size_input).val();
              console.log(size_vl);
              var price_vl = $(price_input).val();
              console.log(price_vl);
              if((size_vl + price_vl).length >0 ){
                  if(size_vl.length == 0){
                      msg = "Bạn phải nhập màu cho giá: "+ price_vl + ",  nếu không xác định màu thì nhập dấu -";    
                      return false;                 
                  }
                  if(price_vl.length == 0){
                      msg = "Bạn phải nhập giá cho màu: "+ size_vl;   
                      return false;                  
                  }
              }
              // if(msg !=""){
              //    break;
              // }
          });
        	return msg;
        };
        $(document).off('click','.btn_size'); 
        $(document).on('click','.btn_size',function(event){
        	var id=$(this).attr('id').replace('btn_','');
        	var val = $('#sizelist').val();
        	if(val.trim()==''){
        		$('#sizelist').val(id);
        	}else{
        		$('#sizelist').val(val+';'+id);
        	}
        });
        $(document).off('click','.icon_move'); 
        $(document).on('click','.icon_move',function(event){
            if($(this).hasClass('top')){
                $(this).removeClass('top');
                $(this).addClass('down');
                document.body.scrollTop = 0; // For Chrome, Safari and Opera 
                document.documentElement.scrollTop = 0; // For IE and Firefox                
            }else{
                $(this).removeClass('down');
                $(this).addClass('top');
                document.body.scrollTop = $(document).height(); // For Chrome, Safari and Opera 
                document.documentElement.scrollTop = $(document).height(); // For IE and Firefox
                
            }
        }); 
        $(window).scroll(function(e){
          
            var x = $(window).scrollTop();
            console.log(x);
            var height_comp = $(document).height()/2;
            if(x<height_comp){
                $('.icon_move').removeClass('top');
                $('.icon_move').addClass('down');
            }else{                
                $('.icon_move').removeClass('down');
                $('.icon_move').addClass('top');
            }
        });
        $(document).off('click','#btn_upload'); 
        $(document).on('click','#btn_upload',function(event){
        	$('#upload_file').click();
        });	
        $(document).off('change','#upload_file'); 
        $(document).on('change','#upload_file',function(event){
        	//var corractpath = (this).val();
        	//var filename = corractpath.replace(/^.*[\\\/]/, '')        	
        	
        	var file_data=$(this).prop("files");
        	//console.log(file_data);	
        	if(file_data.length == 0){
        		return;
        	}
        	var form_data=new FormData(this);
        	for(var i=0;i<file_data.length;i++){
        		form_data.append(i,file_data[i]);
        	}        	
            form_data.append("folder_tmp",$('#folder_tmp').val());
            var base_url= "{{url.get('')}}";
            //console.log(form_data);	
        	Pho_upload("{{url.get('')}}product/upload" ,form_data,function(datas){
				if(datas.status =="OK"){
					//console.log(datas);					
                   // var cnt_add = ("#list_file").find('.add_img').length;  			
					for(var i=0;i<datas.link.length;i++){
		        		//form_data.append(i,file_data[i]);
		        		cnt_add++;
		        		var html_tr= '<tr id="tr_add_'+cnt_add+'"><td><img class="img-rounded" height="60" src="'+datas.link[i]+'" id="img_add_'+cnt_add+'"></td><td><a class="btn btn-danger btn-xs btn_del_img" id="del_add_'+cnt_add+'">Xóa hình</a></td><td><label><input type="radio" name="chk" value="1" id="radio_add_'+cnt_add+'">Chọn làm ảnh đại diện </label><input type="hidden" name="img_add['+cnt_add+']" value="'+datas.link[i]+'"></td><td>Màu</td><td><input type="text" name="color['+cnt_add+']" value=""></td></tr>';
		        		$("#list_file").append(html_tr);		        		
		        	}
		        	if(get_avata_id()==""){
		        		$("#radio_add_1").prop('checked',true);	
		        	}
					//var file_name = datas.link.replace(base_url,"");	
					//('#img_path').val(file_name);				
				}else{
					Pho_message_box_error("Lỗi",datas.msg);
				}
                
            });
        });	
	$(document).off('click','.btn_del_img'); 
    $(document).on('click','.btn_del_img',function(){
        	var id = $(this).attr('id');
        	//console.log(id);
        	//id ="del_add_1";
        	id = id.toString().replace('del_','');
        	//id = str_replace(id,"sdel_","");
        	//console.log(1);
        	var img_path = $('#img_'+id).attr('src');
        	//console.log(2);
        	$('#tr_'+id).remove();
        	//("#list_file").remove(('#tr_'+id));
        	//console.log(3);
        	$("#list_file").append('<input type="hidden" name="img_del[]" value="'+img_path+'">');
        	//console.log(4);
    });
    $(document).off('click','#btn_add_size'); 
    $(document).on('click','#btn_add_size',function(event){
          var html='<tr><td>Màu sắc</td><td><input type="text" name="pro_size[]" class="form-control size_format" value=""><input type="hidden" name="pro_price_id[]" value="0"></td><td>Giá nhập</td><td><input type="text" name="price_imp[]" class="form-control number_format imp" value="" ></td><td>Giá CTV</td><td><input type="text" name="price_seller[]" class="form-control number_format" value="" ></td><td>Giá bán lẻ</td><td><input type="text" name="price_exp[]" class="form-control number_format" value="" ></td></tr>';
          $('#list_size').append(html);
    });    
		var get_avata_id =  function(){
			var list_ra = $("#list_file").find('input[type="radio"]');
			var avata_id ="";
			list_ra.each(function(){
				//console.log((this).prop('checked'));
				if($(this).prop('checked')){					
					avata_id = $(this).attr('id').replace('radio_','');
					return avata_id;
				}
			});
			return avata_id;
		}
    });
    function str_replace(str,str_find,str_rep){
    	return str.replace(str_find,str_rep);
    }
</script>

