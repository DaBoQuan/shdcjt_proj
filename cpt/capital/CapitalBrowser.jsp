<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ page import="weaver.general.Util" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="CapitalAssortmentComInfo" class="weaver.cpt.maintenance.CapitalAssortmentComInfo" scope="page" />
<jsp:useBean id="CapitalStateComInfo" class="weaver.cpt.maintenance.CapitalStateComInfo" scope="page"/>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="resourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<%
String CurrentUser = ""+user.getUID();
String userType = user.getLogintype();

String sqlwhere1 = Util.null2String(request.getParameter("sqlwhere"));
String name = Util.null2String(request.getParameter("name"));
String mark = Util.null2String(request.getParameter("mark"));
String fnamark = Util.null2String(request.getParameter("fnamark"));
//String departmentid = Util.null2String(request.getParameter("departmentid"));
String capitalSpec = Util.null2String(request.getParameter("capitalSpec"));
String stateid = Util.null2String(request.getParameter("stateid"));
String sptcount = Util.null2String(request.getParameter("sptcount"));
String isdata = Util.null2String(request.getParameter("isdata"));
//�ʲ����õ�������
String cptuse = Util.null2String(request.getParameter("cptuse"));
String rightStr= Util.null2String(request.getParameter("rightStr"));;//Ȩ���ж�
//�ʲ���ת���ҳ�� ���Բ鿴������0���ʲ�
String inculdeNumZero = Util.null2String(request.getParameter("inculdeNumZero"));
boolean viewall=false;
//ԭ��sqlwhere1��isdata������viewall��isdata������ҳ��̫������,�ֽ��ղ�����ͳһת��ΪisCapital����(0�ʲ����ϡ�1�ʲ�)�������ʲ�browser�����ʾ���
String isCapital="0";
//session.removeAttribute("workflowidbybrowser");
String billid=Util.null2String(request.getParameter("billid"));
//��session�洢��SESSION�У����������ã��ﵽ��ͬ�����̿���ʹ��ͬһ����򣬲�ͬ������
if (!billid.equals(""))
{
 int billids=Util.getIntValue(billid);
 switch (billids) {
	 case 220: //�ʲ�����
     sqlwhere1=" where isdata='2'  ";
	 sptcount="1";
	 stateid="1";
	 break;
	case 222: //�ʲ�����
     sqlwhere1=" where isdata='2'  ";
	 sptcount="1";
	 stateid="1,2,3";
	 break;
	 case 224: //�ʲ��黹
     sqlwhere1=" where isdata='2'  ";
	 //sptcount="1";
	 stateid="4,2,3";
	 break;
 }
}

//��sqlwhere1��isdata�����ж�
if(sqlwhere1.indexOf("isdata")!=-1){ 
    if(sqlwhere1.substring(sqlwhere1.indexOf("isdata='")+8,sqlwhere1.indexOf("isdata='")+9).equals("2")){
		isCapital = "1";
    }
}else{
    //isdata����Ϊ�ջ�2ʱ���ʲ�
    if (isdata.equals("") || isdata.equals("2")){
        isCapital = "1"; 
    }
}
String tabid="0";

%>
<HTML>
<HEAD>
<LINK REL=stylesheet type=text/css HREF=/css/Weaver.css>
</HEAD>
<BODY scroll="no">
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onSubmitClick(),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>

<FORM ID=SearchForm NAME=SearchForm STYLE="margin-bottom:0" action="/cpt/capital/CapitalBrowserList.jsp" method=post target="optFrame">
<input type=hidden name=sqlwhere value="<%=sqlwhere1%>">
<input type=hidden id=stateid name=stateid value="<%=stateid%>">
<input type=hidden id=sptcount name=sptcount value="<%=sptcount%>">
<input type=hidden id=isCapital name=isCapital value="<%=isCapital%>">
<input type=hidden id=billid name=billid value="<%=billid%>">
<input type=hidden id=inculdeNumZero name=inculdeNumZero value="<%=inculdeNumZero%>">
<input type=hidden id=capitalgroupid name=capitalgroupid> <!--Only for CapitalBrowserTree-->
<input type=hidden id=cptuse name=cptuse value="<%=cptuse%>">
<input type=hidden id=rightStr name=rightStr value="<%=rightStr%>">
<input type=hidden id=isInit name=isInit value="1">

<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr style="height:0px">
	<td height="0" colspan="3"></td>
