<div class="search">    
    <div class="container">
        <div class="row search_tab">
            <div class="col-md-12" style="padding:0px">
                <a href="javascript:void(0)" data="1" class="tab_title active">BẤT ĐỘNG SẢN BÁN</a>
                <a href="javascript:void(0)" data="2" class="tab_title">BẤT ĐỘNG SẢN CHO THUÊ</a>
            </div>
        </div>
        <div class="row search_bg search_condition">
        <form action="{{url.get('tim')}}" method="GET">
            <input type="hidden" name="type" id="mtype" value="1">
            <div class="row search_row">
                <div class="col-md-12 col-sm-12 col-xs-12 no_padding" >
                    <input type="text" name="addr" placeholder="Nhập địa điểm" class="col-md-12">
                </div>
            </div>            
            <div class="row search_row" >
                <div class="col-md-2 col-sm-2 col-xs-12 no_padding"> 
                    <label class="select_icon">                  
                        <select name="ctgid" id="ctg_id">
                            <option>Loại bất động sản</option>
                            <option>Nhà cho thuê</option>
                            <option>Căn hộ cho thuê</option>
                            <option>Đất cho thuê</option>
                        </select>
                    </label>
                    <!-- <i class="fa fa-chevron-down"></i> -->
                </div>
                <div class="col-md-2 col-sm-2 col-xs-12 no_padding">
                    <label class="select_icon">  
                        <select name="provin" id="s_m_provin_id">
                            <option value="">Tỉnh/Thành phố</option>
                            {%for item in provincials%}
                                <option value="{{item.m_provin_id}}" >{{item.m_provin_name}}</option>
                            {%endfor%}
                        </select> 
                    </label>                  
                </div>
                <div class="col-md-2 col-sm-2 col-xs-12 no_padding">
                    <label class="select_icon">
                        <select name="district" id="s_m_district_id">
                            <option value="">Quận/Huyện</option>
                        </select>
                    </label>
                </div>
                <div class="col-md-2 col-sm-2 col-xs-12 no_padding">
                    <label class="select_icon">  
                        <select name="ward" id="s_m_ward_id">
                            <option value="">Phường/Xã</option>
                        </select>
                    </label>
                </div>
                <div class="col-md-2 col-sm-2 col-xs-12 no_padding">
                    <label class="select_icon">  
                        <select name="acreage">
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
                <div class="col-md-2 col-sm-2 col-xs-12 no_padding">
                    <label class="select_icon">  
                        <select name="price" id="price">
                            <option value="">Mức giá</option>
                            <!-- <option value="0">Thỏa thuận</option> 
                            <option value="1">&lt; 500 triệu</option> 
                            <option value="2">500 - 800 triệu</option> 
                            <option value="3">800 - 1 tỷ</option> 
                            <option value="4">1 - 2 tỷ</option> 
                            <option value="5">2 - 3 tỷ</option> 
                            <option value="6">3 - 5 tỷ</option> 
                            <option value="7">5 - 7 tỷ</option> 
                            <option value="8">7 - 10 tỷ</option> 
                            <option value="9">10 - 20 tỷ</option> 
                            <option value="10">20 - 30 tỷ</option> 
                            <option value="11">&gt; 30 tỷ</option> -->
                        </select>
                    </label>
                </div>
            </div>
            <div class="row search_row">
                <div class="col-md-2 col-sm-2 col-xs-12 no_padding">
                    <label class="select_icon">  
                        <select name="street">
                            <option value="">Đường phố</option>
                        </select>
                    </label>
                </div>
                <div class="col-md-2 col-sm-2 col-xs-12 no_padding">
                    <label class="select_icon">  
                        <select name="roomnum">
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
                <div class="col-md-2 col-sm-2 col-xs-12 no_padding">
                    <label class="select_icon">  
                        <select name="directional">
                            <option value="">Hướng nhà</option>
                            {%for item in directionals%}
                                <option value="{{item.m_directional_id}}" >{{item.m_directional_name}}</option>
                            {%endfor%}
                        </select>
                    </label>
                </div>
                <div class="col-md-2 col-sm-2 col-xs-12 no_padding">
                    <label class="select_icon">  
                        <select name="project" id="project">
                            <option value="">Dự án</option>
                        </select>
                    </label>
                </div>
                <div class="col-md-2 col-sm-2 col-xs-12 no_padding">
                    <button class="btn_search"><span class="fa fa-search"></span><span style="margin-left:5px;">TÌM KIẾM</span></button>
                </div>
                
            </div>
            </form>            
        </div>
    </div>
