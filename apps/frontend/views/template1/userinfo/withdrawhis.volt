<div class="row breadcrumb">
	<div class="container">
		<a href="{{baseurl}}">Trang chủ</a>	>
		<a href="{{baseurl}}thanh-vien"> Thành viên</a>	
		<span>> Lịch sử rút tiền</span>			
	</div>
</div>
<div class="row">
	<div class="container">
		{{ partial('includes/user_left') }}
		<div class="col-md-9 col-sm-12 col-xs-12 margin-top20 no_padding_right">
			<div class="row panel_bg padding10">
				<div class="pn_title">			
						<h1 class="margin-top10">Lịch sử rút tiền </h1>
				</div>
				<hr class="line"/>					
	            <div class="post_head">
	               <div class="row">
	               	<div class="table-responsive"> 
							<table class="table table-bordered " style="font-size: 12px;">
								<tr>	
									<th>Ngày</th>							
									<th>Ngân hàng</th>
									<th>Số tài khoản</th>									
									<th>Họ và tên</th>									
									<th>Tiền rút</th>	
									<th>Phí rút</th>
									<th>Trạng thái</th>
								</tr>
								{%for item in list%}
								<tr>
									<td>{{item['add_date']}}</td>
									<td>{{item['bank_name']}}</td>
									<td>{{item['bank_acc_no']}}</td>
									<td>{{item['bank_acc_name']}}</td>
									<td>{{elements.currency_format(item['amount'])}} ₫</td>
									<td>{{elements.currency_format(item['fee'])}} ₫</td>
									<td class="{%if item['status']==1%} col_blue{%elseif item['status']==2 or item['status']==3 %}lab_red{%endif%}">{{item['status_name']}}</td>
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