</tr>
<tr>
	<td ></td>
	<td valign="top">
		<TABLE class=Shadow width="100%">
		<tr>
		<td valign="top">
            <table width=100% height=100% class="form" >
            <tr >
            <td height="30" align="left" background="/images/tab/bg1.gif" colSpan="3">
                <!--��ǩ��ťBegin-->
                <table width=100% height=100% border=0 cellspacing=0 cellpadding=0 >
                <tr align="left">
                    <td nowrap background="/images/tab/bg1.gif" width=15px height=100% align=center></td>

                    <td nowrap name="oTDtype_0"  id="oTDtype_0" background="/images/tab/bglight.gif" width=70px height=100% align=center onmouseover="style.cursor='pointer'" onclick="resetbanner(0)" ><b><%=SystemEnv.getHtmlLabelName(18692,user.getLanguage())%></b></td>

                    <td nowrap name="oTDtype_1"  id="oTDtype_1" background="/images/tab/bglight.gif" width=70px height=100% align=center onmouseover="style.cursor='pointer'" onclick="resetbanner(1)" ><b><%=SystemEnv.getHtmlLabelName(18412,user.getLanguage())%></b></td>

                    <td nowrap background="/images/tab/bg1.gif" width=100% height=100% align=center>&nbsp;</td>
                </tr>
                </table>
                <!--��ǩ��ťEnd-->
            </td>
            </tr>
            
            <!--�ʲ�����-->
            <tr height="40%" name="tr_0"  id="tr_0" style="display:">
            <td valign="top">
                <!--�ʲ�����Begin-->
                <IFRAME name=treeFrame id=treeFrame   width=100%  height=100% frameborder=no src="/cpt/capital/CapitalBrowserTree.jsp">
                �������֧��Ƕ��ʽ��ܣ�������Ϊ����ʾǶ��ʽ��ܡ�
                </IFRAME>
                <!--�ʲ�����End-->
            </td>
            </tr>

            <!--��ϲ�ѯ-->
            <tr height="40%" name="tr_1"  id="tr_1" style="display:none">
            <td valign="top">
                <!--��ϲ�ѯBegin-->
                <table width=100% class=ViewForm>
                <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>

                <tr>
                    <TD width=15% height=20px><%=SystemEnv.getHtmlLabelName(714,user.getLanguage())%></TD>
                    <TD width=35% class=field><input name=mark value="<%=mark%>" class="InputStyle" size="35"></TD>
                </tr>
                <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>

                <%if(isCapital.equals("1")){%>
                <tr>
                    <TD width=15% height=20px><%=SystemEnv.getHtmlLabelName(15293,user.getLanguage())%></TD>
                    <TD width=35% class=field><input name=fnamark value="<%=fnamark%>" class="InputStyle" size="35"></TD>
                </tr>
                <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
                <%}%>

                <tr>
                    <TD width=15%><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></TD>
                    <TD width=35% class=field><input name=name value="<%=name%>" class="InputStyle" size="35"></TD>
                </TR>
                <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>

                <%if(isCapital.equals("1")){%>
                <TR>
                    <TD width=15% height=20px><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></TD>
                    <TD width=35% class=field>
                        
                        <input class="wuiBrowser" id=departmentid type=hidden name="departmentid" value=""
						_url="/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp"
						_displayTemplate="<A href='/hrm/company/HrmDepartmentDsp.jsp?id=#b{id}'>#b{name}</A>"/>
                    </TD>
                </TR>
                <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>

                <tr>
                    <TD width=15%><%=SystemEnv.getHtmlLabelName(904,user.getLanguage())%></TD>
                    <TD width=35% class=field><input name=capitalSpec value="<%=capitalSpec%>" class="InputStyle" size="35"></TD>
                </TR>
                <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>

                <%}%>

                </table>
                <!--��ϲ�ѯEnd-->
            </td>
            </tr>

            <!--��ϸ�б�-->
            <tr height="6%">
            <td valign="top">
                <!--�ʲ����ϻ����ʲ��б�Begin-->
                <TABLE ID=BrowseTable class="BroswerStyle" cellspacing="0" height="100%" width="100%">
                <TR class=DataHeader>

                <!--�ʲ������б�-->
                <%if(isCapital.equals("0")){%>
                    <TH style='display:none'></TH>
                    <TH style='display:none'></TH>
                    <TH style='display:none'></TH>
                    <TH style='display:none'></TH>
					<TH width=25%><%=SystemEnv.getHtmlLabelName(19799,user.getLanguage())%></TH>
                    <TH width=30%><%=SystemEnv.getHtmlLabelName(714,user.getLanguage())%></TH>
                    <TH width=45%><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></TH>
                    <TH style='display:none'></TH>
                    <TH style='display:none'></TH>
                    <TH style='display:none'></TH>
                    <TH style='display:none'></TH>
                    <TH style='display:none'></TH>
                    <TH style='display:none'></TH>
                    <TH style='display:none'></TH>
                <% }%>

                <!--�ʲ��б�-->
                <%if(isCapital.equals("1")){%>
                    <TH style='display:none'></TH>
                    <TH style='display:none'></TH>
                    <TH style='display:none'></TH>
                    <TH style='display:none'></TH>
					<TH width=15%><%=SystemEnv.getHtmlLabelName(19799,user.getLanguage())%></TH>
                    <TH width=15%><%=SystemEnv.getHtmlLabelName(714,user.getLanguage())%></TH>
                    <TH width=24%><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></TH>
                    <TH width=14%><%=SystemEnv.getHtmlLabelName(15293,user.getLanguage())%></TH>
                    <TH width=8%><%=SystemEnv.getHtmlLabelName(602,user.getLanguage())%></TH>
                    <!--TH width=15%><%//SystemEnv.getHtmlLabelName(124,user.getLanguage())%></TH-->
                    <TH width=9%><%=SystemEnv.getHtmlLabelName(1331,user.getLanguage())%></TH>
                    <TH width=16%><%=SystemEnv.getHtmlLabelName(904,user.getLanguage())%></TH>
                    <TH style='display:none'></TH>
                    <TH style='display:none'></TH>
                    <TH width=7%>��</TH>
                <% }%>

                </TR>
                <TR class=Line><TH colspan="13"></TH></TR>
                </table>
                <!--�ʲ����ϻ����ʲ��б�End-->
            </td>
            </tr>

			<tr height="54%">
            <td valign="top">
                <!--�ʲ����ϻ����ʲ��б�Begin-->
                <TABLE ID=BrowseTable class="BroswerStyle" cellspacing="0" height="100%" width="100%">
                <TR><TD colspan="13" valign="top">
                    <IFRAME name=optFrame id=optFrame width=100% height=100% frameborder=no scrolling=yes src="/cpt/capital/CapitalBrowserList.jsp">
                    �������֧��Ƕ��ʽ��ܣ�������Ϊ����ʾǶ��ʽ��ܡ�
                    </IFRAME>
                </TD></TR>
                </table>
                <!--�ʲ����ϻ����ʲ��б�End-->
            </td>
            </tr>

            <tr>
            <td height="25" align="center">
                <BUTTON class=btn accessKey=C  type="button" onclick="btnclear_onclick()" id=btnclear><U>C</U>-<%=SystemEnv.getHtmlLabelName(311,user.getLanguage())%></BUTTON>
                <BUTTON class=btnReset type="button" accessKey=T  id=btncancel onclick="btncancel_onclick()" ><U>T</U>-<%=SystemEnv.getHtmlLabelName(201,user.getLanguage())%></BUTTON>
            </td>
            </tr>
            </TABLE>
        </td>
		</tr>
		</TABLE>
	</td>
	<td></td>
