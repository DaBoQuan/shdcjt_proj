<%@ page import="weaver.general.Util,
                 weaver.docs.docs.CustomFieldManager" %>
<%@ page import="weaver.conn.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<SCRIPT language="javascript" src="/js/weaver.js"></script>
</head>
<%
    int userid = user.getUID();
    int scopeId = Util.getIntValue(request.getParameter("scopeid"),0);


    String imagefilename = "/images/hdDOC.gif";
    String titlename = SystemEnv.getHtmlLabelName(179,user.getLanguage())+"-"+SystemEnv.getHtmlLabelName(343,user.getLanguage());
    String needfav ="1";
    String needhelp ="";
%>
<%@ include file="HrmConstRpDataDefine.jsp" %>

<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
    RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:submitData(),_self} " ;
    RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
    <colgroup>
        <col width="10">
        <col width="">
        <col width="10">
    <tr>
        <td height="10" colspan="3"></td>
    </tr>
    <tr>
        <td ></td>
        <td valign="top">
            <TABLE class=Shadow>
                <tr>
                    <td valign="top">


<FORM id=weaver name=frmMain action="HrmConstRpSubOperation.jsp" method=post>
    <input class=inputstyle type=hidden name=userid value="<%=userid%>">
    <input class=inputstyle type=hidden name=scopeid value="<%=scopeId%>">

<TABLE class=ViewForm  width="100%">
    <colgroup>
        <col width="13%">
        <col width="20%">
        <col width="13%">
        <col width="20%">
        <col width="13%">
        <col width="20%">
<%

    rs.executeSql("select colname,showorder from HrmRpSubDefine where scopeid="+scopeId+" and resourceid="+userid+" order by showorder");
    HashMap hm= new HashMap();
    while(rs.next()){
        hm.put(rs.getString("colname"),rs.getString("showorder"));
    }
    for(int i=0; i<cids.size(); i++){
%>
    <TR>
        <td>
            <%=cFieldLabel.get(i)%>
        </td>
        <td class=Field>
            <input type=hidden name=fieldlabel value="<%=cFieldLabel.get(i)%>">
            <input type=hidden name=fieldname value="<%=cNames.get(i)%>">
            <input class=inputstyle type=text size=3 maxlength=3 name=fieldorder value="<%=(null==hm.get(cNames.get(i)))?"0":hm.get(cNames.get(i))%>" onKeyPress="ItemCount_KeyPress()" onBlur='checknumber2(this)'>
        </td>
<%
        if(++i<cids.size()){
%>
        <td>
            <%=cFieldLabel.get(i)%>
        </td>
        <td class=Field>
            <input type=hidden name=fieldlabel value="<%=cFieldLabel.get(i)%>">
            <input type=hidden name=fieldname value="<%=cNames.get(i)%>">
            <input class=inputstyle type=text size=3 maxlength=3 name=fieldorder value="<%=(null==hm.get(cNames.get(i)))?"0":hm.get(cNames.get(i))%>" onKeyPress="ItemCount_KeyPress()" onBlur='checknumber2(this)'>
        </td>
<%
        }else{
%>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    <TR style="height: 1px;"><TD class=Line colSpan=6></TD></TR>
    </tr>
<%
            break;
        }
%>

<%
        if(++i<cids.size()){
%>
        <td>
            <%=cFieldLabel.get(i)%>
        </td>
        <td class=Field>
            <input type=hidden name=fieldlabel value="<%=cFieldLabel.get(i)%>">
            <input type=hidden name=fieldname value="<%=cNames.get(i)%>">
            <input class=inputstyle type=text size=3 maxlength=3 name=fieldorder value="<%=(null==hm.get(cNames.get(i)))?"0":hm.get(cNames.get(i))%>" onKeyPress="ItemCount_KeyPress()" onBlur='checknumber2(this)'>
        </td>
<%
        }else{
%>
        <td></td>
        <td></td>
    <TR style="height: 1px;"><TD class=Line colSpan=6></TD></TR>
    </tr>
<%
            break;
        }
%>

    </TR>
    <TR style="height: 1px;"><TD class=Line colSpan=6></TD></TR>
<%
    }
%>
</TABLE>

</FORM>


                </td>
            </tr>
        </TABLE>
    </td>
        <td></td>
    </tr>
    <tr>
        <td height="10" colspan="3"></td>
    </tr>
</table>
<script language=javascript>
function submitData() {
 frmMain.submit();
}
function checknumber2(obj)
{
	valuechar = obj.value.split("") ;
	isnumber = false ;
	for(i=0 ; i<valuechar.length ; i++) { charnumber = parseInt(valuechar[i]) ; if( isNaN(charnumber)&& valuechar[i]!="." && valuechar[i]!="-") isnumber = true ;}
	if(isnumber) document.all(objectname).value = "" ;
}
</script>
</BODY>
</HTML>
