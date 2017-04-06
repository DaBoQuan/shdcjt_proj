<%@ page language="java" contentType="text/html; charset=GBK" %> 
<%@ page import="weaver.general.Util" %>
<%@ page import="java.net.URLDecoder" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.systeminfo.menuconfig.LeftMenuHandler" %>
<%@ page import="weaver.systeminfo.menuconfig.LeftMenuInfo" %>

<html>
<%
	String menuId="";
	String menuName="";
    String menuLevel=""; 
    String parentId=""; 

    menuId = Util.null2String(request.getParameter("menuId"));
	menuName = Util.null2String(request.getParameter("menuName"));
    menuLevel = Util.null2String(request.getParameter("menuLevel"));
    parentId = Util.null2String(request.getParameter("parentId"));


    String sqlWhere = "";
    if(!menuId.equalsIgnoreCase("")){
        sqlWhere+=" and t1.id =" + menuId + " ";
    }
    if(!menuName.equalsIgnoreCase("")){
        sqlWhere+=" and t3.labelName like '%" + menuName + "%' ";
    }
    if(!menuLevel.equalsIgnoreCase("")&&!menuLevel.equalsIgnoreCase("0")){
        sqlWhere+=" and t1.menuLevel =" + menuLevel + " ";
    }
    if(!parentId.equalsIgnoreCase("")&&!parentId.equalsIgnoreCase("0")){
        sqlWhere+=" and t1.parentId =" + parentId + " ";
    }

    LeftMenuHandler leftMenuHandler = new LeftMenuHandler();
%>
<head>
<LINK href="/css/BacoSystem.css" type=text/css rel=STYLESHEET>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>

</head>
<BODY>
<DIV class=HdrTitle>
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD align=left width=55><IMG height=24 src="/images/hdDOC.gif"></TD>
    <TD align=left><SPAN id=BacoTitle class=titlename>����: ���˵�</SPAN></TD>
    <TD align=right>&nbsp;</TD>
    <TD width=5></TD>
  <tr>
 <TBODY>
</TABLE>
</div>

 <DIV class=HdrProps></DIV>

  <FORM style="MARGIN-TOP: 0px" name=frmSearch method=post action="\systeminfo\menuconfig\Maint\ManageLeftMenuOperation.jsp">
    <BUTTON class=btn id=btnSearch accessKey=S name=btnSearch type=submit onclick="searchlabel()"><U>S</U>-����</BUTTON>
    <BUTTON class=btn id=btnClear accessKey=R name=btnClear type=reset><U>R</U>-��������</BUTTON>
	<%if(Util.getIntValue(user.getSeclevel(),0)>=20){%>
    <BUTTON class=btn id=btnAdd accessKey=A name=btnAdd onclick="addTopLevelLeftMenu()"><U>A</U>-��Ӷ����˵�</BUTTON>
    <BUTTON class=btn id=btnAdd accessKey=A name=btnAdd onclick="addSubLevelLeftMenu()"><U>B</U>-����Ӳ˵�</BUTTON>
    <BUTTON class=btn id=btnDelete accessKey=D name=btnDelete onclick="deleteMenu()"><U>D</U>-ɾ��</BUTTON>
	<%}%>
    <BUTTON class=btn id=btnEdit accessKey=S name=btnEdit onclick="viewSQL()"><U>E</U>-����SQL</BUTTON>

    <br>
        <TABLE class=Form>
          <COLGROUP> <COL width="5%"> <COL width="32%"> <COL width=1> <COL width="10%"> <COL width="32%"> <TBODY>
          <TR class=Section>
            <TH colSpan=5>��������</TH>
          </TR>
          <TR class=Separator>
            <TD class=sep1 colSpan=5></TD>
          </TR>
		  <TR>
            <TD>���˵�ID</TD>
            <TD Class=Field colspan=4>
              <INPUT class=FieldxLong name=menuId accessKey=Z value="<%=menuId%>">
            </TD>
          </TR>
          <TR>
            <TD>���˵�����</TD>
            <TD Class=Field colspan=4>
              <INPUT class=FieldxLong name=menuName accessKey=Z value="<%=menuName%>">
            </TD>
          </TR>
          <TR>
            <TD>�˵��ȼ�</TD>
            <TD Class=Field colspan=4>
              <SELECT name=menuLevel>
                  <OPTION value=0></OPTION>
                  <OPTION value=1 <%if(menuLevel.equals("1")){%> selected <%}%>>�����˵�</OPTION>
                  <OPTION value=2 <%if(menuLevel.equals("2")){%> selected <%}%>>�Ӳ˵�</OPTION>
              </SELECT>
            </TD>
          </TR>
          <TR>
            <TD>�ϼ��˵�</TD>
            <TD class="field" colspan=4 >
              <BUTTON class=Browser onClick="onShowTopLevelLeftMenu()"></BUTTON>
              <SPAN id=parentIdSpan>
