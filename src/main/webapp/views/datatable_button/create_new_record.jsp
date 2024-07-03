<%@ page import="org.json.JSONObject" %>
<%@ page import="static codes.nwpDataTable.getDataForm" %>
<%
    JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );

    if( jget.has("nwp2_source") && jget.has("nwp2_todo")  ){
        JSONObject jdata = new JSONObject();
        jdata.put("table", jget.getString("nwp2_source") );
        jdata.put("todo", jget.getString("nwp2_todo") );
        jdata.put("popup", true);

        out.print( getDataForm( jdata ) );
    }else{
        out.print( "No table specified" );
    }
%>