<?php

namespace Multiple\Models;
use Phalcon\Mvc\Model;
use Multiple\PHOClass\PhoLog;
//use Phalcon\Mvc\Model\Query;

class DBModel extends Model
{      
    protected function pho_query($sql,$param=array( )){   
    	try{
	        $db = \Phalcon\DI::getDefault()->get('db');
			$stmt = $db->prepare($sql);
			$stmt->execute($param);
			return $stmt->fetchAll(\PDO::FETCH_ASSOC);	
		} catch (\Exception $e) {
			PhoLog::debug_var('---SQL_Error---',$e->getMessage());
			PhoLog::debug_var('---SQL_Error---',$sql);
			PhoLog::debug_var('---SQL_Error---',$param);
			throw $e;
		}	
    }
   	protected function pho_execute($sql,$param=array( )){   
   		try{     
	        $db = \Phalcon\DI::getDefault()->get('db');
			$stmt = $db->prepare($sql);
			return $stmt->execute($param);
		} catch (\Exception $e) {
			PhoLog::debug_var('---SQL_Error---',$e->getMessage());
			PhoLog::debug_var('---SQL_Error---',$sql);
			PhoLog::debug_var('---SQL_Error---',$param);
			throw $e;
		}
    }
    protected function query_first($sql,$param=array( )){    
    	try{    
	        $db = \Phalcon\DI::getDefault()->get('db');
	        $stmt = $db->prepare($sql);
	        $stmt->execute($param);
	        return $stmt->fetch(\PDO::FETCH_ASSOC); 
        } catch (\Exception $e) {
			PhoLog::debug_var('---SQL_Error---',$e->getMessage());
			PhoLog::debug_var('---SQL_Error---',$sql);
			PhoLog::debug_var('---SQL_Error---',$param);
			throw $e;
		}     
    }
}
