<style>
#filedrag
{	
	font-weight: bold;
	text-align: center;	
	color: #555;
	border: 2px dashed rgb(169, 169, 169);
	border-radius: 7px;
	cursor: default;
	overflow: hidden;
	padding-top: 10px;
}

#filedrag.hover
{
	color: #f00;
	border-color: #f00;
	border-style: solid;
	box-shadow: inset 0 3px 4px #888;
}
</style>
<div class="row">
	<div class="container">
		{{ partial('includes/user_left') }}
		{% set define= elements.get_define()%}
		<div class="col-md-9 col-sm-12 col-xs-12 no_padding_right">
			<div class="pn_posts">
				<div class="pn_title">
					<span class="bg_icon"><i class="fa post-pencil"></i></span>
					<h1>ĐĂNG TIN RAO BÁN, CHO THUÊ NHÀ ĐẤT</h1>
				</div>				
				<div class="pn_content pn_background pn_border margin_top">
					<div>
						<h3>Thông tin cơ bản</h3>
					</div>
					<form enctype="multipart/form-data" id="from_post">
						<input type="hidden" name="folder_tmp" id="folder_tmp"  value="{{folder_tmp}}">
						<input type="hidden" name="post_id" id="post_id"  value="{{post_id}}">
						<input type="hidden" name="post_view_id"  value="{{post_view_id}}">
						<input type="hidden" name="post_contract_id" value="{{post_contract_id}}">					

						<div class="row row-margin-bottom lab_invisible" id="lab_message_error" style="text-align:center">
							<label class="lab_red">Có một số thông tin chưa hợp lệ, vui lòng nhập lại !</label>
						</div>
						<div class="row row-margin-bottom">
							<label class="col-md-2 col-sm-2 col-xs-12 title_col">Loại tin <span class="lab_red">(*)</span>:</label>
							<div class="col-md-2 col-sm-2 col-xs-12">
								<label class="control control-radio">
							        BĐS Bán
							        <input type="radio" name="m_type_id" {%if m_type_id ==1%}checked="checked"{%endif%} value="1" class="m_type_id" />
							        <div class="control_indicator"></div>
							    </label>
							</div>
							<div class="col-md-3 col-sm-3 col-xs-12">							
								<label class="control control-radio">
							        BĐS Cho thuê
							        <input type="radio" name="m_type_id" {%if m_type_id ==2%}checked="checked"{%endif%} value="2" class="m_type_id"/>
							        <div class="control_indicator"></div>
							    </label>
							</div>
						</div>
						<div class="row row-margin-bottom">
							<label class="col-md-2 col-sm-2 col-xs-12 title_col">Tiêu đề <span class="lab_red">(*)</span>:</label>
							<div class="col-md-9 col-sm-9 col-xs-12">
								<input type="text" name="post_name" required value="{{post_name}}" id="post_name" maxlength="99" placeholder="Tiêu đề tối đa là 99 ký tự">
								<label class="lab_red lab_invisible" id="post_name_error">Bạn cần nhập tiêu đề !</label>
							</div>												
						</div>
						<div class="row row-margin-bottom">
							<label class="col-md-2 col-sm-2 col-xs-12 title_col">Loại nhà đất <span class="lab_red">(*)</span>:</label>
							<div class="col-md-4 col-sm-4 col-xs-12">
								<label class="select_icon">
									<select name="ctg_id" id="ctg_id" required>
										<option value="">--Chọn loại bất động sản--</option>
									</select>
								</label>
								<label class="lab_red lab_invisible" id="ctg_id_error">Bạn cần chọn loại nhà đất !</label>
							</div>
						</div>
						<div class="row row-margin-bottom">
							<label class="col-md-2 col-sm-2 col-xs-12 title_col">Vị trí <span class="lab_red">(*)</span>:</label>
							<div class="col-md-4 col-sm-4 col-xs-12">
								<label class="select_icon">
									<select id="m_provin_id" name="m_provin_id" required class="opt_height">
										<option value="">--Chọn Tỉnh/Thành phố--</option>
										{%for item in provincials%}
											<option value="{{item.m_provin_id}}" {%if m_provin_id == item.m_provin_id%}selected{%endif%}>{{item.m_provin_name}}</option>
										{%endfor%}
									</select>
								</label>
								<label class="lab_red lab_invisible" id="m_provin_id_error">Bạn cần chọn tỉnh/thành phố !</label>
							</div>
							<div class="col-md-4 col-sm-4 col-xs-12">
								<label class="select_icon">
									<select id="m_district_id" name="m_district_id" required class="opt_height">
										<option value="">--Chọn Quận/Huyện--</option>
									</select>
								</label>
								<label class="lab_red lab_invisible" id="m_district_id_error">Bạn cần chọn quận/huyện !</label>
							</div>
						</div>
						<div class="row row-margin-bottom">
							<label class="col-md-2 col-sm-2 col-xs-12 title_col"></label>
							<div class="col-md-4 col-sm-4 col-xs-12">
								<label class="select_icon">
									<select name="m_ward_id" id="m_ward_id" class="opt_height">
										<option value="">--Chọn Phường/Xã--</option>
									</select>
								</label>
							</div>
							<div class="col-md-4 col-sm-4 col-xs-12">
								<label class="select_icon">
									<select class="m_street_id" name="m_street_id" id="m_street_id" class="opt_height">
										<option value="">--Chọn Đường/Phố--</option>
									</select>
								</label>
							</div>
						</div>
					    <!--<div class="row row-margin-bottom">
														
						</div>-->
						<div class="row row-margin-bottom">
							<label class="col-md-2 col-sm-2 col-xs-12 title_col">Giá</label>
							<div class="col-md-4 col-sm-4 col-xs-12">
								<input type="number" name="price" value="{{price}}">
							</div>
							<label class="col-md-1 col-sm-1 col-xs-12 title_col">Đơn vị</label>
							<div class="col-md-3 col-sm-3 col-xs-12">
								<label class="select_icon">
									<select name="unit_price" id="unit_price">
										<option value="">--Chọn đơn vị--</option>
									</select>
								</label>
							</div>							
						</div>
						<div class="row row-margin-bottom">
							<label class="col-md-2 col-sm-2 col-xs-12 title_col"></label>
							<div class="col-md-4 col-sm-4 col-xs-12">
								<label class="select_icon">
									<select name="project_id" id="project_id">
										<option value="">--Chọn Dự án--</option>
										{%for item in projects%}
										<option value="{{item['news_id']}}">{{item['news_name']}}</option>
										{%endfor%}
									</select>
								</label>
							</div>
							<label class="col-md-1 col-sm-1 col-xs-12 title_col" style="padding-right: 0px">Diện tích</label>
							<div class="col-md-3 col-sm-3 col-xs-12">
								<input type="number" name="acreage" value="{{acreage}}">
							</div>
							<label class="col-md-1 col-sm-1 col-xs-12 title_col">m2</label>
						</div>
						<div class="row row-margin-bottom">
							<label class="col-md-2 col-sm-2 col-xs-12 title_col">Địa điểm<span class="lab_red">(*)</span>:</label>
							<div class="col-md-9 col-sm-9 col-xs-12">
								<input type="text" name="address" id="post_address" required value="{{address}}">
								<label class="lab_red lab_invisible" id="post_address_error">Bạn cần nhập địa điểm !</label>
							</div>							
						</div>
						<hr/>
						<div>
							<h3>Thông tin khác</h3>
						</div>
						<div class="row row-margin-bottom">
							<label class="col-md-2 col-sm-2 col-xs-12 title_col">Mặt tiền</label>
							<div class="col-md-3 col-sm-3 col-xs-12">
								<input type="number" name="facade_width" value="{{facade_width}}">
							</div>	
							<label class="col-md-2 col-sm-2 col-xs-12 title_col">Đường trước nhà</label>
							<div class="col-md-3 col-sm-3 col-xs-12">
								<input type="number" name="street_width" value="{{street_width}}">
							</div>						
						</div>
						<div class="row row-margin-bottom">
							<label class="col-md-2 col-sm-2 col-xs-12 title_col">Số tầng</label>
							<div class="col-md-3 col-sm-3 col-xs-12">
								<input type="number" name="floor_num" value="{{floor_num}}">
							</div>	
							<label class="col-md-2 col-sm-2 col-xs-12 title_col">Số phòng ngủ</label>
							<div class="col-md-3 col-sm-3 col-xs-12">
								<input type="number" name="room_num" value="{{room_num}}">
							</div>						
						</div>
						<div class="row row-margin-bottom">
							<label class="col-md-2 col-sm-2 col-xs-12 title_col">Hướng nhà</label>
							<div class="col-md-3 col-sm-3 col-xs-12">								
								<label class="select_icon">
									<select name="m_directional_id" id="m_directional_id">
										{%for item in directionals%}
											<option value="{{item.m_directional_id}}" {%if m_directional_id == item.m_directional_id%}selected{%endif%}>{{item.m_directional_name}}</option>
										{%endfor%}
									</select>
								</label>
							</div>	
							<label class="col-md-2 col-sm-2 col-xs-12 title_col">Số toilet</label>
							<div class="col-md-3 col-sm-3 col-xs-12">
								<input type="number" name="toilet_num" value="{{toilet_num}}">
							</div>						
						</div>
						<div class="row row-margin-bottom">
							<label class="col-md-2 col-sm-2 col-xs-12 title_col">Hướng ban công</label>
							<div class="col-md-3 col-sm-3 col-xs-12">								
								<label class="select_icon">
									<select name="huong_bancong" id="huong_bancong">
										{%for item in directionals%}
											<option value="{{item.m_directional_id}}" {%if huong_bancong == item.m_directional_id%}selected{%endif%}>{{item.m_directional_name}}</option>
										{%endfor%}
									</select>
								</label>
							</div>				
						</div>
						<div class="row row-margin-bottom">
							<label class="col-md-2 col-sm-2 col-xs-12 title_col">Nội thất</label>
							<div class="col-md-10 col-sm-10 col-xs-12">
								<textarea style="height:100px" name="furniture" id="post_content">{{furniture}}</textarea> 		
							</div>												
						</div>
						<hr/>
						<div>
							<h3>Mô tả chi tiết</h3>
						</div>
						
						<div class="row row-margin-bottom">
							<label class="col-md-2 col-sm-2 col-xs-12 title_col">Nội dung mô tả <span class="lab_red">(*)</span>:</label>
							<div class="col-md-10 col-sm-10 col-xs-12">
								<textarea style="height:130px" name="content" id="post_content" required >{{content}}</textarea> 
								<label class="lab_red lab_invisible" id="post_content_error">Bạn cần nhập nội dung mô tả!</label>
							</div>												
						</div>
						<div class="row row-margin-bottom">
							<label class="col-md-2 col-sm-2 col-xs-12 title_col">Link youtube:</label>
							<div class="col-md-10 col-sm-10 col-xs-12">
								<input type="text" name="youtube_url" value="{{youtube_url}}"  >
							</div>												
						</div>
						<div class="row row-margin-bottom">
							<label class="col-md-2 col-sm-2 col-xs-12 title_col">Cập nhật hình ảnh:</label>							
							<div class="col-md-10 col-sm-10 col-xs-12" id="img_box">
								<div id="filedrag">
									{%for img in img_list%}
									<div class="div_img" id="div_img_{{img.post_img_id}}">
										<img class="" src="{{url.get(img.img_path)}}">
										<a href="javascript:void(0)" class="delete_img" id="delete_img_{{img.post_img_id}}">X</a>
									</div>
									{%endfor%}														
									<div class="div_img" id="div_btn_img">
										<a class="btn_upload" id="btn_upload"><i class="fa fa-cloud-upload"></i><br/>Upload Ảnh</a>
										<input type="file" multiple="true" style="display: none" accept=".JPG,.PNG,.GIF" id="upload_file">
										<input type="file" id="fileselect" style="display: none" accept=".JPG,.PNG,.GIF" name="fileselect[]" multiple="multiple" />
										
									</div>
								</div>
							</div>												
						</div>						
						<hr/>
						<div>
							<h3>Thông tin bản đồ</h3>
						</div>
						<div class="row row-margin-bottom" >

							<input type="text" id="maps_address" value=""  style="display:none">
							<input type="text" name="map_lat" id="map_lat" value="{{map_lat}}"  style="display:none">
							<input type="text" name="map_lng" id="map_lng" value="{{map_lng}}"  style="display:none">
							<div id="maps_maparea">
						      <div id="maps_mapcanvas" style="margin-top:10px;" class="form-group"></div>
						    </div>
						  

						</div>
						<hr/>
						<div>
							<h3>Thông tin liên hệ</h3>
						</div>
						<div class="row row-margin-bottom">
							<label class="col-md-2 col-sm-2 col-xs-12 title_col">Họ tên <span class="lab_red">(*)</span>:</label>
							<div class="col-md-9 col-sm-9 col-xs-12">
								<input type="text" name="contract[full_name]" id="contract_name" required value="{{full_name}}">
								<label class="lab_red lab_invisible" id="contract_name_error">Bạn cần nhập họ tên !</label>
							</div>												
						</div>
						<div class="row row-margin-bottom">
							<label class="col-md-2 col-sm-2 col-xs-12 title_col">Địa chỉ:</label>
							<div class="col-md-9 col-sm-9 col-xs-12">
								<input type="text" name="contract[address]" value="{{contract_address}}">
							</div>												
						</div>
						<div class="row row-margin-bottom">
							<label class="col-md-2 col-sm-2 col-xs-12 title_col">Điện thoại:</label>
							<div class="col-md-9 col-sm-9 col-xs-12">
								<input type="text" name="contract[phone]" value="{{phone}}">
							</div>												
						</div>
						<div class="row row-margin-bottom">
							<label class="col-md-2 col-sm-2 col-xs-12 title_col">Di động <span class="lab_red">(*)</span>:</label>
							<div class="col-md-9 col-sm-9 col-xs-12">
								<input type="text" name="contract[mobie]" id="contract_phone" required value="{{mobie}}">
								<label class="lab_red lab_invisible" id="contract_phone_error">Bạn cần nhập số di động !</label>
							</div>												
						</div>
						<div class="row row-margin-bottom">
							<label class="col-md-2 col-sm-2 col-xs-12 title_col">Email:</label>
							<div class="col-md-9 col-sm-9 col-xs-12">
								<input type="text" name="contract[email]" value="{{email}}">
							</div>												
						</div>
						<hr/>
						<div>
							<h3>Loại tin và lịch đăng tin:</h3>
						</div>
						<div class="row row-margin-bottom">
							<label class="col-md-2 col-sm-2 col-xs-12 title_col">Loại tin rao</label>
							<div class="col-md-2 col-sm-2 col-xs-6 no_padding_right">
								<label class="control control-radio">
							        Tin siêu vip
							        <input type="radio" name="view[post_level]" {%if post_level ==3%}checked="checked"{%endif%} value="3" class="post_level"/>
							        <div class="control_indicator"></div>
							    </label>
							</div>
							<div class="col-md-2 col-sm-2 col-xs-6">
								<label class="control control-radio">
							        Tin vip
							        <input type="radio" name="view[post_level]" value="2" {%if post_level ==2%}checked="checked"{%endif%} class="post_level"/>
							        <div class="control_indicator"></div>
							    </label>
							</div>
							<div class="col-md-2 col-sm-2 col-xs-6">
								<label class="control control-radio">
							        Tin hot
							        <input type="radio" name="view[post_level]" value="1" {%if post_level ==1%}checked="checked"{%endif%} class="post_level"/>
							        <div class="control_indicator"></div>
							    </label>
							</div>
							<div class="col-md-2 col-sm-2 col-xs-6 no_padding_right">
								<label class="control control-radio">
							        Tin thường
							        <input type="radio" name="view[post_level]" value="0" {%if post_level ==0%}checked="checked"{%endif%} class="post_level"/>
							        <div class="control_indicator"></div>
							    </label>
							</div>												
						</div>
						<div class="row row-margin-bottom">
							<label class="col-md-2 col-sm-2 col-xs-12 title_col">Thời gian đăng từ  <span class="lab_red">(*)</span>:</label>
							<div class="col-md-3 col-sm-3 col-xs-12">
								<input type="" name="view[start_date]" class="datetimepicker datepost" id="view_start" required value="{{start_date}}">
								<label class="lab_red lab_invisible" id="view_start_error">Bạn cần nhập từ ngày!</label>
							</div>	
							<label class="col-md-1 col-sm-1 col-xs-12 title_col">Đến :</label>
							<div class="col-md-3 col-sm-3 col-xs-12">
								<input type="" name="view[end_date]" class="datetimepicker datepost" id="view_end" required value="{{end_date}}">
								<label class="lab_red lab_invisible" id="view_end_error">Bạn cần nhập đến ngày !</label>
							</div> 
							<label class="col-md-3 col-sm-3 col-xs-12 title_col"><strong id="total_date">14 ngày</strong></label>						
						</div>
						<div class="row row-margin-bottom">
							<label class="col-md-2 col-sm-2 col-xs-12 title_col">Thành tiền</label>
							<div class="col-md-8 col-sm-8 col-xs-12">
								<input type="hidden" name="view[total_day]" id="view_total_day">
								<input type="hidden" name="view[price]" id="view_price">
								<input type="hidden" name="view[vat]" id="view_vat">
								<input type="hidden" name="view[total_amount]" id="view_total_amount">
								<table class="table table-bordered" style="font-size: 12px;">
									<colgroup>
										<col width="50%"/>
										<col width="50%"/>
									</colgroup>
									<tr>
										<td>Đơn giá</td>
										<td id="view_price_post" style="text-align: right">{{define['tin_sieu_vip']}}</td>
									</tr>
									<tr>
										<td>Phí dịch vụ đăng tin</td>
										<td id="total_amt" style="text-align: right"></td>
									</tr>
									<tr>
										<td>Phí bao gồm VAT(10%)</td>
										<td id="total_vat" style="text-align: right"></td>
									</tr>	
									<tr>
										<td>Tổng tiền</td>
										<td id="total_all" style="text-align: right"></td>
									</tr>
								</table>
							</div>
							
						</div>
						<div class="row row-margin-bottom">
							<label class="col-md-2 col-sm-2 col-xs-12 title_col">Mã an toàn  <span class="lab_red">(*)</span>:</label>
							<div class="col-md-3 col-sm-3 col-xs-12">
								<input type="text" name="capcha_code" class="" id="capcha_code" required value="">
								<label class="lab_red lab_invisible" id="capcha_code_error">Bạn cần nhập mã an toàn</label>
							</div>							
							<div class="col-md-3 col-sm-3 col-xs-12">
								<img src="{{url.get('image/capcha')}}" style="border:1px solid var(--color_pn_header)" id="img-captcha">
								<a style="margin-left: 5px" href="javascript:void(0)" onclick="$('#img-captcha').attr('src', '{{url.get('image/capcha')}}?rand=' + Math.random())"><i class="fa fa-refresh"></i></a>
							</div>					
						</div>
						</form>
						<div class="row row-margin-bottom" style="margin-top:20px">
							<div class="col-md-12 col-sm-12 col-xs-12" style="text-align: center;">
								<button class="btn_dangtin btn_red" id="btn_cancel"><i class="fa fa-times"></i>Hủy bỏ</button>
								<!--<button class="btn_dangtin" id="btn_preview" style="width:110px;"><i class="fa fa-eye"></i>Xem trước</button>-->
								<button class="btn_dangtin" id="btn_save" ><i class="fa fa-check-square-o"></i>Đăng tin</button>
								<button id="mapsubmit" style="display:none">Tìm vị trí</button>
							</div>
						</div>
					
				</div>
			</div>
		</div>
	</div>
