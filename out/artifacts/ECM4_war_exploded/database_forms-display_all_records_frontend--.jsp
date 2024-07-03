<%@ page import="org.json.JSONObject" %>
<%@ page import="static codes.nwpDataTable.getDataTable" %>
<div nwp-file="<%out.print( request.getAttribute("filename") );%>" class="hyella-source-container">
    <%
        JSONObject $table = new JSONObject();
        JSONObject $query = new JSONObject();
        JSONObject $dbs = new JSONObject();

        $table.put("table", "database_forms" );

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