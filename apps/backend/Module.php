<?php

namespace Multiple\Backend;

use Phalcon\Loader;
use Phalcon\Mvc\View;
use Phalcon\Mvc\Dispatcher;
use Phalcon\DiInterface;
use Phalcon\Db\Adapter\Pdo\Mysql as Database;
use Phalcon\Mvc\View\Engine\Volt ;
use Phalcon\Cache\Backend\File as BackFile;
use Phalcon\Cache\Frontend\Data as FrontData;
use Multiple\Models\Define;
class Module
{

	public function registerAutoloaders()
	{

		$loader = new Loader();

		$loader->registerNamespaces(array(
			'Multiple\Backend\Controllers' => '../apps/backend/controllers/',
			'Multiple\Models'      => '../apps/models/',
            'Multiple\Library'      => '../apps/library/',
			'Multiple\Backend\Plugins'     => '../apps/backend/plugins/',
			'Multiple\PHOClass'      => '../apps/phoclass/',
		));
        /*$loader->registerDirs(
			array(
				'../apps/library/',				
			)
		)->register();*/

		$loader->register();
	}

	/**
	 * Register the services here to make them general or register in the ModuleDefinition to make them module-specific
	 */
	public function registerServices(DiInterface $di)
	{

		//Registering a dispatcher
		$di->set('dispatcher', function() {
			$dispatcher = new Dispatcher();
			$dispatcher->setDefaultNamespace("Multiple\Backend\Controllers\\");
			return $dispatcher;
		});

		//Registering the view component
		$di->set('view', function() {
			$view = new View();
			$view->setViewsDir('../apps/backend/views/');
           // $view->setTemplateBefore('main');

            $view->registerEngines([
                ".volt" => function($view, $di) {

                    $volt = new Volt($view, $di);

                    $volt->setOptions([
                        'compiledPath' => function ($templatePath) {
                            return realpath(__DIR__."/../../var/volt") . '/' . md5($templatePath) . '.php';
                        },
                        'compiledExtension' => '.php',
                        'compiledSeparator' => '%'
                    ]);

                    return $volt;
                }
            ]);
			$view->setVar('baseurl', BASE_URL_NAME);
			$view->setVar('percent_exp', PERCENT_EXPORT);
			$view->setVar('percent_seller', PERCENT_SELLER);
			/*$define = $this->get_define();
			foreach($define as $item){
				$view->setVar($item->define_key, $item->define_val);
			}*/
            return $view;
			//return $view;
		});

		//Set a different connection in each module
		/*$di->set('db', function() {
			return new Database(array(
				"host" => "localhost",
				"username" => "root",
				"password" => "",
				"dbname" => "multiple"
			));
		});*/
	}
	public function get_define(){
		//Cache data for one day by default
	    $frontCache = new FrontData(["lifetime" => 86400]);	  
	    $cache = new BackFile($frontCache, ["cacheDir" =>PHO_CACHE_DIR]);
	    $key ="define_4.cache";
	    $data = $cache->get($key);
	    if($data == NULL){
			$db = new Define();
			$data = $db->get_define_by_group(4);
			$cache->save($key,$data);
		}
		return $data;
	}
}
