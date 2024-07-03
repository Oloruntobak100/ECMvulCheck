<%@ page import="org.json.JSONObject" %>
<%@ page import="codes.nwpFiles" %>
<%@ page import="org.json.JSONArray" %>
<div nwp-file="<%out.print( request.getAttribute("filename") );%>" class="hyella-source-container">
    File Download
<%
    JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );
    JSONObject jpet = new JSONObject( request.getAttribute("nwp_pdata").toString() );

    if( jpet.has("id") && ! jpet.getString("id").isEmpty() ) {
            String html = "";
            JSONObject returnedData = nwpFiles.getFile( jpet );
            if( returnedData.has("error") && ! returnedData.getString("error").isEmpty() ){
                html = returnedData.getString("error");
            }
            out.print(html);
    }else{
        out.print( "No record was selected" );
    }
%></div>