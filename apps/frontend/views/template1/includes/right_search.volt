<div class="col-md-4 col-sm-12 col-xs-12 margin_top no_padding_right">
   <div class="row margin_top">            
            <div class="searchright pn_background pn_border"> 
            <form action="{{url.get('tim')}}" method="GET">
               <div class="row" style="margin-top:0px;padding-top:0px;">
                  <div class="col-md-6 col-sm-6 col-xs-6 right_tab" >
                     <a href="javascript:void(0)" data="1" class="right_tab_item right_tab_active" id="tab_1">BĐS BÁN</a>
                     
                  </div>
                  <div class="col-md-6 col-sm-6 col-xs-6 right_tab" >                     
                     <a href="javascript:void(0)" data="2" class="right_tab_item" id="tab_2">BĐS CHO THUÊ</a>
                  </div>
                  <input type="hidden" name="type" id="mtype" value="1">
               </div>
               <div class="right_search_basic">
                  <div class="row">
                     <input type="text" name="addr" id="addr" placeholder="Nhập địa điểm">
                  </div>
                  <div class="row">
                     <label class="select_icon">
                           <select name="ctgid" id="ctg_id">
                              <option value="">Loại bất động sản</option>
                           </select>
                     </label>
                  </div>
                  <div class="row">
                     <label class="select_icon">
                           <select name="provin" id="s_m_provin_id">
                              <option value="">--Chọn Tỉnh/Thành phố--</option>
                           </select>
                     </label>
                  </div>
                  <div class="row">
                     <label class="select_icon">
                           <select name="district" id="s_m_district_id">
                              <option value="">--Chọn Quận/Huyện--</option>
                           </select>
                     </label>
                  </div>
                  <div class="row">
                     <label class="select_icon">
                           <select name="acreage" id="acreage">
                              <option value="">Diện tích</option>
                              <option value="0">Không xác định</option> 
                               <option value="1">&lt;= 30 m2</option> 
                               <option value="2">30-50 m2</option> 
                               <option value="3">50-80 m2</option> 
                               <option value="4">80-100 m2</option> 
                               <option value="5">100-150 m2</option> 
                               <option value="6">150-200 m2</option> 
                               <option value="7">200-250 m2</option> 
                               <option value="8">250-300 m2</option> 
                               <option value="9">300-500 m2</option> 
                               <option value="10">&gt;=500 m2</option>
                           </select>
                     </label>
                  </div>
                  <div class="row">
                     <label class="select_icon">
                           <select name="price" id="price">
                              <option value="">Mức giá</option>
                           </select>
                     </label>
                  </div>
               </div>
               <div class="right_search_advance" style="display:none">
                  <div class="row">
                     <label class="select_icon">
                           <select name="ward" id="s_m_ward_id">
                              <option value="">--Chọn Phường/Xã--</option>
                           </select>
                     </label>
                  </div>
                  <div class="row">
                     <label class="select_icon">
                           <select name="m_ward_id" id="m_ward_id">
                              <option value="">--Chọn Đường/Phố--</option>
                           </select>
                     </label>
                  </div>
                  <div class="row">
                     <label class="select_icon">
                           <select name="directional" id="directional">
                              <option value="">Hướng nhà</option>
                           </select>
                     </label>
                  </div>
                  <div class="row">
                     <label class="select_icon">
                           <select name="roomnum" id="roomnum">
                              <option value="">Số phòng ngủ</option>
                               <option value="0">Không xác đinh</option>
                               <option value="1">1+</option>
                               <option value="2">2+</option>
                               <option value="3">3+</option>
                               <option value="4">4+</option>
                               <option value="5">5+</option>
                           </select>
                     </label>
                  </div>
                  <div class="row">
                    <label class="select_icon">  
                        <select name="project" id="project">
                            <option value="">Dự án</option>
                        </select>
                    </label>
                </div>                  
               </div>
               <div class="right_search_btn">
                  <div class="row">
                     <div class="col-md-6 col-sm-6 col-xs-6" style="padding-left:0px;padding-top:7px;padding-right:0px;">
                        <i class="fa fa-asterisk"></i>
                        <a href="javascript:void(0)" class="show_search_advance">Tìm kiếm nâng cao</a>
                     </div>
                     <div class="col-md-6 col-sm-6 col-xs-6" style="padding-right:0px;">
                        <button class="btn_search"><span class="fa fa-search"></span><span style="margin-left:5px;">TÌM KIẾM</span></button>
                     </div>
                  </div>
               </div>
            </form>
            </div>
   </div>
   		{%if dstlist|length > 0%}
   		 <div class="row margin_top">
            <div class="pn_title">
               <span class="bg_icon" style="padding: 6px 4px 4px 2px;"><i class="fa fa-list"></i></span>
               <h3>{%if dstlist[0]['ctg_name'] is defined%}
               			{{dstlist[0]['ctg_name']}} tại {{dstlist[0]['title']}} 
               		{%elseif dstlist[0]['m_type_id']=='1'%}
               			Bán nhà đất tại {{dstlist[0]['title']}} 
               		{%elseif dstlist[0]['m_type_id']=='2'%}
               			Cho thuê nhà đất tại {{dstlist[0]['title']}}
               		{%endif%}</h3>
            </div>
            <div class="newsboxrow pn_background pn_border">
               <div class="colbox " > <!--height: 314px; position: relative; overflow: hidden;"-->
                     <ul class="boxright" id="tinxemnhieu">
                     {%for item in dstlist%}
                		<li class="news-item"> <i class="fa fa-circle"></i>
                		<a href="{{url.get('tim?')}}{{item['dst_id']}}&type={{type}}">{{item['dst_name']}}({{item['cnt']}})</a></li>
					{%endfor%}
                     </ul>
               </div>
            </div>
         </div>
         {%endif%}
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
         <!--<div class="row margin_top">
            <div class="pn_title">
               <span class="bg_icon" style="padding: 6px 4px 4px 2px;"><i class="fa fa-list"></i></span>
               <h3>Tin xem nhiều</h3>
            </div>
            
            <div class="newsboxrow pn_background pn_border">
               <div class="colbox " >
                     <ul class="boxright" id="tinxemnhieu">
                     {{ elements.getTinxemnhieu() }}
                     </ul>
               </div>
            </div>  
         </div>-->
         <div class="row margin_top">
            <div class="pn_title">
               <span class="bg_icon" style="padding: 6px 4px 4px 2px;"><i class="fa fa-list"></i></span>
               <h3>Dự án nổi bật</h3>
            </div>
            <div class="viplist" style="display: block;height: 400px;overflow-y: auto;margin-top: 5px">
            	{{ elements.getduannoibac() }}            
            </div>
         </div>
      </div>