<%              if(Util.getIntValue(parentId,0)!=0){
                    LeftMenuInfo parentInfo = leftMenuHandler.getMenuInfo(Util.getIntValue(parentId,0));
%>
                    <%=parentInfo.getName(user.getLanguage())%>
<%              }       %>
              </SPAN>
              <INPUT type="hidden" name="parentId" value="<%=Util.getIntValue(parentId,0)%>">
            </TD>
          </TR>
          </TBODY>
        </TABLE>
        <br>
        <TABLE class=ListShort>
          <COLGROUP> <COL width="10%"> <COL width="30%"> <COL width="30%"> <COL width="10%"> <COL width="20%"> <TBODY>
          <TR class=Section>
            <TH colSpan=5>�������</TH>
          </TR>
          <TR class=Separator>
            <TD class=sep2 colSpan=5></TD>
          </TR>
          <TR class=Header>
            <Td >ѡ��</Td>
            <Td >��ʶ</Td>
            <Td >����</Td>
            <Td >�ȼ�</Td>
            <Td >ϸ��</Td>
          </TR>
          <%
          
          ArrayList leftMenuInfos = leftMenuHandler.getAllLeftMenuInfos(sqlWhere);
          for(int i = 0;i<leftMenuInfos.size();i++){
              LeftMenuInfo info = (LeftMenuInfo)leftMenuInfos.get(i);
          %>
<%            if(i%2==1){      %>
	      <TR CLASS="DataDark">
<%		      }else{          %>
	      <TR CLASS="DataLight">
<%		      }               %>
            <TD><input type="checkbox" name="deleteMenuId" value="<%=info.getId()%>" onClick=unselectall()></TD>
            <TD><%=info.getId()%></TD>
            <TD><%=SystemEnv.getHtmlLabelName(info.getLabelId(),user.getLanguage())%></TD>
            <TD ><%=info.getMenuLevel()%></TD>
            <TD><a href="LeftMenuEdit.jsp?id=<%=info.getId()%>"><img src="/images/iedit.gif" width="16" height="16" border="0"></a></TD>
          </TR>
<%        }%>

<TR class=Separator>
            <TD class=sep2 colSpan=5>
            <input type="hidden" name="operation" value="search">
            </TD>
          </TR>
<tr>
          </TBODY>
        </TABLE>
        <br>
        <input type="checkbox" name="checkall0" onClick="CheckAll(checkall0.checked)" value="ON">ȫ��ѡ��<br>

		<br><br>

      </FORM>

<script language="javascript">

function CheckAll(checked) {
    len = document.frmSearch.elements.length;   
    var i=0;
    
    for( i=0; i<len; i++) {
        if (document.frmSearch.elements[i].name=='deleteMenuId') {
            document.frmSearch.elements[i].checked=(checked==true?true:false);
        } 
    } 
}
function unselectall(){
    if(document.frmSearch.checkall0.checked){
        document.frmSearch.checkall0.checked =0;
    }
}

function confirmdel() {
	return confirm("ȷ��ɾ��ѡ������Ϣ��?") ;
}
function addTopLevelLeftMenu() {
	location="LeftMenuAdd.jsp?menuLevel=1";
}
function addSubLevelLeftMenu() {
	location="LeftMenuAdd.jsp?menuLevel=2";
}
function searchlabel() {
	document.frmSearch.operation.value="search";
	document.frmSearch.submit();
}
function deleteMenu() {
	document.frmSearch.operation.value="deleteMenu";
	if(confirmdel()){
		document.frmSearch.submit();
    }
}
function viewSQL(){
    document.frmSearch.action="LeftMenuViewSql.jsp";
    document.frmSearch.submit();
}
function onShowTopLevelLeftMenu(){
    var id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/systeminfo/menuconfig/Maint/TopLevelLeftMenuBrowser.jsp");
    if(id[0]!=null){
        if(id[0]!="0"){
            parentIdSpan.innerHTML = id[1];
            frmSearch.parentId.value=id[0];
        }
        else{
            parentIdSpan.innerHTML = "";
		    frmSearch.parentId.value="";
        }
    }
}
</script>


</BODY>
</HTML>
