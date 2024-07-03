<%@ page import="org.json.JSONObject" %>
<%@ page import="static codes.nwpDataTable.getDataTable" %>
<%@ page import="codes.GlobalFunctions" %>
<div nwp-file="<%out.print( request.getAttribute("filename") );%>" class="hyella-source-container">
    <%
        JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );

        JSONObject $table = new JSONObject();
        JSONObject $query = new JSONObject();
        JSONObject $dbs = new JSONObject();
        JSONObject $dbs2 = new JSONObject();

        $table.put("table", "files" );
        if( jget.has("id") && jget.has("table") ) {
            JSONObject dep = GlobalFunctions.get_json( $table.getString("table") );
            if( dep.has("fields")  ) {
                $query.put("where", " AND ["+ dep.getJSONObject("fields").getString("reference") +"] = '"+ jget.getString("id").trim() +"'  AND ["+ dep.getJSONObject("fields").getString("reference_table") +"] = '"+ jget.getString("table").trim() +"' " );
                /*
                $query.put("select", "");
                $query.put("from", "");
                $query.put("join", "");
                $query.put("group", "");
                $query.put("order", "");
                $query.put("offset", "");
                */
                //$query.put("limit", " TOP 10 ");
                $table.put("query", $query);


                //$dbs.put("title", "Hello");
                $dbs2.put("col", 4);
                //$dbs2.put("content", "Hi");
                $dbs2.put("action", "?action=display_sub_menu&nwp2_action=files&nwp2_todo=view_details_by_reference&todo=use_id&phtml_replacement_selector=" + jget.getString("html_replacement_selector"));
                $dbs.put("datatable_split_screen", $dbs2);

                $dbs.put("show_delete_button", 0);
                $dbs.put("show_add_new", 0);
                $dbs.put("show_edit_button", 0);
                $dbs.put("hide_title", "1");
                $table.put("datatable_settings", $dbs);
                $table.put("table_settings", dep);

                out.print(getDataTable($table));
            }else{
                out.print( "Undefined fields for Table: " + $table.getString("table") );
            }
        }else{
            out.print( "Unspecified source ID and Table" );
        }
    %>
</div>