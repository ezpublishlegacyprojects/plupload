{def $current_node=fetch(content, node, hash( node_id, $module_result.node_id ))
     $current_object=fetch( 'content', 'object', hash( 'object_id', $current_node.contentobject_id ) )
}

{if and(eq($current_object.content_class.is_container,1),$current_object.can_create)}
	<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr">{if $first}<div class="box-tl"><div class="box-tr">{/if}
		<h4>Multiple file upload</h4>
	</div></div></div></div>{if $first}</div></div>{/if}
	
	{if $last}
		<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-bl"><div class="box-br"><div class="box-content">
	{else}
		<div class="box-ml"><div class="box-mr"><div class="box-content">
	{/if}
	<a href={concat("/plupload/widget/",$current_node.node_id)|ezurl}><img src={'plupload_upload.gif'|ezimage} alt="{'plupload Upload'|i18n('plupload')}" /></a>
	</div></div></div>{if $last}</div></div></div>{/if}
{/if}
