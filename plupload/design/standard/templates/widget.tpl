{def $availableRuntimes = ezini( "pluploadSettings", "availableRuntimes", 'plupload.ini' )
     $unique_names = ezini( 'default', 'unique_names' ,'plupload.ini' )
     $max_file_size = ezini( 'default', 'max_file_size' ,'plupload.ini' )
     $chunk_size = ezini( 'default', 'chunk_size' ,'plupload.ini' )
     $filters = ezini( "default", 'filters' ,'plupload.ini' )
     $resize = ezini( "default", 'resize' ,'plupload.ini' )
}
{*this will make it only what is set first -remove this for multiple runtimes*}
{if ne(ezini( "pluploadSettings", "multipleRuntimes", 'plupload.ini' ),"enabled")}
	{set $availableRuntimes = $availableRuntimes[0]}
{/if}

{*setup just the javascript files we need - I don't know if this is better cache-wise*}
{foreach ezini( "default", "JavaScriptList", 'plupload.ini' ) as $javafile}
	<script language="JavaScript" type="text/javascript" src={concat( 'javascript/',$javafile )|ezdesign}></script>

{/foreach}
{foreach $availableRuntimes as $runtime}
	{foreach ezini( $runtime, "JavaScriptList", 'plupload.ini' ) as $javafile}
		<script language="JavaScript" type="text/javascript" src={concat( 'javascript/',$javafile )|ezdesign}></script>
	{/foreach}
{/foreach}

<script>
$(function() {ldelim}
{if $availableRuntimes|contains( "flash" )}
{set	$max_file_size = cond(ezini_hasvariable( 'flash', 'max_file_size' ,'plupload.ini' ),
                              ezini( 'flash', 'max_file_size' ,'plupload.ini' ), true(), $max_file_size )
	$chunk_size = cond(ezini_hasvariable( 'flash', 'chunk_size' ,'plupload.ini' ),
                           ezini( 'flash', 'chunk_size' ,'plupload.ini' ),true(), $chunk_size )
	$filters = cond(ezini_hasvariable( 'flash', 'filters' ,'plupload.ini' ),
                        ezini( 'flash', 'filters' ,'plupload.ini' ), true(), $filters )
	$resize = cond(ezini_hasvariable( 'flash', 'resize' ,'plupload.ini' ),
                       ezini( 'flash', 'resize' ,'plupload.ini' ), true(), $resize )
}
// runtimes : 'gears,html5,flash,silverlight,browserplus',
	$("#flash_uploader").pluploadQueue({ldelim}
		// General settings
		runtimes : 'flash',
		//multipart : 'true',
		//multipart_params : {ldelim} I_could_pass_post_variables_here : "But_then_Safari_would_not_work" {rdelim},
		url : {concat('plupload/upload/',$parentNodeID)|ezroot(single)},
		max_file_size : '{$max_file_size}',
		chunk_size : '{$chunk_size}',
		unique_names : {$unique_names},

		filters : [
	{foreach $filters as $type => $extensions}
		{ldelim}title : "{$type}", extensions : "{$extensions}"{rdelim}{delimiter},{/delimiter}
	{/foreach}
		],
		
	{if and(is_set($resize['width']),is_set($resize['height']),is_set($resize['quality']))}
		// Resize images on clientside if we can  This for some reason is not working
		resize : {ldelim}width : {$resize['width']}, resize: {$resize['height']}, quality : {$resize['quality']}{rdelim},
	{/if}
		// Flash settings
		flash_swf_url : {"flash/plupload.flash.swf"|ezdesign(single)}
	{rdelim});

{/if} {*flash*}

{if $availableRuntimes|contains( "gears" )}
	{set	$max_file_size = cond(ezini_hasvariable( 'gears', 'max_file_size' ,'plupload.ini' ),
				ezini( 'gears', 'max_file_size' ,'plupload.ini' ), true(), $max_file_size )
		$chunk_size = cond(ezini_hasvariable( 'flash', 'chunk_size' ,'plupload.ini' ),
				ezini( 'gears', 'chunk_size' ,'plupload.ini' ),true(), $chunk_size )
		$filters = cond(ezini_hasvariable( 'flash', 'filters' ,'plupload.ini' ),
				ezini( 'gears', 'filters' ,'plupload.ini' ), true(), $filters )
		$resize = cond(ezini_hasvariable( 'flash', 'resize' ,'plupload.ini' ),
			ezini( 'gears', 'resize' ,'plupload.ini' ), true(), $resize )
	}
	// Setup gears version
	$("#gears_uploader").pluploadQueue({ldelim}
		// General settings
		runtimes : 'gears',
		url : {'plupload/upload'|ezroot(single)},
		max_file_size : '{$max_file_size}',
		chunk_size : '{$chunk_size}',
		unique_names : {$unique_names},
		filters : [
	{foreach $filters as $type => $extensions}
		{ldelim}title : "{$type}", extensions : "{$extensions}"{rdelim}{delimiter},{/delimiter}
	{/foreach}
		],
	{if and(is_set($resize['width']),is_set($resize['height']),is_set($resize['quality']))}
		// Resize images on clientside if we can
		resize : {ldelim}width : "{$resize['width']}", resize: "{$resize['height']}", quality : "{$resize['quality']}"{rdelim}
	{/if}

	{rdelim});
{/if} {*gears*}

{if $availableRuntimes|contains( "silverlight" )}
	{set	$max_file_size = cond(ezini_hasvariable( 'silverlight', 'max_file_size' ,'plupload.ini' ),
				ezini( 'silverlight', 'max_file_size' ,'plupload.ini' ), true(), $max_file_size )
		$chunk_size = cond(ezini_hasvariable( 'flash', 'chunk_size' ,'plupload.ini' ),
				ezini( 'silverlight', 'chunk_size' ,'plupload.ini' ),true(), $chunk_size )
		$filters = cond(ezini_hasvariable( 'flash', 'filters' ,'plupload.ini' ),
				ezini( 'silverlight', 'filters' ,'plupload.ini' ), true(), $filters )
		$resize = cond(ezini_hasvariable( 'flash', 'resize' ,'plupload.ini' ),
			ezini( 'silverlight', 'resize' ,'plupload.ini' ), true(), $resize )
	}

	// Setup silverlight version
	$("#silverlight_uploader").pluploadQueue({ldelim}
		// General settings
		runtimes : 'silverlight',
		url : {'plupload/upload'|ezroot(single)},
		max_file_size : '{$max_file_size}',
		chunk_size : '{$chunk_size}',
		unique_names : {$unique_names},
		filters : [
	{foreach $filters as $type => $extensions}
		{ldelim}title : "{$type}", extensions : "{$extensions}"{rdelim}{delimiter},{/delimiter}
	{/foreach}
		],

	{if and(is_set($resize['width']),is_set($resize['height']),is_set($resize['quality']))}
		// Resize images on clientside if we can
		resize : {ldelim}width : "{$resize['width']}", resize: "{$resize['height']}", quality : "{$resize['quality']}"{rdelim},
	{/if}
		// Silverlight settings
		silverlight_xap_url : {"javascript/plupload.silverlight.xap"|ezdesign(single)}
	{rdelim});
{/if} {*silverlight*}

{if $availableRuntimes|contains( "html5" )}
	{set	$max_file_size = cond(ezini_hasvariable( 'html5', 'max_file_size' ,'plupload.ini' ),
				ezini( 'html5', 'max_file_size' ,'plupload.ini' ), true(), $max_file_size )
		$chunk_size = cond(ezini_hasvariable( 'flash', 'chunk_size' ,'plupload.ini' ),
				ezini( 'html5', 'chunk_size' ,'plupload.ini' ),true(), $chunk_size )
		$filters = cond(ezini_hasvariable( 'flash', 'filters' ,'plupload.ini' ),
				ezini( 'html5', 'filters' ,'plupload.ini' ), true(), $filters )
		$resize = cond(ezini_hasvariable( 'flash', 'resize' ,'plupload.ini' ),
			ezini( 'html5', 'resize' ,'plupload.ini' ), true(), $resize )
	}

	// Setup html5 version
	$("#html5_uploader").pluploadQueue({ldelim}
		// General settings
		runtimes : 'html5',
		url : {'plupload/upload'|ezroot(single)},
		max_file_size : '{$max_file_size}',
		chunk_size : '{$chunk_size}',
		unique_names : {$unique_names},
		filters : [
	{foreach $filters as $type => $extensions}
		{ldelim}title : "{$type}", extensions : "{$extensions}"{rdelim}{delimiter},{/delimiter}
	{/foreach}
		],

	{if and(is_set($resize['width']),is_set($resize['height']),is_set($resize['quality']))}
		// Resize images on clientside if we can
		resize : {ldelim}width : "{$resize['width']}", resize: "{$resize['height']}", quality : "{$resize['quality']}"{rdelim}
	{/if}

	{rdelim});
{/if} {*html5*}

{if $availableRuntimes|contains( "browserplus" )}
	{set	$max_file_size = cond(ezini_hasvariable( 'browserplus', 'max_file_size' ,'plupload.ini' ),
				ezini( 'browserplus', 'max_file_size' ,'plupload.ini' ), true(), $max_file_size )
		$chunk_size = cond(ezini_hasvariable( 'flash', 'chunk_size' ,'plupload.ini' ),
				ezini( 'browserplus', 'chunk_size' ,'plupload.ini' ),true(), $chunk_size )
		$filters = cond(ezini_hasvariable( 'flash', 'filters' ,'plupload.ini' ),
				ezini( 'browserplus', 'filters' ,'plupload.ini' ), true(), $filters )
		$resize = cond(ezini_hasvariable( 'flash', 'resize' ,'plupload.ini' ),
			ezini( 'browserplus', 'resize' ,'plupload.ini' ), true(), $resize )
	}

	// Setup browserplus version
	$("#browserplus_uploader").pluploadQueue({ldelim}
		// General settings
		runtimes : 'browserplus',
		url : {'plupload/upload'|ezroot(single)},
		max_file_size : '{$max_file_size}',
		chunk_size : '{$chunk_size}',
		unique_names : {$unique_names},
		filters : [
	{foreach $filters as $type => $extensions}
		{ldelim}title : "{$type}", extensions : "{$extensions}"{rdelim}{delimiter},{/delimiter}
	{/foreach}
		],

	{if and(is_set($resize['width']),is_set($resize['height']),is_set($resize['quality']))}
		// Resize images on clientside if we can
		resize : {ldelim}width : "{$resize['width']}", resize: "{$resize['height']}", quality : "{$resize['quality']}"{rdelim}
	{/if}
	
	{rdelim});
{/if} {*browserplus*}

{if $availableRuntimes|contains( "html4" )}
	{set	$max_file_size = cond(ezini_hasvariable( 'html4', 'max_file_size' ,'plupload.ini' ),
				ezini( 'html4', 'max_file_size' ,'plupload.ini' ), true(), $max_file_size )
		$chunk_size = cond(ezini_hasvariable( 'flash', 'chunk_size' ,'plupload.ini' ),
				ezini( 'html4', 'chunk_size' ,'plupload.ini' ),true(), $chunk_size )
		$filters = cond(ezini_hasvariable( 'flash', 'filters' ,'plupload.ini' ),
				ezini( 'html4', 'filters' ,'plupload.ini' ), true(), $filters )
		$resize = cond(ezini_hasvariable( 'flash', 'resize' ,'plupload.ini' ),
			ezini( 'html4', 'resize' ,'plupload.ini' ), true(), $resize )
	}

	// Setup html4 version
	$("#html4_uploader").pluploadQueue({ldelim}
		// General settings
		runtimes : 'html4',
		url : {'plupload/upload'|ezroot(single)},
		//no chunking possible
		unique_names : {$unique_names},
		filters : [
	{foreach $filters as $type => $extensions}
		{ldelim}title : "{$type}", extensions : "{$extensions}"{rdelim}{delimiter},{/delimiter}
	{/foreach}
		],
	//no resize possible
	{rdelim});
{/if} {*html4*}
{rdelim});

</script>

<form method="post" action={"plupload/upload"|ezurl}>
	<input type="hidden" value={$node.node_id} name="ParentNodeID" >
	{if $availableRuntimes|contains( "flash" )}
		<h3>Flash runtime</h3>
		<div id="flash_uploader" style="width: 450px; height: 330px;">You browser doesn't have Flash installed.</div>
	{/if}
	{if $availableRuntimes|contains( "gears" )}
		<h3>Gears runtime</h3>
		<div id="gears_uploader" style="width: 450px; height: 330px;">You browser doesn't have Gears installed.</div>
	{/if}
	{if $availableRuntimes|contains( "silverlight" )}
		<h3>Silverlight runtime</h3>
		<div id="silverlight_uploader" style="width: 450px; height: 330px;">You browser doesn't have Silverlight installed.</div>
	{/if}
	{if $availableRuntimes|contains( "html5" )}
		<h3>HTML 5 runtime</h3>
		<div id="html5_uploader" style="width: 450px; height: 330px;">You browser doesn't support native upload. Try Firefox 3 or Safari 4.</div>
	{/if}
	{if $availableRuntimes|contains( "browserplus" )}
		<h3>BrowserPlus runtime</h3>
		<div id="browserplus_uploader" style="width: 450px; height: 330px;">You browser doesn't have BrowserPlus installed.</div>
	{/if}
	{if $availableRuntimes|contains( "html4" )}
		<h3>HTML 4 runtime</h3>
		<div id="html4_uploader" style="width: 450px; height: 330px;">You browser doesn't have HTML 4 support.</div>
	{/if}
</form>
<form>
	<input type="submit" value="Reload" onSubmit="javascript:reload();" />
</form>