</div>
{{ stylesheet_link('template1/css/jquery.datetimepicker.css') }}
{{ javascript_include('template1/js/jquery.datetimepicker.full.min.js') }}
{{ partial('includes/pho_ajax') }}
<script type="text/javascript">
	$(document).ready(function() {
		var district_list = Array();
		var ward_list = Array();
		var street_list = Array();
		var category_list = Array();
		var unit_list = Array();
		{%for item in categorys%}
			category_list.push(['{{item.ctg_id}}',"{{item.ctg_name}}",'{{item.parent_id}}']);
		{%endfor%}

		{%for item in districts%}
			district_list.push(['{{item.m_district_id}}',"{{item.m_district_name}}",'{{item.m_provin_id}}']);
		{%endfor%}
		
		{%for item in units%}
			unit_list.push(['{{item.m_unit_id}}',"{{item.m_unit_name}}",'{{item.m_type_id}}']);
		{%endfor%}
		$('.datetimepicker').datetimepicker({
          //format:'Y/m/d H:i',
          format:'d/m/Y',
          inline:false,
          timepicker:false,
          lang:'ru'
    	});
		//console.log(district_list);
		function get_basic(provin_id){
			//console.log(provin_id);
			if(provin_id =='') return;
			loading_flg = false;
	        jsion_ajax("{{url.get('posts/wardsbypro')}}" ,{m_provin_id:provin_id},function(datas){               
	            ward_list = datas.wards;  
	            change_war_option('{{m_ward_id}}');
	        });
	    }
	    function get_street(m_district_id){
			loading_flg = false;
	        jsion_ajax("{{url.get('index/street/')}}"+m_district_id ,null,function(datas){               
	            street_list = datas.streets; 
	            console.log(datas);
	            var option = '<option value="">--Chọn Đường/Phố--</option>';
				$.each(street_list,function(key,item){
					//console.log(item);
					//if(val == item['m_district_id']){
						//if(m_ward_id == item['m_ward_id']){
							//option +='<option value="'+item['m_ward_id']+'" selected>'+item['m_ward_name']+'</option>';
						//}else{
							option +='<option value="'+item['m_street_id']+'">'+item['m_street_name']+'</option>';
						//}					
					//}
				});
				$('#m_street_id').empty();
				$('#m_street_id').append(option);
	        });
	    }
	    setTimeout(get_basic('{{m_provin_id}}'),10);
		$(document).off('change','#m_provin_id');
		$(document).on('change','#m_provin_id',function(){			
			change_district_option('');
			get_basic($(this).val());
			change_map();
		});
		var change_district_option= function(district_id){
			var val = $('#m_provin_id').val();
			var option = '<option value="">--Chọn Quận/Huyện--</option>';
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
			$('#m_district_id').empty();
			$('#m_district_id').append(option);
		};
		change_district_option('{{m_district_id}}');

		$(document).off('change','#m_district_id');
		$(document).on('change','#m_district_id',function(){			
			change_war_option('');
			change_map();
			dis_id = $(this).val();
			get_street(dis_id);
		});
		var change_war_option = function(m_ward_id){
			var val = $('#m_district_id').val();
			var option = '<option value="">--Chọn Phường/Xã--</option>';
			$.each(ward_list,function(key,item){
				//console.log(m_ward_id);
				//console.log(item);
				if(val == item['m_district_id']){
					if(m_ward_id == item['m_ward_id']){
						option +='<option value="'+item['m_ward_id']+'" selected>'+item['m_ward_name']+'</option>';
					}else{
						option +='<option value="'+item['m_ward_id']+'">'+item['m_ward_name']+'</option>';
					}					
				}
			});
			$('#m_ward_id').empty();
			$('#m_ward_id').append(option);		
		};
		//change_war_option('{{m_ward_id}}');
		$(document).off('change','#m_ward_id');
		$(document).on('change','#m_ward_id',function(){
			/*var val = $(this).val();
			var option = '<option value="">--Chọn Đường/Phố--</option>';
			$.each(street_list,function(key,item){
				//console.log(item);
				if(val == item[2]){
					option +='<option value="'+item[0]+'">'+item[1]+'</option>';
				}
			});
			$('#m_street_id').empty();
			$('#m_street_id').append(option);*/
			change_map();			
		});
		function change_map(){
			// var tinh   = $("#m_provin_id :selected").text();
			// var huyen  = $("#m_district_id :selected").text();
			// var phuong = $("#m_ward_id :selected").text();
			// var duong  = $("#m_street_id :selected").text();
			var dc   = $("#post_address").val().trim();
			var addr = "";
			// if(dc !=""){
			// 	addr += dc;
			// } 
			if($("#m_street_id").val()!=""){				
				if(addr !=""){
					addr += " "+ $("#m_street_id :selected").text();
				}else{
					addr += $("#m_street_id :selected").text();
				}
			} 
			if($("#m_ward_id").val() !=""){
				if(addr !=""){
					addr +=", " + $("#m_ward_id :selected").text();
				}else{
					addr += $("#m_ward_id :selected").text();
				}
				
			} 
			if($("#m_district_id").val() !=""){
				if(addr !=""){
					addr +=", " + $("#m_district_id :selected").text();
				}else{
					addr += $("#m_district_id :selected").text();
				}

			} 
			if($("#m_provin_id").val() !=""){
				if(addr !=""){
					addr += ", " + $("#m_provin_id :selected").text();
				}else{
					addr += $("#m_provin_id :selected").text();
				}
			} 
			$("#post_address").val(addr);
			
			change_location();
			
		}
		function change_location(){
			var addr   = $("#post_address").val().trim();
			if(addr !=''){
				addr +=', Việt Nam';
				$('#maps_address').val(addr);			
				$('#mapsubmit').click();
			}
		};
		$(document).off('change','#m_street_id');
		$(document).on('change','#m_street_id',function(){
			change_map();
		});
		$(document).off('change','#post_address');
		$(document).on('change','#post_address',function(){
			change_location();
		});
		//change_m_type_id($("input[name='m_type_id']:checked").val());
		$(document).off('change','.m_type_id');
		$(document).on('change','.m_type_id',function(){
			//var val = $("input[name='m_type_id']:checked").val();
			change_m_type_id('');
			change_unit_price('');
		});
		function change_m_type_id(ctg_id){
			var val = $("input[name='m_type_id']:checked").val();
			var option = '<option value="">--Chọn loại bất động sản--</option>';
			$.each(category_list,function(key,item){
				//console.log(item);
				if(val == item[2]){
					if(ctg_id == item[0]){
						option +='<option value="'+item[0]+'" selected>'+item[1]+'</option>';
					}else{
						option +='<option value="'+item[0]+'">'+item[1]+'</option>';
					}					
				}
			});
			$('#ctg_id').empty();
			$('#ctg_id').append(option);
		}		
		change_m_type_id('{{ctg_id}}');
		function change_unit_price(m_unit_id){
			var val = $("input[name='m_type_id']:checked").val();
			var option = '<option value="">--Chọn đơn vị--</option>';			
			$.each(unit_list,function(key,item){
				//console.log(item);
				if(val == item[2]){
					if(m_unit_id == item[0]){
						option +='<option value="'+item[0]+'" selected>'+item[1]+'</option>';
					}else{
						option +='<option value="'+item[0]+'">'+item[1]+'</option>';
					}					
				}
			});
			$('#unit_price').empty();
			$('#unit_price').append(option);
		}
		change_unit_price('{{unit_price}}');
		
		function topFunction() {
		    document.body.scrollTop = 0; // For Chrome, Safari and Opera 
		    document.documentElement.scrollTop = 0; // For IE and Firefox
		}		
		$(document).off('click','#btn_save'); 
        $(document).on('click','#btn_save',function(event){
        	var msg = check_validate_update();
          	if(!msg){
            	topFunction();
            	return;
          	}
          	var arr = $('#from_post').serializeArray();
	      	Pho_json_ajax('POST',"{{url.get('posts/update')}}" ,arr,function(datas){
		        if(datas.status =="OK"){
		          //Pho_modal_close("modal1");
		          //Pho_message_box("Thông báo",'Đăng tin thành công !');
		          Pho_direct("{{url.get('dang-tin-thanh-cong/')}}" + datas.msg);
		        }else{
		          Pho_message_box_error("Lỗi",datas.msg);
		        }	                
	        });
        });
        var check_validate_update = function(){
        	var flg = true;
        	$('input:required').each(function(key,item){
        		if($(this).val().trim().length == 0){
        			$('#'+ $(this).attr('id') + "_error").show();
        			flg = false;
        		}else{
        			$('#'+ $(this).attr('id') + "_error").hide();
        		}
        	});
        	$('select:required').each(function(key,item){
        		if($(this).val().trim().length == 0){
        			$('#'+ $(this).attr('id') + "_error").show();
        			flg = false;
        		}else{
        			$('#'+ $(this).attr('id') + "_error").hide();
        		}
        	});
        	$('textarea:required').each(function(key,item){
        		if($(this).val().trim().length == 0){
        			$('#'+ $(this).attr('id') + "_error").show();
        			flg = false;
        		}else{
        			$('#'+ $(this).attr('id') + "_error").hide();
        		}
        	});        	
        	if(!flg){
        		$('#lab_message_error').show();
        	}else{
        		$('#lab_message_error').hide();
        	}
        	return flg;
        }
		//delete file
		$(document).off('click','.delete_img'); 
        $(document).on('click','.delete_img',function(event){
        	var id = $(this).attr('id').replace('delete_img_','');
        	var base_url= "{{url.get('')}}";
        	src = $('#div_img_'+id +' img').attr('src');
        	src = src.replace(base_url,"");	        	
        	if(id.indexOf('add') < 0){
        		$('#img_box').append('<input type="hidden" name="img_del[]" value="'+src+'">');
        	}
        	$('#div_img_'+id).remove();
        });
		//upload file
		$(document).off('click','#btn_upload'); 
        $(document).on('click','#btn_upload',function(event){
        	$('#upload_file').click();
        });
		$(document).off('change','#upload_file'); 
        $(document).on('change','#upload_file',function(event){
        	
        	var file_data=$(this).prop("files");
        	//console.log(file_data);	
        	if(file_data.length == 0){
        		return;
        	}
        	var form_data=new FormData(this);
        	for(var i=0;i<file_data.length;i++){
        		form_data.append(i,file_data[i]);
        	}        	
            upload_file(form_data);
        });
        
        var thanh_tien= function(){
        	var oneDay = 24*60*60*1000;
        	var fdate = $('#view_start').val().split('/');
        	var tdate = $('#view_end').val().split('/');
        	var fromdate = new Date(fdate[2],fdate[1],fdate[0]);
        	var todate = new Date(tdate[2],tdate[1],tdate[0]);
        	var total_date =Math.round(Math.abs((todate.getTime() - fromdate.getTime())/(oneDay)));;
        	$('#total_date').text(total_date + ' ngày');
        	var post_level = $('input[name="view[post_level]"]:checked').val();
        	var total_amt =0,vat=0,total=0,price=0;
        	if(post_level ==3){
        		price={{define['tin_sieu_vip']}};
        	}else if(post_level ==2){
        		price={{define['tin_vip']}};
        	}else if(post_level ==1){
        		price={{define['tin_hot']}};
        	}else{
        		price={{define['tin_thuong']}};
        	}
        	total_amt = price*total_date;
        	vat = total_amt*0.1;
        	total = total_amt + vat;
        	$('#view_price_post').text(currency_format(price)+ ' VNĐ');
        	$('#total_amt').text(currency_format(total_amt) + ' VNĐ');
        	$('#total_vat').text(currency_format(vat) + ' VNĐ');
        	$('#total_all').text(currency_format(total) + ' VNĐ');
        	$('#view_total_day').val(total_date);
        	$('#view_price').val(price);
        	$('#view_vat').val(vat);
        	$('#view_total_amount').val(total);
        }
        $(document).off('change','.post_level');
		$(document).on('change','.post_level',function(){
			thanh_tien();
		});
		$(document).off('change','.datepost');
		$(document).on('change','.datepost',function(){
			thanh_tien();
		});
		setTimeout(thanh_tien(),1000);
		
		
	});
