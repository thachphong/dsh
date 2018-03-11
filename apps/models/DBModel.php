<?php

namespace Multiple\Models;
use Phalcon\Mvc\Model;
//use Phalcon\Mvc\Model\Query;

class DBModel extends Model
{      
    protected function pho_query($sql,$param=array( )){        
        $db = \Phalcon\DI::getDefault()->get('db');
		$stmt = $db->prepare($sql);
		$stmt->execute($param);
		return $stmt->fetchAll(\PDO::FETCH_ASSOC);		
    }
   	protected function pho_execute($sql,$param=array( )){        
        $db = \Phalcon\DI::getDefault()->get('db');
		$stmt = $db->prepare($sql);
		return $stmt->execute($param);
    }
    protected function query_first($sql,$param=array( )){        
        $db = \Phalcon\DI::getDefault()->get('db');
        $stmt = $db->prepare($sql);
        $stmt->execute($param);
        return $stmt->fetch(\PDO::FETCH_ASSOC);      
    }
}
