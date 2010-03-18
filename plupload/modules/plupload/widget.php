<?
/**
 * @copyright Copyright (C) 2005-2010 Contactivity BV
 * @license http://ez.no/licenses/gnu_gpl GNU GPL v2
 * @version 0.1
 * @package plupload
 */

include_once( 'autoload.php' );
include_once( 'kernel/common/template.php' );

$Module         = $Params['Module'];
$ModuleINI = eZINI::instance( 'module.ini' );
$parentNodeID = $Params['ParentNodeID'];
$ini = eZINI::instance();
$tpl = templateInit();

$http = eZHTTPTool::instance();
   //Should check and only display the widget if the user has write permissions to the destination
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

$tpl = templateInit();
$tpl->setVariable( 'parentNodeID', $parentNodeID);

$Result['content'] = $tpl->fetch( 'design:widget.tpl' );

//if standalone then do pagelayout = false maybe
$Result['path'] = array( array( 'url' => '/',
'text' => ezi18n( 'design/plupload', 'Home' ) ),
array( 'url' => false, 'text' => 'plupload' ),
array( 'url' => false, 'text' => 'widget' ) ); 

?>