</tr>
<tr  style="height:0px">
	<td height="0" colspan="3"></td>
</tr>
</table>

</FORM>
</BODY></HTML>
<script LANGUAGE=VBS>



sub FromDeparment(inputname,spanname)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp?selectedids="&inputname.value)
	if (Not IsEmpty(id)) then
        if id(0)<> 0 then
            spanname.innerHtml ="<A href='/hrm/company/HrmDepartmentDsp.jsp?id="&id(0)&"'>"&id(1)&"</A>"
            inputname.value=id(0)
        else
            inputname.value=""
        end if
	end if
end sub
</script>
<script language="javascript">
function btnclear_onclick(){
     window.parent.parent.returnValue = {id:"",name:""}//Array(0,"")
     window.parent.parent.close();
}

function btncancel_onclick(){
     window.parent.parent.close();
}

function onSubmitClick()
{
	jQuery("#isInit").val("1");
	onSubmit();
}

function onSubmit()
{
	jQuery("#capitalgroupid").val("");
    document.forms[0].submit();
}

function resetbanner(objid){

    for(i=0;i<=1;i++){
		$("#oTDtype_"+i).attr("background","/images/tab/bgdark.gif");
    }
	$("#oTDtype_"+objid).attr("background","/images/tab/bglight.gif");
    if(objid == 0 ){
        jQuery("#tr_0").css("display","");
        jQuery("#tr_1").css("display","none");
    }
    else if(objid == 1){
        jQuery("#tr_0").css("display","none");
        jQuery("#tr_1").css("display","");
    }
}

function init(){
  resetbanner(<%=tabid%>);
  jQuery("#isInit").val("0");
  onSubmit();
}

init();
</script>