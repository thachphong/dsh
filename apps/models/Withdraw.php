<?php

namespace Multiple\Models;
use Multiple\Models\DBModel;
use Multiple\PHOClass\PhoLog;
class Withdraw extends DBModel
{
    public $withdraw_id;
    public $add_user_id;
  	public $add_date;
  	public $bank_id;
  	public $bank_acc_no;
  	public $bank_acc_name;
  	public $amount;
  	public $status;
  	public $upd_date;
  	public $upd_user_id;
  	public $fee;
    public function initialize()
    {
        $this->setSource("withdraw");
    }
    public function get_all(){
        return Withdraw::find();
    }
    public function _insert($param){
    	try{
			$this->add_user_id = $param['user_id'];
			$this->add_date = date("Y-m-d H:i:s");
			$this->bank_id = $param['bank_id'];
			$this->bank_acc_name = $param['bank_acc_name'];
			$this->bank_acc_no = $param['bank_acc_no'];
			$this->amount = $param['amount'];
			$this->fee = $param['fee'];
			$this->status = 0;		
			if($this->save()== FALSE){
				PhoLog::debug_var('---SQL_Error---',$this->getMessages());
				return FALSE;	
			}
			return TRUE;			
		} catch (\Exception $e) {
			PhoLog::debug_var('---SYS_Error---',$e->getMessage());			
			throw $e;
		} 
	}
	public function get_info($user_id,$status){
		return Withdraw::findFirst(array(
                "add_user_id = :add_user_id:  and status = :status: ",
                'bind' => array('add_user_id'=>$user_id,'status'=>$status)
        ));
	}
	public function get_list_byuser($user_id){
		$sql="select m.bank_acc_no,
			  m.bank_acc_name,
			  m.amount,			  
			  DATE_FORMAT( m.add_date,'%d/%m/%Y') add_date,
			  m.upd_date,
			  m.upd_user_id,
			  m.status,
			  m.fee,
			  n.disp_val status_name ,
				b.bank_name
			from withdraw m
			INNER JOIN m_bank b on b.bank_id = m.bank_id
			LEFT JOIN m_name n on n.def_key = m.status and n.def_name = 'WITHDRAW_STATUS'
			where m.add_user_id =:user_id";
		return $this->pho_query($sql,array('user_id'=>$user_id));
	}
}
