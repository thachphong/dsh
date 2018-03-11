<?php

namespace Multiple\PHOClass;

use Phalcon\Mvc\Controller;
use Phalcon\Cache\Backend\File as BackFile;
use Phalcon\Cache\Frontend\Data as FrontData;
use Phalcon\Cache\Frontend\Output as FrontOutput;
use Phalcon\Cache\Backend\Memory;
use Phalcon\Http\Request;

class PHOController extends Controller
{
	protected function get_param($arr_pa)
	{
		$result= array();
		foreach($arr_pa as $pa){
			$result[$pa]= $this->request->getPost($pa);
		}
		return $result;
	}
	protected function get_Gparam($arr_pa)
	{
		$result= array();
		foreach($arr_pa as $pa){
			$result[$pa]= $this->request->getQuery($pa);
		}
		return $result;
	}
	
	protected function ViewJSON($result){
		$this->view->disable();
        $this->response->setJsonContent($result);
        return $this->response;
	}
	protected function ViewHtml($path,$result)
	{
		foreach($result as $key => $val){
			$this->view->setVar($key, $val);
		}
		$pathinfo = explode('/',$path);
		$this->view->start();
	    $this->view->Render($pathinfo[0], $pathinfo[1]);
	    //$this->view->Render();
		$this->view->finish();
		//$this->view->disable();
		$content1 = $this->view->getContent();
		//$this->view->disable();
		$this->response->setContent($content1);
		/*$this->response = [
		    'html' => $content1,
		    'somedata' => 'somevalues'
		];*/
		return $this->response->send();
	}
	protected function set_template_share(){
		$this->view->setTemplateAfter('main');
	}
	protected function ViewVAR($result){
		foreach($result as $key => $val){
			$this->view->setVar($key, $val);
		}
	}
	protected function CreatHtmlCache($time){	
		$frontCache = new FrontOutput( [ 'lifetime' => $time, ]);	
 		$cache = new BackFile( $frontCache,  ['cacheDir' => PHO_CACHE_HTML ]);
 		return $cache;
	}
	protected function HtmlCache($time,$key,$url_template){	
		//$this->view->disable();	 
		$frontCache = new FrontOutput( [ 'lifetime' => $time, ]);	
 		$cache = new BackFile( $frontCache,  ['cacheDir' => PHO_CACHE_HTML ]);
 		$content = $cache->start($key);
		// If $content is null then the content will be generated for the cache
		if ($content === null) {
			$pathinfo = explode('/',$url_template);
			$this->view->setTemplateAfter('main');
		    echo $this->view->render($pathinfo[0], $pathinfo[1]);
		    // Store the output into the cache file
		    $cache->save();
		} else {
		    // Echo the cached output
		    $this->view->disable();
		    //echo $content;
		    $this->response->setContent($content);		
			return $this->response->send();
		}
	}
	protected function createCache($options){
		$frontendCache = new FrontData($options); 	
 		$cache = new BackFile( $frontendCache,  ['cacheDir' => PHO_CACHE_DIR ]);
 		return $cache;
	}
	public function CacheMemory($options){
		$frontendCache = new FrontData($options); 	
 		$cache = new Memory( $frontendCache);
 		return $cache;
	}
	public function check_loginadmin()
    {
        $auth = $this->session->get('auth');
        if(isset($auth->user_id)==FALSE || $auth->level != 1 ){
            return $this->response->redirect('loginadm/',TRUE);
        }
    }
    public function check_login()
    {
        $auth = $this->session->get('auth');
        if(isset($auth->user_id)==FALSE){
            return $this->response->redirect('dang-nhap',FALSE);
        }
    }
    protected function _redirect($url){
		return $this->response->redirect($url);
	}
	public function convert_vi_to_en($str) {
	     $str = preg_replace("/(à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ)/", 'a', $str);
	     $str = preg_replace("/(è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ)/", 'e', $str);
	     $str = preg_replace("/(ì|í|ị|ỉ|ĩ)/", 'i', $str);
	     $str = preg_replace("/(ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ)/", 'o', $str);
	     $str = preg_replace("/(ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ)/", 'u', $str);
	     $str = preg_replace("/(ỳ|ý|ỵ|ỷ|ỹ)/", 'y', $str);
	     $str = preg_replace("/(đ)/", 'd', $str);    

	     $str = preg_replace("/(À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ)/", 'A', $str);
	     $str = preg_replace("/(È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ)/", 'E', $str);
	     $str = preg_replace("/(Ì|Í|Ị|Ỉ|Ĩ)/", 'I', $str);
	     $str = preg_replace("/(Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ)/", 'O', $str);
	     $str = preg_replace("/(Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ)/", 'U', $str);
	     $str = preg_replace("/(Ỳ|Ý|Ỵ|Ỷ|Ỹ)/", 'Y', $str);
	     $str = preg_replace("/(Đ)/", 'D', $str);
	     return trim(strtolower($str));
	}
	public function convert_string_to_number($str){
		return str_replace(',','',$str);
	}
	public function convert_url($str){
		$str = $this->convert_vi_to_en($str);
		$arr_rep = array(' - ',';',',',':','!','&','%',"'",'"','(',')','/',"\\",'?' );
		$str =str_replace($arr_rep,'', $str);
		$str =str_replace(' ','-', $str);
		return $str;
	}
	public function convert_ascii($str){
		$str = $this->convert_vi_to_en($str);
		$arr_rep = array(' - ',';',',',':','!','&','%',"'",'"','(',')','/',"\\",'?' );
		$str =str_replace($arr_rep,'', $str);	
		return $str;
	}
	public function get_client_ip_server() {
	    $ipaddress = '';	    
		$request = new Request();
		$ipaddress = $request->getClientAddress();	 
	    return $ipaddress;
	}
	public static function currency_format($str){
		if(strlen($str)> 0){
			return number_format($str,0,".",",");
		}
		return "";
	}
}