<script type="text/javascript">
$(document).ready(function() {
	var _param = get_param_search();	
    $(document).off('click','.right_tab_item');
    $(document).on('click','.right_tab_item',function(){
        // console.log('aaa');
        $('.right_tab_item').removeClass('right_tab_active');
        $(this).addClass('right_tab_active');
        change_m_type_id($(this).attr('data'));
        $('#mtype').val($(this).attr('data'));
    });
    
    $(document).off('click','.show_search_advance');
    $(document).on('click','.show_search_advance',function(){
         if($(this).text()=='Tìm kiếm nâng cao'){
             $(this).text('Bỏ tìm kiếm nâng cao');
             $('.right_search_advance').show();
         }else{
             $('.right_search_advance').hide();
              $(this).text('Tìm kiếm nâng cao');
         }
         
    });
    var category_list = null;
    var provins_list = null;
    var district_list = null;
    var ward_list = null;
    var sprices_list = null;
    var m_type_id = 1;
    {%if m_type_id is defined%}
        m_type_id = '{{m_type_id}}';
    {%endif%}
    
    function change_m_type_id(val){
        var option = '<option value="">Loại bất động sản</option>';
        $.each(category_list,function(key,item){
            //console.log(item);
            if(val == item['parent_id']){                    
               option +='<option value="'+item['ctg_id']+'">'+item['ctg_name']+'</option>';                                     
            }
        });
        $('#ctg_id').empty();
        $('#ctg_id').append(option);
        var op_price = '<option value="">Mức giá</option>';
            $.each(sprices_list,function(key,item){            
               if(val == item['m_type_id']){                    
                   op_price +='<option value="'+item['s_price_id']+'">'+item['s_price_name']+'</option>';                                     
               }
         });
         $('#price').empty();
         $('#price').append(op_price);
    }
    //change_m_type_id(1);
    
   function get_basic(){
        jsion_ajax("{{url.get('index/sbasic')}}" ,null,function(datas){               
            district_list = datas.m_districts;  
            provins_list    =  datas.m_provins;
            category_list = datas.categorys;
            sprices_list =   datas.sprices;
            project_list = datas.projects;
            var option = '<option value="">Loại bất động sản</option>';
            $.each(category_list,function(key,item){
               //console.log(item);
               if(m_type_id == item['parent_id']){                    
                   option +='<option value="'+item['ctg_id']+'">'+item['ctg_name']+'</option>';                                     
               }
            });
            $('#ctg_id').empty();
            $('#ctg_id').append(option);
            var option = '<option value="">--Chọn Tỉnh/Thành phố--</option>';
            $.each(provins_list,function(key,item){                                
               option +='<option value="'+item['m_provin_id']+'">'+item['m_provin_name']+'</option>';
            });
            $('#s_m_provin_id').empty();
            $('#s_m_provin_id').append(option);
            var op_price = '<option value="">Mức giá</option>';
            $.each(sprices_list,function(key,item){            
               if(m_type_id == item['m_type_id']){                    
                   op_price +='<option value="'+item['s_price_id']+'">'+item['s_price_name']+'</option>';                                     
               }
            });
            $('#price').empty();
            $('#price').append(op_price);
            var op_project = '<option value="">Dự án</option>';
            $.each(project_list,function(key,item){
               op_project +='<option value="'+item['news_id']+'">'+item['news_name']+'</option>';                        
            });
            $('#project').empty();
            $('#project').append(op_project);
        });
    }
    function get_advance(){
        jsion_ajax("{{url.get('index/sadvance')}}" ,null,function(datas){   
            ward_list    =  datas.m_wards;
           
            var option = '<option value="">Hướng nhà</option>';
            $.each(datas.directionals,function(key,item){                                
               option +='<option value="'+item['m_directional_id']+'">'+item['m_directional_name']+'</option>';
            });
            $('#directional').empty();
            $('#directional').append(option);
            set_param_search();
        });
    }
    function set_param_search(){    	
    	if(_param.type != undefined && _param.type==2 ){		
			$('#tab_2').click();		
		}
		if(_param.addr != undefined && _param.addr.length > 0){
			$('#addr').val(urldecode(_param.addr));
		}
		if(_param.ctgid != undefined && _param.ctgid.length > 0){
			$('#ctg_id').val(_param.ctgid);
		}
		if(_param.provin != undefined && _param.provin.length > 0){
			$('#s_m_provin_id').val(_param.provin);
			change_district_list();
		}
		if(_param.acreage != undefined && _param.acreage.length > 0){
			$('#acreage').val(_param.acreage);
		}
		if(_param.price != undefined && _param.price.length > 0){
			$('#price').val(_param.price);
		}
		if(_param.directional != undefined && _param.directional.length > 0){
			$('#directional').val(_param.directional);
		}
		if(_param.roomnum != undefined && _param.roomnum.length > 0){
			$('#roomnum').val(_param.roomnum);
		}
		if(_param.project != undefined && _param.project.length > 0){
			$('#project').val(_param.project);
		}
    };
    setTimeout(get_basic(),500);
    setTimeout(get_advance(),1000);
    
    $(document).off('change','#s_m_provin_id');
    $(document).on('change','#s_m_provin_id',function(){
        change_district_list();
    }); 
    function change_district_list(){
    	var val = $('#s_m_provin_id').val().trim();
        var option='<option value="">Quận/Huyện</option>';
        if(val !=''){
            var list=district_list;
            for(i=0;i<list.length;i++){
                if(list[i]['m_provin_id'] == val){
                	if(_param.district != undefined && _param.district ==list[i]['m_district_id'] ){
                		option +='<option value="'+list[i]['m_district_id']+'" selected>'+list[i]['m_district_name']+'</option>'; 
                		
                	}else{
                		option +='<option value="'+list[i]['m_district_id']+'">'+list[i]['m_district_name']+'</option>'; 
                	}
                    
                    
                }                        
            }
            $('#s_m_district_id').empty();
            $('#s_m_district_id').append(option);
                               
           // });
        }else{
            $('#s_m_district_id').empty();
            $('#s_m_district_id').append(option);
        }
        if(_param.district != undefined && _param.district.length > 0){
        	_param.district='';
			change_ward_list();
		}
    }; 
    $(document).off('change','#s_m_district_id');
    $(document).on('change','#s_m_district_id',function(){
        change_ward_list();
    });
    function change_ward_list(){
    	var val = $('#s_m_district_id').val().trim();
        var option='<option value="">Phường/Xã</option>';
        if(val !=''){
            var list=ward_list;                    
            for(i=0;i<list.length;i++){
                if(list[i]['m_district_id'] == val){
                	if(_param.ward != undefined && _param.ward == list[i]['m_ward_id']){
						option +='<option value="'+list[i]['m_ward_id']+'" selected>'+list[i]['m_ward_name']+'</option>'; 
						_param.ward='';
					}else{
						option +='<option value="'+list[i]['m_ward_id']+'">'+list[i]['m_ward_name']+'</option>'; 
					}
                    
                }                        
            }                  
        }
        $('#s_m_ward_id').empty();
        $('#s_m_ward_id').append(option);
    };
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
        type: 'POST'
    });
}
function get_param_search(){
	var url = location.href;
	var result = {};
	if(url.indexOf('?')>=0){
		var str = url.split('?');
		if(str[1].indexOf('&')>=0){
			var param = str[1].split('&');
			$.each(param, function( index, value ) {
			    var item = value.split('=');
			    result[item[0]]=item[1];
			});
		}		
	}
	return result;
}
function urldecode(html) {
    var txt = decodeURIComponent(html);
    txt =  txt.replace( /\+/g, ' '); 
    return txt;
}
</script>