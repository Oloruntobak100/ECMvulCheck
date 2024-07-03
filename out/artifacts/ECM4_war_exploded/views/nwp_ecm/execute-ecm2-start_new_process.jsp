<%@ page import="org.json.JSONObject" %>
<%@ page import="static codes.nwpEcm2.Ecm2GetStartNewProcess" %>

<div nwp-file="<%out.print( request.getAttribute("filename") );%>" class="hyella-source-container">
    <%
        String $h1 = "";
        String $h2 = "";
        String $h3 = "1";
        String $key = "";
        String $key1 = "";
        JSONObject $val = new JSONObject();
        JSONObject $val1 = new JSONObject();
        JSONObject $data = Ecm2GetStartNewProcess("");
        JSONObject $items = new JSONObject( $data.get("libraries").toString() );

        JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );
        String html_con = jget.has("html_replacement_selector")?jget.getString("html_replacement_selector"):"";

        $h1 = "<div class=\"row\"><div class=\"col-md-3\"></div><div class=\"col-md-6\"><div  style=\"background:#fff; padding:15px; box-shadow:2px 1px 2px #ddd;\">";
        $h2 = "</div></div></div>";

        $h1 += "<div class=\"row\">";
        $h1 += "<div class=\"col-md-12\">";
        $h1 += "<h4 class=\"data-form-title\">New ECM Process</h4>";
        $h1 += "<hr />";
        $h1 += "</div>";
        $h1 += "</div>";

        if( $h3 != "" ){
            $h1 += "<form id=\"new_workflow_item_form\" method=\"post\" o-action=\"?action=display_sub_menu&html_replacement_selector=new_workflow_item_form-container&view=tags_library&html_parent="+ html_con +"\" data-extra-action=\"&nwp2_action=ecm2&nwp2_todo=new_workflow_item_form\" class=\"activate-ajax \">";
            $h1 += "<div class=\"row\">";
            $h1 += "<div class=\"col-md-12\">";
            $h1 += "<label>Select The Process Type</label>";
            $h1 += "<div>";
            $h1 += "<select class=\"form-control select2\" name=\"id\" >";
            try{

                $h1 += "<option value=\"\"></option>";
                for(int i1 = 0; i1 < $items.names().length(); i1++){
                    $key = $items.names().getString(i1);
                    JSONObject a1 = new JSONObject( $items.get( $key ).toString() );

                    if(  a1.names().length() > 0 ){
                        $h1 += "<optgroup label=\"" + $key + "\">";
                        for(int i2 = 0; i2 < a1.names().length(); i2++){
                            $key1 = a1.names().getString(i2);
                            $val1 = new JSONObject( a1.get( $key1 ).toString() );

                            $h1 += "<option value=\"" + $val1.getString("id") + "\"";

                            if( $val1.has("new_job_action") && ! $val1.getString("new_job_action").isEmpty() ){
                                $h1 += " data-extra-action=\"" + $val1.getString("new_job_action") + "\"";
                            }

                            $h1 += "\">" + $val1.getString("name") + "</option>";
                        }
                        $h1 += "</optgroup>";
                    }

                }
            }catch (Exception e) {
                $h1 += "<option value=\"\">No Workflow Settings</option>";
            }

            $h1 += "</select>";
            $h1 += "</div>";
            $h1 += "</div>";
            $h1 += "</div>";
            $h1 += "</form>";


            out.println( $h1 + "<br /><div id=\"new_workflow_item_form-container\"></div>" + $h2 );
    %>
    <script type="text/javascript" >
	setTimeout(function(){
		$("form#new_workflow_item_form")
		.find("select[name=\"id\"]")
		.change(function(){
			if( $(this).val() ){
                var act = $("form#new_workflow_item_form").attr("o-action");
                //alert( $(this).find('option:selected').attr('data-extra-action') );
                if( $(this).find('option:selected').attr('data-extra-action') ){
                    //alert( $(this).find('option:selected').attr('data-extra-action') );
                    act += $(this).find('option:selected').attr('data-extra-action');
                }else{
                    act += $("form#new_workflow_item_form").attr("data-extra-action");
                }

                $("form#new_workflow_item_form").attr("action", act );
                $("form#new_workflow_item_form").submit();
			}
		});
	}, 300 );
</script>
    <%
        }else{
            out.println( "<div class=\"note note-danger\">You do not have access to any dept folder</div>" );
        }
    %>
</div>