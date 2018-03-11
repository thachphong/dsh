<div class="row">
	<div class="container">
		{{ partial('includes/user_left') }}
		<div class="col-md-9 col-sm-12 col-xs-12 margin_top">
			<div class="pn_title margin_top">
					<span class="bg_icon"><i class="fa post-pencil"></i></span>
					<h1>Nạp tiền vào Diaocviet.vn(Cổng VTCPay)</h1>
			</div>
			<div class="row margin_top pn_background pn_border post_pn" >
            <div class="post_head">
               <div class="row pn_content">	
               	  <form enctype="multipart/form-data" id="from_post" action="{{url.get('exchange/send')}}" method="post">			
					<div class="row row-margin-bottom">						
						<div class="col-md-12 col-sm-12 col-xs-9">
							<img src="{{url.get('template1/images/logo_bank_inland.png')}}"
					<div class="row row-margin-bottom">
						<div class="col-md-4 col-sm-4 col-xs-6 align_right title_lb">
							<label>Tên người thanh toán :</label>
						</div>
						<div class="col-md-4 col-sm-4 col-xs-6 title_lb">
							<label style="font-weight: bold">{{user_name}}</label>
						</div>
					</div>
					<div class="row row-margin-bottom">
						<div class="col-md-4 col-sm-4 col-xs-6 align_right title_lb">
							<label>Số điện thoại :</label>
						</div>
						<div class="col-md-8 col-sm-8 col-xs-6 title_lb">
							<label style="font-weight: bold">{{user_mobile}}</label>
						</div>
					</div>
					<div class="row row-margin-bottom">
						<div class="col-md-4 col-sm-4 col-xs-6 align_right title_lb">
							<label>Số tiền thanh toán :</label>
						</div>
						<div class="col-md-3 col-sm-3 col-xs-3 title_lb">
							<input class="number_format" name="amount" required/> 
						</div>
						<div class="col-md-1 col-sm-1 col-xs-1 title_lb">
							<label>VNĐ</label>
						</div>
					</div>
					<div class="row row-margin-bottom">
						<div class="col-md-4 col-sm-4 col-xs-6 align_right title_lb">
							<label>Số tiền bằng chữ :</label>
						</div>
						<div class="col-md-8 col-sm-8 col-xs-6  title_lb">
							<label id="amount_lb"></label>
						</div>
					</div>
					<div class="col-md-12 col-sm-12 col-xs-12" style="text-align: center;">								
					<button class="btn_dangtin" id="btn_save" style=""><!--<i class="fa fa-save"></i>-->Tiếp tục</button>
					</form>
				</div>
			   </div>
            </div>
            <!--<hr class="line" />-->
            
         </div>			
		</div>
	</div>
</div>
{{ partial('includes/pho_ajax') }}
<script type="text/javascript">
	$(document).ready(function() {		
		function currency_format(n) {
          return n.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,");
      }
      $(document).ready(function() {
         $(document).off('input','.pro_qty'); 
         $(document).on('input','.pro_qty',function(event){
            //console.log('1');
            var tot_amount = 0;
            $('.tr_product').each(function(){
               var qty_obj = $(this).find('.pro_qty')[0];
               var price_obj = $(this).find('.pro_price')[0];
               var qty = $(qty_obj).val();
               var price = $(price_obj).attr('data');
               tot_amount += qty*price;
               console.log(tot_amount);
            });
            $('#total_amount_1').text(currency_format(tot_amount));
            $('#total_amount_vat').text(currency_format(tot_amount*0.1));
            $('#total_amount_2').text(currency_format(tot_amount + tot_amount*0.1));
         });         
      });
      $(document).off('keydown','.number_format');
      $(document).on('keydown','.number_format',function(event){ 
      	  //console.log(event);
      	  if(event.keyCode !=8 && event.keyCode != 46 && event.keyCode != 37 && event.keyCode != 39 && event.keyCode !=16){
      	  	 if($.isNumeric( event.key) == false){
      			return false;
      		 }
      	  }
      		
      });
      $(document).off('keyup','.number_format'); 
        $(document).on('keyup','.number_format',function(event){
        	var val = $(this).val().replace(/,/g,'');
        	if($.isNumeric( val) == false){
        		$(this).val("");
        		return;
        	}
        	$(this).val( parseFloat($(this).val().replace(/,/g, ""))
		                   // .toFixed(2)
		                    .toString()
		                    .replace(/\B(?=(\d{3})+(?!\d))/g, ",")
		    );
		    $('#amount_lb').text(docso(val) + ' đồng');
        });
	});
	var mangso = ['không', 'một', 'hai', 'ba', 'bốn', 'năm', 'sáu', 'bảy', 'tám', 'chín'];

function dochangchuc(so, daydu) {
    var chuoi = "";
    chuc = Math.floor(so / 10);
    donvi = so % 10;
    if (chuc > 1) {
        chuoi = " " + mangso[chuc] + " mươi";
        if (donvi == 1) {
            chuoi += " mốt";
        }
    } else if (chuc == 1) {
        chuoi = " mười";
        if (donvi == 1) {
            chuoi += " một";
        }
    } else if (daydu && donvi > 0) {
        chuoi = " lẻ";
    }
    if (donvi == 5 && chuc > 1) {
        chuoi += " lăm";
    } else if (donvi > 1 || (donvi == 1 && chuc == 0)) {
        chuoi += " " + mangso[donvi];
    }
    return chuoi;
}

function docblock(so, daydu) {
    var chuoi = "";
    tram = Math.floor(so / 100);
    so = so % 100;
    if (daydu || tram > 0) {
        chuoi = " " + mangso[tram] + " trăm";
        chuoi += dochangchuc(so, true);
    } else {
        chuoi = dochangchuc(so, false);
    }
    return chuoi;
}

function dochangtrieu(so, daydu) {
    var chuoi = "";
    trieu = Math.floor(so / 1000000);
    so = so % 1000000;
    if (trieu > 0) {
        chuoi = docblock(trieu, daydu) + " triệu";
        daydu = true;
    }
    nghin = Math.floor(so / 1000);
    so = so % 1000;
    if (nghin > 0) {
        chuoi += docblock(nghin, daydu) + " nghìn";
        daydu = true;
    }
    if (so > 0) {
        chuoi += docblock(so, daydu);
    }
    return chuoi;
}

function docso(so) {
    if (so == 0) return mangso[0];
    var chuoi = "",
        hauto = "";
    do {
        ty = so % 1000000000;
        so = Math.floor(so / 1000000000);
        if (so > 0) {
            chuoi = dochangtrieu(ty, true) + hauto + chuoi;
        } else {
            chuoi = dochangtrieu(ty, false) + hauto + chuoi;
        }
        hauto = " tỷ";
    } while (so > 0);
    return chuoi;
}
</script>