var upload_file = function(form_data){
        	form_data.append("folder_tmp",$('#folder_tmp').val());
            var base_url= "{{url.get('')}}";
            //console.log(form_data);	
        	Pho_upload("{{url.get('posts/upload')}}" ,form_data,function(datas){
				if(datas.status =="OK"){
					//console.log(datas);					
                    var cnt_add = $('.add_img').length;  			
					for(var i=0;i<datas.link.length;i++){
		        		//form_data.append(i,file_data[i]);
		        		cnt_add++;
		        		var html_tr= '<div class="div_img" id="div_img_add_'+cnt_add+'"><img class="add_img" src="'+datas.link[i]+'"><a href="javascript:void(0)" class="delete_img" id="delete_img_add_'+cnt_add+'">X</a><input type="hidden" name="img_add['+cnt_add+']" value="'+datas.link[i]+'"></div>';
		        		$("#div_btn_img").before(html_tr);		        		
		        	}
		        	// if(get_avata_id()==""){
		        	// 	$("#radio_add_1").prop('checked',true);	
		        	// }
					//var file_name = datas.link.replace(base_url,"");	
					//$('#img_path').val(file_name);				
				}else{
					Pho_message_box_error("Lỗi",datas.msg);
				}
                
            });
};
function currency_format(n) {
    return n.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,");
};
function jsion_ajax(url,data,done_fun){
    $.ajax({
        url: url,
        data: data,
        dataType: 'json',
        success: function(datajsion) {
            done_fun(datajsion);
        },
        error: function() {
            alert('Lỗi Ajax !!!');
        },      
        type: 'GET'
    });
}
var map, ele, mapH, mapW, addEle, mapL, mapN, mapZ;

