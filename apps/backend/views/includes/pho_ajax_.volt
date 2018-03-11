<style type="text/css">
.modal_loading {
    display:    none;
    position:   fixed;
    z-index:    1800;
    top:        0;
    left:       0;
    height:     100%;
    width:      100%;
    background: rgba( 255, 255, 255, .8 ) 
                url('{{url.get('templateadm/images/loading.gif')}}') 
                50% 50% 
                no-repeat;
}

/* When the body has the loading class, we turn
   the scrollbar off with overflow:hidden */
body.loading {
    overflow: hidden;   
}
/* Anytime the body has the loading class, our
   modal element will be visible */
body.loading .modal_loading {
    display: block;
}
.header_error{
	background-color: #d9534f;
	color: #fff;
}
.header_error button{	
	color: #fff;
	opacity: 1;
}
.header_info{
	background-color: #fff;
	color: #000;
}
.header_info button{	
	color: #000;
}
</style>
<script type="text/javascript">
var Pho_message_box = function (title, msg, closed_func, style) { 	
	$('#modal_body2').text(msg);
	$('#myModalLabel2').text(title);
	$('#btn_model_close').hide();
	$('#btn_modal_2').click();	
	change_header_background('modal-header1');
	$( "#btn_modal_ok" ).bind({
	  click: function() {
	  	  $('#btn_model_close').click();
	      if(closed_func){
                closed_func();
          }
	  }
	});
};
var change_header_background=function(id_header,ok_flg = true){
	$('#'+id_header).removeClass('header_error');
	$('#'+id_header).removeClass('header_info');
	if(ok_flg){		
		$('#'+id_header).addClass('header_info');
	}else{		
		$('#'+id_header).addClass('header_error');
	}
}
var Pho_message_box_error = function (title, msg, closed_func, style) { 
	
	$('#modal_body2').text(msg);
	$('#myModalLabel2').text(title);
	$('#btn_model_close').hide();
	$('#btn_modal_2').click();	
	change_header_background('modal-header1',false);
	$( "#btn_modal_ok" ).bind({
	  click: function() {
	  	  $('#btn_model_close').click();
	      if(closed_func){
                closed_func();
          }
	  }
	});	
};
var Pho_message_confirm = function (title, msg, closed_func, style) { 
	
	$('#modal_body2').text(msg);
	$('#myModalLabel2').text(title);
	$('#btn_modal_2').click();
	change_header_background('modal-header1');
	$( "#btn_modal_ok" ).bind({
	  click: function() {
	  	  $('#btn_model_close').click();
	      if(closed_func){
                closed_func();
          }
	  }
	});	
};

var Pho_json_ajax= function (type,url,data,done_fun){
    $.ajax({
		url: url,
		data: data,
	    dataType: 'json',
		success: function(datajsion) {
		    done_fun(datajsion);
		},
		error: function() {
			Pho_message_box_error('Lỗi','Lỗi Ajax !!!');
		},		
		type: type
	});
};
var Pho_upload= function (url,data,done_fun){
    $.ajax({
		url: url,
		data: data,
	    dataType: 'json',
		success: function(datajsion) {
		    done_fun(datajsion);
		},
		error: function() {
			Pho_message_box_error('Lỗi','Lỗi Ajax !!!');
		},
		contentType: false,
	    cache: false,
		processData:false,
		type: 'POST'
	});
};
var Pho_modal=function(html_data,title,pa_width){	
	
	$('#dialog_content_2').html(html_data);
	$('#dialog_title_2').text(title);
	$('#dialog_size_2').width(pa_width);
	$('#btn_modal_dialog').click();
};
var Pho_modal_close= function(modal_id ="modal-window"){
	//$('#'+modal_id).remove();
	$('#btn_dialog_close_2').click();
};
var Pho_html_ajax= function (type,url,data,done_fun){
    $.ajax({
		url: url,
		data: data,
	    dataType: 'html',
		success: function(data) {
		    done_fun(data);
		},
		error: function() {
			Pho_message_box_error('Lỗi','Lỗi Ajax !!!');
		},
		type: type
	});
};
var Pho_direct= function(url){
	$body.addClass("loading");
	location.href = url;
}
$body = $("body");
var loading_flg =true;
$(document).on({
    ajaxStart: function() { 
    	if(loading_flg){$body.addClass("loading");}    
    },
    ajaxStop: function() { $body.removeClass("loading");loading_flg=true }    
});
</script>
<div class="modal_loading"></div>

<button id="btn_modal_2" type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal1" style="display: none" data-backdrop="false">Small modal</button>

                  <div class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" id="modal1" style="z-index: 1600;"> 
                    <div class="modal-dialog modal-sm" style="width:400px" >
                      <div class="modal-content">

                        <div class="modal-header" id="modal-header1">
                          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span>
                          </button>
                          <h4 class="modal-title" id="myModalLabel2"></h4>
                        </div>
                        <div class="modal-body" id="modal_body2">
                          	
                        </div>
                        <div class="modal-footer">
                          <button type="button" class="btn btn-default" data-dismiss="modal" id="btn_model_close">Thoát</button>
                          <button type="button" class="btn btn-primary" id="btn_modal_ok">OK</button>
                        </div>

                      </div>
                    </div>
                  </div>
                  
                  
<button id="btn_modal_dialog" type="button" class="btn btn-primary" data-toggle="modal" data-target="#dialog_2" style="display: none" data-backdrop="false" >show dialog</button>

                  <div class="modal fade" id="dialog_2" tabindex="-2" role="dialog" aria-hidden="true" style="z-index: 1400;">
                    <div class="modal-dialog modal-lg" style="width:500px" id="dialog_size_2">
                      <div class="modal-content">
                      		<div class="modal-header" id="modal-header2">
	                        <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="btn_dialog_close_2"><span aria-hidden="true">×</span>
	                          </button>
	                          <h4 class="modal-title" id="dialog_title_2"></h4>
	                        </div>
	                        <div class="modal-body" id="dialog_content_2" style="padding:0px">
	                          	
	                        </div>
                      </div>
                    </div>
                  </div>