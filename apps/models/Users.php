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
    public $level;
    public $status;
    public $pass;
    public $add_date;
    public $upd_date;
    public $email;
    public $sex;
    public $avata;
    public $facebook;
    public $skype;
    public $amount;
    public $del_flg;
    public function initialize()
    {
        $this->setSource("user");
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
        $sql="select * from user t
        where ( user_no = :email)  AND del_flg = 0 ";
                
        
		$data = $this->pho_query($sql,array('email' => $user_no));
		//return $data[0]['list_id'];
		
        if(count($data) > 0){
			return TRUE;
		}
		return FALSE;
    }
    public function _insert($param){
        $this->user_no =$param['user_no'];
        $this->user_name=$param['user_name'];
        $this->mobile=$param['mobile'];
        $this->address=$param['address'];
        $this->level=0; //user thường đăng ký
        $this->status = 0; // chưa kích hoạt
        $this->pass = $this->encodepass($param['pass']);
        $this->email =$param['email'];
        $this->sex =$param['sex'];
        $this->avata ='0.png';
        $this->del_flg = 0;
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
		$sql="update user set pass=:pass_new where user_id =:user_id and pass =:pass_old";
		return $this->pho_execute($sql,array('user_id'=>$user_id,'pass_new'=>$this->encodepass($pass_new),'pass_old'=>$this->encodepass($pass_old)));
	}
	public function updateinfo($param){
		$sql_pa = PHOArray::filter($param, array(
                    'user_name'
                    ,'mobile' 
                    ,'address'                               
                    ,'sex'
                    ,'facebook'
                    ,'skype'
                    ,'user_id'
                   ));
        
		$sql ="update user set user_name= :user_name
						,mobile= :mobile
						,address= :address
						,sex= :sex
						,facebook= :facebook
						,skype= :skype				
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
		$sql ="update user set 
						level = :level	
				where user_id =:user_id ";		
		return $this->pho_execute($sql,array('level'=>$level,'user_id'=>$user_id));
	}
	public function updatelock($user_id,$lock){
		$sql ="update user set 
						del_flg = :del_flg	
				where user_id =:user_id ";		
		return $this->pho_execute($sql,array('del_flg'=>$lock,'user_id'=>$user_id));
	}
}
