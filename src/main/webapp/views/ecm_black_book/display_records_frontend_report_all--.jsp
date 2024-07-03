<%@ page import="org.json.JSONObject" %>
<%@ page import="static codes.nwpDataTable.getDataTable" %>
<%@ page import="static codes.GlobalFunctions.get_json" %>
<%@ page import="static codes.GlobalFunctions.urldecode" %>
<%@ page import="static codes.nwpBlackBook.get_color_codes" %>
<div nwp-file="<%out.print( request.getAttribute("filename") );%>" class="hyella-source-container">
    <%
        JSONObject $table = new JSONObject();
        JSONObject $query = new JSONObject();
        JSONObject $dbs = new JSONObject();
        JSONObject $dbs2 = new JSONObject();

        JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );
        $table.put("table", "fiaps_black_book" );

        JSONObject dep = get_json( $table.getString("table") );
        if( dep.has("fields")  ) {
            //$query.put("where", " AND ["+ dep.getJSONObject("fields").getString("workflow_settings") +"] = '"+ jget.getString("id").trim() +"' AND ["+ dep.getJSONObject("fields").getString("status") +"] NOT IN ( 'complete', 'cancelled' ) " );
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
            $dbs2.put("col", 3);
            $dbs2.put("content", get_color_codes() );
            $dbs2.put("action", "?action=display_sub_menu&nwp2_action="+ $table.getString("table") +"&nwp2_todo=view_details2&phtml_replacement_selector=" + jget.getString("html_replacement_selector") );
            $dbs.put("datatable_split_screen", $dbs2 );

            $dbs.put("show_delete_button", 0);
            $dbs.put("show_add_new", 0);
            $dbs.put("show_edit_button", 0);

            if( jget.has("menu_title") && ! jget.getString("menu_title").isEmpty() ){
                $dbs.put("title", urldecode( jget.getString("menu_title") ) );
            }
            $table.put("datatable_settings", $dbs );

            out.println( getDataTable( $table ) );
        }else{
            out.print( "Undefined fields for Table: " + $table.getString("table") );
        }
    %>
</div>