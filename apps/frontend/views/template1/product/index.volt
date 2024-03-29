<div class="row pos_rl" >
	<div class="bg_frame_search">
	    <div class="container">  
	    	<div class="col-md-6 col-sm-6 col-xs-12">
		    	<span class="page_title fs35">{{pro_name}}</span>
		    	<div class="row brdcrumb">
		    	<a href="{{baseurl}}">Trang chủ</a>	
				{%for br in breadcrumbs%}
					<span>></span>
					<a href="{{baseurl}}c/{{br['ctg_no']}}">{{br['ctg_name']}}</a>
				{%endfor%}
				<span>> {{pro_name}}</span>	
				</div>	    		
			</div>	
			<div class=" col-md-6 col-sm-6 col-xs-12 box_search">
				<form method="get" class="searchform" action="{{url.get('search')}}">				    
				    <input id="s-keyword" name="s" type="text" value="" class="input_search text_input" placeholder="Tìm sản phẩm và dịch vụ">
					<input type="submit" value="" style="font-family:FontAwesome" class="btn_search">
				</form>	
			</div>
	    </div>
    </div>
</div>
<!--<div class="row breadcrumb">
	<div class="container">
		<a href="{{baseurl}}">Trang chủ</a>
		{%for br in breadcrumbs%}
			<span>></span>
			<a href="{{baseurl}}{{br['ctg_no']}}">{{br['ctg_name']}}</a>
		{%endfor%}		
		<span>> {{pro_name}}</span>
	</div>
