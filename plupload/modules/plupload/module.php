<?php
/**
 * @copyright Copyright (C) 2005-2010 Contactivity BV
 * @license http://ez.no/licenses/gnu_gpl GNU GPL v2
 * @version 0.1
 * @package plupload
 */

$Module = array( 'name' => 'plupload', 'variable_params' => true );

$ViewList = array();
$ViewList['upload'] = array( 'script' => 'upload.php',
                             'params' => array( 'ParentNodeID' )
    );
$ViewList['widget'] = array( 'script' => 'widget.php',
                             'params' => array( 'ParentNodeID' )
    );

?>
