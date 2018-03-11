<?php

namespace Multiple\Frontend;

use Phalcon\Loader;
use Phalcon\Mvc\Dispatcher;
use Phalcon\Db\Adapter\Pdo\Mysql as Database;
use Phalcon\Mvc\View\Engine\Volt ;
use Phalcon\Mvc\View;

class Module
{

	public function registerAutoloaders()
	{

		$loader = new Loader();

		$loader->registerNamespaces(array(
			'Multiple\Frontend\Controllers' => '../apps/frontend/controllers/',
			'Multiple\Frontend\Plugins'     => '../apps/frontend/plugins/',
			'Multiple\Models' => '../apps/models/',
			'Multiple\PHOClass' => '../apps/phoclass/',
			'Multiple\Library'      => '../apps/library/',
		));

		$loader->register();
	}

	/**
	 * Register the services here to make them general or register in the ModuleDefinition to make them module-specific
	 */
	public function registerServices($di)
	{

		//Registering a dispatcher
		$di->set('dispatcher', function () {
			$dispatcher = new Dispatcher();

			//Attach a event listener to the dispatcher
			$eventManager = new \Phalcon\Events\Manager();
			$eventManager->attach('dispatch', new \Acl('frontend'));

			$dispatcher->setEventsManager($eventManager);
			$dispatcher->setDefaultNamespace("Multiple\Frontend\Controllers\\");
			return $dispatcher;
		});

		//Registering the view component
		/*$di->set('view', function () {
			$view = new \Phalcon\Mvc\View();
			$view->setViewsDir('../apps/frontend/views/template1');
            
			return $view;
		});*/
        /*$di->set('volt', function ($view, $di) {

        	$volt = new VoltEngine($view, $di);

        	$volt->setOptions(array(
        		"compiledPath" => APP_PATH . "cache/volt/"
        	));

        	$compiler = $volt->getCompiler();
        	$compiler->addFunction('is_a', 'is_a');

        	return $volt;
        }, true);*/
		$di->set('view', function() {
            $view = new View();

            $view->setViewsDir(__DIR__.'/views/template1');
            //$view->setTemplateBefore('main');

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
			$view->setVar('ship_amount', SHIP_AMOUNT);
            return $view;

        });
        
		/*$di->set('db', function () {
			return new Database(array(
				"host" => "localhost",
				"username" => "root",
				"password" => "",
				"dbname" => "multiple"
			));
		});*/
		
	}
}
