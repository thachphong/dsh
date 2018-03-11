<div class="col-md-4 col-sm-12 col-xs-12 margin_top no_padding_right">
         <div class="row margin_top">
            <div class="pn_title">
               <span class="bg_icon" style="padding: 6px 4px 4px 2px;"><i class="fa fa-list"></i></span>
               <h3>Tin đặc biệt</h3>
            </div>
            <!--<div style=" height: 400px;position: relative; overflow: hidden;">-->
            <ul class="viplist" id="viplist" >               
               {{ elements.getTindacbiet() }}
            </ul>
            <!--</div>-->
         </div>
         <div class="row margin_top">
            <div class="pn_title">
               <span class="bg_icon" style="padding: 6px 4px 4px 2px;"><i class="fa fa-list"></i></span>
               <h3>Tin xem nhiều</h3>
            </div>
            
            <div class="newsboxrow pn_background pn_border">
               <div class="colbox " ><!--style=" height: 314px; position: relative; overflow: hidden;"-->
                     <ul class="boxright" id="tinxemnhieu">
                     {{ elements.getTinxemnhieu() }}
                     </ul>
               </div>
            </div>  
         </div>
         <div class="row margin_top">
            <div class="pn_title">
               <span class="bg_icon" style="padding: 6px 4px 4px 2px;"><i class="fa fa-list"></i></span>
               <h3>Dự án nổi bật</h3>
            </div>
            <div class="viplist" style="display: block;height: 400px;overflow-y: auto;margin-top: 5px">
            	{{ elements.getduannoibac() }}            
            </div>
         </div>
         <div class="row margin_top">
            <div class="pn_title">
               <span class="bg_icon" style="padding: 6px 4px 4px 2px;"><i class="fa fa-list"></i></span>
               <h3>Mua bán nhà đất</h3>
            </div>
            
            <div class="newsboxrow pn_background pn_border">
               <div class="colbox " ><!--style=" height: 314px; position: relative; overflow: hidden;"-->
                     <ul class="boxright">
                     {{ elements.getdanhmuc(1) }}
                     </ul>
               </div>
            </div>  
         </div>
         <div class="row margin_top">
            <div class="pn_title">
               <span class="bg_icon" style="padding: 6px 4px 4px 2px;"><i class="fa fa-list"></i></span>
               <h3>Cho thuê nhà đất</h3>
            </div>
            
            <div class="newsboxrow pn_background pn_border">
               <div class="colbox " ><!--style=" height: 314px; position: relative; overflow: hidden;"-->
                     <ul class="boxright">
                     {{ elements.getdanhmuc(2) }}
                     </ul>
               </div>
            </div>  
         </div>
         <!--<div class="row margin_top">
            <div class="pn_title">
               <span class="bg_icon" style="padding: 6px 4px 4px 2px;"><i class="fa fa-list"></i></span>
               <h3>Nhà đất theo Tỉnh/Thành Phố</h3>
            </div>
            
            <div class="newsboxrow pn_background pn_border">
               <div class="colbox " >
                     <ul class="boxright">
                  
                     </ul>
               </div>
            </div>  
         </div>-->
      </div>

<script type="text/javascript">
   $(document).ready(function() {
     // $('#tinxemnhieu').newstape();  
      //$('.newstape').newstape();
      /*$("#tinxemnhieu").simplyScroll({
                    customClass: 'vert',
                    orientation: 'vertical',
                    auto: true,
                    manualMode: 'end',
                    frameRate:10 ,
                    speed: 1
                });
      $("#viplist").simplyScroll({
                    customClass: 'vert',
                    orientation: 'vertical',
                    auto: true,
                    manualMode: 'end',
                    frameRate:10 ,
                    speed: 1
                });*/
   });
</script>