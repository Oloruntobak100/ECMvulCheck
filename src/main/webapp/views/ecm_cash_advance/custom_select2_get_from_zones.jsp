<%@ page import="org.json.JSONObject" %>
<%@ page import="codes.GlobalFunctions" %>
<%@ page import="codes.nwpCashAdvance" %>
<%
    JSONObject jpet = new JSONObject( request.getAttribute("nwp_pdata").toString() );

    JSONObject $qs = new JSONObject();
    JSONObject $sf = new JSONObject();
    JSONObject dep = GlobalFunctions.get_json( nwpCashAdvance.table_name_zone );
    String term = ( jpet.has("term")?jpet.getString("term"):"" );

    if (dep.has("fields") ) {
        String $where = "";
        JSONObject $qf = dep.getJSONObject("fields");
        $qs.put("fields", $qf);

        $sf.put("name", "text");
        $qs.put("select_fields", $sf);
        $qs.put("select_prefix", "[" + nwpCashAdvance.table_name_zone + "].[id]" );

        if (!term.isEmpty()) {
            if ($qf.has("name")) {
                $where += " AND [" + nwpCashAdvance.table_name_zone + "].[" + $qf.getString("name") + "] LIKE '%" + term + "%' ";
            }
        }

        if( GlobalFunctions.app_data.has("hidden_zones_in_cash_advance") && GlobalFunctions.app_data.getBoolean("hidden_zones_in_cash_advance") ){
        }else if ( $qf.has("zone") && jpet.has("zone") ) {
            $where += " AND [" + nwpCashAdvance.table_name_zone + "].[" + $qf.getString("zone") + "] = '" + jpet.getString("zone") + "' ";
        }

        if( ! $where.isEmpty() ){
            $qs.put("where", $where);
        }

        $qs.put("table", nwpCashAdvance.table_name_zone );
        $qs.put("limit", "20");
        JSONObject $qr = new JSONObject();

        $qr = GlobalFunctions.get_records($qs);
        if ($qr.has("row_count") && $qr.has("row") && $qr.getInt("row_count") > 0) {
            out.print( $qr.getJSONArray("row") );
        } else {
            out.print( "[{\"id\":\"\",\"text\":\"Please select a ZONE above\"}]" );
        }
    }
    //return format
    //[{"id":1,"text":"Kade"},{"id":2,"text":"Jim"}]
%>