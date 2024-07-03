<%@ page import="org.json.JSONObject" %>
<%@ page import="codes.GlobalFunctions" %>
<div nwp-file="<% out.print( request.getAttribute("filename") );%>" class="hyella-source-container">
    <h4>Not Coded v3, check ecm2 for now: <% out.print( request.getAttribute("filename") );
        GlobalFunctions.app_popup = true;
        GlobalFunctions.app_popup_title = request.getAttribute("filename").toString();
    %></h4>
</div>