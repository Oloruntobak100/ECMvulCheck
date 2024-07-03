<%@ page import="org.json.JSONObject" %>
<%@ page import="static codes.nwpDataTable.getDataTable" %>
<%@ page import="codes.GlobalFunctions" %>
<div nwp-file="<%out.print( request.getAttribute("filename") );%>" class="hyella-source-container">
    <%
        JSONObject $table = new JSONObject();
        JSONObject $query = new JSONObject();
        JSONObject $dbs = new JSONObject();
        JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );

        $table.put("table", "general_settings" );
        if( jget.has("nwp_filter") && ! jget.getString("nwp_filter").isEmpty() ){
            $table.put("filter", jget.getString("nwp_filter") );
        }

        if( ! GlobalFunctions.nwp_development_mode) {
            $dbs.put("show_delete_button", 0);
            $dbs.put("show_add_new", 0);

            JSONObject newButtonOptions = new JSONObject();
            newButtonOptions.put("nwp2_todo", "edit_general_settings");
            newButtonOptions.put("action", "datatable_button");
            newButtonOptions.put("nwp2_source", $table.getString("table"));
            $dbs.put("show_edit_button_options", newButtonOptions);
        }
        /*
        $query.put("select", "");
        $query.put("from", "");
        $query.put("join", "");
        $query.put("group", "");
        $query.put("order", "");
        $query.put("offset", "");
        */
        //$query.put("limit", " TOP 10 ");
        $table.put("query", $query );

        //$dbs.put("title", "Hello");
        //$dbs.put("hide_title", "1");
        $table.put("datatable_settings", $dbs );

        out.println( getDataTable( $table ) );
    %>
</div>