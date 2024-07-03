<%@ page import="org.json.JSONObject" %>
<%@ page import="codes.GlobalFunctions" %>
<div nwp-file="<%out.print( request.getAttribute("filename") );%>" class="hyella-source-container">
<%
    JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );

    if( jget.has("nwp2_source") && jget.has("nwp2_todo")  ){
        JSONObject jdata = new JSONObject();
        jdata.put("table", jget.getString("nwp2_source") );
        jdata.put("todo", jget.getString("nwp2_todo") );
        String html = "";
        GlobalFunctions.app_popup = true;
        GlobalFunctions.app_popup_title = "Add New User from Active Directory";

        html += "<form id=\"select-ad-user-form\" method=\"post\" action=\"?rst=user_form&action=display_menu&todo=new_user_for2m&nwp2_action="+jget.getString("nwp2_source")+"&nwp2_todo=new_user_form2&nwp2_source="+ jget.getString("nwp2_source") +"&html_replacement_selector=selected-ad-user-con\" class=\"activate-ajax \">";
        html += "<div class=\"row\">";
        html += "<div class=\"col-md-12\">";
        html += "<label>Select Active Directory User</label>";
        html += "<div>";
        html += "<input type=\"text\" class=\"form-control select2\" name=\"active_d_user\" action=\"?action="+ jget.getString("nwp2_source") +"&todo=search_active_directory\">";
        html += "<textarea style=\"display:none;\" name=\"data\"></textarea>";
        html += "</div>";
        html += "</div>";
        html += "</div>";
        html += "</form>";
        html += "<hr /><div id=\"selected-ad-user-con\">";
        html += "<div class=\"note note-warning\">Select a user from active directory</div>";
        html += "</div>";

        out.print( html );
%>
<script type="text/javascript" >
	setTimeout(function(){
		$("form#select-ad-user-form")
		.find("input[name=\"active_d_user\"]")
		.change(function(){
			if( $(this).val() ){
				$("form#select-ad-user-form").find("textarea[name=\"data\"]").val( JSON.stringify( $(this).select2("data") ) );
				$("form#select-ad-user-form").submit();
			}
		});
	}, 300 );
</script>
<%
    }else{
        out.print( "No table specified" );
    }
%></div>