<%@ page import="org.json.JSONObject" %>
<%@ page import="static codes.nwpDataTable.saveDataForm" %>
<%
    JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );
    JSONObject jpet = new JSONObject( request.getAttribute("nwp_pdata").toString() );

    if( jget.has("nwp2_source") && jget.has("nwp2_todo") ){
        JSONObject jdata = new JSONObject();
        jdata.put("table", jget.getString("nwp2_source") );
        jdata.put("todo", jget.getString("nwp2_todo") );
        jdata.put("post_data", jpet );

        JSONObject rd = saveDataForm( jdata );
        if( rd.has("view_details") ){
            out.print( rd.getString("view_details") );
        }else {
            out.print("<pre>" + rd + "</pre>");
        }
    }else{
        out.print( "No table specified" );
    }
%>