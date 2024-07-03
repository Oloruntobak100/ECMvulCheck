<%@ page import="org.json.JSONObject" %>
<%@ page import="static codes.nwpEcm2.save_new_process" %>
<%
    //JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );
    JSONObject jpet = new JSONObject( request.getAttribute("nwp_pdata").toString() );

    JSONObject jdata = new JSONObject();
    jdata.put("post_data", jpet );

    JSONObject rd = save_new_process( jdata );
    //out.print( "<pre>" + rd + "</pre>" );

    String h = "";
    if( rd.has("saved_record") ){
        h += "<div class=\"note note-success alert alert-success\">";
        h += "<h4>Successfully Saved</h4>";
        h += "<p>Saved & Added to Process Workflow</p>";
        h += "</div>";
        h += "<div>";
        h += "<p><button class=\"btn btn-block dark\" hrefX=\"\" onclick=\"$('form#new_workflow_item_form').submit();\">You can add another process</button></p>";
        h += "</div>";
        out.print( h );
    }
%>