ele = 'maps_mapcanvas';
addEle = 'maps_address';
mapLat = 'map_lat';
var maplng = "map_lng";
var markers = [];
var map_lat =21.0197704; 
var map_lng = 105.8007434;
{%if map_lat|length > 0%}
	map_lat = {{map_lat}};
{%endif%}
{%if map_lng|length >0%}
	map_lng = {{map_lng}};
{%endif%}

var post_address = '{{address}}';
if(post_address.length ==0){ post_address = "152 Vũ Phạm Hàm , Phường Yên Hòa , Quận Cầu Giấy, Hà Nội";}
    function initMap() {
	  	mapW = $('#' + ele).innerWidth();
		mapH = mapW * 3 / 5;
		
		// Init MAP
		$('#' + ele).width(mapW).height(mapH > 400 ? 400 : mapH);
        var map = new google.maps.Map(document.getElementById('maps_mapcanvas'), {
          zoom: 15,
          scrollwheel: false,
          center: {lat: map_lat, lng: map_lng}
        });
		
		markers[0] = new google.maps.Marker({
	        map: map,
	        position: new google.maps.LatLng(map_lat,map_lng),
	        draggable: true,
	        animation: google.maps.Animation.DROP
	    });
		var infowindow = new google.maps.InfoWindow;
		infowindow.setContent(post_address);
        infowindow.open(map, markers[0]);
	
        var geocoder = new google.maps.Geocoder();
		//var infowindow = new google.maps.InfoWindow;
        document.getElementById('mapsubmit').addEventListener('click', function() {
          geocodeAddress(geocoder, map,infowindow);
        });
      }

      function geocodeAddress(geocoder, resultsMap,infowindow) {
        var address = document.getElementById('maps_address').value;
        geocoder.geocode({'address': address}, function(results, status) {
          if (status === 'OK') {
           	for (var i = 0, marker; marker = markers[i]; i++) {
	         	marker.setMap(null);
	         	//console.log(i);
	    	 }
	    	//setMapOnAll(null);
	    	markers=[];
            resultsMap.setCenter(results[0].geometry.location);
            marker = new google.maps.Marker({
              map: resultsMap,
              position: results[0].geometry.location
            });
			infowindow.setContent(address);
            infowindow.open(map, marker);
            markers.push(marker);
			$('#map_lat').val(results[0].geometry.location.lat());
			$('#map_lng').val(results[0].geometry.location.lng());
			//console.log(results[0].geometry.location.lat());
			//console.log(results[0].geometry.location.lng());
          } else {
            //alert('Geocode was not successful for the following reason: ' + status);
          }
        });
      }

