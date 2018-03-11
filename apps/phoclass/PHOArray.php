<?php
namespace Multiple\PHOClass;
class PHOArray
{
    
    public static function filter($source, $filter, $add=null)
    {
        $new_array = array();
        foreach ($filter as $key) {
            $new_array[$key] = $source[$key];
        }
        if (is_null($add) == false) {
            $new_array = static::merge($new_array, $add);
        }
        return $new_array;
    }
   
    public static function merge($array1, $array2)
    {
        foreach ($array2 as $key => $val) {
            $array1[$key] = $val;
        }
        return $array1;
    }
}
