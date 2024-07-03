<%@ page import="org.json.JSONObject" %>
<%@ page import="codes.GlobalFunctions" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="codes.nwpEcm2" %>
<%@ page import="codes.nwpCashAdvance" %>
<%
    JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );
    JSONObject jpet = new JSONObject( request.getAttribute("nwp_pdata").toString() );

    if (jget.has("nwp2_action") && !jget.getString("nwp2_action").isEmpty()) {
        JSONObject $qs = new JSONObject();
        JSONObject $sf = new JSONObject();
        JSONObject dep = GlobalFunctions.get_json(jget.getString("nwp2_action"));
        String term = jpet.has("term")?jpet.getString("term"):"";
        JSONObject $qr2 = new JSONObject();

        if (dep.has("fields")) {
            String $where = "";
            String tb = jget.getString("nwp2_action");
            JSONObject $qf = dep.getJSONObject("fields");
            /*$qs.put("fields", $qf);

            $sf.put("name", "text");
            $qs.put("select_fields", $sf);*/
            $qs.put("select", "SELECT [" + tb + "].[id] as 'id', " +
                    "CONCAT( [" + tb + "].[" + dep.getJSONObject("fields").getString("name") + "], ' - ', " +
                    "FORMAT( [" + tb + "].[" + dep.getJSONObject("fields").getString("amount") + "], '#,#.##') ) as 'text' ");

            if ( jget.has("retire_once") && ! jget.getString("retire_once").isEmpty() ) {
                $qs.put("join", " LEFT JOIN " + tb + " as retired " +
                        "ON retired.[" + dep.getJSONObject("fields").getString("previous_reference_number") + "] = [" + tb + "].[" + dep.getJSONObject("fields").getString("name") + "] " +
                        "AND retired.[record_status] = '1' ");
                $where += " AND retired.[id] IS NULL ";
            }

            $where += " AND [" + tb + "].[" + $qf.getString("amount") + "] > 0 ";
            $where += " AND [" + tb + "].[" + $qf.getString("type") + "] IN ( 'single_trip', 'multiple_trip' ) ";
            $where += " AND [" + tb + "].[" + $qf.getString("status") + "] = 'approved' ";

            Boolean myRecords = true;
            if (GlobalFunctions.app_user_data.has("role")) {
                if (GlobalFunctions.app_user_data.has("accessible_functions")
                        && GlobalFunctions.app_user_data.getJSONObject("accessible_functions").has(nwpCashAdvance.table_name + ".retire_all.retire_all")) {
                    myRecords = false;
                }
            }
            if( myRecords ){
                $where += " AND [" + tb + "].[" + $qf.getString("staff") + "] = '"+ GlobalFunctions.app_user +"' ";
            }

            if (!term.isEmpty()) {
                if ($qf.has("name")) {
                    $where += " AND [" + tb + "].[" + $qf.getString("name") + "] LIKE '%" + term + "%' ";
                }
            }
            $qs.put("where", $where);
            $qs.put("table", jget.getString("nwp2_action"));
            $qs.put("limit", "20");
            JSONObject $qr = new JSONObject();

            $qr = GlobalFunctions.get_records($qs);
            if ($qr.has("row_count") && $qr.has("row") && $qr.getInt("row_count") > 0) {
                out.print( $qr.getJSONArray("row") );
            } else {
                out.print( new JSONArray() );
            }
        }
    }
%>