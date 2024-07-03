<%@ page import="org.json.JSONObject" %>
<%@ page import="static codes.nwpFiles.deleteFile" %>

<div nwp-file="<%out.print( request.getAttribute("filename") );%>" class="hyella-source-container">
    <%
        JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );
        JSONObject jpet = new JSONObject( request.getAttribute("nwp_pdata").toString() );

        if( jpet.has( "id" ) && ! jpet.getString( "id" ).isEmpty() ){
            JSONObject rd = deleteFile( jget.put( "id", jpet.getString( "id" ) ).put("action", "delete") );
            if( rd.has("success") ) {
                out.print( rd.getString("success") );
            }else if( rd.has("error") ) {
                out.print( rd.getString("error") );
            }else{
                out.print( "Unknown File Delete Error" );
            }
        }else{
            out.print( "Undefined File ID" );
        }
    %>
</div>