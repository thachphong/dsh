<?php
namespace Multiple\Library;
class FilePHP
{
    
    //Add Start Minh Vnit 2014/11/27
    public function DeleteFolderCommandLine($folderspec) {
        try {
            if ($this->FolderExists($folderspec)) {                     
                 $this->remove($folderspec);
            return true;
            }
        } catch (com_exception $e) {
            ACWLog::write_file('FSO', sprintf('FolderExists(%s):%s', $folderspec, $e->getMessage()));
            throw $e;
            
        }
        return FALSE;
    }
   
    public function BuildPath($path, $name) {       
        try {           
            $tmp = $path.'/'.$name;         
            //return mb_convert_encoding($tmp, 'UTF-8', 'SJIS-win');
            return $tmp;
        } catch (com_exception $e) {
            ACWLog::write_file('FSO', sprintf('BuildPath(%s,%s):%s', $path, $name, $e->getMessage()));
        }

        return FALSE;
    }

    
    public function GetBaseName($path) {
        try {
            $fileinfo = pathinfo($path);
            return $fileinfo['basename'];
        } catch (com_exception $e) {
            ACWLog::write_file('FSO', sprintf('GetBaseName(%s):%s', $path, $e->getMessage()));
        }

        return FALSE;
    }

   
    public function GetExtensionName($path) {
        try {
            $fileinfo = pathinfo($path);
            return $fileinfo['extension'];
        } catch (com_exception $e) {
            ACWLog::write_file('FSO', sprintf('GetExtensionName(%s):%s', $path, $e->getMessage()));
        }

        return FALSE;
    }

    
    public function GetFileName($pathspec) {
        try {
            $fileinfo = pathinfo($pathspec);
            return $fileinfo['filename'];           
        } catch (com_exception $e) {
            ACWLog::write_file('FSO', sprintf('GetFileName(%s):%s', $pathspec, $e->getMessage()));
        }

        return FALSE;
    }    
        
    public function FileList($filespec, $fill = '') {
        $list = array();

        try {
            //$filespec1 = new VARIANT($filespec, VT_BSTR, CP_UTF8);
            //$folderobject = $this->_file->GetFolder($filespec1);
            foreach ($this->toIterator($filespec) as $dir) {
            $folderobject = scandir($dir, 1);
            // ファイル一覧
                //print_r($folderobject);
                foreach ($folderobject as $f)
                {
                    //$tmp = mb_convert_encoding($f->Name, 'UTF-8', 'SJIS-win');
                    //$tmp = $f->Name;
                    if($f != '.' && $f !='..'){
                        $tmp= $f;
                        if ($fill == '' || mb_strpos($tmp, $fill) !== FALSE) {
                            $list[] = $tmp;
                        }
                    }
                }
            }   
        } catch (com_exception $e) {
            ACWLog::write_file('FSO', sprintf('FileList(%s, %s):%s', $filespec, $fill, $e->getMessage()));
        }
        return $list;
    }  
    /**
        FolderList 
     */ 
    public function FolderList($filespec, $fill = '') {

        $list = array();
        try {
            
            $folderobject = scandir($filespec, 1);
            foreach ($folderobject as $f)
            {   
                if($f != '.' && $f !='..'){
                    if(is_dir($filespec.'/'.$f)){
                        $tmp = $f;
                        if ($fill == '' || mb_strpos($tmp, $fill) !== FALSE) {
                            $list[] = $tmp;
                        }
                    }
                }
            }
        } catch (com_exception $e) {
            ACWLog::write_file('FSO', sprintf('FolderList(%s, %s):%s', $filespec, $fill, $e->getMessage()));
        }

        return $list;
    }
    
