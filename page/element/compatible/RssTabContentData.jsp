<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.*" %>
<%@ include file="/homepage/element/content/Common.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="sci" class="weaver.system.SystemComInfo" scope="page" />
<%@page import="weaver.page.style.ElementStyleCominfo"%>
<%@ page import="java.lang.reflect.Constructor" %>
<%@ page import="java.lang.reflect.Method" %>
<%
	/*
		������Ϣ
		--------------------------------------
		hpid:����ҳID
		subCompanyId:��ҳ�����ֲ��ķֲ�ID
		eid:Ԫ��ID
		ebaseid:����Ԫ��ID
		styleid:��ʽID
		
		������Ϣ
		--------------------------------------
		String strsqlwhere ��ʽΪ ����1^,^����2...
		int perpage  ��ʾҳ��
		String linkmode �鿴��ʽ  1:��ǰҳ 2:����ҳ

		
		�ֶ���Ϣ
		--------------------------------------
		fieldIdList
		fieldColumnList
		fieldIsDate
		fieldTransMethodList
		fieldWidthList
		linkurlList
		valuecolumnList
		isLimitLengthList

		��ʽ��Ϣ
		----------------------------------------
		String esc.getIconEsymbol(pc.getStyleid(eid)) ����ͼ��
		class='sparator' �зָ��� 
	*/

String tableStr = "";
//���µ�ǰtab��Ϣ
String tabId = Util.null2String(request.getParameter("tabId"));
String updateSql = "update  hpcurrenttab set currenttab ='"+tabId+"' where eid="
	+ eid
	+ " and userid="
	+ user.getUID()
	+ " and usertype="
	+ user.getType();
rs.execute(updateSql);
%>
<%
//String tabId  = Util.null2String(request.getParameter("tabId"));
if(!tabId.equals("")){
	rs.execute("select tabId,tabTitle,sqlWhere from hpNewsTabInfo where eid="+eid+" and tabid= "+tabId);
	if(rs.next()){
		strsqlwhere = rs.getString("sqlWhere");
	}
}
//strsqlwhere = Util.null2String(request.getParameter("tabWhere"));
String rssReadType="";
String[] rssSettingList = Util.TokenizerString2(strsqlwhere,"^,^");
if(rssSettingList.length==4){
	rssReadType = rssSettingList[3];
	strsqlwhere = rssSettingList[0]+"^,^"+rssSettingList[1]+"^,^"+rssSettingList[2];
}else{
	rssReadType = rssSettingList[2];
	strsqlwhere = ""+"^,^"+rssSettingList[0]+"^,^"+rssSettingList[1];
}

if("2".equals(rssReadType)){
	try{
		Class tempClass=null;
		Method tempMethod=null;
		Constructor ct=null;
		tempClass = Class.forName("weaver.homepage.HomepageExtShow");	
		tempMethod = tempClass.getMethod("getRssContent", new Class[]{java.util.ArrayList.class,java.util.ArrayList.class,java.util.ArrayList.class,java.util.ArrayList.class,java.util.ArrayList.class,String.class,ElementStyleCominfo.class,String.class,String.class,String.class,weaver.hrm.User.class,
		javax.servlet.http.HttpServletRequest.class,String.class,String.class});
		ct = tempClass.getConstructor(null);
		tableStr=(String)tempMethod.invoke(ct.newInstance(null), new Object[] {fieldIdList,fieldColumnList,fieldIsDate,fieldWidthList,isLimitLengthList,strsqlwhere,esc,eid,linkmode,""+perpage,user,request,hpid,""+subCompanyId});
 		
 	}catch(Exception ex){
 		tableStr = ex.toString();
 	}
 	%>
 	
 	<TABLE id="_contenttable_<%=eid%>" class=Econtent width="100%" >
	         <TR>
	          <TD width=1px></TD>
	           <TD width='*'>
	               <%=tableStr%>
	           </TD>
	           <TD width=1px></TD>
	         </TR>
	</TABLE>
 	<%
 }%>
 <%		
if("1".equals(rssReadType)){
if("^,^1".equals(strsqlwhere)||"^,^2".equals(strsqlwhere)) return ;
String rssUrl =hpes.getRssUrlStr(strsqlwhere,perpage);
if("".equals(rssUrl)) return;

String imgSymbol="";
if (!"".equals(esc.getIconEsymbol(hpec.getStyleid(eid)))){
	imgSymbol="<img name='esymbol' src='"+esc.getIconEsymbol(hpec.getStyleid(eid))+"'>";
	imgSymbol=Util.replace(imgSymbol,"\\\\","/",0);
}
int size = fieldIdList.size();
int rssTitleLength=4;
boolean hasTitle=false;
boolean hasDate=false;
boolean hasTime=false;

String titleWidth="0";
String dateWidth="0";
String timeWidth="0";

for (int j = 0; j < size; j++) {
    String fieldId = (String) fieldIdList.get(j);
    String columnName = (String) fieldColumnList.get(j);
    String strIsDate = (String) fieldIsDate.get(j);
    String fieldwidth = (String) fieldWidthList.get(j);
    String isLimitLength = (String) isLimitLengthList.get(j);	
    if ("subject".equals(columnName)) {
        rssTitleLength = hpu.getLimitLength(""+eid, fieldId, "",user,""+hpid,subCompanyId);
		hasTitle=true;
		titleWidth="*";       
    } else if ("createdate".equals(columnName)) {
        hasDate=true;
		dateWidth=fieldwidth;		
    } else if ("createtime".equals(columnName)) {
        hasTime=true;
	    timeWidth=fieldwidth;
    }   
}
//System.out.println(imgSymbol);
%>
<div id = "rssContent_<%=eid%>"></div>

<SCRIPT LANGUAGE="JavaScript">
  loadRssElementContent("<%=eid%>","<%=rssUrl%>","<%=imgSymbol%>","<%=hasTitle%>","<%=hasDate%>","<%=hasTime%>","<%=titleWidth%>","<%=dateWidth%>","<%=timeWidth%>","<%=rssTitleLength%>","<%=linkmode%>","<%=size%>","<%=perpage%>",<%=user.getLanguage()%>);
</SCRIPT>
<%} %>
