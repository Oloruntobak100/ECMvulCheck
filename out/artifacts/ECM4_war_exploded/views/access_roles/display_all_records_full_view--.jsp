<%@ page import="org.json.JSONObject" %>
<%@ page import="static codes.nwpDataTable.getDataTable" %>
<%@ page import="static codes.nwpAccessRoles.saveAccessRole" %>
<div nwp-file="<%out.print( request.getAttribute("filename") );%>" class="hyella-source-container">
    <%
        JSONObject $table = new JSONObject();
        JSONObject $query = new JSONObject();
        JSONObject $dbs = new JSONObject();
        JSONObject $dbs2 = new JSONObject();
        JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );

        $table.put("table", "access_roles" );

        /*
        $query.put("select", "");
        $query.put("from", "");
        $query.put("join", "");
        $query.put("group", "");
        $query.put("order", "");
        $query.put("offset", "");
        */

        //saving record in db
        if( jget.has("todo") && jget.getString("todo").equals("save_access_roles_cap") ) {
            JSONObject jpet = new JSONObject( request.getAttribute("nwp_pdata").toString() );
            saveAccessRole( jget, jpet );
        }

        if( jget.has("html_replacement_selector") ) {
            $dbs.put("html_replacement_selector", jget.getString("html_replacement_selector"));

            //bcos of custom buttons
            $dbs.put("button_params", "&html_replacement_selector=" + jget.getString("html_replacement_selector"));
        }
        /*$dbs2.put("col", 4);
        $dbs2.put("action", "?action=display_sub_menu&nwp2_action="+ $table.getString("table") +"&nwp2_todo=view_details&todo=use_id&phtml_replacement_selector=" + jget.getString("html_replacement_selector"));
        $dbs.put("datatable_split_screen", $dbs2);*/

        /*$dbs.put("show_delete_button", 0);
        $dbs.put("show_add_new", 0);
        $dbs.put("show_edit_button", 0);*/

        //$dbs.put("hide_title", "1");

        //$query.put("limit", " TOP 10 ");
        $table.put("query", $query );

        JSONObject newButtonOptions = new JSONObject();
        newButtonOptions.put("nwp2_action", "display_sub_menu" );
        newButtonOptions.put("nwp2_todo", "access_roles_cap");
        newButtonOptions.put("params", "&nwp2_action=" + $table.getString("table") + "&nwp2_todo=access_roles_cap" );
        $dbs.put("show_add_new_options", newButtonOptions );

        newButtonOptions = new JSONObject();
        newButtonOptions.put("nwp2_action", "display_sub_menu" );
        newButtonOptions.put("nwp2_todo", "access_roles_cap");
        newButtonOptions.put("params", "&nwp2_action=" + $table.getString("table") + "&nwp2_todo=access_roles_cap" );
        $dbs.put("show_edit_button_options", newButtonOptions );

        //$dbs.put("title", "Hello");
        //$dbs.put("hide_title", "1");
        $table.put("datatable_settings", $dbs );

        out.println( getDataTable( $table ) );
    %>
</div>