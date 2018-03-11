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
					<h1>Gia hạn tin đăng</h1>
				</div>				
				<div class="pn_content pn_background pn_border margin_top">
					<div>
						<h3>Loại tin và lịch đăng tin</h3>
					</div>
					<form enctype="multipart/form-data" id="from_post">						
						<input type="hidden" name="post_id" id="post_id"  value="{{post_id}}">
						<input type="hidden" name="post_view_id"  value="{{post_view_id}}">
						<input type="hidden" name="post_contract_id" value="{{post_contract_id}}">					

						<div class="row row-margin-bottom lab_invisible" id="lab_message_error" style="text-align:center">
							<label class="lab_red">Có một số thông tin chưa hợp lệ, vui lòng nhập lại !</label>
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
								<button class="btn_dangtin" id="btn_save" ><i class="fa fa-check-square-o"></i>Cập nhật</button>
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
		
		$('.datetimepicker').datetimepicker({
          //format:'Y/m/d H:i',
          format:'d/m/Y',
          inline:false,
          timepicker:false,
          lang:'ru'
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
		
		function topFunction() {
		    document.body.scrollTop = 0; // For Chrome, Safari and Opera 
		    document.documentElement.scrollTop = 0; // For IE and Firefox
		}		
		
		$(document).off('click','#btn_cancel'); 
        $(document).on('click','#btn_cancel',function(event){
        	location.href="{{url.get('tin-da-dang')}}";
        });
		$(document).off('click','#btn_save'); 
        $(document).on('click','#btn_save',function(event){
        	var msg = check_validate_update();
          	if(!msg){
            	topFunction();
            	return;
          	}
          	var arr = $('#from_post').serializeArray();
	      	Pho_json_ajax('POST',"{{url.get('posts/updincr')}}" ,arr,function(datas){
		        if(datas.status =="OK"){
		          //Pho_modal_close("modal1");
		          //Pho_message_box("Thông báo",'Đăng tin thành công !');
		          Pho_direct("{{url.get('posts/succincr/')}}" + datas.msg);
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

</script>
