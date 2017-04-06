<%@ page language="java" contentType="text/html; charset=GBK" %> 

<%@ include file="/systeminfo/init.jsp" %>

<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.Constants" %>
<%@ page import="weaver.viewform.workplan.WorkPlanVisitViewForm" %>

<%
    if(!HrmUserVarify.checkUserRight("WorkPlanReportSet:Set", user))
    {
        response.sendRedirect("/notice/noright.jsp");
        return;
    }
%>

<HTML>
<HEAD>
  <LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
  <SCRIPT language="javascript" src="../../js/weaver.js"></SCRIPT>
</HEAD>

<BODY>
<!--============================= MainFrame������ʾ��ʼ =============================-->
<%
    String imagefilename = "/images/hdMaintenance.gif";
    String titlename = SystemEnv.getHtmlLabelName(82, user.getLanguage()) + ":" + SystemEnv.getHtmlLabelName(19043, user.getLanguage());
    String needhelp ="";
%>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<!--============================= MainFrame������ʾ���� =============================-->

<!--============================= �Ҽ��˵���ʼ =============================-->
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
    RCMenu += "{" + SystemEnv.getHtmlLabelName(826,user.getLanguage()) + ",javascript:doSave(),_self}";
    RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<!--============================= �Ҽ��˵����� =============================-->

  <TABLE width=100% height=100% border="0" cellspacing="0" cellpadding="0">
    <COLGROUP>
      <COL width="10">
      <COL width="">
      <COL width="10">
    <TR>
      <TD height="10" colspan="3"></TD>
    </TR>
    <TR>
      <TD ></TD>
      <TD valign="top">
        <TABLE class=Shadow>
          <TR>
            <TD valign="top">  
              <form name="weaver" action="WorkPlanReportSetOperation.jsp?method=addWorkPlanSet" method="post">
                <TABLE class=ViewForm>
                  <COLGROUP>
                    <COL width="20%">
                    <COL width="80%">
                  <TBODY>
                    <!--============================= ѡ��鿴��Ա�ͱ�ͳ����Ա��ʼ =============================-->
                    
                    <!--============================= �鿴��Ա��ʾ���ֿ�ʼ============================-->
                    <TR>
                      <TD>
                        <%=SystemEnv.getHtmlLabelName(19040,user.getLanguage())%>
                      </TD>
                      <TD class="field">
                        <SELECT class=InputStyle name=WorkPlanVisitType onchange="onChangeVisitType()">   
                          <OPTION value="<%= Constants.Hrm_SubCompany %>" selected><%=SystemEnv.getHtmlLabelName(141,user.getLanguage())%></OPTION> 
                          <OPTION value="<%= Constants.Hrm_Department %>"><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></OPTION> 
                          <OPTION value="<%= Constants.Hrm_Station %>"><%=SystemEnv.getHtmlLabelName(6086,user.getLanguage())%></OPTION> 
                          <OPTION value="<%= Constants.Hrm_Role %>"><%=SystemEnv.getHtmlLabelName(122,user.getLanguage())%></OPTION> 
                          <OPTION value="<%= Constants.Hrm_All_Member %>"><%=SystemEnv.getHtmlLabelName(235,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(127,user.getLanguage())%></OPTION> 
                          <OPTION value="<%= Constants.Hrm_Resource %>"><%=SystemEnv.getHtmlLabelName(179,user.getLanguage())%></OPTION> 
                        </SELECT>
                        &nbsp;&nbsp;
                        <!--======== �ֲ���ѡ�� ========-->
                        <BUTTON class=Browser style="display:''" onClick="onShowSubcompany('VisitRelatedShareID', 'VisitShowRelatedShareName')" name=VisitShowSubCompany></BUTTON>
                        <!--======== ���Ŷ�ѡ�� ========-->
                        <BUTTON class=Browser style="display:none" onClick="onShowDepartment(VisitRelatedShareID, VisitShowRelatedShareName)" name=VisitShowDepartment></BUTTON>
                        <!--======== ��λ��ѡ�� ==========-->
                        <BUTTON class=Browser style="display:none" onclick="onShowPost('VisitRelatedShareID', VisitShowRelatedShareName)" name=VisitShowPost></BUTTON>
                        <!--======== ��ɫ��ѡ�� ========-->
                        <BUTTON class=Browser style="display:none" onclick="onShowRole('VisitRelatedShareID', 'VisitShowRelatedShareName')" name=VisitShowRole></BUTTON>
                        <!--======== �����˶�ѡ�� ========-->
                        
                        <!--======== ������Դ��ѡ�� ========-->
                        <BUTTON class=Browser style="display:none" onClick="onShowResource(VisitRelatedShareID, VisitShowRelatedShareName)" name=VisitShowResource></BUTTON> 

                        <INPUT type=hidden name=VisitRelatedShareID id="VisitRelatedShareID" value="">
                        <SPAN id=VisitShowRelatedShareName name=VisitShowRelatedShareName><IMG src='/images/BacoError.gif' align=absMiddle></SPAN>                                            
                      </TD>       
                    </TR>
                    <TR>
                      <TD class=Line colSpan=2 id=VisitShowRoleLevelLine name=VisitShowRoleLevelLine style=""></TD>
                    </TR>
                    <TR id=VisitShowSecLevel name=VisitShowSecLevel style="">
                      <TD><%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%>&nbsp<%=SystemEnv.getHtmlLabelName(325,user.getLanguage())%></TD>
                      <TD class="field">
                        <INPUT type=text name=VisitSecLevel class=InputStyle size=6 value="10" onchange='checkinput("VisitSecLevel","VisitSecLevelImage")' onkeypress="ItemCount_KeyPress()">
                        <SPAN id=VisitSecLevelImage></SPAN>
                      </TD>
                    </TR>
                    <TR>
                       <TD class=Line colSpan=2 id=VisitShowSecLevelLine name=VisitShowSecLevelLine style="display:none"></TD>
                    </TR>
                    <!--============================= �鿴��Ա��ʾ���ֽ���====================-->
                                        
                    <TR  class=Spacing>
                      <TD class=Line colSpan=2></TD>
                    </TR>
                    
                    <!--============================= ��ͳ����Ա��ʾ���ֿ�ʼ============================-->
                    <TR>
                      <TD>
                        <%=SystemEnv.getHtmlLabelName(19038,user.getLanguage())%>
                      </TD>
                      <TD class="field">
                        <SELECT class=InputStyle name=WorkPlanReportType onchange="onChangeReportType()">   
                          <OPTION value="<%= Constants.Hrm_SubCompany %>" selected><%=SystemEnv.getHtmlLabelName(141,user.getLanguage())%></OPTION> 
                          <OPTION value="<%= Constants.Hrm_Department %>"><%=SystemEnv.getHtmlLabelName(124,user.getLanguage())%></OPTION> 
                          <OPTION value="<%= Constants.Hrm_Station %>"><%=SystemEnv.getHtmlLabelName(6086,user.getLanguage())%></OPTION> 
                          <OPTION value="<%= Constants.Hrm_Role %>"><%=SystemEnv.getHtmlLabelName(122,user.getLanguage())%></OPTION> 
                          <OPTION value="<%= Constants.Hrm_All_Member %>"><%=SystemEnv.getHtmlLabelName(235,user.getLanguage())%><%=SystemEnv.getHtmlLabelName(127,user.getLanguage())%></OPTION> 
                          <OPTION value="<%= Constants.Hrm_Resource %>"><%=SystemEnv.getHtmlLabelName(179,user.getLanguage())%></OPTION> 
                        </SELECT>
                        <!--======== �ֲ���ѡ�� ========-->
                        <BUTTON class=Browser style="display:''" onClick="onShowSubcompany('ReportRelatedShareID', 'ReportShowRelatedShareName')" name=ReportShowSubCompany></BUTTON>
                        <!--======== ���Ŷ�ѡ�� ========-->
                        <BUTTON class=Browser style="display:none" onClick="onShowDepartment(ReportRelatedShareID, ReportShowRelatedShareName)" name=ReportShowDepartment></BUTTON>
                        <!--======== ��λ��ѡ�� ==========-->
                        <BUTTON class=Browser style="display:none" onclick="onShowPost('ReportRelatedShareID', ReportShowRelatedShareName)" name=ReportShowPost></BUTTON>
                        <!--======== ��ɫ��ѡ�� ========-->
                        <BUTTON class=Browser style="display:none" onclick="onShowRole('ReportRelatedShareID', 'ReportShowRelatedShareName')" name=ReportShowRole></BUTTON>
                        <!--======== ������Դ��ѡ�� ========-->
                        <BUTTON class=Browser style="display:none" onClick="onShowResource(ReportRelatedShareID, ReportShowRelatedShareName)" name=ReportShowResource></BUTTON> 

                        <INPUT type=hidden name=ReportRelatedShareID id="ReportRelatedShareID" value="">
                        <SPAN id=ReportShowRelatedShareName name=ReportShowRelatedShareName><IMG src='/images/BacoError.gif' align=absMiddle></SPAN>                                            
                      </TD>       
                    </TR>
                    <TR>
                      <TD class=Line colSpan=2 id=ReportShowRoleLevelLine name=ReportShowRoleLevelLine style=""></TD>
                    </TR>
                    <TR id=ReportShowSecLevel name=ReportShowSecLevel style="">
                      <TD><%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%>&nbsp<%=SystemEnv.getHtmlLabelName(326,user.getLanguage())%></TD>
                      <TD class="field">
                        <INPUT type=text name=ReportSecLevel class=InputStyle size=6 value="10" onchange='checkinput("ReportSecLevel","ReportSecLevelImage")' onkeypress="ItemCount_KeyPress()">
                        <SPAN id=ReportSecLevelImage></SPAN>
                      </TD>
                    </TR>
                    <TR>
                       <TD class=Line colSpan=2 id=ReportShowSecLevelLine name=ReportShowSecLevelLine style="display:none"></TD>
                    </TR>
                    <!--============================= ��ͳ����Ա��ʾ���ֽ���===========================-->
                                      
                    <!--============================= ѡ��鿴��Ա�ͱ�ͳ����Ա���� =============================-->
                    
                    <TR>
                      <TD colspan=2>
                        <TABLE  width="100%">
                          <TR>
                            <TD width="40%"></TD>
                            <TD width="20%"><img src="/images/arrow_d.gif" style="cursor:hand" title="���" onclick="addValue()" border="0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="/images/arrow_u.gif" style="cursor:hand" title="�Ƴ�" border="0" onclick="removeValue()"></TD>
                            <TD width="40%"></TD>
                          </TR>
                        </TABLE>
                      </TD>
                    <TR>
                    
                    <!--============================= ��ͳ����Ա�Ͳ鿴��Ա�б�ʼ =============================-->
                    <TR>
                      <TD class=Line colSpan=2></TD>
                    </TR>                    
                    <TR>
                      <TD colspan=2>
                        <table class="listStyle" id="oTable" name="oTable">
                          <COLGROUP>
                            <COL width="4%" align="center">
                            <COL width="24%" align="center">
                            <COL width="24%" align="center">
                            <COL width="24%" align="center">
                            <COL width="24%" align="center">
                          <TR class="header">
                            <TD><input type="checkbox" name="chkAll" onclick="chkAllClick(this)"></TD>
                            <TD><%=SystemEnv.getHtmlLabelName(19039,user.getLanguage())%></TD>
                            <TD><%=SystemEnv.getHtmlLabelName(19038,user.getLanguage())%>/<%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%></TD>
                            <TD><%=SystemEnv.getHtmlLabelName(19041,user.getLanguage())%></TD>
                            <TD><%=SystemEnv.getHtmlLabelName(19040,user.getLanguage())%>/<%=SystemEnv.getHtmlLabelName(683,user.getLanguage())%></TD>
                          </TR>
                          <TR class=line>
                            <TD COLspan=6></TD>
                          </TR>
                        </table>
                      </TD>
                    </TR>
                    <!--============================= ��ͳ����Ա�Ͳ鿴��Ա�б���� =============================-->
                    
                  </TBODY>
                </TABLE>
              </form>
            </TD>
          </TR>
        </TABLE>       
      </TD>
      <TD></TD>
    </TR>
    <TR>
      <TD height="10" COLspan="3"></TD>
    </TR>
  </TABLE>

</BODY>
</HTML>

<SCRIPT LANGUAGE="JavaScript">
<!--
    function onChangeVisitType()
    {
        var workPlanVisitType = document.all("WorkPlanVisitType").value;

        document.all("VisitShowSecLevel").style.display='';
        document.all("VisitShowRoleLevelLine").style.display='';
        
        document.all("VisitShowDepartment").style.display='none';
        document.all("VisitShowSubCompany").style.display='none';
        document.all("VisitShowRole").style.display='none';
        document.all("VisitShowPost").style.display='none';
        document.all("VisitShowResource").style.display='none';
        
        document.all("VisitRelatedShareID").value = -1;
        document.all("VisitSecLevel").value = 10;
        VisitShowRelatedShareName.innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
        
        /*====== ������ ======*/
        if(<%= Constants.Hrm_All_Member %> == workPlanVisitType)
        {
            VisitShowRelatedShareName.innerHTML = "";
        }
        
        /*====== �ֲ� ======*/
        if(<%= Constants.Hrm_SubCompany %> == workPlanVisitType)
        {
            document.all("VisitShowSubCompany").style.display='';
        }
    
        /*====== ���� ======*/
        if(<%= Constants.Hrm_Department %> == workPlanVisitType)
        {
            document.all("VisitShowDepartment").style.display='';
        }
        
        /*====== ��ɫ ======*/
        if(<%= Constants.Hrm_Role %> == workPlanVisitType)
        {
            document.all("VisitShowRole").style.display='';
        }
        
        /*====== ��λ ======*/
        if(<%= Constants.Hrm_Station %> == workPlanVisitType)
        {
            document.all("VisitShowPost").style.display='';
        }
        
        /*====== ������Դ ======*/
        if(<%= Constants.Hrm_Resource %> == workPlanVisitType)
        {
            document.all("VisitShowSecLevel").style.display='none';
            document.all("VisitShowRoleLevelLine").style.display='none';
            document.all("VisitShowResource").style.display='';
        }
    }
    
    function onChangeReportType()
    {
        var workPlanReportType = document.all("WorkPlanReportType").value;

        document.all("ReportShowSecLevel").style.display='';
        document.all("ReportShowRoleLevelLine").style.display='';
        
        document.all("ReportShowDepartment").style.display='none';
        document.all("ReportShowSubCompany").style.display='none';
        document.all("ReportShowRole").style.display='none';
        document.all("ReportShowPost").style.display='none';
        document.all("ReportShowResource").style.display='none';
        
        document.all("ReportRelatedShareID").value = -1;
        document.all("ReportSecLevel").value = 10;
        ReportShowRelatedShareName.innerHTML = "<IMG src='/images/BacoError.gif' align=absMiddle>";
        
        /*====== ������ ======*/
        if(<%= Constants.Hrm_All_Member %> == workPlanReportType)
        {
            ReportShowRelatedShareName.innerHTML = "";
        }
        
        /*====== �ֲ� ======*/
        if(<%= Constants.Hrm_SubCompany %> == workPlanReportType)
        {
            document.all("ReportShowSubCompany").style.display='';
        }
    
        /*====== ���� ======*/
        if(<%= Constants.Hrm_Department %> == workPlanReportType)
        {
            document.all("ReportShowDepartment").style.display='';
        }
        
        /*====== ��ɫ ======*/
        if(<%= Constants.Hrm_Role %> == workPlanReportType)
        {
            document.all("ReportShowRole").style.display='';
        }
        
        /*====== ��λ ======*/
        if(<%= Constants.Hrm_Station %> == workPlanReportType)
        {
            document.all("ReportShowPost").style.display='';
        }
        
        /*====== ������Դ ======*/
        if(<%= Constants.Hrm_Resource %> == workPlanReportType)
        {
            document.all("ReportShowSecLevel").style.display='none';
            document.all("ReportShowRoleLevelLine").style.display='none';
            document.all("ReportShowResource").style.display='';
        }
    }


    function removeValue()
    {
        var chks = document.getElementsByName("chkShareDetail");
        
        for (var i=chks.length-1; i>=0; i--)
        {
            var chk = chks[i];
            if (chk.checked)
            {
                oTable.deleteRow(chk.parentElement.parentElement.parentElement.rowIndex)
            }
        }
    }


    function addValue()
    {        
        if (<%= Constants.Hrm_All_Member %> != visitWorkPlanType || <%= Constants.Hrm_All_Member %> != reportWorkPlanType)
        {
            if(!check_form(document.weaver,'VisitRelatedShareID') || !check_form(document.weaver,'ReportRelatedShareID')) 
            {
                return ;
            }
        }

        if (!check_form(document.weaver,'VisitSecLevel') || !check_form(document.weaver,'ReportSecLevel'))
        {
            return;
        }
        
        //�����б��е�����ID
        var visitWorkPlanType = document.all("WorkPlanVisitType").value;        
        var reportWorkPlanType = document.all("WorkPlanReportType").value;
        
        //�����б��е���������
        var visitShareTypeText = document.all("WorkPlanVisitType").options.item(document.all("WorkPlanVisitType").selectedIndex).innerText;        
        var reportShareTypeText = document.all("WorkPlanReportType").options.item(document.all("WorkPlanReportType").selectedIndex).innerText;        

        //ѡ���ѡ����ID
        var visitRelatedShareIDs = document.all("VisitRelatedShareID").value;   
        var reportRelatedShareIDs = document.all("ReportRelatedShareID").value;
        
        //ѡ���ѡ��������
        var visitRelatedShareNames = document.all("VisitShowRelatedShareName").innerHTML;
        var reportRelatedShareNames = document.all("ReportShowRelatedShareName").innerHTML;

        //��ȫ����
        var visitSecLevelValue = document.all("VisitSecLevel").value;
        var reportSecLevelValue = document.all("ReportSecLevel").value;


        //���� + �����б��е�����ID + ѡ���ѡ����ID + ��ȫ����
        var totalValue = "-1" + "_" + reportWorkPlanType + "_," + reportRelatedShareIDs + ",_" + reportSecLevelValue + "_" + visitWorkPlanType + "_," + visitRelatedShareIDs + ",_" + visitSecLevelValue;
        var oRow = oTable.insertRow();
        var oRowIndex = oRow.rowIndex;

        if (0 == oRowIndex % 2)
        {
            oRow.className = "dataLight";
        }
        else
        {
            oRow.className = "dataDark";
        }

        for (var i = 1; i <= 5; i++)
        //����һ���е�ÿһ��
        {
            oCell = oRow.insertCell();
            var oDiv = document.createElement("div");
            if (1 == i) 
            {
                oDiv.innerHTML="<input class='inputStyle' type='checkbox' name='chkShareDetail' value='" + totalValue + "'><input type='hidden' name='txtShareDetail' value='" + totalValue+"'>";
            }
            else if (2 == i)
            {
                oDiv.innerHTML = reportShareTypeText;
            }
            else if (3 == i)
            {
                if(<%= Constants.Hrm_All_Member %> != reportWorkPlanType)
                {
                    oDiv.innerHTML = reportRelatedShareNames;
                }               
                if(<%= Constants.Hrm_All_Member %> != reportWorkPlanType && <%= Constants.Hrm_Resource %> != reportWorkPlanType)
                {
                    oDiv.innerHTML += " / ";
                }
                if(<%= Constants.Hrm_Resource %> != reportWorkPlanType)
                {
                    oDiv.innerHTML += reportSecLevelValue;
                }
            }
            else if (4 == i)
            {
                oDiv.innerHTML = visitShareTypeText;
            }
            else if (5 == i)
            {
                if(<%= Constants.Hrm_All_Member %> != visitWorkPlanType)
                {
                    oDiv.innerHTML = visitRelatedShareNames;
                }
                if(<%= Constants.Hrm_All_Member %> != visitWorkPlanType && <%= Constants.Hrm_Resource %> != visitWorkPlanType)
                {
                    oDiv.innerHTML += " / ";
                }
                if(<%= Constants.Hrm_Resource %> != visitWorkPlanType)
                {
                    oDiv.innerHTML += visitSecLevelValue;
                }
                
            }
            
            oCell.appendChild(oDiv);
        }
    }


    function chkAllClick(obj)
    {
        var chks = document.getElementsByName("chkShareDetail");
        for (var i=0; i<chks.length; i++)
        {
            var chk = chks[i];
            chk.checked=obj.checked;
        }
    }
    
    function doSave()
    {
        document.weaver.submit();
    }
    
    function init()
    {
    <%
        List workPlanVisitViewFormArrayList = (List)(request.getAttribute("workPlanVisitViewFormArrayList"));

        for(int i = 0; i < workPlanVisitViewFormArrayList.size(); i++)
        {
            WorkPlanVisitViewForm workPlanVisitViewForm = new WorkPlanVisitViewForm();
            
            workPlanVisitViewForm = (WorkPlanVisitViewForm)workPlanVisitViewFormArrayList.get(i);            
    %>
    
            var totalValue = "<%= workPlanVisitViewForm.getWorkPlanVisitSetID() %>" + "_" + "<%= workPlanVisitViewForm.getWorkPlanReportType() %>" + "_" + "<%= workPlanVisitViewForm.getWorkPlanReportContentID() %>" + "_" + "<%= workPlanVisitViewForm.getWorkPlanReportSec() %>" + "_" + "<%= workPlanVisitViewForm.getWorkPlanVisitType() %>" + "_" + "<%= workPlanVisitViewForm.getWorkPlanVisitContentID() %>" + "_" + "<%= workPlanVisitViewForm.getWorkPlanVisitSec() %>";
            var oRow = oTable.insertRow();
            var oRowIndex = oRow.rowIndex;
    
            if (0 == oRowIndex % 2)
            {
                oRow.className = "dataLight";
            }
            else
            {
                oRow.className = "dataDark";
            }
    
            for (var i = 1; i <= 5; i++)
            //����һ���е�ÿһ��
            {
                oCell = oRow.insertCell();
                var oDiv = document.createElement("div");
                if (1 == i) 
                {
                    oDiv.innerHTML="<input class='inputStyle' type='checkbox' name='chkShareDetail' value='" + totalValue + "'><input type='hidden' name='txtShareDetail' value='" + totalValue+"'>";
                }
                else if (2 == i)
                {
                    oDiv.innerHTML = "<%= workPlanVisitViewForm.getWorkPlanReportTypeName() %>";
                }
                else if (3 == i)
                {
                    oDiv.innerHTML = "<%= workPlanVisitViewForm.getWorkPlanReportContentName() %>";
                }
                else if (4 == i)
                {
                    oDiv.innerHTML = "<%= workPlanVisitViewForm.getWorkPlanVisitTypeName() %>";
                }
                else if (5 == i)
                {
                    oDiv.innerHTML = "<%= workPlanVisitViewForm.getWorkPlanVisitContentName() %>";   
                }
                
                oCell.appendChild(oDiv);
            }
    <%            
        }
    %>
    }
    
    init();
    
//-->
</SCRIPT>


<SCRIPT language=VBS>
sub onShowSubcompany(inputename, tdname)
    <%--for TD.4240 edited by wdl--%>
    linkurl="/hrm/company/HrmSubCompanyDsp.jsp?id="
    id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser3.jsp?selectedids="&document.all(inputename).value)
    if NOT isempty(id) then
        if id(0)<> "" then        
        resourceids = id(0)
        resourcename = id(1)
        sHtml = ""
        resourceids = Mid(resourceids,2,len(resourceids))
        resourcename = Mid(resourcename,2,len(resourcename))
        document.all(inputename).value = resourceids
        while InStr(resourceids,",") <> 0
            curid = Mid(resourceids,1,InStr(resourceids,",")-1)
            curname = Mid(resourcename,1,InStr(resourcename,",")-1)
            resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
            resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
            sHtml = sHtml&"<a href="&linkurl&curid&">"&curname&"</a>&nbsp"
        wend
        sHtml = sHtml&"<a href="&linkurl&resourceids&">"&resourcename&"</a>&nbsp"
        document.all(tdname).innerHtml = sHtml
        <%--
        document.all(tdname).innerHtml ="<a href='/hrm/company/HrmSubCompanyDsp.jsp?id="+id(0)+"'>"+ id(1)+"</a>"
        document.all(inputename).value=id(0)
        --%>
        else
        document.all(tdname).innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
        document.all(inputename).value=""
        end if
    end if
    <%--end--%>
end sub


sub onShowDepartment(inputname,spanname)
    linkurl="/hrm/company/HrmDepartmentDsp.jsp?id="
    id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/MutiDepartmentBrowser.jsp?selectedids="&inputname.value)
    if (Not IsEmpty(id)) then
    if id(0)<> "" then
        resourceids = id(0)
        resourcename = id(1)
        sHtml = ""
        resourceids = Mid(resourceids,2,len(resourceids))
        resourcename = Mid(resourcename,2,len(resourcename))
        inputname.value= resourceids
        while InStr(resourceids,",") <> 0
            curid = Mid(resourceids,1,InStr(resourceids,",")-1)
            curname = Mid(resourcename,1,InStr(resourcename,",")-1)
            resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
            resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
            sHtml = sHtml&"<a href="&linkurl&curid&">"&curname&"</a>&nbsp"
        wend
        sHtml = sHtml&"<a href="&linkurl&resourceids&">"&resourcename&"</a>&nbsp"
        spanname.innerHtml = sHtml
    else    
        spanname.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
        inputname.value="0"
    end if
    end if
end sub


sub onShowResource(inputname,spanname)
    linkurl="/hrm/resource/HrmResource.jsp?id="
    id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp")
    if (Not IsEmpty(id)) then
    if id(0)<> "" then
        resourceids = id(0)
        resourcename = id(1)
        sHtml = ""
        resourceids = Mid(resourceids,2,len(resourceids))
        resourcename = Mid(resourcename,2,len(resourcename))
        inputname.value= resourceids
        while InStr(resourceids,",") <> 0
            curid = Mid(resourceids,1,InStr(resourceids,",")-1)
            curname = Mid(resourcename,1,InStr(resourcename,",")-1)
            resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
            resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
            sHtml = sHtml&"<a href="&linkurl&curid&">"&curname&"</a>&nbsp"
        wend
        sHtml = sHtml&"<a href="&linkurl&resourceids&">"&resourcename&"</a>&nbsp"
        spanname.innerHtml = sHtml
    else    
        spanname.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
        inputname.value="0"
    end if
    end if
end sub


sub onShowCRM(inputname,spanname)
  temp =inputname.value
    id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/CRM/data/MutiCustomerBrowser.jsp?resourceids="+temp)
    if (Not IsEmpty(id1)) then
        if (Len(id1(0)) > 500) then '500Ϊ��ṹ��ؿͻ��ֶεĳ���
            result = msgbox("��ѡ�����ؿͻ�����̫�࣬���ݿ⽫�޷��������е���ؿͻ���������ѡ��",48,"ע��")
            spanname.innerHtml =""
            inputname.value=""
        elseif id1(0)<> "" then
            resourceids = id1(0)
            resourcename = id1(1)
            sHtml = ""
            resourceids = Mid(resourceids,2,len(resourceids))
            inputname.value= resourceids
            resourcename = Mid(resourcename,2,len(resourcename))
            while InStr(resourceids,",") <> 0
                curid = Mid(resourceids,1,InStr(resourceids,",")-1)
                curname = Mid(resourcename,1,InStr(resourcename,",")-1)
                resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
                resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
                sHtml = sHtml&"<a href='/CRM/data/ViewCustomer.jsp?CustomerID="&curid&"'>"&curname&"</a>&nbsp"
            wend
            sHtml = sHtml&"<a href='/CRM/data/ViewCustomer.jsp?CustomerID="&resourceids&"'>"&resourcename&"</a>&nbsp"
            spanname.innerHtml = sHtml
        else
            spanname.innerHtml =""
            inputname.value=""
        end if
    end if
    
end sub


sub onShowRole(inputename,tdname)
    id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/roles/HrmRolesBrowser.jsp")
    if NOT isempty(id) then
            if id(0)<> "" then
        document.all(tdname).innerHtml = id(1)
        document.all(inputename).value=id(0)
        else
        document.all(tdname).innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
        document.all(inputename).value=""
        end if
    end if
end sub


sub onShowPost(inputname,spanname)
    tmpids = document.all(inputname).value
    id1 = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/MultiPostBrowser.jsp?resourceids="&tmpids)
    
    if (Not IsEmpty(id1)) then
        if id1(0)<> "" then
            resourceids = id1(0)
            resourcename = id1(1)
            sHtml = ""          
            resourceids = Mid(resourceids,2,len(resourceids))         
            document.all(inputname).value= resourceids
            resourcename = Mid(resourcename,2,len(resourcename))

            while InStr(resourceids,",") <> 0
                curid = Mid(resourceids,1,InStr(resourceids,",")-1)
                curname = Mid(resourcename,1,InStr(resourcename,",")-1)
                resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
                resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
                sHtml = sHtml&""&curname&"&nbsp"
            wend

            sHtml = sHtml&""&resourcename&"&nbsp"
            spanname.innerHtml = sHtml          

        else
            document.all(spanname).innerHtml = ""
            document.all(inputname).value = ""
        end if
    end if
end sub
</SCRIPT>

