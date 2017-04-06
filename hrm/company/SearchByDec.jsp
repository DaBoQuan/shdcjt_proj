<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="RoleComInfo" class="weaver.hrm.roles.RolesComInfo" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />

<HTML><HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver.css>


</HEAD>

<body>
<%
int uid=user.getUID();
    String departmentmultiDecOrder = null;

    Cookie[] cks = request.getCookies();

    for (int i = 0; i < cks.length; i++) {
        //System.out.println("ck:"+cks[i].getName()+":"+cks[i].getValue());
        if (cks[i].getName().equals("departmentmultiDecOrder" + uid)) {
            departmentmultiDecOrder = cks[i].getValue();
            break;
        }
    }

    String rem="1"+departmentmultiDecOrder.substring(1);
Cookie ck = new Cookie("departmentmultiDecOrder"+uid,rem);
ck.setMaxAge(30*24*60*60);
response.addCookie(ck);

%>
	<FORM NAME="SearchForm" STYLE="margin-bottom:0" action="MultiSelect.jsp" method="post" target="frame2">
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
	<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:document.SearchForm.btnsub.click(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
	%>
	<BUTTON class=btnSearch accessKey=S style="display:none"  id=btnsub onclick="btnsub_onclick();"><U>S</U>-<%=SystemEnv.getHtmlLabelName(197,user.getLanguage())%></BUTTON>
        <%
RCMenu += "{"+SystemEnv.getHtmlLabelName(199,user.getLanguage())+",javascript:document.SearchForm.reset(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<BUTTON class=btnReset accessKey=T style="display:none" type=reset ><U>T</U>-<%=SystemEnv.getHtmlLabelName(199,user.getLanguage())%></BUTTON>

	<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(826,user.getLanguage())+",javascript:document.SearchForm.btnok.click(),_self}";
	RCMenuHeight += RCMenuHeightStep ;
	%>
	<!-- 2012-08-15 ypc �޸� �����btnok_onclick() �¼� -->
	<BUTTON class=btn accessKey=O style="display:none" id=btnok onclick="btnok_onclick();"><U>O</U>-<%=SystemEnv.getHtmlLabelName(826,user.getLanguage())%></BUTTON>

	<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(201,user.getLanguage())+",javascript:window.parent.parent.close(),_self}";
	RCMenuHeight += RCMenuHeightStep ;
	%>
	<BUTTON class=btnReset accessKey=T style="display:none" id="btncancel"><U>T</U>-<%=SystemEnv.getHtmlLabelName(201,user.getLanguage())%></BUTTON>


	<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(311,user.getLanguage())+",javascript:document.SearchForm.btnclear.click(),_self}" ;
	RCMenuHeight += RCMenuHeightStep ;
	%>
	<!-- 2012-08-15 ypc �޸� �����btnclear_onclick() �¼� -->
	<BUTTON class=btn accessKey=2 style="display:none" id=btnclear onclick="btnclear_onclick();"><U>2</U>-<%=SystemEnv.getHtmlLabelName(311,user.getLanguage())%></BUTTON>

<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<script>
rightMenu.style.visibility='hidden'
</script>

<table width=100%  class=ViewForm  valign=top>
<TR style="height:5%"><TD class=Line1 colspan=4></TD>
</TR>
<tr>
<TD height="15" colspan=4 > &nbsp;</TD>
</tr>
<TR>
<TD width=15% class=lable><%=SystemEnv.getHtmlLabelName(15390,user.getLanguage())%></TD>
<TD width=35% class=Field1 colspan="3"><input class=inputstyle name=deptname size="40"></TD>
</tr>
<TR style="height:5%"><TD class=Line colSpan=4></TD></TR>
<TR>
<TD width=15% class=lable><%=SystemEnv.getHtmlLabelName(22806,user.getLanguage())%></TD>
      <TD width=35% class=Field1 colspan="3">
        <input class=inputstyle name=deptcode size="40">
      </TD>
</tr>
<TR style="height:5%"><TD class=Line colSpan=4></TD></TR>
<TR>
<TD colspan="4">&nbsp;</TD>
</tr>
<TR>
<TD colspan="4">&nbsp;</TD>
</tr>
<TR>
<TD colspan="4">&nbsp;</TD>
</tr>
    <TR>
<TD colspan="4">&nbsp;</TD>
</tr>
    <TR>
<TD colspan="4">&nbsp;</TD>
</tr> 

    <TR style="height:5%"><TD class=Line colSpan=4></TD></TR>

	<TR style="height:5%"><TD class=Line1 colspan=4></TD></TR>
</table>
<input class=inputstyle type="hidden" name="sqlwhere" value='<%=Util.null2String(request.getParameter("sqlwhere"))%>'>
  <input class=inputstyle type="hidden" name="resourceids" >
<input class=inputstyle type="hidden" name="tabid" >
	<!--########//Search Table End########-->
	</FORM>
<!--
<SCRIPT LANGUAGE=VBS>
resourceids =""
resourcenames = ""

Sub btnclear_onclick()
     window.parent.returnvalue = Array("","")
     window.parent.close
End Sub


Sub btnok_onclick()
	 setResourceStr()
     replaceStr()
     window.parent.returnvalue = Array(resourceids,resourcenames)
    window.parent.close
End Sub

Sub btnsub_onclick()
	setResourceStr()
    document.all("resourceids").value = Mid(resourceids,2)
    document.all("tabid").value=1
    document.SearchForm.submit
End Sub

Sub btncancel_onclick()
     window.close()
End Sub
</SCRIPT>  -->

<script language="javascript">
//2012-08-15 ypc  ��Ӵ˺���

function btnsub_onclick(){
	setResourceStr();
    $G("resourceids").value = resourceids.substr(1);
    $("input[name=tabid]").val(1); //�����val(2) ��Ϊval(1) �Ϳ��Խ���� ����֮��������ť�����˵����� 2012-08-15 ypc �޸�
    document.SearchForm.submit();
}
//2012-08-15 ypc ��� ԭ���ǣ���ҳ��� ȷ���Ҽ��˵��� �¼���������vbs��д�� ��Google�ͻ���ǲ��ܽ����� ���Ը�Ϊjs
function btnclear_onclick(){
    window.parent.parent.returnValue = {id:"",name:""};
    window.parent.parent.close();
}
//2012-08-15 ypc ��� ԭ���ǣ���ҳ��� ȷ���Ҽ��˵��� �¼���������vbs��д�� ��Google�ͻ���ǲ��ܽ����� ���Ը�Ϊjs end
function btnok_onclick(){
	setResourceStr();
    replaceStr();
    window.parent.parent.returnValue = {id:resourceids,name:resourcenames};
	window.parent.parent.close();
}

function setResourceStr(){

	var resourceids1 =""
        var resourcenames1 = ""
     try{
	for(var i=0;i<parent.frame2.resourceArray.length;i++){
		resourceids1 += ","+parent.frame2.resourceArray[i].split("~")[0] ;

		resourcenames1 += ","+parent.frame2.resourceArray[i].split("~")[1] ;
	}
	resourceids=resourceids1
	resourcenames=resourcenames1
     }catch(err){}
}

function replaceStr(){
    var re=new RegExp("[ ]*[|][^|]*[|]","g")
    resourcenames=resourcenames.replace(re,"|")
    re=new RegExp("[|][^,]*","g")
    resourcenames=resourcenames.replace(re,"")
}

function onShowSubcompany(){
	var results = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser.jsp?selectedids="+jQuery("#subcompanyid").val());
	if(results){
		if (results.id!="" ){
			subcompanyspan.innerHTML =results.name;
			$G("subcompanyid").value=results.id;
		    $G("departmentspan").innerHTML="";
		    $G("departmentid").value="";
		}
		else{
			subcompanyspan.innerHTML ="";
			$G("subcompanyid").value="";
		}
	}
}
function onShowDepartment(){
    var results = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp?selectedids="+jQuery("#departmentid").val());
	if (results){
		if (results.id!="") {
				departmentspan.innerHTML =results.name;
				document.SearchForm.departmentid.value=results.id;
				subcompanyspan.innerHTML="";
				document.SearchForm.subcompanyid.value="";
			}
            else{
				departmentspan.innerHTML="";
				document.SearchForm.departmentid.value="";
			}
	}
}

function onShowRole(){
	var results = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/roles/HrmRolesBrowser.jsp")
	if(results){
	     if (results.id!= "" ){
			rolespan.innerHTML=results.name;
			document.SearchForm.roleid.value=results.id;
		}
		else{
			rolespan.innerHTML=results.name;
			document.SearchForm.roleid.value="";
		}
	}
}
</script>
</BODY>
</HTML>