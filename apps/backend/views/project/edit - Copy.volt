<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Admin! | </title>    
    {{ partial('includes/header') }}
    {{ partial('includes/editor') }}
    <style>
  .dvtinh{
    margin-top: 7px;
      display: block;
  }
  .optionGroup {
      font-weight: bold;
      font-style: italic;
  }
  
  </style>
  </head>
  {% set login_info= elements.getuser()%}
  <body class="nav-md">    
    {{ partial('includes/pho_ajax') }}
    <div class="container body">
      <div class="main_container">        
        {{ partial('includes/left') }}
        <!-- top navigation -->
        <div class="top_nav">         
          {{ partial('includes/menu') }}
        </div>
        <!-- /top navigation -->

        <!-- page content -->
        {{ content() }}
        
        <!-- /page content -->
        <div class="right_col" role="main" style="min-height: 600px">
          <div class="">           
            <div class="clearfix"></div>

            <div class="row">              
        <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Thêm dự án </h2>
                    
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <div class="row">
                      <div class="col-md-12 col-sm-12 col-xs-12">
                
                  <div class="x_content">
                    <br />
                    <form id="form_ctg" action="" class="form-horizontal form-label-left" enctype="multipart/form-data">
                      <div class="row">
                        <div class="col-md-8">
                            <div class="form-group">
                              <label class="control-label col-md-2 col-sm-2 col-xs-12" for="project_name">Tên dự án<span class="required">*</span>
                              </label>
                              <div class="col-md-10 col-sm-10 col-xs-12">
                                <input type="text" id="project_name" required="required" name="project_name" class="form-control col-md-10 col-xs-12" value="{{project_name}}">                          
                                <input type="hidden"  name="project_id" value="{{project_id}}"> 
                                <input type="hidden" name="folder_tmp" value="{{folder_tmp}}">                       
                              </div>
                            </div>
                            <div class="form-group">
                              <label class="control-label col-md-2 col-sm-2 col-xs-12" for="ctg_id">Loại dự án<span class="required">*</span>
                              </label>
                              <div class="col-md-4 col-sm-4 col-xs-12">
                                <select class="form-control" name="ctg_id" id="ctg_id">
                                   <option ></option>
                                   {%for ctg in ctg_list%}
                                    
                                      <option   value="{{ctg['ctg_id']}}" {%if ctg['ctg_id'] == ctg_id%}selected="selected"{%endif%}>{{ctg['ctg_name']}}</option>
                                   {%endfor%}                           
                                </select>                  
                              </div>
                              <label class="control-label col-md-2 col-sm-2 col-xs-12" for="ctg_id">Quy mô dự án
                              </label>
                              <div class="col-md-4 col-sm-4 col-xs-12">
                                   <input type="text" id="scale" name="scale" value="{{scale}}" class="form-control">            
                              </div>
                            </div>
                            <div class="form-group">
                              <label class="control-label col-md-2 col-sm-2 col-xs-12" for="boss_name">Chủ đầu tư<span class="required">*</span>
                              </label>
                              <div class="col-md- col-sm-10 col-xs-12">
                                <input type="text" id="boss_name" required="required" name="boss_name" class="form-control col-md-10 col-xs-12" value="{{boss_name}}">
                              </div>
                            </div>
                             
                        </div>
                        <div class="col-md-4">
                          <div class="form-group">                        
                           <!--  <label class="control-label col-md-2 col-sm-2 col-xs-12" for="img_path">Hình Ảnh</label> -->
                            <div class="col-md-7 col-sm-7 col-xs-12">
                              <input type="hidden" id="img_path" name="img_path" class="form-control col-md-7 col-xs-12" value="{{img_path}}"> 
                              <img src="{%if img_path!=""%}{{url.get()}}{{img_path}}{%endif%}" class="img-rounded" style="height: 120px;width:170px;border: solid 1px #06be17;" id="news_avata" title ="Ảnh đại diện">                         
                            </div>
                            <div class="col-md-5 col-sm-5 col-xs-12">
                              <button class="btn btn-primary" type="button" id="btn_upload">Upload</button>
                              <input  type="file" id="upload_file" style="display: none"/>
                              
                            </div>
                          </div>
                        </div>
                      </div>                    
                    <div class="row">
                      <div class="col-md-8">
	                      <div class="form-group">                        
	                        <label class="control-label col-md-2 col-sm-2 col-xs-12" for="img_path">Tỉnh/TP</label>
	                        <div class="col-md-4 col-sm-4 col-xs-12">
	                          <select id="m_provin_id" name="m_provin_id" required class="form-control">
										<option value=""></option>
										{%for item in provincials%}
											<option value="{{item.m_provin_id}}" {%if m_provin_id == item.m_provin_id%}selected{%endif%}>{{item.m_provin_name}}</option>
										{%endfor%}
									</select>
	                        </div>
	                        <label class="control-label col-md-2 col-sm-2 col-xs-12" for="img_path">Quận/Huyện</label>
	                        <div class="col-md-4 col-sm-4 col-xs-12">
		                          <select id="m_district_id" name="m_district_id" class="form-control">
										<option value=""></option>
								  </select>
	                        </div>
                        </div> 
                      </div>
                      <div class="col-md-4">
	                      <div class="form-group">
	                        <label class="control-label col-md-4 col-sm-4 col-xs-12" for="img_path">Phuường/Xã</label>
	                        <div class="col-md-8 col-sm-8 col-xs-12">
		                          <select name="m_ward_id" id="m_ward_id" class="form-control">
									<option value=""></option>
								  </select>
	                        </div>                         
	                      </div>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-md-8">
	                      <div class="form-group">                        
	                        <label class="control-label col-md-2 col-sm-2 col-xs-12" for="img_path">Đường phố</label>
	                        <div class="col-md-4 col-sm-4 col-xs-12">
		                        <select class="form-control" name="m_street_id" id="m_street_id">
									<option value=""></option>
								</select>
	                        </div>
	                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="img_path">Tổng diện tích</label>
	                        <div class="col-md-3 col-sm-3 col-xs-12">
	                          <input type="number" id="acreage" name="acreage" class="form-control col-md-10 col-xs-12" value="{{acreage}}" style="width:85%">                      	  <label style="padding-top: 7px; font-size: 13px;font-weight:normal">m2</label>
	                        </div>
	                         
                        </div> 
                      </div>
                      <div class="col-md-4">
	                      <div class="form-group">
	                        <label class="control-label col-md-6 col-sm-6 col-xs-12" for="img_path">Mật độ xây dựng</label>
	                        <div class="col-md-5 col-sm-5 col-xs-12">
	                          <input type="number" id="percent" name="percent" class="form-control col-md-10 col-xs-12" value="{{acreage}}">                           
	                        </div>
	                        <label style="padding-top: 7px; font-size: 13px;">%</label>                         
	                      </div>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-md-8">
	                      <div class="form-group">                        
	                        <label class="control-label col-md-2 col-sm-2 col-xs-12" for="img_path">Địa chỉ</label>
	                        <div class="col-md-10 col-sm-10 col-xs-12">
	                          <input type="text" id="address" name="address" class="form-control col-md-10 col-xs-12" value="{{address}}">                      
	                        </div>
                        </div> 
                      </div>
                      <div class="col-md-4">
	                      <div class="form-group">
	                        <label class="control-label col-md-6 col-sm-6 col-xs-12" for="img_path">Hiện/Ẩn</label>
	                        <div class="col-md-6 col-sm-6 col-xs-12">
		                        <select class="form-control" name="del_flg">
                                   <option value="0" {%if del_flg == 0%}selected="selected"{%endif%}>Hiện</option>
                                   <option value="1" {%if del_flg == 1%}selected="selected"{%endif%}>Ẩn</option>
                                </select>  
	                        </div>                         
	                      </div>
                      </div>
                    </div>
                      <div class="form-group">                        
                        <label class="control-label col-md-1 col-sm-2 col-xs-12" for="img_path">Trích dẫn</label>
                        <div class="col-md-11 col-sm-11 col-xs-12">
                          <textarea type="text" id="des" name="des" class="form-control col-md-7 col-xs-12" style="height:90px">{{des}}</textarea>                          
                        </div>                        
                      </div>
                      <div class="form-group">                        
                        <!--<label class="control-label col-md-2 col-sm-2 col-xs-12" for="ctg_name">Nội dung</label>-->
                        <div class="col-md-12 col-sm-12 col-xs-12">
                          <textarea  id="pro_content" name="content">{{content}}</textarea>
                        </div>
                      </div>                    
                      <div class="ln_solid"></div>
                      <div class="form-group">
                        <div class="col-md-12 col-sm-12" style="text-align: center">
                          <a class="dialog_close btn btn-primary" href="{{url.get('news')}}">Thoát</a>
                          <button class="btn btn-success" id="btn_save" type="button">Cập nhật</button>
                        </div>
                      </div>
                      <!--start Thông tin bản đồ-->
                      <div class="row" style="display: none">

							<input type="text" id="maps_address" value=""  style="display:none">
							<input type="text" name="map_lat" id="map_lat" value="{{map_lat}}"  style="display:none">
							<input type="text" name="map_lng" id="map_lng" value="{{map_lng}}"  style="display:none">
							<div id="maps_maparea">
						      <div id="maps_mapcanvas" style="margin-top:10px;" class="form-group"></div>
						    </div>						    
					  </div>
					  <!--end Thông tin bản đồ-->
                    </form>
                    <button id="mapsubmit" style="display:none">Tìm vị trí</button>
                  </div>
                </div>
              </div>
                    </div>
          
                    
                    
                    </div>
          </div>
          
                  </div>
                </div>
              </div>
              
            </div>
         <!-- </div>-->
        
        </div>
        <!-- footer content -->       
        {{ partial('includes/footer') }}
        <!-- /footer content -->
        
      </div>
    </div>

