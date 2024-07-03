<%@ page import="org.json.JSONObject" %>
<div nwp-file="<%out.print( request.getAttribute("filename") );%>"  class="hyella-source-container">
    <%out.println( request.getAttribute("filename") );%>
    <div class="note note-danger"><%out.println( request.getAttribute("msg") );%></div>
    <div class="row">
    <%
        try{
            JSONObject j2 = new JSONObject( request.getAttribute("nwp_gdata").toString() );
            for(int i1 = 0; i1 < j2.names().length(); i1++) {
                String m1 = j2.names().getString(i1);

                out.println( "<div class=\"col-md-4\"><b>"+ m1 +"</b><br />"+ j2.get( m1 ).toString() +"<br /><br /></div>" );
            }
        }catch (Exception e) {
            out.println( "<h4>Unable to Read NWP_GDATA</h4>");
            out.println( request.getAttribute("nwp_gdata").toString() );
        }
        //out.println( new JSONObject( request.getAttribute("nwp_gdata").toString() ) );
    %>
    </div>
</div>