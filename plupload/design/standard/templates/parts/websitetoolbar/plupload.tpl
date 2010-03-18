  {if and( $content_object.can_create, $is_container))}
    <a href={concat("/plupload/widget/",$current_node.node_id)|ezurl} title="{'plupload'|i18n('extension/plupload')}"><img src={"ezwt-icon-plupload.gif"|ezimage} alt="{'Plupload'|i18n('extension/plupload')}" /></a>
  {/if}