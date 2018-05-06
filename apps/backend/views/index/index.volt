<style type="text/css">
  .red_col{
      color: red;
  }
  .blue_col{
      color: blue;
  }
</style>
<div class="right_col" role="main" style="min-height: 600px">
        <div class="">            
            <div class="clearfix"></div>

            <div class="row">              
                <div class="col-md-12 col-sm-12 col-xs-12">     
                   <h3>Số đơn hàng đặt mới: <span class="blue_col">{{order_info['cnt_new']}}</span></h3>     
                   <h3>Số đơn hàng đang giao: <span class="red_col">{{order_info['cnt_shipping']}}</span></h3>       
                   <hr/>
                   <h3>Tổng user chưa active: <span class="red_col">{{user_info['not_active']}}</span></h3>  
                   <h3>Tổng user đăng ký ctv: <span class="blue_col">{{user_info['total_ctv']}}</span></h3>  
                   <h3>Tổng user đăng ký: <span class="blue_col">{{user_info['total']}}</span></h3> 
                </div>
            </div>
        </div>
                
</div>
</div>
        
</div>