<%@ page import="org.json.JSONObject" %>
<%@ page import="static codes.nwpCashAdvance.save_new_process" %>
<%@ page import="codes.GlobalFunctions" %>
<%
    JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );
    JSONObject jpet = new JSONObject( request.getAttribute("nwp_pdata").toString() );

    if( jget.has("wf") && ! jget.getString("wf").isEmpty() ) {
        JSONObject jdata = new JSONObject();

        jdata.put("html_parent", jget.has("html_parent")?jget.getString("html_parent"):"" );
        jdata.put("html_replacement_selector", jget.has("html_replacement_selector")?jget.getString("html_replacement_selector"):"" );
        jdata.put("workflow_settings", jget.getString("wf") );
        jdata.put("post_data", jpet);

        JSONObject rd = save_new_process(jdata);
        //out.print( "<pre>" + rd + "</pre>" );

        String h = "";
        if ( rd.has("view_details") ) {
            out.print( rd.getString("view_details") );
            GlobalFunctions.app_replace_container = jget.has("html_parent")?jget.getString("html_parent"):"";
        }else if (rd.has("saved_record")) {
            h += "<div class=\"note note-success alert alert-success\">";
            h += "<h4>Successfully Saved</h4>";
            h += "<p>Saved & Added to Process Workflow</p>";
            h += "</div>";
            h += "<div>";
            h += "<p><button class=\"btn btn-block dark\" hrefX=\"\" onclick=\"$('form#new_workflow_item_form').submit();\">You can add another process</button></p>";
            h += "</div>";
            out.print(h);
        }
    }else{
        GlobalFunctions.app_notice_type = "error";
        GlobalFunctions.app_notice = "Invalid Process Type...please select a process type and try again";
        GlobalFunctions.app_notice_only = true;
    }
%>