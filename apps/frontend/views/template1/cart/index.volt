
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
                  <table class="table">
                  	<colgroup>
                  		<col width="40%">
                  		<col width="10%">
                  		<col width="15%">
                  		<col width="15%">
                  		<col width="15%">
                  		<col width="5%">
                  	</colgroup>
                    <tbody>
                        <tr class="tenbold">
                                          <th class="sanpham">Sản Phẩm</th>
                                          <th class="sanpham">Màu sắc/ Kích thước</th>
                                          <th style="text-align:right">Giá</th>
                                          <th style="text-align:center">Số Lượng</th>
                                          <th style="text-align:right">Thành tiền</th>
                                          <th style="text-align:center" align="center">Xóa</th>
                        </tr>
                        {%for item in carts%}
                        	<tr class="spline tr_product">                                       
                                <td><img src="{{baseurl}}crop/50x50{{item['img_path']}}" style="margin-right:10px">{{item['pro_name']}}</td>
                                <td>{{item['size']}}</td>
                                <td align="right">
                                <span class="amount pro_price" data="{{item['price_exp']}}">{{elements.currency_format(item['price_exp'])}}<span>₫</span></span>                    
                                          </td>
                                <td style="text-align:center"> 
                                <!--<input value="{{item['qty']}}" name="pro_qty[]" id="pro_qty_{{item['pro_price_id']}}" type="number" style="width:43px;text-align: center;" class="pro_qty" >-->
                                <input type="hidden" name="pro_price_id[]" value="{{item['pro_price_id']}}">     
                                <span class="cart_pro_qty">
									<a href="javascript:void(0)" onclick="qty_add({{item['pro_price_id']}},-1)" class="qty_btn"><i class="fa fa-minus" ></i></a>
									<input value="1" id="pro_qty_{{item['pro_price_id']}}" name="pro_qty[]" class="qty_btn" style="width: 40px"/>
									<a href="javascript:void(0)" onclick="qty_add({{item['pro_price_id']}},1)" class="qty_btn"><i class="fa fa-plus"></i></a>
								</span>                                      
                                </td>
                                <td align="right">
                                <span  class="itemamount pro_price" id="amount_{{item['pro_price_id']}}" data="{{item['price_exp']}}">{{elements.currency_format(item['price_exp'])}} ₫</span>                    
                                          </td>
                                <td style="text-align:center"><a style="color: red" href="{{baseurl}}cart/delete/{{item['pro_price_id']}}">X</a>
                                </td>
                            </tr>
                        {%endfor%}
                        <tr class="spline">
                        	<td width="40%" class="sanpham" >Tổng cộng</td>
                        	<td width="40%" align="right" colspan="4"><span class="amount" id="total_amount_1">{{elements.currency_format(total_amount)}}<span>₫</span></span></td>
                                          <td></td>
                        </tr>
                        <tr class="spline">
	                        <td width="40%" class="sanpham" >Phí ship</td>
	                        <td width="40%" align="right" colspan="4"><span class="amount" id="total_amount_vat">{{elements.currency_format(20000)}} ₫</span></td>
	                        <td></td>
                        </tr>
                        <tr class="order-total">
                        </tr>
                        <tr class="spline">
                            <td width="40%" class="sanpham" >Thanh toán</td>
                            <td width="40%" align="right" colspan="4">
                            	<strong><span class="amount" id="total_amount_2">{{elements.currency_format(total_amount+ 20000)}}<span>₫</span></span></strong>
                            </td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
                </form>
               </div>
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
<script type="text/javascript">
	$(document).ready(function() {
		$(document).off('click','#btn_pay');
	    $(document).on('click','#btn_pay',function(){
	        $('#frm_order').submit();
			        
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
         var amount = quantity * parseInt(price);
         console.log(amount);
        $("#amount_"+id).empty();
        $("#amount_"+id).append(currency_format(amount) + ' ₫');
        var tot_amount = 0;
            $('.itemamount').each(function(){
               var amount  = $(this).text().replace(' ₫','');               
               tot_amount += parseInt (amount.replace('.',''));
               console.log(tot_amount);
            });
        $('#total_amount_1').text(currency_format(tot_amount));
        var fee = $('#total_amount_vat').text().replace(' ₫','').replace('.','');
        $('#total_amount_2').text(currency_format(tot_amount + parseInt(fee)));
    }
    function currency_format(n) {
          return n.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1.");
    }
</script>