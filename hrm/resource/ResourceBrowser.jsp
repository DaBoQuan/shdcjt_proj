<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>

<%
String needsystem=Util.null2String(request.getParameter("needsystem"));
String from  = Util.null2String(request.getParameter("from"));
int uid=user.getUID();
String resourcesingle=(String)session.getAttribute("resourcesingle");
        if(resourcesingle==null){
        Cookie[] cks= request.getCookies();
        
        for(int i=0;i<cks.length;i++){
        //System.out.println("ck:"+cks[i].getName()+":"+cks[i].getValue());
        if(cks[i].getName().equals("resourcesingle"+uid)){
        resourcesingle=cks[i].getValue();
        break;
        }
        }
        }
String tabid="0";
if(resourcesingle!=null&&resourcesingle.length()>0){
String[] atts=Util.TokenizerString2(resourcesingle,"|");
tabid=atts[0];

}

%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<STYLE type=text/css>PRE {
}
A {
	COLOR:#000000;FONT-WEIGHT: bold; TEXT-DECORATION: none
}
A:hover {
	COLOR:#56275D;TEXT-DECORATION: none
}
</STYLE>


</HEAD>
<body scroll="no">



<TABLE class=form width=100% id=oTable1 height=100%>
  <COLGROUP>
  <COL width="50%">
  </colgroup>
  <TBODY>
  <tr>
  <td  height=30 colspan=3 background="/images/tab/bg1.gif" align=left>
  <table width=100% border=0 cellspacing=0 cellpadding=0 height=100%  >
  <tr align="left">
  <td nowrap background="/images/tab/bg1.gif" width=15px height=100% align=center></td> 
  
  <td nowrap name="oTDtype_0"  id="oTDtype_0" background="/images/tab/bglight.gif" width=70px height=100% align=center onmouseover="style.cursor='pointer'" onclick="resetbanner(0)" ><b><%=SystemEnv.getHtmlLabelName(18770,user.getLanguage())%></b></td>
 
  <td nowrap name="oTDtype_1"  id="oTDtype_1" background="/images/tab/bglight.gif" width=70px height=100% align=center onmouseover="style.cursor='pointer'" onclick="resetbanner(1)" ><b><%=SystemEnv.getHtmlLabelName(18771,user.getLanguage())%></b></td>
 
  <td nowrap name="oTDtype_2"  id="oTDtype_2" background="/images/tab/bglight.gif" width=70px height=100% align=center onmouseover="style.cursor='pointer'" onclick="resetbanner(2)" ><b><%=SystemEnv.getHtmlLabelName(18412,user.getLanguage())%></b></td>

  <td nowrap name="oTDtype_3"  id="oTDtype_3" height="100%" >&nbsp;</td>
  </tr>
  </table>
  </td>
  </tr>
<tr>
<td  id=oTd1 name=oTd1 width=100% height=40%>

<IFRAME name=frame1 id=frame1   width=100%  height=100% frameborder=no scrolling=no>
�������֧��Ƕ��ʽ��ܣ�������Ϊ����ʾǶ��ʽ��ܡ�
</IFRAME>

</td>
</tr>
<tr>
<td  id=oTd2 name=oTd2 width="100%" height=60%>

<IFRAME name=frame2 id=frame2 src="/hrm/resource/Select.jsp?tabid=<%=tabid%>&needsystem=<%=needsystem%>&from=<%=from%>" width=100%  height=100% frameborder=no scrolling=no>
�������֧��Ƕ��ʽ��ܣ�������Ϊ����ʾǶ��ʽ��ܡ�
</IFRAME>

</td>
</tr>
</TBODY>
</table>



<script language=javascript>
	function resetbanner(objid){

		for(i=0;i<=2;i++){
			$("#oTDtype_"+i).attr("background","/images/tab/bgdark.gif");
		}
		$("#oTDtype_"+objid).attr("background","/images/tab/bglight.gif");
		
		 var curDoc;
			if(document.all){
				curDoc=window.frames["frame2"].document
			}
			else{
				curDoc=document.getElementById("frame2").contentDocument	
			}
		
		if(objid == 0 ){
		        window.frame1.location="/hrm/resource/SingleSearchByOrgan.jsp?needsystem=<%=needsystem%>&from=<%=from%>";	
		        try{
		        $(curDoc).find("#btnsub").css("display","none");
		        //2012-08-10 ypc �޸�
			    //window.frame2.btnsub.style.display="none"  ����д�� ������ҳ���л���ʱ��������ť���� ��ҳ����л�����
			}catch(err){}
		        }		
		else if(objid == 1){
			window.frame1.location="/hrm/resource/SingleSearchByGroup.jsp?needsystem=<%=needsystem%>";
			try{
			$(curDoc).find("#btnsub").css("display","none");
			//2012-08-10 ypc �޸�
			//window.frame2.btnsub.style.display="none" ����д�� ������ҳ���л���ʱ��������ť���� ��ҳ����л�����
			}catch(err){}
			}
		else if(objid == 2){
			window.frame1.location="/hrm/resource/SingleSearch.jsp?needsystem=<%=needsystem%>&from=<%=from%>";
			try{
			$(curDoc).find("#btnsub").css("display","inline");
			//2012-08-10 ypc �޸�
			//window.frame2.btnsub.style.display="inline" ����д�� ������ҳ���л���ʱ��������ť���� ��ҳ����л�����
			}catch(err){}
			}
	}

resetbanner(<%=tabid%>);
</script>

</body>
</html>