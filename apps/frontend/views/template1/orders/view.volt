<div class="row breadcrumb">
	<div class="container">
		<a href="{{baseurl}}">Trang chủ</a>	>
		<a href="{{baseurl}}thanh-vien"> Thành viên</a>	>
		<a href="{{baseurl}}orders/list"> Quản lý đơn hàng</a>
		<span>> Chi tiết đơn đặt hàng</span>			
	</div>
</div>
<div class="row">
	<div class="container">
		{{ partial('includes/user_left') }}
		<div class="col-md-9 col-sm-12 col-xs-12 margin-top20 no_padding_right">
			<div class="row panel_bg padding10">
				<div class="pn_title">			
						<h1 class="margin-top10">Chi tiết đơn đặt hàng </h1>
				</div>
				<hr class="line"/>
				<div class="row margin_top pn_background pn_border post_pn" >											
					<div class="row">
						<span class="col-md-3 col-sm-3 col-xs-3 align_right">Họ và tên:</span><label class="col-md-9 col-sm-9 col-xs-9">{{full_name}}</label>								
					</div>
					<div class="row">
						<span class="col-md-3 col-sm-3 col-xs-3 align_right">Điện thoại:</span><label class="col-md-9 col-sm-9 col-xs-9">{{phone}}</label>								
					</div>
					<div class="row">
						<span class="col-md-3 col-sm-3 col-xs-32 align_right">Địa chỉ:</span><label class="col-md-9 col-sm-9 col-xs-9">{{address}}</label>								
					</div>
					<div class="row">
						<span class="col-md-3 col-sm-3 col-xs-3 align_right">Phường/xã:</span><label class="col-md-9 col-sm-9 col-xs-9">{{ward_name}}</label>								
					</div> 
					<div class="row">
						<span class="col-md-3 col-sm-3 col-xs-3 align_right">Quận/Huyện:</span><label class="col-md-9 col-sm-9 col-xs-9">{{district_name}}</label>								
					</div>
					<div class="row">
						<span class="col-md-3 col-sm-3 col-xs-3 align_right">Tỉnh/TP:</span><label class="col-md-9 col-sm-9 col-xs-9">{{provin_name}}</label>								
					</div>
					<div class="row">
						<span class="col-md-3 col-sm-3 col-xs-3 align_right">Phí ship:</span><label class="col-md-9 col-sm-9 col-xs-9">{{elements.currency_format(ship_amount)}} ₫</label>								
					</div>
					<div class="row">
						<span class="col-md-3 col-sm-3 col-xs-3 align_right">Tổng tiền thanh toán:</span><label class="col-md-9 col-sm-9 col-xs-9">{{elements.currency_format(total_amount)}} ₫</label>								
					</div>
					<div class="row">
						<span class="col-md-3 col-sm-3 col-xs-3 align_right">Tổng tiền chiết khấu:</span><label class="col-md-9 col-sm-9 col-xs-9">{{elements.currency_format(total_discount)}} ₫</label>								
					</div>
					<div class="row">
						<span class="col-md-3 col-sm-3 col-xs-3 align_right">Trạng thái:</span><label class="col-md-9 col-sm-9 col-xs-9 {%if status==2%} col_blue{%elseif status==4 or status==3 %}lab_red{%endif%}">{{status_name}}</label>								
					</div>
					<div class="row">
						<span class="col-md-3 col-sm-3 col-xs-3 align_right">Tiền cộng vào tài khoản:</span><label class="col-md-9 col-sm-9 col-xs-9">{%if status==2 and discount_flg==1%}
											{{elements.currency_format(total_discount)}} ₫
										{%else%}
											0 ₫
										{%endif%}</label>								
					</div>
					<div class="row">
						<span class="col-md-3 col-sm-3 col-xs-3 align_right">Loại thành viên:</span><label class="col-md-9 col-sm-9 col-xs-9 col_blue">{%if discount_flg==1%}Cộng tác viên(CTV){%else%}Thành viên thường{%endif%}</label>								
					</div>
					<div class="row">
						<span class="col-md-3 col-sm-3 col-xs-3 align_right">Ngày đặt hàng:</span><label class="col-md-9 col-sm-9 col-xs-9">{{ord_date}}</label>								
					</div>	
				</div>		
	            <div class="post_head">
	               <div class="row">
	               	<div class="table-responsive"> 
							<table class="table table-bordered " style="font-size: 12px;">
								<tr>								
									<th>Tên sản phẩm</th>
									<th>Kích thước</th>
									<th>Màu sắc</th>					
									<th>Số lượng</th>
									<th>Giá</th>	
									<th>Thành tiền</th>								
									<th>Chiết khấu</th>
								</tr>
								{%for item in list%}
								<tr>
									<td><a class="link_color" href="{{baseurl}}sp/{{item['pro_no']}}_{{item['pro_id']}}" target="_blank">{{item['pro_name']}}</a></td>
									<td>{{item['size']}}</td>
									<td>{{item['color']}}</td>
									<td>{{item['qty']}}</td>
									<td>{{elements.currency_format(item['price'])}}</td>
									<td>{{elements.currency_format(item['total'])}}</td>
									<td>{{elements.currency_format(item['discount'])}}</td>
									
								</tr>
								{%endfor%}							
							</table>
							</div>
						</div>
			
	            </div>
	            <!--<hr class="line" />-->
	            
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
		$('.datetimepicker').datetimepicker({
          //format:'Y/m/d H:i',
          format:'d/m/Y',
          inline:false,
          timepicker:false,
          lang:'ru'
    	});
    	$(document).off('click','#clear_input');
    	$(document).on('click','#clear_input',function(){
    		$('#orders_id').val('');
    		$('#fdate').val('');
    		$('#tdate').val('');
    		$('#status').val('');
    	});
    	$(document).off('click','.btn_cancel');
    	$(document).on('click','.btn_cancel',function(){
    		var id = $(this).attr('id').replace('cancel_','');
    		Pho_message_confirm('Xác nhận','Bạn có chắc chắn muốn hủy đơn đặt "'+id+'" ?',function(){
    			location.href="{{url.get('orders/cancel/')}}"+id;
    		});
    	});
	});
</script>
