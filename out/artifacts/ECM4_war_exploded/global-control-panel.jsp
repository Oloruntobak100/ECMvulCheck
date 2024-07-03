<%@ page import="org.json.JSONObject" %>
<%@ page import="static codes.GlobalFunctions.GetAccessedFunctions" %>
<%@ page import="static codes.GlobalFunctions.GetControlPanel" %>
<%@ page import="static codes.GlobalFunctions.GetNewID" %>
<%@ page import="static codes.GlobalFunctions.rawurlencode" %>
<%@ page import="java.util.Locale" %>

<div>
    <%

        JSONObject $cp_data = GetControlPanel();
        JSONObject $data = $cp_data.getJSONObject( "data" );

        JSONObject $items = $data.getJSONObject("item");

        String $table_real = "";

        String $table = $data.getString("table");

        String $plugin = $data.getString("plugin");

        String $static_comments = $data.getString("static_comments");

        String $click_btn = "";

        String $title_key = $data.getString("title_key");
        //String $title_key = "";

        String $title_text = $data.getString("title_text");

        JSONObject $note = new JSONObject();
        // JSONObject $note = $data.getJSONObject("note");

        String $refresh_params = $data.getString("refresh_params");

        String $pid = $data.getString("id");

        String $tb = "";

        String $unique_key = "";

        String $container = $data.getString("html_replacement_selector");

        //JSONObject $general_actions = $data.getJSONObject("general_actions");
        JSONObject $tasks = $data.getJSONObject("general_tasks");
        JSONObject $tasks2 = $data.getJSONObject("general_tasks2");

        //JSONObject $tasks = new JSONObject();

        JSONObject $tabs = $data.getJSONObject("tabs");

        ///String $details = $data.getString("details");

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



        // echo "<pre>"; print_r( $table ); echo "</pre>";
        //echo "<pre>"; print_r( $data["locked"] ); echo "</pre>";
        // echo "<pre>"; print_r( $e ); echo "</pre>";


        $tb = $table;
        if( $table_real != ""){
            $tb = $table_real;
        }

        // echo "<pre>"; print_r( $data ); echo "</pre>";
        $unique_key = GetNewID();

        if( $pid != "" && $table != "" ){
            $container = $data.getString( "html_replacement_selector" );
            //$tasks = $data.getJSONObject( "general_tasks" );
            //$details = $data.getString( "details" );
            $tabs = $data.getJSONObject( "tabs" );
            $override_refresh = "";
            JSONObject $locked = new JSONObject();

            $notice = "";
            $close = "";



            //JSONObject $action_group = $data.getJSONObject( "action_group" );
            JSONObject $action_group = new JSONObject();

            if( $action_group != null ){
                $ags = $action_group;
            }else{
                JSONObject $ag = new JSONObject();
            }

            // $ags = isset( $data[ "action_group" ][ "title" ] ) && isset( $data[ "action_group" ][ "actions" ][0] ) ? array( $data[ "action_group" ] ) : array();
            // $ags = isset( $data[ "action_groups" ] ) ? $data[ "action_groups" ] : $ags;

    %>
    <% if( $data.getString( "hide_title" ) == "" ){ %>
    <div class="row">
        <div class="col-md-12">
            <% out.print( $close ); %>
            <h4 style="text-align:center;">
                <%
                    if( $data.getInt("show_refresh") > 0 && $data.getString( "action_to_perform" ) != "" && $container != "" ){
                        $label = "";
                        if( $data.getString( "table_label" ) != "" ){
                            $label = $data.getString( "table_label" );
                        }else {
                            $label = $table.substring( 0 ).toUpperCase() + $table.substring(1);
                        }
                        //$label = isset( $data[ 'table_label' ] ) ? $data[ 'table_label' ] : ucwords( $table );
                        $refresh_table = $table;

                        if( $plugin != "" ){
                            $refresh_table = $plugin;
                        }

                        $rsa = "?action="+ $refresh_table +"&todo="+ $data.getString("action_to_perform");
                        if( $override_refresh != "" ){
                            $rsa = $override_refresh;
                        }
                        if( $override_refresh != "" ){
                            $rsa += $refresh_params;
                        }

                %>
                <a href="#" title="Re-open <% out.println( $label ); %>" class="custom-single-selected-record-button m-link" override-selected-record="<% out.println( $pid ); %>" action="<% out.println( $rsa ); %>&html_replacement_selector=<% out.println( $container ); %>"><i class="icon-refresh"></i></a>
                <% } %>
                <strong>
                    <%

                        if( $title_text != "" ){
                            out.print( $title_text );
                        }else {
                            if ($title_key != "") {
                                out.print($title_key);
                            } else {
                                String dlabel = "";
                                if ($items.getString("name") != "") {
                                    dlabel += $items.getString("name");
                                } else {
                                    dlabel += "";
                                }

                                if ($items.getString("serial_num") != "") {
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
                        if( $data.getString( "tab_params" ) != "" ){
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

                                if( $tbs.has("html") && $tbs.getString("html") != "" ){
                                    if( $d_active2 == "" && $tbs.has("active") && $tbs.getString("active") != "" ){
                                        $d_active = "";
                                        $d_active2 = " active ";
                                    }

                                    $th1 += "<li class=\""+$d_active2+"\"><a data-toggle=\"tab\" href=\"#tabd-"+$ktbs+"-" +  $unique_key + "\" class=\" m-link\">" +  $tb_title + "</a></li>";
                                    $hh1 += "<div class=\""+$d_active2+" tab-pane\" id=\"tabd-"+$ktbs+"-" +  $unique_key + "\">"+ $tbs.getString("html")  +"</div>";

                                    if( $d_active2 != "" ){
                                        $d_active2 = " second-place ";
                                    }
                                }else if( $tb_action != "" && $tb_todo != "" && $tb_title != "" ){
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
            </div>

        </div>
    </div>
    <% } %>
</div>