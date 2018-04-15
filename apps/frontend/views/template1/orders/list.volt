<div class="row breadcrumb">
	<div class="container">
		<a href="{{baseurl}}">Trang chủ</a>	>
		<a href="{{baseurl}}thanh-vien"> Thành viên</a>	
		<span>> Quản lý đơn đặt hàng</span>			
	</div>
</div>
<div class="row">
	<div class="container">		
		<div class="col-md-9 col-sm-12 col-xs-12 margin-top20 no_padding_right" style="float:right">
			<div class="row panel_bg padding10">
				<div class="pn_title">			
						<h1 class="margin-top10">Quản lý đơn đặt hàng </h1>
				</div>
				<hr class="line"/>
				<div class="row margin_top pn_background pn_border post_pn" >											
					<div class="row">
						<form enctype="multipart/form-data" id="from_post" action="{{url.get('orders/list')}}" method="get">
								<div class="col-md-2 col-sm-3 col-xs-12 no_padding_left">
									<input type="text" name="orders_id" value="{{orders_id}}" id="orders_id" placeholder="Mã đơn đặt">
								</div>
								<div class="col-md-2 col-sm-3 col-xs-12">
									<input name="fdate" id="fdate" class="datetimepicker datepost" placeholder="Từ ngày" value="{{fdate}}"/>
								</div>
								<div class="col-md-2 col-sm-3 col-xs-12">
									<input name="tdate" id="tdate" class="datetimepicker datepost" placeholder="đến ngày" value="{{tdate}}"/>
								</div>
								<div class="col-md-3 col-sm-3 col-xs-12 row-margin-bottom">
									<select name="status" id="status" >
											<option value="">--Trạng thái--</option>
											<option value="0" {%if status == '0'%}selected{%endif%}>Đang chờ xử lý</option>
											<option value="1" {%if status == '1'%}selected{%endif%}>Đang giao</option>
											<option value="2" {%if status == '2'%}selected{%endif%}>Đã giao</option>
											<option value="4" {%if status == '3'%}selected{%endif%}>Khách hàng không nhận</option>
											<option value="4" {%if status == '4'%}selected{%endif%}>Đã hủy</option>
									</select>
									
								</div>	
								<div class="col-md-1 col-sm-2 col-xs-6 no_padding">
									<button class="btn_dangtin"><i class="fa fa-search"></i>Tìm</button>		
								</div>
								<div class="col-md-2 col-sm-2 col-xs-6" style="padding-top:5px">
									<a class="btn_dangtin" id="clear_input" style="padding:6px" href="javascript:void(0)">Xóa bộ lọc</a>		
								</div>
						</form>
															
					</div>
					<div class="row row-margin-bottom">							
						<div class="col-md-10 col-sm-10 col-xs-12">
							<span class="col-md-9 col-sm-9 col-xs-12" style="padding-top: 7px;">Lưu ý: khi nhập mã đơn đặt thì các bộ lọc khác không có tác dụng</span>		
						</div>							
																				
					</div>
				</div>		
	            <div class="post_head">
	               <div class="row">
	               	<div class="table-responsive"> 
							<table class="table table-bordered table_repon table_orderlist" style="font-size: 12px;">
								<tr class="tr_head">								
									<th>Mã đơn</th>
									<th>Ngày đặt hàng</th>
									<!--<th>Ngày giao hàng</th>-->
									<th>Tổng tiền</th>									
									<th>Chiết khấu</th>	
									<th>Trạng thái</th>
									<th>Tiền được cộng vào TK</th>	
									<th>Chi tiết</th>					
									<th>Hủy</th>
								</tr>
								{%for item in list%}
								<tr>
									<td>{{item['ord_id']}}</td>
									<td>{{item['ord_date']}}</td>
									<td>{{elements.currency_format(item['total_amount'])}} ₫</td>
									<td>{{elements.currency_format(item['total_discount'])}} ₫</td>
									<td class="{%if item['status']==2%} col_blue{%elseif item['status']==4 or item['status']==3 %}lab_red{%endif%}">{{item['status_name']}}</td>	
									<td>
										{%if item['status']==2 and item['discount_flg']==1%}
											{{elements.currency_format(item['total_discount'])}} ₫
										{%else%}
											0 ₫
										{%endif%}
									</td>
									<td><a target="_blank" href="{{url.get('orders/view/')}}{{item['ord_id']}}" class="link_color">Xem chi tiết</a></td>						
											
									<td>
										{%if item['status']==0%}
											<a href="javascript:void(0)" id="cancel_{{item['ord_id']}}" class="btn_cancel btn_red_small">Hủy</a>
										{%endif%}
									</td>
									
								</tr>
								{%endfor%}							
							</table>
							</div>
						</div>
			{%if total_page > 1%}
	         <div class="row margin_top" >
	            <div class="col-md-12 col-sm-12 col-xs-12" style="display: flex;justify-content: center;">
	               <ul class="page_number">
	                  {%if page > 1%}
	                     <li class="hide_mobile"><a href="{{url.get('')}}{{ctg_no}}&page=1">Trang đầu</a></li>
	                     <li class="hide_mobile"><a href="{{url.get('')}}{{ctg_no}}&page={{(page-1)}}">Trang trước</a></li>
	                     <li class="hide_desk"><a href="{{url.get('')}}{{ctg_no}}?page=1"><<</a></li>
                     	 <li class="hide_desk"><a href="{{url.get('')}}{{ctg_no}}?page={{(page-1)}}"><</a></li>
	                  {%endif%}                 
	                  
	                  {%for i in  start..end%} 
	                    <li {%if page == i%}class="active"{%endif%}><a href="{{url.get('')}}{{ctg_no}}&page={{i}}">{{i}}</a></li>
	                  {%endfor%}
	                  {%if page < total_page%}
	                     <li class="hide_mobile"><a href="{{url.get('')}}{{ctg_no}}&page={{page+1}}">Trang sau</a></li>
	                     <li class="hide_mobile"><a href="{{url.get('')}}{{ctg_no}}&page={{total_page}}">Trang cuối</a></li>
	                     <li class="hide_desk"><a href="{{url.get('')}}{{ctg_no}}?page={{page+1}}">></a></li>
                     	 <li class="hide_desk"><a href="{{url.get('')}}{{ctg_no}}?page={{total_page}}">>></a></li>
	                  {%endif%}       
	               </ul>
	            </div>
	         </div>
	         {%endif%}
	            </div>
	            <!--<hr class="line" />-->
	            
	         </div>	
         </div>	
         {{ partial('includes/user_left') }}	
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
