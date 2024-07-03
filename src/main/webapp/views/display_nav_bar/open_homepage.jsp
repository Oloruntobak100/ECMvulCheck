<%@ page import="org.json.JSONObject" %>
<%
  //return parameters to homepage
  String containter = request.getAttribute("html_replacement_selector").toString();
  JSONObject rGet = new JSONObject();

    rGet.put("nwp_redirect", true);
    rGet.put("action", "display_menu");
    rGet.put("get_children", 1);
    rGet.put("todo", "my_wk_apd");
    rGet.put("nwp2_todo", "execute");
    rGet.put("nwp2_action", "nwp_workflow");
    rGet.put("nwp_todo", "data_approval_dashboard");
    rGet.put("nwp_action", "workflow");
    if( ! containter.isEmpty() ) {
      rGet.put("html_replacement_selector", containter );
    }
  out.print( rGet.toString() );
%>