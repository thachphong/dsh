<?php

namespace Multiple\Models;
use Phalcon\Mvc\Model\Validator\Email as EmailValidator;
use Phalcon\Mvc\Model\Validator\Uniqueness as UniquenessValidator;
use Multiple\Models\DBModel;
use Multiple\PHOClass\PhoLog;
use Multiple\PHOClass\PHOArray;
class Users extends DBModel
{    
    public $user_id;
    public $user_no;
    public $user_name;
    public $mobile;
    public $address;
    public $city;
    public $district;
    public $ward;
    public $level;
    public $status;
    public $pass;
    public $add_date;
    public $upd_date;
    public $email;
    public $sex;
    public $avata;
    public $bank_id;
    public $bank_acc_no;
    public $bank_acc_name;
    public $amount;
    public $del_flg;
    public $ctv_flg;
    public function initialize()
    {
        $this->setSource("m_user");
    }
    public function get_All(){
        $usr_data = Users::query()->execute();
        return $usr_data;
    }
    public function get_info($user_id){
        return Users::findFirst(array(
            "user_id = :user_id:  ",
            'bind' => array('user_id' => $user_id)
        ));
    }
    public function get_user($user_no,$pass){     
       // PhoLog::debug_var('---test---',$user_no);  
       // PhoLog::debug_var('---test---',$this->encodepass($pass)); 
		return Users::findFirst(array(
            "(email = :email: OR user_no = :email:) and pass= :pass:  and del_flg = 0",
            'bind' => array('email' => $user_no,'pass'=>$this->encodepass($pass))
        ));
	}
    public function active($email,$id){     
       // PhoLog::debug_var('---test---',$user_no);  
        //PhoLog::debug_var('---test---',$this->encodepass($pass)); 
        $usr = Users::findFirst(array(
            "email = :email: and user_id= :user_id:  ",
            'bind' => array('email' => $email,'user_id'=>$id)
        ));
        if($usr != false){
            $usr->status = 1;
            return $usr->save();
        }
        return false;
    }
    private function encodepass($pass){
        return sha1(PHO_SALT.$pass);
    }
	public function get_row($user_no,$pass){
        $sql="select * from m_user t
        where ( user_no = :email)  AND del_flg = 0 ";
                
        
		$data = $this->pho_query($sql,array('email' => $user_no));
		//return $data[0]['list_id'];
		
        if(count($data) > 0){
			return TRUE;
		}
		return FALSE;
    }
    public function _insert($param){
        $this->user_no =$param['email'];
        $this->user_name=$param['user_name'];
        $this->mobile=$param['mobile'];
        $this->address=$param['address'];
        $this->level=0; //user thường đăng ký
        $this->status = 0; // chưa kích hoạt
        $this->pass = $this->encodepass($param['pass']);
        $this->email =$param['email'];
        $this->sex =$param['sex'];      
		if(strlen($param['district'])>0){
			$this->district =$param['district'];
		} 
		if(strlen($param['city'])>0){
			$this->city =$param['city'];
		} 
		if(strlen($param['ward'])>0){
			$this->ward =$param['ward'];
		}        
        $this->ctv_flg =$param['ctv_flg'];
        $this->avata ='0.png';
        $this->del_flg = 0;
        PhoLog::debug_var('---test---',$param); 
        return $this->save();
    }
    public function get_validation($param){
        $user = Users::findFirst(array(
                "(email = :email: OR user_no = :user_no:) and status <> 2 ",
                'bind' => array('email' => $param['email'],'user_no'=>$param['user_no'])
        ));
        if($user == false){
            return true;
        }
        if($user->email == $param['email']){
            $res['msg']= "Email này đã có, vui lòng nhập mail khác";
            $res['code'] = "email";
            return $res;
        }
        if($user->user_no == $param['user_no']){
            $res['msg'] ="Tên đăng nhập này đã có, vui lòng nhập tên đăng nhập khác";
            $res['code'] = "userno";
            return $res;
        }
    }
    public function updatepass($user_id,$pass_old,$pass_new){
		$sql="update m_user set pass=:pass_new where user_id =:user_id and pass =:pass_old";
		return $this->pho_execute($sql,array('user_id'=>$user_id,'pass_new'=>$this->encodepass($pass_new),'pass_old'=>$this->encodepass($pass_old)));
	}
	public function updateinfo($param){
		$sql_pa = PHOArray::filter($param, array(
                    'user_name'
                    ,'mobile' 
                    ,'address'                               
                    ,'sex'                   
                    ,'user_id'
                    ,'city'
                    ,'district'
                    ,'ward'
                    ,'ctv_flg'
                    ,'bank_id'
                    ,'bank_acc_no'
                    ,'bank_acc_name'
                   ));
        
		$sql ="update m_user set user_name= :user_name
						,mobile= :mobile
						,address= :address
						,sex= :sex					
						,city=:city
						,district=:district
						,ward=:ward	
						,ctv_flg = :ctv_flg
						,bank_id = :bank_id
						,bank_acc_no = :bank_acc_no
						,bank_acc_name = :bank_acc_name		
						";
		if(strlen($param['avata']) >0){
			$sql .=" ,avata= :avata";
			$sql_pa['avata']= $param['avata'];
		}
		$sql .=" where user_id =:user_id";
		return $this->pho_execute($sql,$sql_pa);
	}
	public function get_user_rows($param)
	{
		$sql = "SELECT	user_id,user_name,user_no,email,mobile,level,
				(case when level=1 then 'Admin' else 'Thường' end) level_name,del_flg
				 FROM	user ";
		
		if (isset($param['s_user_name'])) {
			$sql_param = array(
					'user_name' =>  '%' .$param['s_user_name'] . '%'
				);
			$sql .= " WHERE lower(usr.user_name) like lower(:user_name) ";
		} else {
			$sql_param = array();
		}
		
		$sql .= "
			ORDER BY
				user_id
		";
		//var_dump($sql);die;
		return $this->pho_query($sql, $sql_param);
	}
	public function updatelevel($user_id,$level){		
		$sql ="update m_user set 
						level = :level	
				where user_id =:user_id ";		
		return $this->pho_execute($sql,array('level'=>$level,'user_id'=>$user_id));
	}
	public function updatelock($user_id,$lock){
		$sql ="update m_user set 
						del_flg = :del_flg	
				where user_id =:user_id ";		
		return $this->pho_execute($sql,array('del_flg'=>$lock,'user_id'=>$user_id));
	}
	public function get_user_bymail($email){
		$sql = "select * from m_user where email=:email";
		return $this->query_first($sql,array('email'=>$email));
	}
    public function get_total_info(){
        $sql="select 
                (select count(*) from m_user ) total
                ,(select count(*) from m_user where status = 0) not_active
                ,(select count(*) from m_user where status = 1 and ctv_flg = 1) total_ctv";
        return $this->query_first($sql);
    }
}