</div>-->
<div class="row" >
	<div class="container panel_bg margin-top10">		
		<div class="row padding-bottom10">
			<div class="col-md-6 col-sm-6 col-xs-12">
				<div class="col-md-1 col-sm-1 col-xs-2 no_padding">
					<ul class="img_list">
					{%for key,img in imglist%}
						<li class="img_item {%if key==0%}img_active{%endif%}" id="img_{{img.pro_img_id}}"><img src="{{baseurl}}{{img.img_path}}"/></li>
					{%endfor%}
					</ul>
				</div>
				<div class="col-md-11 col-sm-11 col-xs-10 no_padding_right">
					<img id="zoom_08" class="img_main" src="{{baseurl}}{{imglist[0].img_path}}" data-zoom-image="{{baseurl}}{{imglist[0].img_path}}" title="{{pro_name}}" alt="{{pro_name}}"/>
				</div>
			</div>
			<div class="col-md-6 col-sm-6 col-xs-12 no_padding_left mobi_lpad">
				<h1>{{pro_name}}</h1>
				<hr/>
				<div class="row no_padding_left">
					<h5>Giá : <del class="price">{{elements.currency_format(pricelist[0].price_seller)}} đ</del>
						<strong class="price col_blue">{{elements.currency_format(pricelist[0].price_exp)}} đ</strong>
					</h5>
				</div>
				<div class="col-md-6 col-sm-6 col-xs-12">
					<h5>
					
					</h5>
				</div>
				<div class="row margin-top10">
					<span>Trạng thái: {{status_name}}</span>					
				</div>
				<form action="{{baseurl}}cart/addtocart" method="post" id="formcart">
				<div class="row margin-top10" {%if color_flg ==false%}style="display:none"{%endif%}>
					<input type="hidden" name="color_sel" id="color_sel" value=""/>
					<ul class="colorlist no_padding">
						<li class="title_color"> Màu sắc</li>
						{%for img in imglist%}
							{%if img.color !=''%}
							<li class="">
								<a id="color_{{img.pro_img_id}}" class="color_item" data="{{img.color}}" href="javascript:;">
									<img src="{{baseurl}}{{img.img_path}}" title="{{img.color}}"/>
								</a>								
							</li>
							{%endif%}
						{%endfor%}
					</ul>
					<span class="lab_red lab_invisible border_red" id="color_error">Bạn cần màu sắc !</span>
					<input type="hidden" name="pro_size"  id="pro_size" value="{{pricelist[0].pro_price_id}}"/>
				</div>
				<div class="row margin-top10" {%if sizes|length==0%}style="display:none"{%endif%}>
					<input type="hidden" name="size_sel" id="size_sel" value=""/>
					<ul class="sizelist no_padding">
						<li class="title_color"> Kích thước</li>
						{%for size in sizes%}
							<li class="">
								<a class="size_item" href="javascript:;" data="{{size}}">
									{{size}}
								</a>								
							</li>
						{%endfor%}
					</ul>	
					<span class="lab_red lab_invisible border_red" id="size_error">Bạn cần kích thước !</span>
				</div>
				<div class="row margin-top10">
					<span class="title_color">Số lượng</span>
					<span class="pro_qty">
						<a href="javascript:void(0)" onclick="qty_add(-1)"><i class="fa fa-minus" ></i></a>
						<input value="1" id="pro_qty" name="pro_qty"/>
						<a href="javascript:void(0)" onclick="qty_add(1)"><i class="fa fa-plus"></i></a>
					</span>					
				</div>
				</form>
				<div class="row">
					<div class="col-md-12 col-sm-12 col-xs-12 no_padding_left" style="padding-top: 10px;">
						<a class="btn_buy btn_orange" id="addtocart">Mua ngay</a>					
						<a class="btn_buy btn_red" id="add_cart">Thêm vào giỏ hàng</a>
					</div>
				</div>
			</div>
			
		</div>
	</div>
	<div class="container margin-top20">		
		<div class="col-md-80 col-sm-9 col-xs-12 no_padding_left">
			<div class="row panel_bg">
				<ul class="nav nav-tabs" id="comment_tab">
	                 <li class="active"><a data-toggle="tab" href="#tab1">Mô tả</a></li>
	                 <li><a data-toggle="tab" href="#tab2" >Thông số kỹ thuật</a></li>
	                 <li><a data-toggle="tab" href="#tab3" >Bình luận</a></li>                 
	            </ul>
	               <div class="tab-content">
	                  <div id="tab1" class="tab-pane fade in active">
	                  	<div class="fr-element fr-view padding10">
	                  		{{content|nl2br}}
	                  	</div>
	                  </div>
	                  <div id="tab2" class="tab-pane fade">
	                     <div class="fr-element fr-view padding10" style="min-height: 50px;">
	                  		{{technology|nl2br}}
	                  	</div>                 
	                  </div>
	                  <div id="tab3" class="tab-pane fade padding10">
	                  		<div class="fb-comments" data-href="{{url.get('sp/')}}{{pro_no}}_{{pro_id}}" data-width="100%" data-numposts="20"></div>
	                        <div id="fb-root"></div>
	                        <script>(function(d, s, id) {
	                                      var js, fjs = d.getElementsByTagName(s)[0];
	                                      if (d.getElementById(id)) return;
	                                      js = d.createElement(s); js.id = id;
	                                      js.src = "//connect.facebook.net/vi_VN/sdk.js#xfbml=1&version=v2.9&appId=807407399380069";
	                                      fjs.parentNode.insertBefore(js, fjs);
	                                    }(document, 'script', 'facebook-jssdk'));
	                        </script>
	                  </div>
	               </div>
			</div>
			<div class="row margin-top-10">
				<div class="pn-header-top">
					<div class="pn-title">
						<h3 class="ctg_title">Sản phẩm cùng danh mục</h3>
					</div>
					
				</div>
				<div class="row pro_list relation">
					{%for item in relations%}					
					<div class="col-md-3 col-sm-3 col-xs-6 pro_list_item">
						<a href="{{url.get('sp/')}}{{item['pro_no']}}_{{item['pro_id']}}">	
						<div class="div_img">		
							{%for key,img in item['img_path']%}
								{%if key < 2%}
									<img src="{{url.get('')}}{{img}}" class="{%if key >0%}img_sec{%else%}img_first{%endif%}" title="{{item['pro_name']}}" alt="{{item['pro_name']}}"/>
								{%endif%}
							{%endfor%}
						</div>						
						<div class="div_desc">
							<span class="lst-it-title">{{item['pro_name']}}</span>
							<div><del class="font_size14">{{elements.currency_format(item['price_seller'])}} đ</del><strong class="font_size14 col_blue">{{elements.currency_format(item['price_exp'])}} đ</strong></div>
						</div>						
						</a>
						<div class="row">
							<a class="icon-cart"></a>
						</div>
					</div>
					
					{%endfor%}
			</div>
			</div>
		</div>
		<div class="col-md-20 col-sm-3 col-xs-12 no_padding">
			<div class="row pn-header-top">
				<div class="pn-title">
					<h3 class="ctg_title">Sản phẩm bán chạy</h3>
				</div>
			</div>
			<div class="row pro_list">
				{{elements.getGoodsell()}}
			</div>
		</div>		
	</div>
	<!--<div class="container">
		<div class="row margin-top-10">
			<div class="pn-header-top">
				<div class="pn-title">
					<h2>Sản phẩm cùng danh mục</h2>
				</div>
			</div>
		</div>
	</div>-->