    public function FileFolderList($filespec, $sub = false, $fill = '', $ffill = '') {

        $list = array();
        $sublist = array();
        try {
            
            $folderobject = $filespec1 = scandir($filespec, 1);

            // ファイル一覧
            foreach ($folderobject as $f)
            {
                if($f != '.' && $f !='..'){
                    //$tmp = mb_convert_encoding($f->Name, 'UTF-8', 'SJIS-win');
                    if(is_dir($filespec.'/'.$f)){  // is sub folder
                        $tmp = $f;
                        if ($ffill == '' || mb_strpos($tmp, $ffill) !== FALSE) {
                            $list[] = $tmp;
                            $sublist[] = $tmp;
                        }
                    }else{   // is file
                        $tmp = $f;
                        if ($fill == '' || mb_strpos($tmp, $fill) !== FALSE) {
                            $list[] = $tmp;
                        }   
                    }
                }
            }
            
            
            // フォルダ一覧（サブフォルダ検索）
            foreach ($sublist as $s)
            {
                $subpath =$filespec.'/'.$s; //$this->BuildPath($filespec, $s);
                $list[ '/' . $s ] = $this->FileFolderList($subpath  , $sub,  $fill, $ffill);
            }
        } catch (com_exception $e) {
            ACWLog::write_file('FSO', sprintf('FileFolderList(%s, %d, %s, %s):%s', $filespec, $sub, $fill, $ffill, $e->getMessage()));
        }

        return $list;
    }  
    /**
        FolderExists : chek absolute  path
     */    
    public function FolderExists($folderspec) {
        try {
            //$folderspec1 = new VARIANT($folderspec, VT_BSTR, CP_UTF8);
            //return $this->_file->FolderExists($folderspec1) === true;
            return is_dir($folderspec);
        } catch (com_exception $e) {
            ACWLog::write_file('FSO', sprintf('FolderExists(%s):%s', $folderspec, $e->getMessage()));
            throw $e;
        }

        return FALSE;
    }
    /**
        MoveFolder
     */
    public function MoveFile($source, $destination) {
        try {
            $this->CopyFile($source, $destination);
            $this->DeleteFile($source);         
            return TRUE;
        } catch (com_exception $e) {
            ACWLog::write_file('FSO', sprintf('MoveFile(%s,%s):%s', $source, $destination, $e->getMessage()));
        }
        return FALSE;
    }   

    /**
        MoveFolder
     */
    public function MoveFolder($source, $destination) {
        try {
            $this->CopyFolder($source, $destination);
            $this->DeleteFolder($source);
            return TRUE;
        } catch (com_exception $e) {
            ACWLog::write_file('FSO', sprintf('MoveFolder(%s,%s):%s', $source, $destination, $e->getMessage()));
        }
        return FALSE;
    }
    /**
        DeleteFile
     */
    public function DeleteFile($filespec, $force = false) {
        try {  
            if(is_file($filespec)){                     
                return $this->remove($filespec);
            }
        } catch (com_exception $e) {
            ACWLog::write_file('FSO', sprintf('CreateFolder(%s):%s', $filespec, $e->getMessage()));
        }
        return FALSE;
    }


    /**
        DeleteFolder
     */
    public function DeleteFolder($folderspec, $force = false) {
        try {                       
            return $this->remove($folderspec);
        } catch (com_exception $e) {
            ACWLog::write_file('FSO', sprintf('DeleteFolder(%s, %d):%s', $folderspec, $force, $e->getMessage()));
        }
        return FALSE;
    }
    
