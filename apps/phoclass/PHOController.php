<?php

namespace Multiple\PHOClass;

use Phalcon\Mvc\Controller;
use Phalcon\Cache\Backend\File as BackFile;
use Phalcon\Cache\Frontend\Data as FrontData;
use Phalcon\Cache\Frontend\Output as FrontOutput;
use Phalcon\Cache\Backend\Memory;
use Phalcon\Http\Request;
use Multiple\Models\Provincial;
use Multiple\Models\District;
use Multiple\Models\Ward;
use Multiple\Models\Bank;
use Multiple\PHOClass\PhoLog;
class PHOController extends Controller
{
	protected function get_param($arr_pa)
	{
		try{
			$result= array();
			foreach($arr_pa as $pa){
				$result[$pa]= $this->request->getPost($pa);
			}
			return $result;
		} catch (\Exception $e) {
			PhoLog::Exception_log('---SYS_Error---',$e);			
			throw $e;
		}
	}
	protected function get_Gparam($arr_pa)
	{
		try{
			$result= array();
			foreach($arr_pa as $pa){
				$result[$pa]= isset($_GET[$pa])?$_GET[$pa]:'';
			}
			return $result;
		} catch (\Exception $e) {
			PhoLog::Exception_log('---SYS_Error---',$e);			
			throw $e;
		}
	}
	
