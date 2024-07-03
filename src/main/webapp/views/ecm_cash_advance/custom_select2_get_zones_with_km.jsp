<%@ page import="org.json.JSONObject" %>
<%@ page import="codes.GlobalFunctions" %>
<%@ page import="codes.nwpCashAdvance" %>
<%
    JSONObject jpet = new JSONObject( request.getAttribute("nwp_pdata").toString() );

    JSONObject $qs = new JSONObject();
    JSONObject $sf = new JSONObject();
    JSONObject dep = GlobalFunctions.get_json( nwpCashAdvance.table_name_zone );
    JSONObject dep_km = GlobalFunctions.get_json( nwpCashAdvance.table_name_km_chart );
    String term = ( jpet.has("term")?jpet.getString("term"):"" );

    if (dep.has("fields") && dep_km.has("fields")) {
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

        if ( $qf.has("zone") && jpet.has("to_zone") ) {
            $where += " AND [" + nwpCashAdvance.table_name_zone + "].[" + $qf.getString("zone") + "] = '" + jpet.getString("to_zone") + "' ";
        }

        Boolean checkDest = true;
        if (jpet.has("transport") && jpet.getString("transport").equals("flight")) {
            checkDest = false;
        }

        if ( checkDest && jpet.has("from") && ! jpet.getString("from").isEmpty()) {
            $qs.put("join", " JOIN [" + nwpCashAdvance.table_name_km_chart + "] " +
                    "ON ( ( [" + nwpCashAdvance.table_name_zone + "].[id] = [" + nwpCashAdvance.table_name_km_chart + "].["+ dep_km.getJSONObject("fields").getString("to") +"] " +
                    "AND [" + nwpCashAdvance.table_name_km_chart + "].["+ dep_km.getJSONObject("fields").getString("from") +"] = '" + jpet.getString("from") + "' ) " +
                    "OR ( [" + nwpCashAdvance.table_name_zone + "].[id] = [" + nwpCashAdvance.table_name_km_chart + "].["+ dep_km.getJSONObject("fields").getString("from") +"] " +
                    "AND [" + nwpCashAdvance.table_name_km_chart + "].["+ dep_km.getJSONObject("fields").getString("to") +"] = '" + jpet.getString("from") + "' ) ) " +
                    "AND [" + nwpCashAdvance.table_name_km_chart + "].[record_status] = '1'" );

            $qs.put("group", " GROUP BY [" + nwpCashAdvance.table_name_zone + "].[id], " +
                    "[" + nwpCashAdvance.table_name_zone + "].["+ dep.getJSONObject("fields").getString("name") +"] ");
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

            if ( $qf.has("zone") && jpet.has("to_zone")  && jpet.getString("to_zone").isEmpty() ) {
                out.print( "[{\"id\":\"\",\"text\":\"Please select a DESTINATION ZONE above\"}]" );
            }else{
                out.print( "[{\"id\":\"\",\"text\":\"No Destination Found in Kilometer Chart\"}]" );
            }
        }
    }
    //return format
    //[{"id":1,"text":"Kade"},{"id":2,"text":"Jim"}]
%>