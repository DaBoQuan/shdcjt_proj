<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ include file="/systeminfo/init.jsp" %>
<%
String resourceids=Util.null2String(request.getParameter("resourceids"));

int uid=user.getUID();
String resourcemulti=(String)session.getAttribute("resourcemulti");
if(resourcemulti==null){
	Cookie[] cks= request.getCookies();
	for(int i=0;i<cks.length;i++){
		//System.out.println("ck:"+cks[i].getName()+":"+cks[i].getValue());
		if(cks[i].getName().equals("resourcemulti"+uid)){
			resourcemulti=cks[i].getValue();
			break;
		}
	}
}
String tabid="0";
//if(resourcemulti!=null&&resourcemulti.length()>0){
//	String[] atts=Util.TokenizerString2(resourcemulti,"|");
//	tabid=atts[0];
//}
%>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<STYLE type="text/css">
PRE{}
A{COLOR:#000000;FONT-WEIGHT: bold; TEXT-DECORATION: none}
A:hover{COLOR:#56275D;TEXT-DECORATION:none}
</STYLE>
<script type="text/javascript">
function resetbanner(objid){
	for(i=0;i<=1;i++){
		jQuery("#oTDtype_"+i).attr("background","/images/tab/bgdark.gif");
	}
	jQuery("#oTDtype_"+objid).attr("background","/images/tab/bgdark.gif");
	if(objid==0){		        
		window.frame1.location="/email/MailContacterBrowserMultiTree.jsp";
		try{
			window.frame2.btnsub.style.display="none"
		}catch(err){}
	}else if(objid==1){
		window.frame1.location="/email/MailContacterBrowserMultiSearch.jsp";
		try{
			window.frame2.btnsub.style.display="none"
		}catch(err){}
	}
}
window.onload = function(){resetbanner(<%=tabid%>);}
</script>

</HEAD>
<body scroll="no">



<TABLE class=form width=100% id=oTable1 height=100%>
  <COLGROUP>
  <COL width="50%">
  <COL width=5>
  <COL width="50%">
  </colgroup>
  <TBODY>
  <tr>
  <td height=30 colspan=3 background="/images/tab/bg1.gif" align="left">
  <table cellspacing="0" cellpadding="0" style="width:100%;height:100%">
  <tr>
	  <td nowrap background="/images/tab/bg1.gif" width=15px height=100% align=center></td>
	  <td nowrap name="oTDtype_0"  id="oTDtype_0" background="/images/tab/bglight.gif" width=70px height=100% align=center onmouseover="style.cursor='hand'" onclick="resetbanner(0)" ><b>��ϵ��</b></td>
	  <td nowrap name="oTDtype_1"  id="oTDtype_1" background="/images/tab/bglight.gif" width=70px height=100% align=center onmouseover="style.cursor='hand'" onclick="resetbanner(1)" ><b>��ϲ�ѯ</b></td>
	  <td>&nbsp;</td>
  </tr>
  </table>
  </td>
  </tr>
<tr>
<td  id=oTd1 name=oTd1 width=100% height=40%>

<IFRAME name=frame1 id=frame1  width=100%  height=100% frameborder=no scrolling=auto>
�������֧��Ƕ��ʽ��ܣ�������Ϊ����ʾǶ��ʽ��ܡ�
</IFRAME>

</td>
</tr>
<tr>
<td  id=oTd2 name=oTd2 width=100% height=60%>

<IFRAME name=frame2 id=frame2 src="/email/MailContacterBrowserMultiSelect.jsp?contacterGroupId=0&tabid=<%=tabid%>&resourceids=<%=resourceids%>" width=100%  height=100% frameborder=no scrolling=no>
�������֧��Ƕ��ʽ��ܣ�������Ϊ����ʾǶ��ʽ��ܡ�
</IFRAME>

</td>
</tr>
</TBODY>
</table>





</body>
</html>