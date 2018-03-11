
<div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">               
                  <div class="x_content">
                    <br />
                    <form id="form_ctg" action="" class="form-horizontal form-label-left" enctype="multipart/form-data">                      
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="ctg_name">Tên Loại dự án <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input type="text" id="ctg_name" required="required" name="ctg_name" class="form-control col-md-7 col-xs-12" value="{{ctg_name}}">
                          <input type="hidden"  name="ctg_id" value="{{ctg_id}}">
                          <input type="hidden"  name="ctg_level" value="{{ctg_level}}">
                          <input type="hidden"  name="news_flg" value="{{news_flg}}">
                          <input type="hidden" name="parent_id_1" value="{{parent_id_1}}">
                        </div>
                      </div>                     
                      <div class="form-group">
                        <label for="middle-name" class="control-label col-md-3 col-sm-3 col-xs-12">Thứ tự hiển thị</label>
                        <div class="col-md-3 col-sm-3 col-xs-12">
                          <input id="ctg_sort" class="form-control col-md-7 col-xs-12" type="number" name="ctg_sort" value="{{sort}}" >
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Hiện/Ẩn</label>
                        <div class="col-md-3 col-sm-3 col-xs-12">
                          <select class="form-control" name="del_flg">
                             <option value="0" {%if del_flg == 0%}selected="selected"{%endif%}>Hiện</option>
                             <option value="1" {%if del_flg == 1%}selected="selected"{%endif%}>Ẩn</option>
                          </select>                          
                        </div>
                      </div>                      
                      <div class="ln_solid"></div>
                      <div class="form-group">
                        <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                          <button class="dialog_close btn btn-primary" type="button">Thoát</button>
                          <button class="btn btn-success" id="btn_save" type="button">Cập nhật</button>
                        </div>
                      </div>

                    </form>
                  </div>
                </div>
              <!--</div>-->
            </div>
