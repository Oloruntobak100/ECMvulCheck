<%@ page import="org.json.JSONObject" %>
<%@ page import="static codes.nwpWorkflow.getDetailsView" %>
<%@ page import="codes.nwpWorkflow" %>

<div nwp-file="<%out.print( request.getAttribute("filename") );%>" class="hyella-source-container">
    <%
        JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );
        JSONObject jpet = new JSONObject( request.getAttribute("nwp_pdata").toString() );

        if( jpet.has( "id" ) && ! jpet.getString( "id" ).isEmpty() ){
            out.print( getDetailsView( jget.put( "id", jpet.getString( "id" ) ).put( "db_table", nwpWorkflow.workflow_items_table_name ) ) );
        }else{
            out.print( "Undefined ID" );
        }
    %>
</div>