    public function CopyFile($originFile, $targetFile, $override = false)
    {
        try{
            
        
            $path_end= substr($originFile,strlen($originFile)-1,1);
            if($path_end=="*") // copy all file in folder
            {
                $sub_path = substr($originFile,0,strlen($originFile)-1);
                $list_file = $this->FileList($sub_path,'',FALSE);
                foreach($list_file as $item){
                    $item_file = $sub_path.$item;
                    $disti_file = $targetFile.$item;
                    $this->CopyFile($item_file,$disti_file,$override,FALSE);
                }
                return TRUE;
            }
        if (stream_is_local($originFile) && !is_file($originFile)) {
            //throw new FileNotFoundException(sprintf('Failed to copy "%s" because file does not exist.', $originFile), 0, null, $originFile);
            return FALSE;
        }

            $this->CreateFolder(dirname($targetFile),0777);

            if (!$override && is_file($targetFile) && null === parse_url($originFile, PHP_URL_HOST)) {
                $doCopy = filemtime($originFile) > filemtime($targetFile);
            } else {
                $doCopy = true;
            }

            if ($doCopy) {
                
                $source = fopen($originFile, 'r');
                $target = fopen($targetFile, 'w');
                stream_copy_to_stream($source, $target);
                fclose($source);
                fclose($target);
                unset($source, $target);

                if (!is_file($targetFile)) {
                    //throw new IOException(sprintf('Failed to copy "%s" to "%s".', $originFile, $targetFile), 0, null, $originFile);
                    return FALSE;
                }
            }
            return TRUE;
        } catch (com_exception $e) {
            ACWLog::write_file('FSO', sprintf('CopyFile(%s,%s,%d):%s', $originFile, $targetFile, $override, $e->getMessage()));
        }
        return FALSE;
    }

   
    public function CreateFolder($dirs, $mode = 0777)
    {
        try{
            foreach ($this->toIterator($dirs) as $dir) {
                if (is_dir($dir)) {
                    continue;
                }

                if (true == @mkdir($dir, $mode, true)) {
                    //throw new IOException(sprintf('Failed to create "%s".', $dir), 0, null, $dir);
                    return true;
                }
            }
        } catch (com_exception $e) {
            ACWLog::write_file('FSO', sprintf('CreateFolder(%s):%s', $foldername, $e->getMessage()));
        }
        return false;
    }
    
    public function FileExists($files)
    {
        foreach ($this->toIterator($files) as $file) {
            if (!file_exists($file)) {
                return false;
            }
        }

        return true;
    }
    
    public function remove($files)
    {
        $files = iterator_to_array($this->toIterator($files));
        $files = array_reverse($files);
        foreach ($files as $file) {
            if (!file_exists($file) && !is_link($file)) {
                continue;
            }

            if (is_dir($file) && !is_link($file)) {
                $this->remove(new \FilesystemIterator($file));

                if (true !== @rmdir($file)) {
                    //throw new ioexception(sprintf('Failed to remove directory "%s".', $file), 0, null, $file);
                    return false;
                }
            } else {
               
                if (defined('PHP_WINDOWS_VERSION_MAJOR') && is_dir($file)) {
                    if (true !== @rmdir($file)) {
                        //throw new ioexception(sprintf('Failed to remove file "%s".', $file), 0, null, $file);
                        return false;
                    }
                } else {
                    if (true !== @unlink($file)) {
                        //throw new ioexception(sprintf('Failed to remove file "%s".', $file), 0, null, $file);
                        return false;
                    }
                }
            }
        }
        return TRUE;
    }
    
    public function symlink($originDir, $targetDir, $copyOnWindows = false)
    {
        if (!function_exists('symlink') && $copyOnWindows) {
            $this->CopyFolder($originDir, $targetDir);

            return;
        }

        $this->CreateFolder(dirname($targetDir));

        $ok = false;
        if (is_link($targetDir)) {
            if (readlink($targetDir) != $originDir) {
                $this->remove($targetDir);
            } else {
                $ok = true;
            }
        }

        if (!$ok) {
            if (true !== @symlink($originDir, $targetDir)) {
                $report = error_get_last();
                if (is_array($report)) {
                    if (defined('PHP_WINDOWS_VERSION_MAJOR') && false !== strpos($report['message'], 'error code(1314)')) {
                        //throw new ioexception('Unable to create symlink due to error code 1314: \'A required privilege is not held by the client\'. Do you have the required Administrator-rights?');
                        return false;
                    }
                }

                //throw new ioexception(sprintf('Failed to create symbolic link from "%s" to "%s".', $originDir, $targetDir), 0, null, $targetDir);
                return false;
            }
        }
    }
    
