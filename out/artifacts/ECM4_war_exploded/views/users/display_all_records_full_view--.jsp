<%@ page import="org.json.JSONObject" %>
<%@ page import="static codes.nwpDataTable.getDataTable" %>
<div nwp-file="<%out.print( request.getAttribute("filename") );%>" class="hyella-source-container">
    <%
        JSONObject table = new JSONObject();
        JSONObject query = new JSONObject();
        JSONObject dataTableSettings = new JSONObject();

        table.put("table", "users" );

        /*
        $query.put("select", "");
        $query.put("from", "");
        $query.put("join", "");
        $query.put("group", "");
        $query.put("order", "");
        $query.put("offset", "");
        */
        //$query.put("limit", " TOP 10 ");
        table.put("query", query );

        //$dbs.put("title", "Hello");
        //$dbs.put("hide_title", "1");
        JSONObject newButtonOptions = new JSONObject();
        newButtonOptions.put("nwp2_action", table.getString("table") );
        newButtonOptions.put("nwp2_todo", "select_user_from_ad");
        dataTableSettings.put("show_add_new_options", newButtonOptions );

        /*newButtonOptions = new JSONObject();
        newButtonOptions.put("nwp2_action", table.getString("table") );
        newButtonOptions.put("nwp2_todo", "edit");
        dataTableSettings.put("show_edit_button_options", newButtonOptions );*/

        table.put("datatable_settings", dataTableSettings );

        out.println( getDataTable( table ) );
    %>
</div>