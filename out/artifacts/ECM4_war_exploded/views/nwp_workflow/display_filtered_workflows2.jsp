<%@ page import="org.json.JSONObject" %>
<%@ page import="static codes.nwpWorkflow.getTableName" %>
<%@ page import="static codes.nwpDataTable.getDataTable" %>
<%@ page import="static codes.GlobalFunctions.get_json" %>
<%@ page import="static codes.GlobalFunctions.urldecode" %>
<%@ page import="codes.GlobalFunctions" %>
<%@ page import="codes.nwpAccessRoles" %>
<%@ page import="codes.nwpWorkflow" %>
<div nwp-file="<%out.print( request.getAttribute("filename") );%>" class="hyella-source-container">
    <%
        JSONObject $table = new JSONObject();
        JSONObject $query = new JSONObject();
        JSONObject $dbs = new JSONObject();
        JSONObject $dbs2 = new JSONObject();

        JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );
        $table.put("table", getTableName() );

        if( jget.has("id") && jget.has("table") ) {
            JSONObject dep1 = get_json( $table.getString("table") );
            if( dep1.has("fields")  ) {
                String $where = " AND ["+ $table.getString("table") +"].["+ dep1.getJSONObject("fields").getString("workflow_settings") +"] = '"+ jget.getString("id").trim() +"' ";
                if( GlobalFunctions.app_user_data.has("role") ){
                    JSONObject dep = GlobalFunctions.get_json( nwpAccessRoles.access_role_status );
                    if ( dep.has("fields") && dep.getJSONObject("fields").has("reference") && dep.getJSONObject("fields").has("reference_table") && dep.getJSONObject("fields").has("access_role_id") ) {
                        $query.put("join", " JOIN " + nwpAccessRoles.access_role_status + " ON [" + nwpAccessRoles.access_role_status + "].["+dep.getJSONObject("fields").getString("status")+"] = ["+ nwpWorkflow.table_name+"].[" + dep1.getJSONObject("fields").getString( "status" ) + "] AND [" + nwpAccessRoles.access_role_status + "].["+dep.getJSONObject("fields").getString("reference")+"] = ["+nwpWorkflow.table_name+"].[" + dep1.getJSONObject("fields").getString( "workflow_settings" ) + "] AND [" + nwpAccessRoles.access_role_status + "].["+dep.getJSONObject("fields").getString("reference_table")+"] = '"+nwpWorkflow.workflow_settings_table_name+"' AND [" + nwpAccessRoles.access_role_status + "].["+dep.getJSONObject("fields").getString("access_role_id")+"] = '"+GlobalFunctions.app_user_data.getString("role")+"'  AND [" + nwpAccessRoles.access_role_status + "].[record_status] = '1' ");
                    }
                }else{
                    $where += " AND ["+ $table.getString("table") +"].["+ dep1.getJSONObject("fields").getString("status") +"] NOT IN ( 'complete', 'cancelled' ) ";
                }
                $query.put( "where", $where );

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
                $dbs2.put("col", 4);
                //$dbs2.put("content", "Hi");
                $dbs2.put("action", "?action=display_sub_menu&nwp2_action=nwp_workflow&nwp_source="+ $table.getString("table") +"&nwp2_todo=view_details2&phtml_replacement_selector=" + jget.getString("html_replacement_selector") );
                $dbs.put("datatable_split_screen", $dbs2 );

                $dbs.put("show_delete_button", 0);
                $dbs.put("show_add_new", 0);
                $dbs.put("show_edit_button", 0);

                if( ( jget.has("nwp2_type") && jget.getString("nwp2_type").equals("full") ) ) {
                    if( jget.has("menu_title") && ! jget.getString("menu_title").isEmpty() ){
                        $dbs.put("title", urldecode( jget.getString("menu_title") ) );
                    }

                }else{
                    $dbs.put("hide_title", "1");
                }
                $table.put("datatable_settings", $dbs );

                out.println( getDataTable( $table ) );
            }else{
                out.print( "Undefined fields for Table: " + $table.getString("table") );
            }
        }else{
            out.print( "Unspecified source ID and Table" );
        }
    %>
</div>