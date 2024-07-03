<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="codes.GlobalFunctions" %>
<%@ page import="static codes.nwpComments.get_comments" %>
<%@ page import="static codes.GlobalFunctions.get_project_data" %>
<%@ page import="static codes.GlobalFunctions.get_record_name" %>
<div nwp-file="<%out.print( request.getAttribute("filename") );%>" class="hyella-source-container">
<div id="comments-view-details">
    <style>
        a#view-more {
            margin: 0px auto 0px;
        }
        li.out.b {
            display: flex;
        }
        .rply {
            margin: 0px auto 0px;
        }
    </style>
    <%
        JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );
        JSONObject jpet = new JSONObject( request.getAttribute("nwp_pdata").toString() );
        Boolean use_id = ( jget.has("todo") && jget.getString("todo").equals("use_id") )?true:false;


        //JSONObject $data = new JSONObject("{\"action_to_perform\":\"view_details_by_reference\",\"other_params\":{\"parent\":[],\"tablex\":\"workflow\",\"id\":\"ww27160171060\"},\"reference\":\"\",\"view\":1,\"table\":\"comments\",\"labels\":{\"comments2484\":{\"table_name\":\"comments\",\"serial_number\":\"10\",\"field_type\":\"undefined\",\"filed_length\":\"undefined\",\"field_label\":\"Date\",\"display_field_label\":\"Date\",\"form_field\":\"date-5time\",\"form_field_options\":\"\",\"required_field\":\"yes\",\"data\":\"\",\"database_objects\":\"\",\"attributes\":\"\",\"class\":\"\",\"default_appearance_in_table_fields\":\"show\",\"display_position\":\"display-in-table-row\",\"acceptable_files_format\":\"\",\"field_id\":\"comments2484\",\"group\":\"\",\"id\":\"comments2484\",\"serial_num\":\"6131\",\"created_by\":\"35991362173\",\"modification_date\":\"1627912330\",\"creation_date\":\"1627912330\",\"modified_by\":\"35991362173\",\"text\":\"Date\",\"field_key\":\"comments2484\",\"table\":\"comments\",\"field_identifier\":\"date\"},\"comments2485\":{\"table_name\":\"comments\",\"serial_number\":\"20\",\"field_type\":\"undefined\",\"filed_length\":\"undefined\",\"field_label\":\"Title\",\"display_field_label\":\"Title\",\"form_field\":\"text\",\"form_field_options\":\"\",\"required_field\":\"yes\",\"data\":\"\",\"database_objects\":\"\",\"attributes\":\"\",\"class\":\"\",\"default_appearance_in_table_fields\":\"show\",\"display_position\":\"display-in-table-row\",\"acceptable_files_format\":\"\",\"field_id\":\"comments2485\",\"group\":\"\",\"id\":\"comments2485\",\"serial_num\":\"6132\",\"created_by\":\"35991362173\",\"modification_date\":\"1627912330\",\"creation_date\":\"1627912330\",\"modified_by\":\"35991362173\",\"text\":\"Title\",\"field_key\":\"comments2485\",\"table\":\"comments\",\"field_identifier\":\"title\"},\"comments2486\":{\"table_name\":\"comments\",\"serial_number\":\"30\",\"field_type\":\"undefined\",\"filed_length\":\"undefined\",\"field_label\":\"Message\",\"display_field_label\":\"Message\",\"form_field\":\"textarea\",\"form_field_options\":\"\",\"required_field\":\"yes\",\"data\":\"\",\"database_objects\":\"\",\"attributes\":\"\",\"class\":\"\",\"default_appearance_in_table_fields\":\"show\",\"display_position\":\"display-in-table-row\",\"acceptable_files_format\":\"\",\"field_id\":\"comments2486\",\"group\":\"\",\"id\":\"comments2486\",\"serial_num\":\"6133\",\"created_by\":\"35991362173\",\"modification_date\":\"1627912330\",\"creation_date\":\"1627912330\",\"modified_by\":\"35991362173\",\"text\":\"Message\",\"field_key\":\"comments2486\",\"table\":\"comments\",\"field_identifier\":\"message\"},\"comments2487\":{\"table_name\":\"comments\",\"serial_number\":\"40\",\"field_type\":\"undefined\",\"filed_length\":\"undefined\",\"field_label\":\"Type\",\"display_field_label\":\"Type\",\"form_field\":\"select\",\"form_field_options\":\"get_comment_type\",\"required_field\":\"yes\",\"data\":\"\",\"database_objects\":\"\",\"attributes\":\"\",\"class\":\"\",\"default_appearance_in_table_fields\":\"hide\",\"display_position\":\"display-in-table-row\",\"acceptable_files_format\":\"\",\"field_id\":\"comments2487\",\"group\":\"\",\"id\":\"comments2487\",\"serial_num\":\"6134\",\"created_by\":\"35991362173\",\"modification_date\":\"1627912330\",\"creation_date\":\"1627912330\",\"modified_by\":\"35991362173\",\"text\":\"Type\",\"field_key\":\"comments2487\",\"table\":\"comments\",\"field_identifier\":\"type\"},\"comments2488\":{\"table_name\":\"comments\",\"serial_number\":\"50\",\"field_type\":\"undefined\",\"filed_length\":\"undefined\",\"field_label\":\"Reference\",\"display_field_label\":\"Reference\",\"form_field\":\"text\",\"form_field_options\":\"\",\"required_field\":\"no\",\"data\":\"\",\"database_objects\":\"\",\"attributes\":\"\",\"class\":\"\",\"default_appearance_in_table_fields\":\"hide\",\"display_position\":\"display-in-table-row\",\"acceptable_files_format\":\"\",\"field_id\":\"comments2488\",\"group\":\"\",\"id\":\"comments2488\",\"serial_num\":\"6135\",\"created_by\":\"35991362173\",\"modification_date\":\"1627912330\",\"creation_date\":\"1627912330\",\"modified_by\":\"35991362173\",\"text\":\"Reference\",\"field_key\":\"comments2488\",\"table\":\"comments\",\"field_identifier\":\"reference\"},\"comments2489\":{\"table_name\":\"comments\",\"serial_number\":\"60\",\"field_type\":\"undefined\",\"filed_length\":\"undefined\",\"field_label\":\"Reference Table\",\"display_field_label\":\"Reference Table\",\"form_field\":\"text\",\"form_field_options\":\"\",\"required_field\":\"no\",\"data\":\"\",\"database_objects\":\"\",\"attributes\":\"\",\"class\":\"\",\"default_appearance_in_table_fields\":\"hide\",\"display_position\":\"display-in-table-row\",\"acceptable_files_format\":\"\",\"field_id\":\"comments2489\",\"group\":\"\",\"id\":\"comments2489\",\"serial_num\":\"6136\",\"created_by\":\"35991362173\",\"modification_date\":\"1627912330\",\"creation_date\":\"1627912330\",\"modified_by\":\"35991362173\",\"text\":\"Reference Table\",\"field_key\":\"comments2489\",\"table\":\"comments\",\"field_identifier\":\"reference_table\"},\"comments6130\":{\"table_name\":\"comments\",\"serial_number\":\"70\",\"field_type\":\"undefined\",\"filed_length\":\"undefined\",\"field_label\":\"Plugin\",\"display_field_label\":\"Plugin\",\"form_field\":\"text\",\"form_field_options\":\"\",\"required_field\":\"no\",\"data\":[],\"database_objects\":\"\",\"attributes\":\"\",\"class\":\"\",\"default_appearance_in_table_fields\":\"hide\",\"display_position\":\"display-in-table-row\",\"acceptable_files_format\":\"\",\"field_id\":\"comments6130\",\"group\":\"\",\"id\":\"comments6130\",\"serial_num\":\"6137\",\"created_by\":\"35991362173a\",\"modification_date\":\"1627912330\",\"creation_date\":\"1627912330\",\"modified_by\":\"35991362173a\",\"text\":\"Plugin\",\"field_key\":\"comments6130\",\"table\":\"comments\",\"field_identifier\":\"plugin\"},\"comments6138\":{\"table_name\":\"comments\",\"serial_number\":\"80\",\"field_type\":\"undefined\",\"filed_length\":\"undefined\",\"field_label\":\"Status\",\"display_field_label\":\"Status\",\"form_field\":\"select\",\"form_field_options\":\"get_comment_status\",\"required_field\":\"no\",\"data\":[],\"database_objects\":\"\",\"attributes\":\"\",\"class\":\"\",\"default_appearance_in_table_fields\":\"hide\",\"display_position\":\"display-in-table-row\",\"acceptable_files_format\":\"\",\"field_id\":\"comments6138\",\"group\":\"\",\"id\":\"dds27091417242\",\"serial_num\":\"6138\",\"created_by\":\"35991362173a\",\"modification_date\":\"1627912473\",\"creation_date\":\"1627912473\",\"modified_by\":\"35991362173a\",\"text\":\"Status\",\"field_key\":\"comments6138\",\"table\":\"comments\",\"field_identifier\":\"status\"},\"comments6139\":{\"table_name\":\"comments\",\"serial_number\":\"84\",\"field_type\":\"undefined\",\"filed_length\":\"undefined\",\"field_label\":\"Status 2\",\"display_field_label\":\"Status 2\",\"form_field\":\"select\",\"form_field_options\":\"get_comment_status2\",\"required_field\":\"no\",\"data\":[],\"database_objects\":\"\",\"attributes\":\"\",\"class\":\"\",\"default_appearance_in_table_fields\":\"hide\",\"display_position\":\"display-in-table-row\",\"acceptable_files_format\":\"\",\"field_id\":\"comments6139\",\"group\":\"\",\"id\":\"dds27091418830\",\"serial_num\":\"6139\",\"created_by\":\"35991362173a\",\"modification_date\":\"1627912489\",\"creation_date\":\"1627912489\",\"modified_by\":\"35991362173a\",\"text\":\"Status 2\",\"field_key\":\"comments6139\",\"table\":\"comments\",\"field_identifier\":\"status2\"},\"comments6140\":{\"table_name\":\"comments\",\"serial_number\":\"90\",\"field_type\":\"undefined\",\"filed_length\":\"undefined\",\"field_label\":\"Child Reference\",\"display_field_label\":\"Child Reference\",\"form_field\":\"text\",\"form_field_options\":\"\",\"required_field\":\"no\",\"data\":[],\"database_objects\":\"\",\"attributes\":\"\",\"class\":\"\",\"default_appearance_in_table_fields\":\"hide\",\"display_position\":\"display-in-table-row\",\"acceptable_files_format\":\"\",\"field_id\":\"comments6140\",\"group\":\"\",\"id\":\"dds27091422639\",\"serial_num\":\"6140\",\"created_by\":\"35991362173a\",\"modification_date\":\"1627912527\",\"creation_date\":\"1627912527\",\"modified_by\":\"35991362173a\",\"text\":\"Child Reference\",\"field_key\":\"comments6140\",\"table\":\"comments\",\"field_identifier\":\"child_reference\"},\"comments6141\":{\"table_name\":\"comments\",\"serial_number\":\"93\",\"field_type\":\"undefined\",\"filed_length\":\"undefined\",\"field_label\":\"Child Reference Table\",\"display_field_label\":\"Child Reference Table\",\"form_field\":\"text\",\"form_field_options\":\"\",\"required_field\":\"no\",\"data\":[],\"database_objects\":\"\",\"attributes\":\"\",\"class\":\"\",\"default_appearance_in_table_fields\":\"hide\",\"display_position\":\"display-in-table-row\",\"acceptable_files_format\":\"\",\"field_id\":\"comments6141\",\"group\":\"\",\"id\":\"dds27091424034\",\"serial_num\":\"6141\",\"created_by\":\"35991362173a\",\"modification_date\":\"1627912541\",\"creation_date\":\"1627912541\",\"modified_by\":\"35991362173a\",\"text\":\"Child Reference Table\",\"field_key\":\"comments6141\",\"table\":\"comments\",\"field_identifier\":\"child_reference_table\"},\"comments6142\":{\"table_name\":\"comments\",\"serial_number\":\"100\",\"field_type\":\"undefined\",\"filed_length\":\"undefined\",\"field_label\":\"Data\",\"display_field_label\":\"Data\",\"form_field\":\"textarea-unlimited\",\"form_field_options\":\"\",\"required_field\":\"no\",\"data\":[],\"database_objects\":\"\",\"attributes\":\"\",\"class\":\"\",\"default_appearance_in_table_fields\":\"hide\",\"display_position\":\"do-not-display-in-table\",\"acceptable_files_format\":\"\",\"field_id\":\"comments6142\",\"group\":\"\",\"id\":\"dds27091425467\",\"serial_num\":\"6142\",\"created_by\":\"35991362173a\",\"modification_date\":\"1627912555\",\"creation_date\":\"1627912555\",\"modified_by\":\"35991362173a\",\"text\":\"Data\",\"field_key\":\"comments6142\",\"table\":\"comments\",\"field_identifier\":\"data\"}},\"fields\":{\"date\":\"comments2484\",\"title\":\"comments2485\",\"message\":\"comments2486\",\"type\":\"comments2487\",\"reference\":\"comments2488\",\"reference_table\":\"comments2489\",\"plugin\":\"comments6130\",\"status\":\"comments6138\",\"status2\":\"comments6139\",\"child_reference\":\"comments6140\",\"child_reference_table\":\"comments6141\",\"data\":\"comments6142\"},\"items\":{\"ww27160171060\":null},\"development\":1}");
        JSONObject $data = get_comments( jget );
        //System.out.println($data);

        JSONObject $fields = $data.has("fields" ) ? $data.getJSONObject("fields") :new JSONObject();
        JSONObject $labels = $data.has("labels" ) ? $data.getJSONObject("labels") :new JSONObject();
        String $table = ($data.has("tablex") ) ? $data.getString("tablex") : "";
        Integer $limit = $data.has("limit") ? $data.getInt("limit") : 0;
        String $html_replacement_selector = "inventories-asset-center-sub";

        if( ! use_id ){
            GlobalFunctions.app_popup = true;
            GlobalFunctions.app_popup_title = "View Comments";
        }