</script>
<script async defer  src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAGWoTNwauIzO_pJEDymaSYTG031uJbbkk&callback=initMap">
    </script>
<script>
	(function() {

	// getElementById
	function $id(id) {
		return document.getElementById(id);
	}


	// output information
	/*function Output(msg) {
		var m = $id("messages");
		m.innerHTML = msg + m.innerHTML;
	}*/


	// file drag hover
	function FileDragHover(e) {
		e.stopPropagation();
		e.preventDefault();
		e.target.className = (e.type == "dragover" ? "hover" : "");
	}


	// file selection
	function FileSelectHandler(e) {

		// cancel event and hover styling
		FileDragHover(e);

		// fetch FileList object
		var files = e.target.files || e.dataTransfer.files;
		var form_data=new FormData(this);
		// process all File objects
		for (var i = 0, f; f = files[i]; i++) {
			//ParseFile(f);
			form_data.append(i,f);
		}	       	
        upload_file(form_data);

	}


	// output file information
	function ParseFile(file) {

		Output(
			"<p>File information: <strong>" + file.name +
			"</strong> type: <strong>" + file.type +
			"</strong> size: <strong>" + file.size +
			"</strong> bytes</p>"
		);

	}


	// initialize
	function Init() {

		var fileselect = $id("fileselect"),
			filedrag = $id("filedrag"),
			submitbutton = $id("submitbutton");

		// file select
		fileselect.addEventListener("change", FileSelectHandler, false);

		// is XHR2 available?
		var xhr = new XMLHttpRequest();
		if (xhr.upload) {

			// file drop
			filedrag.addEventListener("dragover", FileDragHover, false);
			filedrag.addEventListener("dragleave", FileDragHover, false);
			filedrag.addEventListener("drop", FileSelectHandler, false);
			filedrag.style.display = "block";

			// remove submit button
			//submitbutton.style.display = "none";
		}

	}

	// call initialization file
	if (window.File && window.FileList && window.FileReader) {
		Init();
	}


})();
</script>
