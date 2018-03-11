<div class="row">
	<div class="container">
		{{ partial('includes/user_left') }}
		<div class="col-md-9 col-sm-12 col-xs-12">
			<div class="pn_posts">
				<div class="pn_title">
					<span class="bg_icon"><i class="fa post-pencil"></i></span>
					<h1>GIA HẠN TIN THÀNH CÔNG </h1>
				</div>				
				<div class="pn_content pn_background pn_border margin_top">
					<div style="text-align:center">
						<h3>Tin của bạn đã được gia hạn thành công</h3>
					</div>
					<div class="row">
						<table class="table table-bordered">
							<tbody>
						      <tr>
						        <td>Mã đăng tin</td>
						        <td>{{post['post_id']}}</td>						       
						      </tr>
						      <tr>
						        <td>Loại Tin</td>
						        <td>
						        	{%if post['post_level'] == 0%}Tin thường
						        	{%elseif post['post_level'] == 1%}Tin hot
						        	{%elseif post['post_level'] == 2%}Tin vip
						        	{%elseif post['post_level'] == 3%}Tin siêu vip
						        	{%endif%}
						        </td>						        
						      </tr>
						      <tr>
						        <td>Thời gian đăng tin</td>
						        <td>{{post['post_date_num']}} ngày</td>						        
						      </tr>
						      <tr>
						        <td>Link xem tin</td>
						        <td><a href="{{url.get('b/')}}{{post['post_no']}}_{{post['post_id']}}" target="_blank">{{url.get('b/')}}{{post['post_no']}}_{{post['post_id']}}</a></td>						        
						      </tr>
						    </tbody>
						</table>
					</div>
					
				</div>
			</div>
		</div>
	</div>
</div>
