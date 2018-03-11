   <div class="col-lg-4 col-sm-4 col-xs-12">
                                		<div class="tabsview">
	        <div id="tabs">
	            <ul>
	                <li><a href="#tabs-1"><i class="fa fa-rocket"></i> Đọc Nhiều</a></li>
	                <li><a href="#tabs-2"><i class="fa fa-eye"></i> Mớt Nhất</a></li>
	            </ul>
	            <div id="tabs-1">
	                <div class="list-posts">
		                <ul>
		                	{{ elements.getTopPost() }}	 	
		                </ul>
		            </div>
	            </div>
	            <div id="tabs-2">
	                <div class="list-posts">
		                <ul>		                	
		                	{{ elements.getNewPost() }}	                    		                    
		                </ul>
		            </div>
	            </div>
	        </div>
	        <script>
	        jQuery(function() {
	             jQuery( "#tabs" ).tabs();
	        });
	        </script>
	    </div>
        <div id="eweb_post_by_cate_3-3" class="item-cate-2 item-cate-3 item-cate">            
        	<div class="subcat-2"><span>	            
        		<a href="../c/thoi-su/" title=""><i class="fa fa-"></i> Thời sự</a></span>
            </div>            
            <div class="list-posts">
                <ul>
                	{{ elements.getMidlePost() }}
                </ul>
            </div>

        </div><!--<div id="text-15" class="widget_text item-cate">			<div class="textwidget"><script type="text/javascript" src="//admicro1.vcmedia.vn/ads_codes/ads_box_34237.ads"></script></div>
		</div> -->                           </div>