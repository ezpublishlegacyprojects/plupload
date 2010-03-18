<?php
/**
 * upload.php
 *
 * @ Copyright 2010, Contactivity
 * @license http://ez.no/licenses/gnu_gpl GNU GPL v2
 * @version 0.1
 * @package plupload
 *
 */
	$Module       = $Params['Module'];
	$parentNodeID = $Params['ParentNodeID'];
        $sys = eZSys::instance();
        $storage_dir = $sys->storageDirectory();
        $pluploadINI = eZINI::instance( 'plupload.ini.append.php', 'settings');
	$parentNodeID = $Params['ParentNodeID'];

	//check if the user has write permissions to the destination before doing any uploading I know we do it in the template anyway... but this is to keep someone from hacking around that.

	// Check if parent node ID provided in URL exists and is an integer
	if ( !$parentNodeID OR !is_numeric( $parentNodeID ) )
		return $Module->handleError( eZError::KERNEL_NOT_AVAILABLE, 'kernel' );
	
	// Fetch parent node
	$parentNode = eZContentObjectTreeNode::fetch( $parentNodeID );
	
	// Check if parent node object exists
	if( !$parentNode )
		return $Module->handleError( eZError::KERNEL_NOT_FOUND, 'kernel' );
	
	// Check if current user has access to parent node and can create content inside
	if( !$parentNode->attribute( 'can_read' ) OR !$parentNode->attribute( 'can_create' ) )
		return $Module->handleError( eZError::KERNEL_ACCESS_DENIED, 'kernel' );

	//There should be a check here for allowed filetypes - but then, that depends on the runtime that is being used... Which is information that I don't have here.  Maybe I should be using the multipart option and sending it as a post variable

	// HTTP headers for no cache etc
	header('Content-type: text/plain; charset=UTF-8');
	header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");
	header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT");
	header("Cache-Control: no-store, no-cache, must-revalidate");
	header("Cache-Control: post-check=0, pre-check=0", false);
	header("Pragma: no-cache");

	// Settings
	$target=$pluploadINI->variable('pluploadSettings', 'DownloadPath');

        $sys = eZSys::instance();
        $storage_dir = $sys->storageDirectory();
        $targetDir = $storage_dir . '/'.$target;

	$cleanupTargetDir = false; // Remove old files
	$maxMinutes = $pluploadINI->variable('pluploadSettings', 'maxFileAge') ? $pluploadINI->variable('pluploadSettings', 'maxFileAge') : 60;
	$maxFileAge = $maxMinutes * 60; // Temp file age in seconds

	$timelimit = $pluploadINI->variable('pluploadSettings', 'setTimeLimit') ? $pluploadINI->variable('pluploadSettings', 'setTimeLimit') : 5;
	// 5 minutes execution time - just the chunk
	@set_time_limit($timelimit * 60);
	// usleep(5000);

	// Get parameters
	$chunk = isset($_REQUEST["chunk"]) ? $_REQUEST["chunk"] : 0;
	$chunks = isset($_REQUEST["chunks"]) ? $_REQUEST["chunks"] : 0;
	$fileName = isset($_REQUEST["name"]) ? $_REQUEST["name"] : '';

	// Clean the fileName for security reasons
	$fileName = preg_replace('/[^\w\._]+/', '', $fileName);

	// Create target dir
	if (!file_exists($targetDir))
		@mkdir($targetDir);

	// Remove old temp files
	if (is_dir($targetDir) && ($dir = opendir($targetDir))) {
		while (($file = readdir($dir)) !== false) {
			$filePath = $targetDir . DIRECTORY_SEPARATOR . $file;
			$removeTempFiles = $pluploadINI->variable('pluploadSettings', 'removeTempFiles');
			if ( $removeTempFiles == 'enabled' ) {
				// Remove temp files if they are older than the max age
				if (preg_match('/\\.tmp$/', $file) && (filemtime($filePath) < time() - $maxFileAge))
					@unlink($filePath);
			}
		}
		closedir($dir);
	} else {
		echo('{"jsonrpc" : "2.0", "error" : {"code": 100, "message": "Failed to open temp directory."}, "id" : "id"}');
		eZExecution::cleanExit();
	}
	if (strpos($_SERVER["HTTP_CONTENT_TYPE"], "multipart") !== false) {
		if (isset($_FILES['file']['tmp_name']) && is_uploaded_file($_FILES['file']['tmp_name'])) {
			// Open temp file
			$out = fopen($targetDir . DIRECTORY_SEPARATOR . $fileName, $chunk == 0 ? "wb" : "ab");
			if ($out) {
				// Read binary input stream and append it to temp file
				$in = fopen($_FILES['file']['tmp_name'], "rb");

				if ($in) {
					while ($buff = fread($in, 4096))
						fwrite($out, $buff);
				} else {
					echo('{"jsonrpc" : "2.0", "error" : {"code": 101, "message": "Failed to open input stream."}, "id" : "id"}');
					eZExecution::cleanExit();
				}
				fclose($out);
				unlink($_FILES['file']['tmp_name']);
			} else {
				echo('{"jsonrpc" : "2.0", "error" : {"code": 102, "message": "Failed to open output stream."}, "id" : "id"}');
				eZExecution::cleanExit();
			}
		} else {
			echo('{"jsonrpc" : "2.0", "error" : {"code": 103, "message": "Failed to move uploaded file."}, "id" : "id"}');
			eZExecution::cleanExit();
		}
	} else {
		// Open temp file
		$out = fopen($targetDir . DIRECTORY_SEPARATOR . $fileName, $chunk == 0 ? "wb" : "ab");
		if ($out) {
			// Read binary input stream and append it to temp file
			$in = fopen("php://input", "rb");

			if ($in) {
				while ($buff = fread($in, 4096))
					fwrite($out, $buff);
			} else {
				echo('{"jsonrpc" : "2.0", "error" : {"code": 101, "message": "Failed to open input stream."}, "id" : "id"}');
				eZExecution::cleanExit();

			}
			fclose($out);
		} else {
			echo('{"jsonrpc" : "2.0", "error" : {"code": 102, "message": "Failed to open output stream."}, "id" : "id"}');
			eZExecution::cleanExit();
		}
	}

	if ( $chunk == ($chunks - 1) AND count($result['errors']) == 0) { //last chunk of a file - handle upload

		//This is where we would have to put some sort of upload handler based on file type

		$upload = new eZContentUpload();
		if ( $_FILES['file']['name'] ) {
			$return = $upload->handleLocalFile( $result, $targetDir . DIRECTORY_SEPARATOR . $fileName, $parentNodeID,"", $_FILES['file']['name'] ); 
		} else {
			$return = $upload->handleLocalFile( $result, $targetDir . DIRECTORY_SEPARATOR . $fileName, $parentNodeID ); 
		}
		if ($return === FALSE) {
			foreach($result['errors'] as $error_string) {
				echo('{"jsonrpc" : "2.0", "error" : {"code": 102, "message": "'.$error_string['description'].'"}, "id" : "id"}');
			}
		} else { //Must be a chunk with no errors
			echo('{"jsonrpc" : "2.0", "result" : null, "id" : "id"}');
		}
		@unlink($targetDir . DIRECTORY_SEPARATOR . $fileName);
	} else {
		// Return JSON-RPC response
		echo('{"jsonrpc" : "2.0", "result" : null, "id" : "id"}');
	}
	eZExecution::cleanExit();
?>