<script>
  $(document).ready(function() {
  	var district_list = Array();
	var ward_list = Array();
	var street_list = Array();
	{%for item in districts%}
		district_list.push(['{{item.m_district_id}}',"{{item.m_district_name}}",'{{item.m_provin_id}}']);
	{%endfor%}
	
    $('#pro_content').froalaEditor({
    theme: 'royal',
    language: 'vi',
    imageUploadURL:"{{url.get('phofile/upload/')}}{{folder_tmp}}"
    });
            
        
        $(document).off('blur','.number_format'); 
        $(document).on('blur','.number_format',function(event){
          var val = $(this).val();
          if($.isNumeric( val) == false){
            $(this).val("");
            return;
          }
          $(this).val( parseFloat($(this).val().replace(/,/g, ""))
                       // .toFixed(2)
                        .toString()
                        .replace(/\B(?=(\d{3})+(?!\d))/g, ",")
                        );
        });
    $(document).off('click','#btn_save'); 
    $(document).on('click','#btn_save',function(event){
        var msg = check_validate_update();
        if(msg !=""){
            Pho_message_box_error("Lỗi",msg);
            return;
        }
        var arr = $('#form_ctg').serializeArray();
      	Pho_json_ajax('POST',"{{url.get('project/update')}}" ,arr,function(datas){
	        if(datas.status =="OK"){
	          //Pho_modal_close("modal1");
	          //Pho_message_box("Thông báo",datas.msg);
	          Pho_direct("{{url.get('project')}}");
	        }else{
	          Pho_message_box_error("Lỗi",datas.msg);
	        }                
    	});

    });
        var check_validate_update = function(){
          if($('#project_name').val()==''){
            return "Bạn chưa nhập Tên dự án !";
          } 
          if($('#ctg_id').val()==''){
            return "Bạn chưa chọn loại dự án !";
          } 
          if($('#img_path').val()==''){
            return "Bạn chưa upload ảnh đại diện!";
          } 
          if($('#img_path').val()==''){
            return "Bạn chưa upload ảnh đại diện!";
          }  
          if($('#m_provin_id').val()==''){
            return "Bạn chưa chọn tỉnh/thành phố!";
          }  
          if($('#m_district_id').val()==''){
            return "Bạn chưa chọn quận/huyện!";
          } 
          if($('#boss_name').val()==''){
            return "Bạn chưa chủ đầu tư!";
          }   
          return "";
        };
        $(document).off('click','#btn_upload'); 
        $(document).on('click','#btn_upload',function(event){
          $('#upload_file').click();
        }); 
        $(document).off('change','#upload_file'); 
        $(document).on('change','#upload_file',function(event){
          var corractpath = $(this).val();
          //var filename = corractpath.replace(/^.*[\\\/]/, '')         
          
          var file_data=$(this).prop("files")[0];
          //console.log(file_data); 
          var form_data=new FormData(this);
            form_data.append("file",file_data);
            var base_url= "{{url.get('')}}";
            //console.log(form_data); 
          Pho_upload("{{url.get('phofile/upload/')}}{{folder_tmp}}" ,form_data,function(datas){
            //if(datas.status =="OK"){
               //console.log(datas);
            var file_name = datas.link.replace(base_url,"");  
            $('#img_path').val(file_name);
            $('#news_avata').attr('src',datas.link);
                    
            //}else{
              //Pho_message_box_error("Lỗi",datas.msg);
            //}
                
            });
        });
        function get_basic(){
			loading_flg = false;
	        jsion_ajax("{{url.get('posts/wards')}}" ,null,function(datas){               
	            ward_list = datas.wards;  
	            change_war_option('{{m_ward_id}}');
	        });
	       /* if('{{m_district_id}}' !=''){
	        	get_street('{{m_district_id}}');
	        }*/
	    }
	    function get_street(m_district_id){
			loading_flg = false;
			var treet_id = '{{m_street_id}}';
	        jsion_ajax("{{url.get('index/street/')}}"+m_district_id ,null,function(datas){               
	            street_list = datas.streets; 
	            console.log(datas);
	            var option = '<option value=""></option>';
				$.each(street_list,function(key,item){
					//console.log(item);
					//if(val == item['m_district_id']){
						if(treet_id == item['m_street_id']){
							option +='<option value="'+item['m_street_id']+'" selected>'+item['m_street_name']+'</option>';
						}else{
							option +='<option value="'+item['m_street_id']+'">'+item['m_street_name']+'</option>';
						}					
					//}
				});
				$('#m_street_id').empty();
				$('#m_street_id').append(option);
	        });
	    }
	    setTimeout(get_basic(),10);
		$(document).off('change','#m_provin_id');
		$(document).on('change','#m_provin_id',function(){			
			change_district_option('');
			change_map();
		});
		var change_district_option= function(district_id){
			var val = $('#m_provin_id').val();
			var option = '<option value=""></option>';
			$.each(district_list,function(key,item){
				//console.log(item);
				if(val == item[2]){
					if(district_id == item[0] ){
						option +='<option value="'+item[0]+'" selected >'+item[1]+'</option>';
					}else{
						option +='<option value="'+item[0]+'" >'+item[1]+'</option>';
					}					
				}
			});
			$('#m_district_id').empty();
			$('#m_district_id').append(option);
		};
		change_district_option('{{m_district_id}}');

		$(document).off('change','#m_district_id');
		$(document).on('change','#m_district_id',function(){			
			change_war_option('');
			change_map();
			dis_id = $(this).val();
			get_street(dis_id);
		});
		var change_war_option = function(m_ward_id){
			var val = $('#m_district_id').val();
			var option = '<option value=""></option>';
			$.each(ward_list,function(key,item){
				//console.log(item);
				if(val == item['m_district_id']){
					if(m_ward_id == item['m_ward_id']){
						option +='<option value="'+item['m_ward_id']+'" selected>'+item['m_ward_name']+'</option>';
					}else{
						option +='<option value="'+item['m_ward_id']+'">'+item['m_ward_name']+'</option>';
					}					
				}
			});
			$('#m_ward_id').empty();
			$('#m_ward_id').append(option);		
		};
		$(document).off('change','#m_ward_id');
		$(document).on('change','#m_ward_id',function(){
			change_map();			
		});
		$(document).off('change','#m_street_id');
		$(document).on('change','#m_street_id',function(){
			change_map();
		});
		function change_map(){			
			var dc   = $("#address").val().trim();
			var addr = "";
			// if(dc !=""){
			// 	addr += dc;
			// } 
			if($("#m_street_id").val()!=""){				
				if(addr !=""){
					addr += " "+ $("#m_street_id :selected").text();
				}else{
					addr += $("#m_street_id :selected").text();
				}
			} 
			if($("#m_ward_id").val() !=""){
				if(addr !=""){
					addr +=", " + $("#m_ward_id :selected").text();
				}else{
					addr += $("#m_ward_id :selected").text();
				}
				
			} 
			if($("#m_district_id").val() !=""){
				if(addr !=""){
					addr +=", " + $("#m_district_id :selected").text();
				}else{
					addr += $("#m_district_id :selected").text();
				}

			} 
			if($("#m_provin_id").val() !=""){
				if(addr !=""){
					addr += ", " + $("#m_provin_id :selected").text();
				}else{
					addr += $("#m_provin_id :selected").text();
				}
			} 
			$("#address").val(addr);
			
			change_location();
			
		}
		function change_location(){
			var addr   = $("#address").val().trim();
			if(addr !=''){
				addr +=', Việt Nam';
				$('#maps_address').val(addr);			
				$('#mapsubmit').click();
			}
		};
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
        type: 'GET'
    });
}
var map, ele, mapH, mapW, addEle, mapL, mapN, mapZ;