</div>
<script type="text/javascript">
$(document).ready(function() {
    $(document).off('click','.tab_title');
    $(document).on('click','.tab_title',function(){
        $('.tab_title').removeClass('active');
        $(this).addClass('active');
        change_m_type_id($(this).attr('data'));
        $('#mtype').val($(this).attr('data'));
        m_type_id = $(this).attr('data');
    });
    var category_list = Array();
    var sprices = Array();
    var m_type_id =1;
    function get_basic(){
        jsion_ajax("{{url.get('index/sbasic')}}" ,null,function(datas){               
            district_list = datas.m_districts;  
            provins_list    =  datas.m_provins;
            category_list = datas.categorys;
            sprices =   datas.sprices;
            project_list = datas.projects;
            //console.log(datas);
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
            $.each(sprices,function(key,item){            
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
            
        });
    }
    setTimeout(get_basic(),500);
    setTimeout(get_advance(),1000);
    function change_m_type_id(val){
        var option = '<option value="">Loại bất động sản</option>';
        //console.log(val);
        $.each(category_list,function(key,item){
            //console.log(item);
            if(val == item.parent_id){                    
                option +='<option value="'+item.ctg_id+'">'+item.ctg_name+'</option>';
            }
        });
        $('#ctg_id').empty();
        $('#ctg_id').append(option);
        var op_price = '<option value="">Mức giá</option>';
        //console.log(sprices);  
        $.each(sprices,function(key,item){  
        	//console.log(item);          
            if(val == item.m_type_id){                    
                op_price +='<option value="'+item.s_price_id+'">'+item.s_price_name+'</option>';                                     
            }
        });
        $('#price').empty();
        $('#price').append(op_price);
    }
    change_m_type_id(1);
    var district_list = null;
    var ward_list = null;
    function get_district(){
        jsion_ajax("{{url.get('index/district')}}" ,null,function(datas){               
            district_list = datas.m_districts;  
            ward_list    =  datas.m_wards;  
        });
    }
    setTimeout(get_district(),1000);
    $(document).off('change','#s_m_provin_id');
    $(document).on('change','#s_m_provin_id',function(){
        var val = $(this).val().trim();
        var option='<option value="">Quận/Huyện</option>';
        if(val !=''){
            var list=district_list;
            for(i=0;i<list.length;i++){
                if(list[i]['m_provin_id'] == val){
                    option +='<option value="'+list[i]['m_district_id']+'">'+list[i]['m_district_name']+'</option>'; 
                }                        
            }
            $('#s_m_district_id').empty();
            $('#s_m_district_id').append(option);
                               
           // });
        }else{
            $('#s_m_district_id').empty();
            $('#s_m_district_id').append(option);
        }        
        
    });  
    $(document).off('change','#s_m_district_id');
    $(document).on('change','#s_m_district_id',function(){
        var val = $(this).val().trim();
        var option='<option value="">Phường/Xã</option>';
        if(val !=''){
            var list=ward_list;                    
            for(i=0;i<list.length;i++){
                if(list[i]['m_district_id'] == val){
                    option +='<option value="'+list[i]['m_ward_id']+'">'+list[i]['m_ward_name']+'</option>'; 
                }                        
            }                  
        }
        $('#s_m_ward_id').empty();
        $('#s_m_ward_id').append(option);        
        
    });  

    s_m_ward_id
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
</script>