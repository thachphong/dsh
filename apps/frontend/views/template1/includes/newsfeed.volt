<section class="slider">
    <div class="container">
        <div class="row">
            <div class="col-lg-9 col-sm-9">
                <div class="slider-posts-news">
                    <div class="title-posts-news">New update</div>
                    <div class="append_recent">
                        <div id="owl-slider" class="owl-carousel">
                        	{{ elements.getNewsfeed() }}
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-sm-3">
            <div id="searchform1">
                <!--<form method="get" id="searchform" action="{{url.get('search')}}">-->
    <input class="text-search" type="text" name="s_name" id="s_name" placeholder="Tìm kiếm bài viết" />
    <input name="search" type="button" id='buttom-search' class='buttom-search' value=""/>
</div>            </div>
        </div>
    </div>
</section>