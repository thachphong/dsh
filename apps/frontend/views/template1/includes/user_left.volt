<div class="col-md-3 col-sm-12 col-xs-12 no_padding_left user_left">
	
	<div class="row margin-top10 huongdan panel_bg">
		<div class="pn-header-top border_bottom">
			<div class="pn-title">		    	
		        <h2>Thông tin tài khoản</h2>
		    </div>
		</div>
	    
	    <div class="row pn_background pn_border margin_top">
		    <ul>
		    	<li><a href="{{url.get('thanh-vien')}}"><i class="fa-angle-double-right"></i>Thông báo</a></li>
		        <li><a href="{{url.get('thanh-vien/thongtin')}}"><i class="fa-angle-double-right"></i><span>Thay đổi thông tin cá nhân</span></a></li>
		        <li><a href="{{url.get('thanh-vien/pass')}}"><i class="fa-angle-double-right"></i>Thay đổi mật khẩu</a></li>	        
		        <li><a href="{{url.get('orders/list')}}"><i class="fa-angle-double-right"></i>Quản lý đơn hàng</a></li>
		        <li><a href="{{baseurl}}thanh-vien/withdraw"><i class="fa-angle-double-right"></i>Yêu cầu rút tiền</a></li>
		        <li><a href="{{baseurl}}thanh-vien/withdrawhis"><i class="fa-angle-double-right"></i>Lịch sử rút tiền</a></li>
		        
		    </ul>
	    </div>
    </div> 
    <div class="row"> 
    	<div class="panel_bg" style="text-align:center">
	    	{% set login_info= elements.getuser()%}
		    <img src="{{url.get('images/users/')}}{{login_info.avata}}" style="width:100%; padding:20px; max-width:240px;" />
		    <h3 class="title_2" style="text-align:center">{{login_info.user_name}}</h3>
		    <div style="padding: 10px;">
		    <strong >Số dư : {{elements.currency_format(login_info.amount)}} VNĐ</strong>
		    </div>
	    </div>
    </div>   
</div>