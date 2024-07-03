<%@ page import="org.json.JSONObject" %>
<%
    //return parameters to call nwp_ecm/control_panel to open workflow by clicking on url
    JSONObject url_params = new JSONObject( request.getAttribute("url_params").toString() );
    String containter = request.getAttribute("html_replacement_selector").toString();
    JSONObject rGet = new JSONObject();
    if( url_params.has("id") && url_params.has("w") && ! url_params.getString("id").isEmpty() ) {
        rGet.put("nwp_redirect", true);
        rGet.put("action", "display_sub_menu");
        rGet.put("todo", "");
        rGet.put("nwp2_todo", "control_panel");
        rGet.put("nwp2_action", "nwp_ecm");
        rGet.put("workflow", url_params.getString("w") );
        rGet.put("id", url_params.getString("id") );
        if( ! containter.isEmpty() ) {
            rGet.put("html_replacement_selector", containter );
        }
    }else{
        rGet.put("html", "No workflow id was specified in " + request.getAttribute("filename").toString());
    }
    out.print( rGet.toString() );
%>