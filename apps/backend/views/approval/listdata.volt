<!--<form role="form" id="form_approval" action="" method="POST" enctype="multipart/form-data">-->
<table class="table table-hover"  style="padding: 10px">
	<colgroup>
		<col width="50"/>
		<col width="100"/>
		<col width="100"/>
		<col width=""/>
		
		<col width="150"/>
	</colgroup>
    <thead>
          <tr>
            <th>STT</th>
            <th>Ảnh</th>            
            <th>Tiêu Đề</th>
            <th>Trạng Thái</th>                  
            <th>Ngày Đăng</th>                  
          </tr>
    </thead>
    <tbody>
    	{%for  key,row in datapost %}
	       <tr class="{%if key%2== 1%}info{%endif%}">
	            <td>{{key+1}}</td>
	            <td>
	            	
		           	<img class="img-responsive" style="max-width: 100px" src="{{url.get('images/'~row.filename)}}" width="500" alt="{{row.caption}}" />		          
		        </td>
	            
	            <td>		            	            	
	            	<!--<fieldset id="status" style="font-weight: normal">-->
				        <label style="font-weight: normal">
				        	<input type="radio" value="0"  name="status[{{row.id}}]" title="Chưa" {%if row.status==0 %}checked{%endif%}>Chưa
				        </label>
				        <label style="font-weight: normal">
				        	<input type="radio" value="1" name="status[{{row.id}}]" title="Duyệt"  {%if row.status==1 %}checked{%endif%}>Duyệt
				        </label>
				        <label style="font-weight: normal">
				        	<input type="radio" value="2" name="status[{{row.id}}]" title="Xóa"  {%if row.status==2 %}checked{%endif%}>Xóa
				        </label>
				    
	            </td>
	            <td>
	            	<a  href="{{url.get('posts/'~row.id)}}" TARGET="_blank">
	            		<strong>{{row.caption}}</strong>
	            	</a>
	            	<br />
	            	<span>{{row.des}}</span>
	            </td>
	            <td>{{elements.formatdate(row.add_date,row.add_time)}}</td>
	            <input type="hidden" value="{{row.id}}" name="id_dl[]" >
	            	           
	       </tr>
       {%endfor%}      
   </tbody>
</table>

<!--phan trang-->
<div style="text-align: center">
<ul class="pagination">
        {%if page > 1 %}
            <li><a href="javascript:void(0)" class="page_link" id="page_{{(page-1)}}">&laquo; Previous</a></li>
        {%endif%}


        {%for item in 1..totalpage%}
            {%if page == item %}
                <li class="active"><span class="page_link selected" id="page_{{item}}">{{item}}</span></li>
            {%else%}
                <li><a href="javascript:void(0)" class="page_link" id="page_{{item}}" >{{item}}</a></li>
            {%endif%}
        {%endfor%}

        {%if page < totalpage %}
            <li><a href="javascript:void(0)" class="page_link" id="page_{{(page+1)}}">Next &raquo;</a></li>
        {%endif%}

       
</ul>	
</div>
<div style=" text-align: center; margin-bottom: 100px">
	<button type="button" class="btn_delete btn btn-success" id="btn_approval">Cập nhật</button>	
</div>
<!--</form>-->
