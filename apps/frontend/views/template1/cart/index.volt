
<div class="row breadcrumb">
	<div class="container">
		<a href="{{baseurl}}">Trang chủ</a>		
		<span>> Giỏ hàng</span>			
	</div>
</div>
<div class="row content_bg">	
   <div class="container panel_bg margin-top10">
      <div class="col-md-12 col-sm-12 col-xs-12 margin_top ">
      	 <div class="row margin_top" >
         <!--<div class="pn_posts">-->
            <div class="pn_title">               
               <h1>Giỏ hàng </h1>
            </div> 
            <hr class="line" />           
            <div class="pn_content pn_background pn_border margin_top">               
               <div class="row">
               	<form action="{{baseurl}}cart/pay" method="post" id="frm_order">
                  <table class="table" style="font-size: 14px;">
                  	<colgroup>
                  		<col width="30%">
                  		<col width="9%">
                  		<col width="9%">
                  		<col width="11%">
                  		<col width="12%">
                  		<col width="11%">
                  		<col width="11%">
                  		<col width="5%">
                  	</colgroup>
                    <tbody>
                        <tr class="tenbold">
                                          <th class="sanpham">Sản Phẩm</th>
                                          <th class="sanpham">Màu sắc</th>
                                          <th class="sanpham">Kích thước</th>
                                          <th style="text-align:right">Giá</th>
                                          <th style="text-align:center">Số Lượng</th>
                                          <th style="text-align:right">Thành tiền</th>
                                          <th style="text-align:right">Chiết khấu</th>
                                          <th style="text-align:center" align="center">Xóa</th>
                        </tr>
                        {%set idx = 0%}
                        {%if carts|length >0%}
                        {%for item in carts%}
                        	{%set idx = idx +1%}
                        	<tr class="spline tr_product" id="tr_{{idx}}">                                       
                                <td><img src="{{baseurl}}crop/50x50{{item['img_path']}}" style="margin-right:10px" title="{{item['pro_name']}}" alt="{{item['pro_name']}}">{{item['pro_name']}}</td>
                                <td>{{item['color']}}</td>
                                <td>{{item['size']}}</td>
                                <td align="right">
                                <span class="amount pro_price" data="{{item['price_exp']}}">{{elements.currency_format(item['price_exp'])}}<span>₫</span></span>                    
                                          </td>
                                <td style="text-align:center"> 
                                <!--<input value="{{item['qty']}}" name="pro_qty[]" id="pro_qty_{{item['pro_price_id']}}" type="number" style="width:43px;text-align: center;" class="pro_qty" >-->
                                <input type="hidden" name="pro_price_id[]" value="{{item['pro_price_id']}}" id="pro_price_{{idx}}">  
                                <input type="hidden" name="sizes[]" value="{{item['size']}}" id="size_{{idx}}">
                                <input type="hidden" name="colors[]" value="{{item['color']}}" id="color_{{idx}}">   
                                <span class="cart_pro_qty">
									<a href="javascript:void(0)" onclick="qty_add({{idx}},-1)" class="qty_btn"><i class="fa fa-minus" ></i></a>
									<input value="{{item['qty']}}" id="pro_qty_{{idx}}" name="pro_qty[]" class="qty_btn" style="width: 40px"/>
									<a href="javascript:void(0)" onclick="qty_add({{idx}},1)" class="qty_btn"><i class="fa fa-plus"></i></a>
								</span>                                      
                                </td>
                                <td align="right">
                                <span  class="itemamount pro_price" id="amount_{{idx}}" data="{{item['price_exp']}}" seller="{{item['price_seller']}}">{{elements.currency_format(item['amount'])}} ₫</span>                    
                                          </td>
                                <td align="right">
                                <span  class="itemck pro_price" id="chietkhau_{{idx}}" data="{{item['price_exp']}}">{{elements.currency_format(item['chietkhau'])}} ₫</span>                    
                                          </td>
                                <td style="text-align:center"><a class="btn_del" id="del_{{idx}}" style="color: red" href="javascript:void(0)">X</a>
                                </td>
                            </tr>
                        {%endfor%}
                        {%endif%}
                        <tr class="spline">
                        	<td width="40%" class="sanpham" >Tổng cộng</td>
                        	<td width="40%" align="right" colspan="5"><span class="amount" id="total_amount_1">{{elements.currency_format(total_amount)}}<span>₫</span></span></td>
                                         <td colspan="2"></td>
                        </tr>
                        <tr class="spline">
	                        <td width="40%" class="sanpham" >Phí ship</td>
	                        <td width="40%" align="right" colspan="5"><span class="amount" id="total_amount_vat">{{elements.currency_format(ship_amount)}} ₫</span></td>
	                        <td colspan="2"></td>
                        </tr>
                        <tr class="order-total">
                        </tr>
                        <tr class="spline">
                            <td width="40%" class="sanpham col_red" >Tổng tiền phải thanh toán</td>
                            <td width="40%" align="right" colspan="5">
                            	<strong><span class="amount col_red" id="total_amount_2">{{elements.currency_format(total_amount+ ship_amount)}} ₫</span></strong>
                            </td>
                            <td colspan="2"></td>
                        </tr>
                        <tr class="spline">
                            <td width="40%" class="sanpham col_blue" >Tổng tiền chiết khấu</td>
                            <td width="40%" align="right" colspan="6">
                            	<strong><span class="amount col_blue" id="total_ck">{{elements.currency_format(total_ck)}} ₫</span></strong>
                            </td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
                </form>
               </div>
               {%if ctv_flg !=1%}
               <div class="row">
               		<div class="panel panel-danger" >
               			<div class="panel-body">
               				{%if ctv_flg==''%}
		      				<p class="lab_red">Bạn chưa đăng ký làm cộng tác viên, nên sẽ không nhận được tiền chiết khấu</p>
		      				<a class="link_color" href="{{baseurl}}p/huong-dan-dang-ky-ctv"><strong>Hướng dẫn đăng ký làm cộng tác viên</strong></a>
		      				{%elseif ctv_flg==0%}
		      				<p class="lab_red">Tài khoản của bạn không phải là cộng tác viên, nên sẽ không nhận được tiền chiết khấu</p>
		      				<a class="link_color" href="{{baseurl}}p/huong-dan-dang-ky-ctv"><strong>Hướng dẫn đăng ký làm cộng tác viên</strong></a>
		      				{%endif%}
               			</div>
					</div>
               </div>
               {%endif%}
               <div class="row">
					<div class="col-md-12 col-sm-12 col-xs-12 no_padding_left" style="padding-bottom: 10px;text-align:right">
						<a class="btn_buy btn_orange" href="{{baseurl}}" style="float:left">Tiếp tục mua hàng</a>					
						<a class="btn_buy btn_red" id="btn_pay">Tiến hành thanh toán</a>
					</div>
				</div>
            </div>
         </div>
      </div>     
   </div>  
