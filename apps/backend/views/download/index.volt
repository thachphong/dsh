<div class="row">

    <div class="col-md-8" id="content_data">
<h3 class="page_title">Download</h3>

<form role="form" id="form_download" action="" method="POST" enctype="multipart/form-data">
    <div class="form-group">
	    <label for="title">Chọn danh mục</label>
	    <select name="menu_id">
            <option></option>
            {%for item in listmenu%}
            	<option value="{{item.id}}">{{item.title}}</option>
            {% endfor %}
	    </select>
	</div>
    <div class="form-group">
        <label>Link download</label>
        <input size="65" name="link_dl" value="" />
        <input type="button" value="Download" id="btn_download">
    </div>
    {{date_out}}
    <table class="table table-bordered table-striped" style="margin-bottom: 100px">    	
    	<thead>
    	<tr>
    		<th style="text-align: center">
    			<input type="checkbox" id="check_all">
    		</th>
    		<th>
    			Menu    			
    		</th>    		
    		<th>
    			Link download    			
    		</th>
    	</tr>
    	</thead>
    	{%for ctg in ctglist%}
    		<tr>
    			<td style="text-align: center"><input type="checkbox" name="chk" id="chk_{{ctg.id}}" class="chk_item"></td>
    			<td >{{ctg.menu_id}}</td>
    			<td >{{ctg.link}}</td>
    			
    		</tr>            	
        {% endfor %}
    	
    </table>
</form>

</div>

</div>
<script>
    /*$('#show_msg').click(function(){
        alert('f');
    });*/
    $(document).ready(function(e) {
		//alert		 
        $(document).on('click','#btn_download',function(){
            
            var arr = $('#form_download').serializeArray();
            //var $arr = new FormData();//$('#form_login').serializeArray();
            //arr.push({name: 'email', value: $('#email').val()});     
            //arr.push({name: 'password', value: $('#password').val()});     
            //console.log(arr);
            //var _data = {email:'admin',password:'admin'};
            Pho_json_ajax('POST',"{{url.get('download/exe')}}" ,arr,function(data){
                if(data.status =='OK'){
                    Pho_message_box('Thông báo',data.msg, function(){
                        //window.location.href="{{url.get('download')}}";
                        $('input[name="link_dl"]').val('');
                    }); 
                }else{
                    Pho_message_box_error('Lỗi',data.msg);
                }
            });
        });
        $(document).off('click','#check_all');
        $(document).on('click','#check_all',function(){
        	var chk_flg = false;
        	if($('#check_all').is(':checked')){
        		chk_flg = true;
        	}
        	$(document).find(".chk_item").each(function(){        	
        		$(this).prop("checked",chk_flg);        			        		
        	});
        });
    });
</script>
