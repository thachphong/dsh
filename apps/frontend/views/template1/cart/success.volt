
<div class="row breadcrumb">
	<div class="container">
		<a href="{{baseurl}}">Trang chủ</a>		
		<span>> Đặt hàng thành công</span>			
	</div>
</div>
<div class="row content_bg">	
   <div class="container panel_bg margin-top10">
      <div class="col-md-12 col-sm-12 col-xs-12 margin_top ">
      	 <div class="row margin_top" >
         <!--<div class="pn_posts">-->
            <div class="pn_title">               
               <h1>Đặt hàng thành công </h1>
            </div> 
            <hr class="line" />           
            <div class="pn_content pn_background pn_border margin_top">               
               <div class="row" style="text-align: center">               	
                  <h4>Xin chúc mừng, đơn hàng của bạn đã đặt thành công</h4>    
                  <h4>Mã đơn hàng là: <label class="col_blue">{{ord_id}}</label></h4>    
                  <p>Trang web sẽ tự động chuyển về trang chủ trong vòng <label class="col_blue" id="count">20</label> giây.</p>          
               </div>
               <div class="row padding10">
					<div class="col-md-12 col-sm-12 col-xs-12 no_padding_left" style="padding-bottom: 10px;text-align:center">
						<a class="btn_buy btn_orange" href="{{baseurl}}" >Tiếp tục mua hàng</a>
						<a class="btn_buy btn_red" href="{{baseurl}}" >Quản lý đơn hàng</a>
					</div>
				</div>
            </div>
         </div>
      </div>     
   </div>  
</div>
<script type="text/javascript">
   $(document).ready(function () {  
   	  var count = 20;
      setInterval(reload_home, 1000);
      function reload_home(){
      	 if(count==0){
      	 	location.href = '{{baseurl}}';
      	 }else{
      	 	count--;
      	 	$('#count').text(count);
      	 }         
      }
  });
</script>