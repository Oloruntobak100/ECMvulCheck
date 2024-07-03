<%@ page import="org.json.JSONObject" %>
<%@ page import="static codes.nwpDataTable.getPopup" %>
Hello Babs
<%
    JSONObject $table = new JSONObject();
    $table.put("modal_title", "Edit Hello");
    $table.put("modal_body", "Peace Hello");
%>