<?php

namespace Multiple\Frontend\Controllers;

use Multiple\PHOClass\PHOController;
use Phalcon\Image\Adapter\GD;
use Multiple\PHOClass\PhoLog;
use Multiple\Library\Captcha;
class ImageController extends PHOController
{

	public function indexAction()
	{
		
	}
	public function cropAction($size){
		try{			
		
			$QUERY_STRING = $_SERVER['QUERY_STRING'];
			$url = str_replace('_url=/crop/'.$size.'/', '', $QUERY_STRING);
			//$url = str_replace('_url=/crop/', '', $QUERY_STRING);			
			$url = str_replace('&', '', $url);
			$path_parts = pathinfo($url);
			$file_thumb = str_replace('.'.$path_parts['extension'], $size.'.'.$path_parts['extension'], $url);
			//PhoLog::debug_var('---img---',$url);
			$file_cache = PHO_CACHE_HTML. str_replace('/', '_', $file_thumb);
			if(!file_exists($file_cache)){
						
			//}else{
				$file_name =PHO_PUBLIC_PATH. $url;
				//PhoLog::debug_var('---img---','1:'.$file_name);
				//PhoLog::debug_var('---img---','2:'.$file_cache);
				
				$exp = explode('x', $size);
				//PhoLog::debug_var('---img---',$exp);
				/*$img = new GD($file_name);			
				$img->resize($exp[0],null,\Phalcon\Image::WIDTH);//->crop($exp[0],$exp[1]);*/
			    self::thumb_image($file_name,$exp[0],$exp[1],$file_cache);
				//PhoLog::debug_var('---img---',$file_name);
				//$this->view->disable();	
				//$this->response->setContent(file_get_contents($file_cache));		
				//$this->response->setContent($img->render('jpg'));
				//$img->save($file_cache);
			}	
			$this->view->disable();	
			//PhoLog::debug_var('---img---','view');
			$this->response->setContent(file_get_contents($file_cache));		
	       // PhoLog::debug_var('---img---',$exp);
	        return $this->response;
        } catch (\Exception $e) {
			PhoLog::debug_var('---Error---','------------------------------');
			PhoLog::debug_var('---Error---',$e);
		}
	}
	public function splitAction($left_right)
	{
		try{			
		
			$QUERY_STRING = $_SERVER['QUERY_STRING'];
			$url = str_replace('_url=/split/'.$left_right.'/', '', $QUERY_STRING);
			//$url = str_replace('_url=/crop/', '', $QUERY_STRING);			
			$url = str_replace('&', '', $url);
			$path_parts = pathinfo($url);
			$file_thumb = str_replace('.'.$path_parts['extension'], $left_right.'.'.$path_parts['extension'], $url);
			//PhoLog::debug_var('---img---',$url);
			$file_cache = PHO_CACHE_HTML. str_replace('/', '_', $file_thumb);
			if(!file_exists($file_cache)){
						
			//}else{
				$file_name =PHO_PUBLIC_PATH. $url;
				//PhoLog::debug_var('---img---','1:'.$file_name);
				//PhoLog::debug_var('---img---','2:'.$file_cache);
				
				//$exp = explode('x', $size);
				//PhoLog::debug_var('---img---',$exp);
				/*$img = new GD($file_name);			
				$img->resize($exp[0],null,\Phalcon\Image::WIDTH);//->crop($exp[0],$exp[1]);*/
		//	    self::thumb_image($file_name,$exp[0],$exp[1],$file_cache);
			    self::split_image($file_name,$file_cache,$left_right);
				//PhoLog::debug_var('---img---',$file_name);
				//$this->view->disable();	
				//$this->response->setContent(file_get_contents($file_cache));		
				//$this->response->setContent($img->render('jpg'));
				//$img->save($file_cache);
			}	
			$this->view->disable();	
			//PhoLog::debug_var('---img---','view');
			$this->response->setContent(file_get_contents($file_cache));		
	       // PhoLog::debug_var('---img---',$exp);
	        return $this->response;
        } catch (\Exception $e) {
			PhoLog::debug_var('---Error---','------------------------------');
			PhoLog::debug_var('---Error---',$e);
		}
	}
	public static function thumb_image($file_src, $width, $height, $new_file){	

		if(!file_exists($file_src))	return false; // không tìm thấy file
		
		if ($cursize = getimagesize ($file_src)) {					
			$newsize = self::setWidthHeight($cursize[0], $cursize[1], $width, $height);
			$info = pathinfo($file_src);
			PhoLog::debug_var('---img---',$cursize);
			PhoLog::debug_var('---img---',$newsize);
			PhoLog::debug_var('---img---','imagecreatetruecolor');
			$dst = imagecreatetruecolor($newsize[0],$newsize[1]);
			
			$types = array('jpg' => array('imagecreatefromjpeg', 'imagejpeg'),
						'gif' => array('imagecreatefromgif', 'imagegif'),
						'jpeg' => array('imagecreatefromjpeg', 'imagejpeg'),
						'png' => array('imagecreatefrompng', 'imagepng'),
						'GIF' => array('imagecreatefromGIF', 'imageGIF'),
						'JPG' => array('imagecreatefromjpeg', 'imagejpeg'),
						'JPEG' => array('imagecreatefromJPEG', 'imageJPEG'),
						'PNG' => array('imagecreatefromPNG', 'imagePNG'));
			PhoLog::debug_var('---img---','2');
			$func = $types[$info['extension']][0];
			PhoLog::debug_var('---img---','3');
			$src = $func($file_src); 
			PhoLog::debug_var('---img---','imagecopyresampled');
			imagecopyresampled($dst, $src, 0, 0, 0, 0,$newsize[0], $newsize[1],$cursize[0], $cursize[1]);
			$func = $types[$info['extension']][1];
			//$new_file = str_replace('.'.$info['extension'],'_thumb.'.$info['extension'],$file);
			PhoLog::debug_var('---img---','ok');
			return $func($dst, $new_file) ? TRUE : false;
		}
	}
	public static function setWidthHeight($width, $height, $maxWidth, $maxHeight){
		$ret = array($width, $height);
		$ratio = $width / $height;
		if ($width > $maxWidth || $height > $maxHeight) {
			$ret[0] = $maxWidth;
			$ret[1] = $ret[0] / $ratio;
			if ($ret[1] > $maxHeight) {
				$ret[1] = $maxHeight;
				$ret[0] = $ret[1] * $ratio;
			}
		}
		return $ret;
	}
	public static function split_image($file_src, $new_file,$left_right){	//:left:0 right:1

		if(!file_exists($file_src))	return false; // không tìm thấy file
		
		if ($cursize = getimagesize ($file_src)) {					
			//$newsize = self::setWidthHeight($cursize[0], $cursize[1], $width, $height);
			$info = pathinfo($file_src);
			PhoLog::debug_var('---img---',$cursize);
			PhoLog::debug_var('---img---',$newsize);
			PhoLog::debug_var('---img---','imagecreatetruecolor');
			$width = $cursize[0];
			$height = $cursize[1];
			
			$dst = imagecreatetruecolor($width/2,$height);
					
			
			$types = array('jpg' => array('imagecreatefromjpeg', 'imagejpeg'),
						'gif' => array('imagecreatefromgif', 'imagegif'),
						'jpeg' => array('imagecreatefromjpeg', 'imagejpeg'),
						'png' => array('imagecreatefrompng', 'imagepng'),
						'GIF' => array('imagecreatefromGIF', 'imageGIF'),
						'JPG' => array('imagecreatefromjpeg', 'imagejpeg'),
						'JPEG' => array('imagecreatefromJPEG', 'imageJPEG'),
						'PNG' => array('imagecreatefromPNG', 'imagePNG'));
			PhoLog::debug_var('---img---','2');
			$func = $types[$info['extension']][0];
			PhoLog::debug_var('---img---','3');
			$src = $func($file_src); 
			PhoLog::debug_var('---img---','imagecopyresampled');
			//imagecopy($dst, $src, 0, 0, 0, 0,$newsize[0], $newsize[1],$cursize[0], $cursize[1]);
			if($left_right ==0){
				imagecopy($dst, $src, 0, 0, 0, 0, $width/2, $height);
			}else{
				imagecopy($dst, $src, 0, 0, $width/2, 0, $width/2, $height);
			}
			//imagecopy($leftSide, $orig, 0, 0, 0, 0, $width/2, $height);
			//imagecopy($rightSide, $orig, 0, 0, $width/2, 0, $width/2, $height);
			
			$func = $types[$info['extension']][1];
			//$new_file = str_replace('.'.$info['extension'],'_thumb.'.$info['extension'],$file);
			PhoLog::debug_var('---img---','ok');
			return $func($dst, $new_file) ? TRUE : false;
		}
	}
	public function capchaAction(){
		try{
			$this->view->disable();
			$captcha = new Captcha();
			$code ="";
			$this->response->setContent( $captcha->get_and_show_image($code));
			//PhoLog::debug_var('---img---',$code);
			$this->session->set('captcha_code', $code);	
			return $this->response;
		}catch (\Exception $e) {
			PhoLog::debug_var('---Error---',$e);
		}

	}
}