	protected function ViewJSON($result){
		try{
			$this->view->disable();
	        $this->response->setJsonContent($result);
	        return $this->response;
        } catch (\Exception $e) {
			PhoLog::Exception_log('---SYS_Error---',$e);			
			throw $e;
		}
	}
	protected function ViewHtml($path,$result)
	{
		try{
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
		} catch (\Exception $e) {
			PhoLog::Exception_log('---SYS_Error---',$e);			
			throw $e;
		}
	}
	protected function set_template_share(){
		$this->view->setTemplateAfter('main');
	}
	protected function ViewVAR($result){
		try{
			if(count($result)>0){
				foreach($result as $key => $val){
					$this->view->setVar($key, $val);
				}
			}		
		} catch (\Exception $e) {
			PhoLog::Exception_log('---SYS_Error---',$e);			
			throw $e;
		}
	}
	protected function CreatHtmlCache($time){	
		try{
			$frontCache = new FrontOutput( [ 'lifetime' => $time, ]);	
	 		$cache = new BackFile( $frontCache,  ['cacheDir' => PHO_CACHE_HTML ]);
	 		return $cache;
 		} catch (\Exception $e) {
			PhoLog::Exception_log('---SYS_Error---',$e);			
			throw $e;
		}
	}
	protected function HtmlCache($time,$key,$url_template){	
		try{
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
		} catch (\Exception $e) {
			PhoLog::Exception_log('---SYS_Error---',$e);			
			throw $e;
		}
	}
	protected function createCache($time){
		try{
			$frontendCache = new FrontData([ 'lifetime' => $time]); 	
	 		$cache = new BackFile( $frontendCache,  ['cacheDir' => PHO_CACHE_DIR ]);
	 		return $cache;
 		} catch (\Exception $e) {
			PhoLog::Exception_log('---SYS_Error---',$e);			
			throw $e;
		}
	}
	public function CacheMemory($options){
		try{
			$frontendCache = new FrontData($options); 	
	 		$cache = new Memory( $frontendCache);
	 		return $cache;
 		} catch (\Exception $e) {
			PhoLog::Exception_log('---SYS_Error---',$e);			
			throw $e;
		}
	}
	public function check_loginadmin()
    {
    	try{
	        $auth = $this->session->get('auth');
	        if(isset($auth->user_id)==FALSE || $auth->level != 1 ){
	            return $this->response->redirect('loginadm/',TRUE);
	        }
        } catch (\Exception $e) {
			PhoLog::Exception_log('---SYS_Error---',$e);			
			throw $e;
		}
    }
    public function check_login()
    {
    	try{
	        $auth = $this->session->get('auth');
	        if(isset($auth->user_id)==FALSE){
	            return $this->response->redirect('dang-nhap',FALSE);
	        }
        } catch (\Exception $e) {
			PhoLog::Exception_log('---SYS_Error---',$e);			
			throw $e;
		}
    }
    protected function _redirect($url){
		return $this->response->redirect($url);
	}
	public function convert_vi_to_en($str) {
		try{
			//setlocale(LC_CTYPE, 'cs_CZ');
			//$str = iconv('UTF-8', 'ASCII//TRANSLIT', $str);
		      $str = preg_replace("/(à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ)/", 'a', $str);
		      $str = preg_replace("/(è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ)/", 'e', $str);
		      $str = preg_replace("/(ì|í|ị|ỉ|ĩ)/", 'i', $str);
		      $str = preg_replace("/(ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ)/", 'o', $str);
		      $str = preg_replace("/(ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ)/", 'u', $str);
		      $str = preg_replace("/(ỳ|ý|ỵ|ỷ|ỹ)/", 'y', $str);
		      $str = preg_replace("/(đ)/", 'd', $str);    

		      $str = preg_replace("/(À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ)/", 'A', $str);
		      $str = preg_replace("/(È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ)/", 'E', $str);
		      $str = preg_replace("/(Ì|Í|Ị|Ỉ|Ĩ|Ì)/", 'I', $str);
		      $str = preg_replace("/(Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ)/", 'O', $str);
		      $str = preg_replace("/(Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ)/", 'U', $str);
		      $str = preg_replace("/(Ỳ|Ý|Ỵ|Ỷ|Ỹ)/", 'Y', $str);
		      $str = preg_replace("/(Đ)/", 'D', $str);
		      $str = str_replace('ì', 'i', $str);
		     return trim(strtolower($str));
	     } catch (\Exception $e) {
			PhoLog::Exception_log('---SYS_Error---',$e);			
			throw $e;
		}
	}
	public function convert_string_to_number($str){
		return str_replace(',','',$str);
	}
	public function convert_url($str){
		try{
			$str = $this->convert_vi_to_en($str);
			$arr_rep = array(' - ',';',',',':','!','&','%',"'",'"','(',')','/',"\\",'?' );
			$str =str_replace($arr_rep,'', $str);
			$str =str_replace(' ','-', $str);
			return $str;
		} catch (\Exception $e) {
			PhoLog::Exception_log('---SYS_Error---',$e);			
			throw $e;
		}
	}
	public function convert_ascii($str){
		try{
			$str = $this->convert_vi_to_en($str);
			$arr_rep = array(' - ',';',',',':','!','&','%',"'",'"','(',')','/',"\\",'?' );
			$str =str_replace($arr_rep,'', $str);	
			return $str;
		} catch (\Exception $e) {
			PhoLog::Exception_log('---SYS_Error---',$e);			
			throw $e;
		}
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
	public function get_Provin(){
		try{
			$cache = $this->createCache(864000);//10 ngay
			$key="m_provin_list.cache";
			$data = $cache->get($key);
			if($data == NULL){
				$data = Provincial::get_all();
				$cache->save($key,$data);
			}
			return $data; 
		} catch (\Exception $e) {
			PhoLog::Exception_log('---SYS_Error---',$e);			
			throw $e;
		}
	}
	public function get_District($m_provin_id){
		try{
			$cache = $this->createCache(864000);//10 ngay
			$key="m_district_list_$m_provin_id.cache";
			$data = $cache->get($key);
			if($data == NULL){
				$db = new District();
				$data = $db->get_byparent($m_provin_id);
				$cache->save($key,$data);
			}
			return $data; 
		} catch (\Exception $e) {
			PhoLog::Exception_log('---SYS_Error---',$e);			
			throw $e;
		}
	}
	public function get_Ward($m_district_id){
		try{
			$cache = $this->createCache(864000);//10 ngay
			$key="m_ward_list_$m_district_id.cache";
			$data = $cache->get($key);
			if($data == NULL){
				$db = new Ward();
				$data = $db->get_byparent($m_district_id);
				$cache->save($key,$data);
			}
			return $data;
		} catch (\Exception $e) {
			PhoLog::Exception_log('---SYS_Error---',$e);			
			throw $e;
		} 
	}
	public function get_Bank(){
		try{
			$cache = $this->createCache(864000);//10 ngay
			$key="m_bank_list.cache";
			$data = $cache->get($key);
			if($data == NULL){
				$data = Bank::get_all();
				$cache->save($key,$data);
			}
			return $data; 
		} catch (\Exception $e) {
			PhoLog::Exception_log('---SYS_Error---',$e);			
			throw $e;
		}
	}
}