ele = 'maps_mapcanvas';
addEle = 'maps_address';
mapLat = 'map_lat';
var maplng = "map_lng";
var markers = [];
var map_lat =21.0197704; 
var map_lng = 105.8007434;
{%if map_lat|length > 0%}
	map_lat = {{map_lat}};
{%endif%}
{%if map_lng|length >0%}
	map_lng = {{map_lng}};
{%endif%}

var post_address = '{{address}}';
if(post_address.length ==0){ post_address = "152 Vũ Phạm Hàm , Phường Yên Hòa , Quận Cầu Giấy, Hà Nội";}
    function initMap() {
	  	mapW = $('#' + ele).innerWidth();
		mapH = mapW * 3 / 5;
		
		// Init MAP
		$('#' + ele).width(mapW).height(mapH > 400 ? 400 : mapH);
        var map = new google.maps.Map(document.getElementById('maps_mapcanvas'), {
          zoom: 15,
          scrollwheel: false,
          center: {lat: map_lat, lng: map_lng}
        });
		
		markers[0] = new google.maps.Marker({
	        map: map,
	        position: new google.maps.LatLng(map_lat,map_lng),
	        draggable: true,
	        animation: google.maps.Animation.DROP
	    });
		var infowindow = new google.maps.InfoWindow;
		infowindow.setContent(post_address);
        infowindow.open(map, markers[0]);
	
        var geocoder = new google.maps.Geocoder();
		//var infowindow = new google.maps.InfoWindow;
        document.getElementById('mapsubmit').addEventListener('click', function() {
          geocodeAddress(geocoder, map,infowindow);
        });
      }

      function geocodeAddress(geocoder, resultsMap,infowindow) {
        var address = document.getElementById('maps_address').value;
        geocoder.geocode({'address': address}, function(results, status) {
          if (status === 'OK') {
           	for (var i = 0, marker; marker = markers[i]; i++) {
	         	marker.setMap(null);
	         	//console.log(i);
	    	 }
	    	//setMapOnAll(null);
	    	markers=[];
            resultsMap.setCenter(results[0].geometry.location);
            marker = new google.maps.Marker({
              map: resultsMap,
              position: results[0].geometry.location
            });
			infowindow.setContent(address);
            infowindow.open(map, marker);
            markers.push(marker);
			$('#map_lat').val(results[0].geometry.location.lat());
			$('#map_lng').val(results[0].geometry.location.lng());
			//console.log(results[0].geometry.location.lat());
			//console.log(results[0].geometry.location.lng());
          } else {
            //alert('Geocode was not successful for the following reason: ' + status);
          }
        });
      }

</script>
<script async defer  src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAGWoTNwauIzO_pJEDymaSYTG031uJbbkk&callback=initMap">
    </script>

</body>
</html>