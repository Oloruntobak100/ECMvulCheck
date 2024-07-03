<%@ page import="org.json.JSONObject" %>
<%@ page import="static codes.nwpWorkflow.VisualiseWorkflow" %>
<%@ page import="codes.GlobalFunctions" %>
<%
    JSONObject jget = new JSONObject( request.getAttribute("nwp_gdata").toString() );
    JSONObject jpet = new JSONObject( request.getAttribute("nwp_pdata").toString() );

    if( jpet.has("id") && ! jpet.getString("id").isEmpty() ){

        JSONObject jdata = new JSONObject();
        jdata.put("id", jpet.getString("id") );
        jdata.put("post", jpet );

        JSONObject rd = VisualiseWorkflow( jdata );
        //JSONObject rd = new JSONObject();
        //out.print( "<pre>" + rd + "</pre>" ); rd = new JSONObject();
        //out.print( "<pre>" + jdata + "</pre>" );

        if( rd.has( "error" ) ){

            GlobalFunctions.app_notice_type = "error";
            GlobalFunctions.app_notice = rd.getString( "error" );
            GlobalFunctions.app_notice_only = true;

        }else{

            GlobalFunctions.app_popup = true;
            GlobalFunctions.app_popup_title = "Workflow Settings Approval Chain";
            GlobalFunctions.app_popup_style = " min-width:55%; ";

            if( rd.has( "other_params" ) && rd.getJSONObject( "other_params" ).has( "flow" ) && rd.getJSONObject( "other_params" ).getJSONArray( "flow" ).length() > 0 ){
                //$data["other_params"]["flow_count"];
                Integer $h = rd.getJSONObject( "other_params" ).getInt( "flow_count" ) * 280; %>
<div id="drawing" style="margin:30px auto; width:auto; text-align:center; overflow-y:auto;"></div>
<script type="text/javascript" >
    setTimeout(function(){
        flowSVG.draw(SVG('drawing').size(700, <% out.print( $h ); %>));
        flowSVG.config({
            interactive: false,
            showButtons: false,
            connectorLength: 60,
            defaultFontSize: 17,
            w: 250,
            h: 210,
            scrollto: true
        });
        flowSVG.shapes(	<% out.print( rd.getJSONObject( "other_params" ).getJSONArray( "flow" ).toString() ); %>);
    }, 500);
</script>
<% }else{ %>
<div class="note note-danger">Invalid Process Flow</div>
<% }

}
}else{
    out.print( "No record id specified" );
}
%>