</div>
{{ partial('includes/pho_ajax') }}
<script type="text/javascript">
	$(document).ready(function() {
		$(document).off('click','#btn_pay');
	    $(document).on('click','#btn_pay',function(){
	        $('#frm_order').submit();
			        
	    });
	    $(document).off('click','.btn_del');
	    $(document).on('click','.btn_del',function(){
	        var id = $(this).attr('id').replace('del_','');
			
			Pho_json_ajax('POST',"{{baseurl}}cart/delete" ,{
				'pro_size':$('#pro_price_'+id).val(),	       		
	       		'color_sel':$('#color_'+id).val(),
	       		'size_sel':$('#size_'+id).val()
	       		},function(datas){
		        if(datas.status =="OK"){
		             $('#tr_'+id).remove();
		             cal_total();
		        }else{		        	
		        	Pho_message_box_error("Lỗi",datas.msg);
		        }	                
	        });        
	    });
	    
	});
    function qty_add(id,qty){
         var val = parseInt($("#pro_qty_"+id).val());
         var quantity = val + qty;
         if((quantity) == 0){
            return;
         }
         $("#pro_qty_"+id).val(quantity);
         var price = $('#amount_'+id).attr('data').replace('₫','');
         var seller = $('#amount_'+id).attr('seller');
         var amount = quantity * parseInt(price);
         var chietkhau = quantity * (parseInt(price)-parseInt(seller));
         //console.log(amount);
        $("#amount_"+id).empty();
        $("#amount_"+id).append(currency_format(amount) + ' ₫');
        $("#chietkhau_"+id).empty();
        $("#chietkhau_"+id).append(currency_format(chietkhau) + ' ₫');
        cal_total();
    }
    function cal_total(){
    	var tot_amount = 0;
            $('.itemamount').each(function(){
               var amount  = $(this).text().replace(' ₫','');               
               tot_amount += parseInt (amount.replace(/\./g,''));
               console.log(tot_amount);
            });
        var tot_ck = 0;
            $('.itemck').each(function(){
               var amount  = $(this).text().replace(' ₫','');               
               tot_ck += parseInt (amount.replace(/\./g,''));
               //console.log(tot_ck);
            });
        $('#total_ck').text(currency_format(tot_ck));
        $('#total_amount_1').text(currency_format(tot_amount));
        var fee = $('#total_amount_vat').text().replace(' ₫','').replace('.','');
        $('#total_amount_2').text(currency_format(tot_amount + parseInt(fee)));
    }
    function currency_format(n) {
          return n.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1.");
    }
</script>