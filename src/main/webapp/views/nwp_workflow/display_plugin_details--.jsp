<%@ page import="org.json.JSONObject" %>
<%@ page import="static codes.GlobalFunctions.GetControlPanel" %>
<%@ page import="static codes.GlobalFunctions.GetNewID" %>
<%@ page import="static codes.GlobalFunctions.__perpare_buttons" %>
<%@ page import="java.util.Objects" %>
<%@ page import="org.json.JSONArray" %>

<div nwp-file="<%out.print( request.getAttribute("filename") );%>" class="hyella-source-container">
    <%
        JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );
        JSONObject $data = GetControlPanel( "ecm1650356439210", "ecm2" );

        String $pid = $data.has("id")?$data.getString("id"):"";
        String $table = $data.has("table")?$data.getString("table"):"";

        //$unique_key = GetNewID("control_panel");
        if( ! $pid.isEmpty() && ! $table.isEmpty() ){
            JSONObject $items = $data.getJSONObject("item");

            String $table_real = "";

            String $plugin = $data.has("plugin")?$data.getString("plugin"):"";

            String $static_comments = $data.has("static_comments")?$data.getString("static_comments"):"";

            String $click_btn = "";

            String $title_key = $data.has("title_key")?$data.getString("title_key"):"";
            //String $title_key = "";

            String $title_text = $data.has("title_text")?$data.getString("title_text"):"";


            //JSONObject $note = new JSONObject();
            JSONArray $note = $data.has("note")?$data.getJSONArray("note"):new JSONArray();

            JSONObject $footer_buttons = $data.has("footer_buttons")?$data.getJSONObject("footer_buttons"):new JSONObject();

            String $refresh_params = $data.has("refresh_params")?$data.getString("refresh_params"):"";


            String $tb = "";

            String $unique_key = "";

            String $container = $data.has("html_replacement_selector")?$data.getString("html_replacement_selector"):"";

            JSONObject $general_actions = $data.has("general_actions")?$data.getJSONObject("general_actions"):new JSONObject();
            JSONObject $tasks = $data.has("general_tasks")?$data.getJSONObject("general_tasks"):new JSONObject();
            JSONObject $tasks2 = $data.has("general_tasks2")?$data.getJSONObject("general_tasks2"):new JSONObject();
            JSONObject $tabs = $data.has("tabs")?$data.getJSONObject("tabs"):new JSONObject();


            String $details = $data.has("details")?$data.getString("details"):"";

            int $details_column = $data.has("details_column")?$data.getInt("details_column"):5;
            int $action_column = $data.has("action_column")?$data.getInt("action_column"):3;
            int $comments_column = $data.has("comments_column")?$data.getInt("comments_column"):4;

            String $override_refresh = "";

            String $notice = "";

            String $close = "";

            JSONObject $ags = new JSONObject();

            String $label = "";

            String $refresh_table = $table;

            String $rsa = "";

            String $th1 = "";

            String $hh1 = "";

            String $th2 = "";

            String $d_active = "";

            String $d_active2 = "";

            String $tab_params = "";

            JSONObject $tbs = new JSONObject();

            String $ktbs = "";

            String $tb_action = "";

            String $tb_todo = "";

            String $tb_title = "";

            String $otr = "";

            String $xid = "";

            String $hn = "";

            String $h = "";

            JSONObject $kav = new JSONObject();

            String $b = "";

            String $axt = "";

            JSONObject $oav = new JSONObject();

            String $oak = "";

            String $act = "";

            JSONObject $action = new JSONObject();


            // echo "<pre>"; print_r( $table ); echo "</pre>";
            //echo "<pre>"; print_r( $data["locked"] ); echo "</pre>";
            // echo "<pre>"; print_r( $e ); echo "</pre>";

            $tb = $table;
            if( ! $table_real.isEmpty() ){
                $tb = $table_real;
            }

            //$details = $data.getString( "details" );
            $unique_key = $pid;
            $override_refresh = "";
            JSONObject $locked = new JSONObject();

            $notice = "";
            $close = "";

            JSONObject $action_group = $data.has( "action_group" )?$data.getJSONObject( "action_group" ):new JSONObject();
            //JSONObject $action_group = new JSONObject();

            if( ! Objects.isNull($action_group) ){
                $ags = $action_group;
            }else{
                JSONObject $ag = new JSONObject();
            }

            //$ags = isset( $data[ "action_group" ][ "title" ] ) && isset( $data[ "action_group" ][ "actions" ][0] ) ? array( $data[ "action_group" ] ) : array();
            //$ags = isset( $data[ "action_groups" ] ) ? $data[ "action_groups" ] : $ags;
    %>
    <% if( $data.getString( "hide_title" ).isEmpty() ){ %>
    <div class="row">
        <div class="col-md-12">
            <% out.print( $close ); %>
            <h4 style="text-align:center;">
                <%
                    if( $data.getInt("show_refresh") > 0 && jget.has( "action" ) && ! jget.getString( "action" ).isEmpty() ){
                        $container = jget.getString("html_replacement_selector");

                        $rsa = "?action="+ jget.getString( "action" ) +"&nwp_action=&nwp_todo=&todo="+ jget.getString("todo")+"&nwp2_todo="+ jget.getString("nwp2_todo")+"&nwp2_action="+ jget.getString("nwp2_action");
                        /* if( ! $override_refresh.isEmpty() ){
                            $rsa = $override_refresh;
                        }
                        if( ! $override_refresh.isEmpty() ){
                            $rsa += $refresh_params;
                        }*/

                %>
                <a href="#" title="Re-open <% out.println( $title_text ); %>" class="custom-single-selected-record-button m-link" override-selected-record="<% out.println( $pid ); %>" action="<% out.println( $rsa ); %>&html_replacement_selector=<% out.println( $container ); %>"><i class="icon-refresh"></i></a>
                <% } %>
                <strong>
                    <%

                        if( ! $title_text.isEmpty() ){
                            out.print( $title_text );
                        }else {
                            if ( ! $title_key.isEmpty() ) {
                                out.print($title_key);
                            } else {
                                String dlabel = "";
                                if ( ! $items.getString("name").isEmpty()) {
                                    dlabel += $items.getString("name");
                                } else {
                                    dlabel += "";
                                }

                                if ( ! $items.getString("serial_num").isEmpty() ) {
                                    dlabel += $items.getString("serial_num");
                                } else {
                                    dlabel += "";
                                }
                                out.print(dlabel);
                            }
                        }     // out.println( isset( $e[ $title_key ] ) ? $e[ $title_key ] : ( isset( $e[ 'name' ] ) ? $e[ 'name' ] : $label ) . ( isset( $e["serial_num"] ) ? '#'.$e["serial_num"] : '' );
                    %></strong></h4>
        </div>
    </div>
    <% } %>

    <div class="row">
        <div class="col-md-12">

            <div class="tabbable tabbable-custom" id="transaction-tabs">
                <ul class="nav nav-tabs">
                    <%
                        $th1 = "";
                        $hh1 = "";
                        $th2 = "";
                        $d_active = "active";
                        $d_active2 = "";
                        if( ! $data.getString( "tab_params" ).isEmpty() ){
                            $tab_params = $data.getString( "tab_params" );
                        }

                        try{

                            for(int i1 = 0; i1 < $tabs.names().length(); i1++){
                                $ktbs = $tabs.names().getString(i1);
                                $tbs = $tabs.getJSONObject( $ktbs );
                                $tb_action = ( $tbs.has("action") ) ? $tbs.getString("action") : "";
                                $tb_title = ( $tbs.has("title") ) ? $tbs.getString("title") : "";
                                $tb_todo = ( $tbs.has("todo") ) ? $tbs.getString("todo") : "";
                                $otr = ( $tbs.has("one_time_request") ) ? $tbs.getString("one_time_request") : "";
                                $xid = ( $tbs.has("custom_id") ) ? $tbs.getString("custom_id") : $pid;

                                if( $tbs.has("html") && ! $tbs.getString("html").isEmpty() ){
                                    if( $d_active2 == "" && $tbs.has("active") && $tbs.getString("active") != "" ){
                                        $d_active = "";
                                        $d_active2 = " active ";
                                    }

                                    $th1 += "<li class=\""+$d_active2+"\"><a data-toggle=\"tab\" href=\"#tabd-"+$ktbs+"-" +  $unique_key + "\" class=\" m-link\">" +  $tb_title + "</a></li>";
                                    $hh1 += "<div class=\""+$d_active2+" tab-pane\" id=\"tabd-"+$ktbs+"-" +  $unique_key + "\">"+ $tbs.getString("html")  +"</div>";

                                    if( $d_active2 != "" ){
                                        $d_active2 = " second-place ";
                                    }
                                }else if( ! $tb_action.isEmpty() && ! $tb_todo.isEmpty() && ! $tb_title.isEmpty() ){
                                    $th2 += "<li ><a data-toggle=\"tab\" href=\"#tab-2-" +  $unique_key + "\" clickme=\"" +  $ktbs + "\" class=\"custom-single-selected-record-button " +  $otr +"\" action=\"?action=" +  $tb_action +"&todo=" +  $tb_todo +"&html_replacement_selector=general-activity-window-" +  $unique_key + $tab_params+"\" override-selected-record=\"" +  $xid + "\" class=\"m-link\">" +  $tb_title + "</a></li>";
                                }

                            }
                        }catch (Exception e) {
                            out.println( "No TABS FOUND" );
                        }
                    %>
                    <li class="<% out.print( $d_active ); %>"><a data-toggle="tab" class="m-link" href="#tab-1-<% out.print( $unique_key ); %>">Basic Info</a></li>
                    <%
                        out.print( $th1 );
                        //if( ! empty( $ags ) || ! empty( $data[ 'general_tasks' ] ) || ! empty( $data[ 'general_tasks2' ] ) ){
                        //if( $ags.names().length() > 0 || $tasks.names().length() > 0  || $tasks2.names().length() > 0 ){
                        if( $ags.length() > 0 || $tasks.length() > 0  || $tasks2.length() > 0 ){
                    %>
                    <li ><a data-toggle="tab" href="#tab-2-<% out.print( $unique_key ); %>" class="m-link" id="tab2-handle-<% out.print( $unique_key );  %>" >Activity Window</a></li>
                    <% } %>
                    <% out.print( $th2 ); %>

                </ul>
                <div class="tab-content resizable-heightx" style="overflow-y:hidden; overflow-x:hidden;">
                    <% out.print( $hh1 ); %>
                    <div class="tab-pane <% out.print( $d_active ); %>" id="tab-1-<% out.print( $unique_key ); %>">
                        <br />
                        <div class="row">
                            <div class="col-md-<% out.println( $details_column ); %>">
                                <%
                                    out.print( $notice );
                                    out.print( $details );
                                %>
                            </div>
                            <div class="col-md-<% out.print( $action_column ); %> action-column" >
                                <%
                                    if( $note.length() > 0 ){
                                        $hn = "";
                                        JSONObject $av;
                                        for( int i = 0; i < $note.length(); i++ ){
                                            $av = $note.getJSONObject( i );

                                            if( $av.has("message") ){
                                                $hn += "<div class=\"note note-"+ ( ( $av.has("type") ) ? $av.getString("type") : "" ) +"\" >";
                                                if( $av.has("title" ) && $av.getString("title").length() > 0 ){
                                                    $hn += "<h4><strong>" + $av.getString("title") +"</strong></h4>";
                                                }
                                                $hn += "<p>"+ $av.getString("message") +"</p></div>";
                                            }
                                        }
                                        out.println( $hn );
                                    }else{
                                        //if( $note.length() > 0 ){ out.print( "<div class=\"note note-warning\">"+ $note.toString() +"</div>" ); }
                                    }

                                    $h = "";
                                    if( ($tasks.length() > 0) || $tasks2.length() > 0 ){

                                        $h += "<h5><strong>Tasks</strong></h5>";
                                        $h += "<div class=\"dropdown inline clearfix\" ><ul class=\"dropdown-menux\" role=\"menu\" style=\"width:100%;\">";

                                        int $has = 0;
                                        if( $tasks.getString("general_tasks").length() > 0 ){
                                            // out.print( '<pre>'; print_r( strrpos( $e[ 'status' ], '.', 2 ) ); out.print( '</pre>';
                                            $has = 1;
                                            $h += __perpare_buttons( $tasks, $unique_key, $pid, $container );
                                        }

                                        if( $data.getString("general_tasks2").length() > 0 ){
                                            if( $has > 0 ){ $h += "<li class=\"divider\"></li>"; }
                                            $h += __perpare_buttons( $tasks2, $unique_key, $pid, $container );
                                        }

                                        $h += "</ul></div>";
                                    }


                                    // out.print( '<pre>'; print_r( $ags ); out.print( '</pre>';
                                    if( $ags.length() > 0 ){
                                        for(  int i = 0; i < $ags.length(); i++ ){
                                            String $agdk = $ags.names().getString(i);
                                            JSONObject $agd = $ags.getJSONObject( $agdk );
                                            JSONObject $agd_actions = $agd.getJSONObject( "actions" );

                                            if( $agd.has("title") && $agd_actions.length() > 0 ){


                                                if( $agd_actions.length() > 0 ){
                                                    $h += "<h5><strong>"+ $agd.getString("title") +"</strong></h5>";
                                                    $h += "<div class=\"dropdown inline clearfix\" ><ul class=\"dropdown-menux\" role=\"menu\" style=\"width:100%;\">";

                                                    for( int i2 = 0; i2 < $agd_actions.length(); i2++ ){
                                                        String $kav2 = $agd_actions.names().getString(i2);
                                                        JSONObject $av = $agd_actions.getJSONObject( $kav2 );
                                                        $xid = ( $av.has("custom_id")  && $av.getString("custom_id").length() > 0 ) ? $av.getString("custom_id") : $pid;

                                                        String $ti = "";

                                                        String $ak = $av.getString("action") + "." + $av.getString("todo");

                                                        if( $action.getJSONObject($ak).has("count") ){
                                                            $ti = " title=\"Performed "+ $action.getJSONObject($ak).getJSONObject("count") +" time(s)\" ";
                                                        }

                                                        String $params2 = ( $av.has("params") ) ? $av.getString("params") : "";

                                                        $h += "<li role=\"presentation\"><a clickme="+ $kav +" " +$ti+ " role=\"menuitem\" tabindex=\"-1\" href=\"#\" action=\"?action="+ $av.getString("action") +"&todo="+ $av.getString("todo")+ "&html_replacement_selector=general-activity-window-"+ $unique_key +"&container="+ $container + $params2 +"\" override-selected-record=\""+ $xid +"\" class=\"custom-single-selected-record-button open-activity-window\" unique_key=\""+ $unique_key +"\">"+ $av.getString("title") +"</a></li>";
                                                    }

                                                    $h += "</ul></div><br>";

                                                }
                                            }
                                        }
                                    }

                                    if( $general_actions.length() > 0  ){
                                        //$b = $h ? '<br />' : '';
                                        $b = "";

                                        $b += "<h5><strong>General Actions</strong></h5>";
                                        $b += "<div class=\"dropdown inline clearfix\" ><ul class=\"dropdown-menux\" role=\"menu\" style=\"width:100%;\">";



                                        for( int i = 0; i < $general_actions.length(); i++ ){
                                            String $kav2 = $general_actions.names().getString(i);
                                            JSONObject $av = $general_actions.getJSONObject( $kav2 );

                                            $axt = "";
                                            if( $av.has("action") && $av.getString("action") == "comments" && $av.getString("todo") == "add_comment" ){
                                                $axt = "&modal_callback=nwOpenModule.loadLatestComment";
                                            }
                                            $xid = ( $av.has("custom_id") && $av.getString("custom_id").length() > 0 ) ? $av.getString("custom_id") : $pid;

                                            $b += "<li role=\"presentation\"><a clickme="+ $kav +" role=\"menuitem\" tabindex=\"-1\" href=\"#\" action=\"?action="+ $av.getString("action") +"&todo="+ $av.getString("todo") +"&container="+ $container + $axt +"&table="+ $tb + (  $av.has( "params" ) ? $av.getString("params") : "" ) +"\" override-selected-record=\""+ $xid +"\" class=\"custom-single-selected-record-button\">"+ $av.getString("title") +"</a></li>";
                                        }


                                        $b += "</ul></div>";
                                        $h += $b;
                                    }

                                    out.print( $h );
                                %>
                            </div>

                            <div class="col-md-<% out.print( $comments_column ); %>">
                                <% if( ! $static_comments.equals("") ){ out.print( $static_comments ); } %>
                                <% if( $data.getString("show_comments").equals("1") ){ %>
                                <a href="#" action="?action=comments&todo=view_details_by_reference&html_replacement_selector=latest-comments-container&table=<% out.print( $tb ); %>&modal=1&no_error=1" override-selected-record="<% out.print( $pid ); %>" class="custom-single-selected-record-button" id="latest-comments-container-link" style="display:none;">View Latest Comments...</a>

                                <div id="latest-comments-container" style="max-height:350px; overflow-y:auto;  position:relative;">
                                    <i>View Latest Comments...</i>
                                </div>
                                <% } %>
                            </div>

                        </div>

                        <hr />
                        <div class="row">
                            <div class="col-md-12">
                                <%
                                    if( $footer_buttons.length() > 0 ){
                                        for( int i = 0; i < $footer_buttons.length(); i++ ){
                                            $oak = $footer_buttons.names().getString(i);
                                            $oav = $footer_buttons.getJSONObject( $oak );

                                            $xid = ( $oav.has("custom_id") && $oav.getString("custom_id").length() > 0 ) ? $oav.getString("custom_id") : $pid;
                                            $act = "?action="+ $oav.getString("action") + "&todo=" + $oav.getString("todo");
                                %>
                                <a href="#" <% out.print( $oav.has( "attr") ? $oav.getString("attr") : "" ); %> class="btn <% out.print( $oav.has("class") ? $oav.getString("class") : "dark" ) ; %> custom-single-selected-record-button" override-selected-record="<% out.print( $xid ); %>" action="<% out.print( $act ); %>&html_replacement_selector=<% out.print( $container ); %>" <% out.print( $oav.has("confirm_prompt" ) ? " confirm-prompt=\""+ $oav.getString("confirm_prompt") +"\" " : "" ); %>><% out.print( $oav.has("text") ? $oav.getString("text") : "Submit" ); %></a>
                                <%
                                        }
                                    }
                                %>

                            </div>
                        </div>

                    </div>

                    <div class="tab-pane" id="tab-2-<% out.print( $unique_key ); %>">
                        <br />
                        <div id="general-activity-window-<% out.print( $unique_key ); %>">
                            <div class="note note-info"><h4><strong>No Action/Task</strong></h4>Some activities in 'Basic Info' will appear here</div>
                        </div>
                    </div>

                </div>
            </div>

        </div>
    </div>

    <script type="text/javascript" class="auto-remove">
        var click_btn = '<% out.print($click_btn); %>';
        var unique_key = '<% out.print($unique_key); %>';
        var nwWorkflow = function () {
            return {
                recordItem: {
                    id:"",
                },
                init: function () {
                    $( 'a.open-activity-window' )
                        .click(function(){
                            // console.log( $(this) );
                            var unique_key = $(this).attr( 'unique_key' );
                            $( 'a#tab2-handle-' + unique_key ).addClass( 'custom-single-selected-record-button activatedRightClick' ).attr({
                                'action' : $( this ).attr( 'action' ),
                                'override-selected-record' : $(this).attr( 'override-selected-record' ),
                            }).click();
                            $( 'a#tab2-handle-' + unique_key ).html( $(this).html() );
                            // $( '#tab-2' ).html( '' );
                        });

                    nwWorkflow.loadLatestComment();
                    nwWorkflow.submitDataForm();

                    if( click_btn ){
                        setTimeout(function(){
                            $('a[clickme="'+ click_btn +'"]').click();
                        }, 400 );
                    }
                },
                loadLatestComment: function () {
                    if( $('a#latest-comments-container-link') ){
                        setTimeout(function(){
                            $('a#latest-comments-container-link').click();
                        }, 1000 );
                    }
                },
                openActivityWindow: function () {
                    // $('a#tab2-handle').click();
                },
                selectAllFields: function ( t ) {

                    $('select[name="fields['+ t +'][]"]')
                        .find('option')
                        .prop('selected', true);

                    $('select[name="fields['+ t +'][]"]')
                        .trigger("change");
                },
                clearAllFields: function ( t ) {

                    $('select[name="fields['+ t +'][]"]')
                        .find('option')
                        .prop('selected', false);

                    $('select[name="fields['+ t +'][]"]')
                        .trigger("change");
                },
                selectAllFields2: function ( t ) {

                    $('select[name="'+ t +'[]"]')
                        .find('option')
                        .prop('selected', true);

                    $('select[name="'+ t +'[]"]')
                        .trigger("change");
                },
                clearAllFields2: function ( t ) {

                    $('select[name="'+ t +'[]"]')
                        .find('option')
                        .prop('selected', false);

                    $('select[name="'+ t +'[]"]')
                        .trigger("change");
                },
                updateTableFields: function () {

                    var json = JSON.parse( $('textarea#table-fields-json').val() );
                    var table = $('form#duplicate-settings-form').find('select[name="table"]').val();

                    if( json && table && json[ table ] ){
                        $('form#duplicate-settings-form')
                            .find('select[name="fields"]')
                            .html( json[ table ] )
                            .trigger("change");
                    }
                },
                assignedDataLocation:{},
                assignedData:{},
                activateAssignment: function () {
                    nwWorkflow.assignedData = {};
                    nwWorkflow.assignedDataLocation = {};
                    nwWorkflow.submitDataForm();
                },
                assignRecordsToValidators: function ( id ) {
                    //
                    //var json = JSON.parse( $('textarea#table-fields-json').val() );
                    //var table = $('form#duplicate-settings-form').find('select[name="table"]').val();

                    if( id && $('#assign-' + id ) ){
                        $('form#assign-data-validator-form')
                            .show();

                        var $r = $('#record-' + id );

                        var $a = $('#assign-' + id );
                        var $form = $('form#assign-data-validator-form');
                        var dd = { "state":1, "lga":1, "ward":1, "community":1 }
                        var title = [];

                        $form.find('input[name="records"]').val( parseInt( $r.attr('data-count') ) );
                        $form.find('input[name="records"]').attr( "max", parseInt( $r.attr('data-count') ) );

                        $.each( dd, function( k1, v1 ){

                            if( $a.attr( 'data-' + k1 ) ){
                                $form.find('input[name="'+ k1 +'"]').val( $a.attr('data-' + k1 ) );

                                if( $a.attr( 'data-' + k1 + '-text' ) ){
                                    $form.find('input[name="'+ k1 +'_text"]').val( $a.attr( 'data-' + k1 + '-text' ) );

                                    title.push( $a.attr( 'data-' + k1 + '-text' ) );
                                }
                            }

                        } );

                        if( title.length > 0 ){
                            $form.find('#assign-title').html( title.join(" - ") );
                        }
                    }

                },
                displayValidators: function () {
                    //
                    //var json = JSON.parse( $('textarea#table-fields-json').val() );
                    //var table = $('form#duplicate-settings-form').find('select[name="table"]').val();
                    var h = '';
                    var colspan = 6;
                    var dx = {};
                    var hx = '#assigned-records-table';
                    var hx2 = '#assign-records-table';
                    var total_assign = 0;

                    if( ! $.isEmptyObject( nwWorkflow.assignedData ) ){
                        //console.log( nwWorkflow.assignedData );

                        $.each( nwWorkflow.assignedData, function( k1, v1 ){

                            h += '<tr><td colspan="'+ colspan +'"><strong>'+ v1.validator.text +'</strong></td></tr>';

                            if( v1.data && ! $.isEmptyObject( v1.data ) ){
                                $.each( v1.data, function( k2, v2 ){
                                    h += '<tr><td>'+ v2.state_text +'</td><td>'+ v2.lga_text +'</td><td>'+ v2.ward_text +'</td><td>'+ v2.community_text +'</td><td>'+ v2.records_assigned +'</td><td></td></tr>';

                                    if( ! dx[ v2.state ] ){
                                        dx[ v2.state ] = {
                                            records:0,
                                            state:v2.state,
                                            data:{},
                                        };
                                    }

                                    if( ! dx[ v2.state ][ "data" ][ v2.lga ] ){
                                        dx[ v2.state ][ "data" ][ v2.lga ] = {
                                            records:0,
                                            lga:v2.lga,
                                            data:{},
                                        };
                                    }

                                    if( v2.ward ){
                                        if( ! dx[ v2.state ][ "data" ][ v2.lga ]["data"][ v2.ward ] ){
                                            dx[ v2.state ][ "data" ][ v2.lga ]["data"][ v2.ward ] = {
                                                records:0,
                                                ward:v2.ward,
                                                data:{},
                                            };
                                        }
                                        dx[ v2.state ][ "data" ][ v2.lga ]["data"][ v2.ward ]["records"] += v2.records_assigned;

                                        if( v2.community ){
                                            if( ! dx[ v2.state ][ "data" ][ v2.lga ]["data"][ v2.ward ]["data"][ v2.community ] ){
                                                dx[ v2.state ][ "data" ][ v2.lga ]["data"][ v2.ward ]["data"][ v2.community ] = {
                                                    records:0,
                                                    community:v2.community,
                                                    data:{},
                                                };
                                            }

                                            dx[ v2.state ][ "data" ][ v2.lga ]["data"][ v2.ward ]["data"][ v2.community ]["records"] += v2.records_assigned;


                                            var c = parseInt( $( hx2 ).find('td#community-' + v2.community ).parent().attr("data-count") * 1 );
                                            var c1 = c - dx[ v2.state ][ "data" ][ v2.lga ]["data"][ v2.ward ]["data"][ v2.community ]["records"];

                                            $( hx2 )
                                                .find('td#community-' + v2.community )
                                                .html( c1 )
                                                .parent()
                                                .attr( "balance", c1 );

                                        }else{
                                            $( hx2 )
                                                .find('tr.ward-' + v2.ward )
                                                .addClass("disabled");
                                        }

                                        var c = parseInt( $( hx2 ).find('td#ward-' + v2.ward ).parent().attr("data-count") * 1 );
                                        var c1 = c - dx[ v2.state ][ "data" ][ v2.lga ]["data"][ v2.ward ]["records"];

                                        $( hx2 )
                                            .find('td#ward-' + v2.ward )
                                            .attr( "balance", c1 )
                                            .html( c1 )
                                            .parent()
                                            .attr( "balance", c1 );

                                    }else{

                                        $( hx2 )
                                            .find('tr.lga-' + v2.lga )
                                            .addClass("disabled");
                                    }

                                    total_assign += v2.records_assigned;
                                    dx[ v2.state ]["records"] += v2.records_assigned;
                                    dx[ v2.state ][ "data" ][ v2.lga ]["records"] += v2.records_assigned;


                                    var c = parseInt( $( hx2 ).find('td#lga-' + v2.lga ).parent().attr("data-count") * 1 );
                                    var c1 = c - dx[ v2.state ][ "data" ][ v2.lga ]["records"];

                                    $( hx2 )
                                        .find('td#lga-' + v2.lga )
                                        .html( c1 )
                                        .parent()
                                        .attr( "balance", c1 );
                                });
                            }

                            h += '<tr><td colspan="'+ colspan +'">&nbsp;</td></tr>';
                        } );

                    }

                    $( hx ).html( h );

                    var jx = {};
                    jx[ 'assign' ] = nwWorkflow.assignedData;
                    jx[ 'location' ] = nwWorkflow.assignedDataLocation;

                    $('form#assign-to-validator-form')
                        .find( 'textarea[name="data"]' )
                        .val( JSON.stringify( jx ) );

                    $('form#assign-to-validator-form')
                        .find( 'input[name="total_assign"]' )
                        .val( total_assign );

                    $('form#assign-data-validator-form')
                        .hide();
                },
                submitDataForm: function(){

                    $("form.client-form")
                        .on('submit', function(e){
                            e.preventDefault();

                            var err = "";
                            var msg = "";

                            var data = {};
                            $(this)
                                .find(".form-control, .form-check-input")
                                .each(function(){
                                    var val = $(this).val();

                                    switch( $(this).attr("type") ){
                                        case "hidden":
                                        case "text":
                                            if( $(this).hasClass("select2") ){
                                                var d = $(this).select2('data');

                                                if( ! $.isEmptyObject( d ) ){
                                                    var n = $(this).attr("name");

                                                    if( $(this).attr("tags") && $(this).attr("tags") == "true" ){

                                                        data[ n + "_tags" ] = d;
                                                        data[ n + "_text" ] = '';

                                                        $.each( d, function( k, v ){
                                                            if( v.text ){
                                                                data[ n + "_text" ] += v.text + ', ';
                                                            }
                                                        } );

                                                    }else{

                                                        $.each( d, function( k, v ){
                                                            if( k ){
                                                                data[ n + "_" + k ] = v;
                                                            }
                                                        } );

                                                    }
                                                }
                                            }
                                            break;
                                        case "number":
                                            val = parseFloat( val );
                                            if( isNaN( val ) )val = 0;
                                            break;
                                        case "select":
                                            var n = $(this).attr("name");

                                            if( $(this).val() ){
                                                var val = $(this).val().toString();
                                            }else{
                                                val = '';
                                            }

                                            data[ n + "_text" ] = $(this).children('option:selected').text().trim();
                                            break;
                                        case "radio":
                                            if( ! $(this).is(":checked") ){
                                                return;
                                            }
                                            break;
                                    }

                                    data[ $(this).attr("name") ] = val;
                                });
                            console.log( data );

                            var id = 1;

                            var form = $(this).attr("id");

                            var refresh = '';
                            var increment = 0;
                            var cart_items = {};
                            var empty_form_values = 1;


                            switch( form ){
                                case "assign-data-validator-form":
                                    if( ! err ){

                                        if( data["validator_tags"] && ! $.isEmptyObject( data["validator_tags"] ) && data["records"] ){

                                            var k3 = data["state"] + '-' + data["lga"] + '-' + data["ward"] + '-' + data["community"];
                                            var div = Math.floor( parseInt( data["records"] ) / data["validator_tags"].length );
                                            var remain = ( parseInt( data["records"] ) % data["validator_tags"].length );

                                            $.each( data["validator_tags"], function( k2, v2 ){
                                                if( ! nwWorkflow.assignedData[ v2.id ] ){
                                                    nwWorkflow.assignedData[ v2.id ] = { data:{}, validator:v2 };
                                                }

                                                if( ! nwWorkflow.assignedData[ v2.id ][ "data" ][ k3 ] ){
                                                    nwWorkflow.assignedData[ v2.id ][ "data" ][ k3 ] = {};
                                                }

                                                nwWorkflow.assignedData[ v2.id ][ "data" ][ k3 ] = JSON.parse( JSON.stringify( data ) );
                                                nwWorkflow.assignedData[ v2.id ][ "data" ][ k3 ]["records_assigned"] = div + remain;
                                                remain = 0;
                                            } );

                                            var edata = { theme:'note note-success alert-success' , err:"Changes Successfully Saved", msg:"Validators has been assigned", typ:'jsuerror' };
                                            nwDisplayNotification.display_notification( edata );

                                            nwWorkflow.displayValidators();

                                        }else{
                                            err = "Invalid Validators / Records";
                                            msg = "Please try again";
                                        }
                                    }
                                    break;
                                default:
                                    err = "Invalid Input";
                                    msg = "Please try again or contact technical support team";
                                    break;
                            }

                            if( err ){
                                var data = {theme:'alert-danger', err:err, msg:msg, typ:'jsuerror' };
                                nwDisplayNotification.display_notification( data );
                                return false;
                            }

                            //$(this).trigger('reset');

                            if( empty_form_values ){
                                $(this).find('.form-control').not(".keep-value").val("");

                                if( $(this).find("input.select2") ){
                                    $(this).find("input.select2").select2("val", "");
                                }
                                if( $(this).find("input.uploaded-file") ){
                                    $(this).find("input.uploaded-file").val("");
                                    $(this).find(".qq-upload-list").html("");
                                }
                            }
                        });
                },

            };

        }();
        nwWorkflow.init();
    </script>
    <% }else{
            out.println("The ID and Table is not defined");
    } %>
</div>