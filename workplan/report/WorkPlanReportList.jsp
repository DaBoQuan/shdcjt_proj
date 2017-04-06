<%@ page language="java" contentType="text/html; charset=GBK" %> 

<%@ include file="/systeminfo/init.jsp" %>

<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.Constants" %>
<%@ page import="weaver.viewform.workplan.WorkPlanVisitViewForm" %>

<%
  String type = request.getParameter("type");
  //��ʾ���ͣ�1Ϊ��ͳ�ƣ�2Ϊ��ͳ��
%>

<script language=javascript>
    function initBanner(objID)
    {       
        for(i = 1; i <= 2; i++)
        {
            document.all("oTDtype_" + i).background="/images/tab2.png";
            document.all("oTDtype_" + i).className="cycleTD";
        }

        document.all("oTDtype_" + objID).background="/images/tab.active2.png";
        document.all("oTDtype_" + objID).className="cycleTDCurrent";
        
        var o = document.frames[1].document;
        o.location="WorkPlanReportListContent.jsp?type=" + objID;
    }
    
    function resetBanner(objID)
    {       
        for(i = 1; i <= 2; i++)
        {
            document.all("oTDtype_" + i).background="/images/tab2.png";
            document.all("oTDtype_" + i).className="cycleTD";
        }

        document.all("oTDtype_" + objID).background="/images/tab.active2.png";
        document.all("oTDtype_" + objID).className="cycleTDCurrent";
                
        window.location="WorkPlanReportListOperation.jsp?type=" + objID;
    }
</script>

<HTML>
<HEAD>
  <LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
  
  <STYLE>
    #tabPane TR TD{padding-top:2px}
    #monthHtmlTbl TD,#seasonHtmlTbl TD{cursor:hand;text-align:center;padding:0 2px 0 2px;color:#333;text-decoration:underline}
    .cycleTD{font-family:MS Shell Dlg,Arial;background-image:url(/images/tab2.png);cursor:hand;font-weight:bold;text-align:center;color:#666;border-bottom:1px solid #879293;}
    .cycleTDCurrent{font-family:MS Shell Dlg,Arial;padding-top:2px;background-image:url(/images/tab.active2.png);cursor:hand;font-weight:bold;text-align:center;color:#666}
    .seasonTDCurrent,.monthTDCurrent{color:black;font-weight:bold;background-color:#CCC}
    #subTab{border-bottom:1px solid #879293;padding:0}
  </STYLE>
  
</HEAD>
 
<BODY onload="initBanner(<%= type %>)" style="overflow:auto">

<!--============================= �Ҽ��˵���ʼ =============================-->
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<!--============================= �Ҽ��˵����� =============================-->

<TABLE width="100%" height="100%" cellspacing="0" cellpadding="0">
  <TR>
    <TD height="60">
    
    <!--============================= MainFrame������ʾ��ʼ =============================-->
<%
    String imagefilename = "/images/hdMaintenance.gif";
    String titlename = "";

    titlename = SystemEnv.getHtmlLabelName(19080, user.getLanguage());

    String needhelp ="";    
%>
    <%@ include file="/systeminfo/TopTitle.jsp" %>
    <!--============================= MainFrame������ʾ���� =============================-->
      
      <FORM name=weaver id=weaver>
        <input type="hidden" name="type" value="1">
        <TABLE style="width:100%;height:95%" border=0 cellspacing=0 cellpadding=0  scrolling=no id="tabPane">
          <colgroup>
            <col width="79"></col>
            <col width="79"></col>
            <col width="*"></col>
            </colgroup>
        <TBODY>
          <TR>
            <TD height="2%"></TD>
          </TR>
          <TR align=left height="20">
            <TD class="cycleTDCurrent" name="oTDtype_1" id="oTDtype_1" background="/images/tab.active2.png" width=79px  align=center onmouseover="style.cursor='hand'" onclick="resetBanner(1)" ><b><%=SystemEnv.getHtmlLabelName(19057,user.getLanguage())%></b></TD>
            <TD class="cycleTD" name="oTDtype_2" id="oTDtype_2" background="/images/tab2.png" width=79px align=center onmouseover="style.cursor='hand'" onclick="resetBanner(2)" ><b><%=SystemEnv.getHtmlLabelName(19058,user.getLanguage())%></b></TD>
             <TD style="border-bottom:1px solid rgb(145,155,156)">&nbsp;</TD>
          </TR>
          <TR>
            <TD colspan="4" style="padding:0;">
              <iframe src="" ID="iFrameWorkPlanReportList" name="iFrameWorkPlanReportList" frameborder="0" style="width:100%;height:100%;border-right:1px solid #879293;border-bottom:1px solid #879293;border-left:1px solid #879293;padding:10px;padding-right:0" scrolling="auto"/>
            </TD>
          </TR>
        </TBODY>
        </TABLE>
      </FORM>
    </TD>
  </TR>
</TABLE>

</BODY>


