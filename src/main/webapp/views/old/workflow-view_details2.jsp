<%@ page import="org.json.JSONObject" %>
<%@ page import="static codes.nwpWorkflow.getDetailsView" %>
<div nwp-file="<%out.print( request.getAttribute("filename") );%>" class="hyella-source-container">
  <%
    JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );
    out.print( getDetailsView( jget ) );
  %>
</div>