    public function makePathRelative($endPath, $startPath)
    {
        // Normalize separators on Windows
        if (defined('PHP_WINDOWS_VERSION_MAJOR')) {
            $endPath = strtr($endPath, '\\', '/');
            $startPath = strtr($startPath, '\\', '/');
        }

        // Split the paths into arrays
        $startPathArr = explode('/', trim($startPath, '/'));
        $endPathArr = explode('/', trim($endPath, '/'));

        // Find for which directory the common path stops
        $index = 0;
        while (isset($startPathArr[$index]) && isset($endPathArr[$index]) && $startPathArr[$index] === $endPathArr[$index]) {
            $index++;
        }

        // Determine how deep the start path is relative to the common path (ie, "web/bundles" = 2 levels)
        $depth = count($startPathArr) - $index;

        // Repeated "../" for each level need to reach the common path
        $traverser = str_repeat('../', $depth);

        $endPathRemainder = implode('/', array_slice($endPathArr, $index));

        // Construct $endPath from traversing to the common path, then to the remaining $endPath
        $relativePath = $traverser.(strlen($endPathRemainder) > 0 ? $endPathRemainder.'/' : '');

        return (strlen($relativePath) === 0) ? './' : $relativePath;
    }
    
    public function CopyFolder($directory, $destination, $overwrite = true)
    {
        try{                    
            // If no directory to copy return false
            if (!is_dir($directory)) {
                return false;
            } else {
                // Create a FilesystemIterator instance 
                $FilesystemIterator = new FilesystemIterator($directory,FilesystemIterator::SKIP_DOTS);
                // If destination directory not exists
                if (!is_dir($destination)) {
                    // Create a destination directory
                    mkdir($destination,0777,true);
                }
                elseif($overwrite === true)
                {
                    $this->DeleteFolder($destination);
                }
                // Loop files and directories
                foreach ($FilesystemIterator as $Iterator) {
                    // If directory
                    if ($Iterator->isDir()) {
                        // Copy directory or return false
                        $path_source = $Iterator->getPathname();
                        $fname = $Iterator->getFilename ();
                        $path_copy = $destination.DIRECTORY_SEPARATOR.$fname;
                        if (false === $this->CopyFolder($path_source,$path_copy))
                            return false;
                    } else { // Else if file
                        // Copy file or return false
                        $path_source = $Iterator->getPathname();
                        $fname = $Iterator->getFilename();
                        $path_copy = $destination.DIRECTORY_SEPARATOR.$fname;
                        if (false === copy($path_source,$path_copy))
                                return false;
                    }
                }
                // If copying finished without any failure return true
                return true;
            }
        } catch (com_exception $e) {
            ACWLog::write_file('FSO', sprintf('CopyFolder(%s,%s,%d):%s', $source, $destination, $overwrite, $e->getMessage()));
        }
        return FALSE;
    }

    
    public function isAbsolutePath($file)
    {
        if (strspn($file, '/\\', 0, 1)
            || (strlen($file) > 3 && ctype_alpha($file[0])
                && substr($file, 1, 1) === ':'
                && (strspn($file, '/\\', 2, 1))
            )
            || null !== parse_url($file, PHP_URL_SCHEME)
        ) {
            return true;
        }

        return false;
    }

    /**
     * @param mixed $files
     *
     * @return \Traversable
     */
    private function toIterator($files)
    {
        if (!$files instanceof \Traversable) {
            $files = new \ArrayObject(is_array($files) ? $files : array($files));
        }

        return $files;
    }
    //new code
    public function write_file($filepath, $str)
    {       
        if (($fp = @fopen($filepath, "a")) === false) {
            return;
        }

        if (!flock($fp, LOCK_EX)) {
            @fclose($fp);
            return;
        }

        if (fwrite($fp,  $str ) === false) {
            @flock($fp, LOCK_UN);
            @fclose($fp);
            return;
        }

        if (!fflush($fp)) {
            @flock($fp, LOCK_UN);
            @fclose($fp);
            return;
        }

        if (!flock($fp, LOCK_UN)) {
            @fclose($fp);
            return;
        }

        if (!fclose($fp)) {
            return;
        }
    }
}