</div>
{{ partial('includes/pho_ajax') }}
<script>
	$(document).ready(function() {
		var color_flg = {{color_flg}};
		var size_flg = false;
		{%if sizes|length > 0%}
			size_flg = true;
		{%endif%}
		$("#zoom_08").elevateZoom({
				zoomWindowFadeIn: 500,
				zoomWindowFadeOut: 500,
				lensFadeIn: 500,
				lensFadeOut: 500
		});
		$(document).off('mouseover','.img_item');
	    $(document).on('mouseover','.img_item',function(){
	    	change_img($(this));
	        /*$('.img_item').removeClass('img_active');
	        $(this).addClass('img_active');
	        var img = $(this).find('img')[0];
	        var src = $(img).attr('src');
	        //console.log(src);
	        $("#zoom_08").attr('src',src);
	        $("#zoom_08").attr('data-zoom-image',src);
	        var ez =   $('#zoom_08').data('elevateZoom');	  
   
			  ez.swaptheimage(src, src); */
	    });
	    var change_img = function(obj){
	    	$('.img_item').removeClass('img_active');
	        $(obj).addClass('img_active');
	        var img = $(obj).find('img')[0];
	        var src = $(img).attr('src');
	        //console.log(src);
	        $("#zoom_08").attr('src',src);
	        $("#zoom_08").attr('data-zoom-image',src);
	        var ez =   $('#zoom_08').data('elevateZoom');	  
   
			  ez.swaptheimage(src, src); 
	    }
	    $(document).off('click','.color_item');
	    $(document).on('click','.color_item',function(){
	    	$('.color_item').removeClass('active');
	    	$(this).addClass('active');
	    	var id =$(this).attr('id').replace('color_','')
	    	change_img($('#img_'+id));
	    	$('#color_sel').val($(this).attr('data'));
	    });	
	    $(document).off('click','.size_item');
	    $(document).on('click','.size_item',function(){
	    	$('.size_item').removeClass('active');
	    	$(this).addClass('active');
	    	$('#size_sel').val($(this).attr('data'));
	    });		    
	    $(document).off('click','#add_cart');
	    $(document).on('click','#add_cart',function(){
	       if(!color_size_validate()){return;}
	       Pho_json_ajax('POST',"{{url.get('cart/add')}}" ,{'pro_size':$('#pro_size').val()
	       		,'pro_qty':$('#pro_qty').val(),'color_sel':$('#color_sel').val(),'size_sel':$('#size_sel').val()
	       		},function(datas){
		        if(datas.status =="OK"){
		          //Pho_modal_close("modal1");
		          	$('#cart_number').text(datas.total);
		            Pho_message_box("Thêm thành công",'Sản phẩm đã được thêm vào giỏ hàng của bạn');
		            setTimeout(function(){Pho_message_close();},2000);
		          //Pho_direct("{{url.get('users/success')}}" );
		        }else{		        	
		        	Pho_message_box_error("Lỗi",datas.msg);
		        }	                
	        });
	    });
	    $(document).off('click','#addtocart');
	    $(document).on('click','#addtocart',function(){
	    	if(!color_size_validate()){return;}
	       $('#formcart').submit();
	    });
	    var color_size_validate = function(){
	    	var chk = true;
	    	console.log(color_flg);
	    	console.log(size_flg);
	    	if(color_flg && $('#color_sel').val()==''){
	    		$('#color_error').show();
	    		chk = false;
	    	}else{
	    		$('#color_error').hide();
	    	}
	    	if(size_flg && $('#size_sel').val()==''){
	    		$('#size_error').show();
	    		chk = false;
	    	}else{
	    		$('#size_error').hide();
	    	}
	    	console.log(chk);
	    	return chk;
	    }
	});
	function qty_add(qty){
         var val = parseInt($("#pro_qty").val());
         var quantity = val + qty;
         if((quantity) == 0){
            return;
         }
         $("#pro_qty").val(quantity);
    }
</script>