// out.print( '<pre>'; print_r( $table ); out.print( '</pre>';
        if( $data.has("parent") && $data.getJSONArray("parent").length() > 0 ){
            JSONObject $pr = get_project_data();
            String $site_url2 = $pr.has("domain_name" )?$pr.getString("domain_name") : "";

            JSONArray $op_parent = $data.getJSONArray("parent");
            JSONArray $op_children = $data.getJSONArray("children");
            String $ref = $op_parent.getJSONObject(0).has("reference") ? $op_parent.getJSONObject(0).getString("reference") : "";
            String $ref_table = $op_parent.getJSONObject(0).has("reference_table") ? $op_parent.getJSONObject(0).getString("reference_table") : "";

            JSONObject $child = new JSONObject();
            if( $op_children.length() > 0 ){
                for(int i = 0; i < $op_children.length(); i++ ){
//                    String $chk = $op_children.getString(i);
                    JSONObject $ch = $op_children.getJSONObject(i);

                    if( ! $child.has( $ch.getString("reference") ) ){
                        $child.put($ch.getString("reference"), new JSONArray() );
                    }
                    $child.put( $ch.getString("reference"),  $child.getJSONArray($ch.getString("reference") ).put( $ch ) );
                }
            }

        if( $table.equals("workflow") ){
        }else {

            for( int i = 0; i < $op_parent.length(); i++ ){
                JSONObject $pval = $op_parent.getJSONObject(i);
    %>
    <div class="portlet"><%
        String $head = "";
        String $h = "";
        if( $table.equals("comments") ){
            if( $ref_table.equals("ecm2") ) {
            }else if ($ref_table.equals("workflow")) {
                $h = "<div class=\"portlet-title line\">\n" +
                        "                <div class=\"caption\"><i class=\"icon-comments\"></i></div>\n" +
                        "                <div class=\"tools\">\n" +
                        "                <a href=\"\" class=\"collapse\"></a>\n" +
                        "                <a href=\"#portlet-config\" data-toggle=\"modal\" class=\"config\"></a>\n" +
                        "                <a href=\"\" class=\"reload custom-single-selected-record-button\" override-selected-record=\"" + $ref + "\" action=\"?action=display_sub_menu&nwp2_action=comments&nwp2_todo=view_details_by_reference&todo=&table=" + $table + "&html_replacement_selector=latest-comments-container&modal=1\"></a>\n" +
                        "                <a href=\"\" class=\"remove\"></a>\n" +
                        "                </div>\n" +
                        "                </div>";
            }else{
                if( !$ref.isEmpty() ){
                    $head += "<a href=\"#\" class=\"btn btn-default custom-single-selected-record-button\" override-selected-record=\""+ $ref +"\" action=\"?module=&action=display_sub_menu&nwp2_action="+ $ref_table +"&todo=&nwp2_todo=view_details& html_replacement_selector="+ $html_replacement_selector +"\" title=\"View Details\">Preview</a>";
                    $head += "<br /><br />";
                }
            }
        }
        out.print( $head );
        out.print( $h );
    %>
        <div class="portlet-body" id="chats">
            <div class="scroller" style="height: auto;" data-always-visible="1" data-rail-visible1="1">
                <ul class="chats">
                    <div style="display:block;">
                        <li class="in">
                            <%
                                //  $user = get_name_of_referenced_record( array( "id" => $pval["created_by"], "table" => 'users', 'return_data' => 1 ) );
                                String $user = get_record_name( new JSONObject().put("id", $pval.getString("created_by") ).put("table", "users" ) );
                            %>
                            <%--<img class="avatar img-responsive" alt="" src="<% out.print( ( isset( $user[ 'photograph' ] ) && $user[ 'photograph' ] ) ? ( $site_url2 . $user[ 'photograph' ] ) : 'a-assets/images/avatars/1.jpg'; %>" />--%>
                            <img class="avatar img-responsive" alt="" src="<% out.print( "a-assets/images/avatars/1.jpg" ); %>" />
                            <div class="message">
                                <span class="arrow"></span>
                                <%--                                <span class="name" style="font-weight:bold;"><% if( isset( $user["name"] ) )out.print( $user["name"]; %></span>--%>
                                <span class="name" style="font-weight:bold;"><% out.print( $user ); %></span>
                                <%--                                <span class="datetime" style="font-style:italic;">@ <% out.print( date("d  M Y : h:ia" , $pval[ 'creation_date' ] ); %></span>--%>
                                <span class="datetime" style="font-style:italic;">@ <% out.print( GlobalFunctions.convert_timestamp_to_date( $pval.getString("creation_date"), "date-5time", 0 ) ); %></span>
                                <span class="body"><big>
<%--									<% out.print( __get_value( $pval[ 'message' ], 'message' ); %>--%>
									<% out.print( $pval.getString("message").replace("\n", "<br />") ); %>
								 </big></span>
                            </div>
                        </li>
                        <div class="rply" style="text-align:center;">
                            <a href="#" class="btn blue btn-xs custom-single-selected-record-button" override-selected-record="<% out.print( $pval.getString("id") ); %>" action="?action=display_sub_menu&nwp2_action=comments&todo=&nwp2_todo=reply_comment&html_replacement_selector=reply-comment-<% out.print( $pval.getString("id") ); %>&callback=commentView.replyComment&ctitle=<% out.print( GlobalFunctions.rawurlencode( "RE: " + $pval.getString("title") ) ); %>" ><i class="icon-reply"></i> reply</a>
                        </div>
                    </div>
                    <li class="in" style="display:none;">
                        <div id="reply-comment-<% out.print( $pval.getString("id") ); %>">
                        </div>
                    </li>
                    <div class="replies replies-<% out.print( $pval.getString("id") ); %>" id="<% out.print( $pval.getString("id") ); %>">

                        <%
                            if( $child.has($pval.getString("id")) && $child.getJSONArray($pval.getString("id")).length() > 0 ){
                                for(  int i2 = 0; i2 < $child.getJSONArray($pval.getString("id")).length(); i2++ ){
                                    //String $value_key = $child.getJSONObject($pval.getString("id")).names().getString(i2);
                                    JSONObject $value = $child.getJSONArray($pval.getString("id")).getJSONObject( i2 );

                                    String $user2 = get_record_name( new JSONObject().put("id", $value.getString("created_by") ).put("table", "users" ) );

                        %>
                        <li class="out">
                            <img class="avatar img-responsive" alt="" src="<% out.print( "a-assets/images/avatars/2.jpg" ); %>" />
                            <!--<img class="avatar img-responsive" alt="" src="<% out.print(  !$user2.isEmpty() ? ( $site_url2 + "user2" ) : "a-assets/images/avatars/2.jpg" ); %>" />-->
                            <div class="message">
                                <span class="arrow"></span>
                                <a href="#" class="name"><% out.print( $user2 ); %></a>
                                <span class="datetime">at <% out.print(  GlobalFunctions.convert_timestamp_to_date( $value.getString("creation_date"), "date-5time", 0 ) ); %></span>
                                <span class="body">
<%--										 <% out.print( __get_value( $value[ 'message' ], 'message' ); %>--%>
										 <% out.print( $value.getString("message").replace("\n", "<br />") ); %>
										 </span>
                            </div>
                        </li>
                        <%
                            }
                        %>
                    </div>
                    <% if( $child.getJSONArray($pval.getString("id")).length() >= $limit ){ %>
                    <li class="out b">
                        <a href="#" id="view-more" class="" parent-id="<% out.print( $pval.getString("id") ); %>" >View More</a>
                    </li>
                    <% } %>
                </ul>
            </div>

        </div>
    </div>
    <%
                }

            }
        }
    %>

    <script type="text/javascript">
        var commentView = {
            data: {},
            init: function(){
                $( 'div.replies' ).each(function(){
                    commentView.data[ $( this ).attr( 'id' ) ] = $( this ).children( 'li.out' ).length;
                });

                $( document ).off( '#view-more' );
                $( document ).on( 'click', '#view-more', function(){
                    var v = {
                        id : $( this ).attr( 'parent-id' ),
                        limit : commentView.data[ $( this ).attr( 'parent-id' ) ],
                        callback : 'commentView.init',
                    };

                    $.fn.cProcessForm.ajax_data = {
                        ajax_data: v,
                        form_method: 'post',
                        ajax_data_type: 'json',
                        ajax_action: 'request_function_output',
                        ajax_container: '',
                        ajax_get_url: "?module=&action=comments&todo=view_more_comment",
                    };
                    $.fn.cProcessForm.ajax_send();
                });
            },
            appendReply:function(){
                if( $.fn.cProcessForm.returned_ajax_data && $.fn.cProcessForm.returned_ajax_data.html_replacement ){
                    // console.log( $.fn.cProcessForm.returned_ajax_data );
                    $( 'div.replies-' + $.fn.cProcessForm.returned_ajax_data.id ).prepend( $.fn.cProcessForm.returned_ajax_data.html_replacement );
                    $( 'div.replies' ).each(function(){
                        commentView.data[ $( this ).attr( 'id' ) ] = $( this ).children( 'li.out' ).length;
                        console.log( commentView.data );
                    });
                    if( $.fn.cProcessForm.returned_ajax_data.html_replacement_selector_one ){
                        $( $.fn.cProcessForm.returned_ajax_data.html_replacement_selector_one ).parent().hide();
                    }
                }
            },
            replyComment:function(){
                if( $.fn.cProcessForm.returned_ajax_data && $.fn.cProcessForm.returned_ajax_data.html_replacement_selector ){
                    $( $.fn.cProcessForm.returned_ajax_data.html_replacement_selector ).parent().removeAttr( 'style' );
                }
            },
        };
        commentView.init();
    </script>

    <% }else{
    %>
    <div class="note note-warning">No Comments Found</div>
    <%
        } %>
</div>
</div>