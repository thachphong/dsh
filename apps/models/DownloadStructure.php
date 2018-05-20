<?php

namespace Multiple\Models;

use Multiple\Models\DBModel;
use Multiple\PHOClass\PHOArray;

class DownloadStructure extends DBModel
{
    public $id;
    public $key;
    public $description;
    public $xpath;
    public $ref_link;
    public $element_remove;
    public $from_string;
    public $to_string;
    public $sort;
    public $ctg_flg;
    public $dl_category_id;
    public $stop_flg;
        
    public function initialize()
    {
        $this->setSource("download_structure");
    }
    public function get_by_ref_link($reflink,$ctg_flg = 0){
        //$data = DownloadStructure::find(array('ref_link'=>$reflink,  "order" => "sort"));
        // $data = DownloadStructure::query()
        //         ->where("ref_link = :ref_link:")  
        //         ->addwhere("ctg_flg = :ctg_flg:") 
        //         ->addwhere("stop_flg = 0 ")              
        //         ->bind(array("ref_link" => $reflink,'ctg_flg'=>$ctg_flg))
        //         ->order("sort")
        //         ->execute();
        // return $data;
        return  DownloadStructure::find(array(
                "ref_link = :ref_link: and ctg_flg=:ctg_flg: and stop_flg = 0 ",
                'bind' => array('ref_link' => $reflink,'ctg_flg'=>$ctg_flg),
                'order'=> "sort"
        ));
    }
    public function get_by_ctg_link($reflink,$dl_category_id = 0){
        return  DownloadStructure::find(array(
                "ref_link = :ref_link: and ctg_flg=1 and stop_flg = 0 and dl_category_id = :dl_category_id:",
                'bind' => array('ref_link' => $reflink,'dl_category_id'=>$dl_category_id),
                'order'=> "sort"
        ));
        //$data = DownloadStructure::find(array('ref_link'=>$reflink,  "order" => "sort"));
        // $data = DownloadStructure::query()
        //         ->where("ref_link = :ref_link:")  
        //         ->addwhere("ctg_flg = 1 ")
        //         ->addwhere("stop_flg = 0 ")  
        //         ->addwhere("dl_category_id = :dl_category_id:")
        //         ->bind(array("ref_link" => $reflink,'dl_category_id' =>$dl_category_id))
        //         ->order("sort")
        //         ->execute();
        // return $data;
    }
    public  function get_rows(){
        $sql="select dc.*,c.ctg_name from download_structure dc
                Left JOIN category c on c.ctg_id = dc.dl_category_id
                order by dc.ctg_flg desc,dc.ref_link,dc.sort
                ";
        return $this->pho_query($sql);
    }
    public function get_info($id){
        return  DownloadStructure::findFirst(array(
                "id = :id: ",
                'bind' => array('id' => $id)
            ));
    }
    public function insert($param){
        $this->ref_link = $param['ref_link'];
        $this->xpath = $param['xpath'];
        $this->element_remove = $param['element_remove'];
        $this->from_string = $param['from_string'];
        $this->to_string = $param['to_string'];
        $this->sort = $param['sort'];
        $this->ctg_flg = $param['ctg_flg'];
        $this->dl_category_id = $param['dl_category_id'];
        $this->stop_flg = $param['stop_flg'];
        $this->key = $param['key'];
        $this->save();
        return $this->id;        
    }
    public function _update($param){

        $sql = "update download_structure
                    set ref_link = :ref_link
                    ,xpath = :xpath 
                    ,element_remove= :element_remove  
                    ,from_string =:from_string
                    ,to_string =:to_string
                    ,sort=:sort
                    ,ctg_flg =:ctg_flg
                    ,dl_category_id =:dl_category_id
                    ,stop_flg =:stop_flg
                    ,download_structure.key =:key
                    where id = :id
                ";  
 
        return $this->pho_execute($sql, PHOArray::filter($param, array(
                     'id',
                      'ref_link',
                      'xpath',          
                      'element_remove'
                      ,'from_string'
                      ,'to_string'
                      ,'sort'
                      ,'ctg_flg'
                      ,'dl_category_id'
                      ,'stop_flg'
                      ,'key'
                    )));    
    }
}
