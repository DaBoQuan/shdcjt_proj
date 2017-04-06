<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ include file="/systeminfo/init.jsp" %>

<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="resourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>

<%
	Calendar cal = Calendar.getInstance();
	String currDate = Util.add0(cal.get(Calendar.YEAR), 4) + "-" +
					Util.add0(cal.get(Calendar.MONTH) + 1, 2) + "-" +
					Util.add0(cal.get(Calendar.DAY_OF_MONTH), 2);

	String currUserId = String.valueOf(user.getUID());  //��ǰ�����û�
	String userId = Util.null2String(request.getParameter("selectUser"));  //���鿴������ʱ
	if (userId.equals(""))
	{
		userId = currUserId;
	}

	String setDate = "";
	//String selectDate =  Util.null2String(request.getParameter("selectdater"));
	String selectDate =  Util.null2String(request.getParameter("selectdate"));
	
	//System.out.println("$$$$$$" + selectDate);
	if (selectDate.equals("")) 
	{
		selectDate = currDate;
	}

	String moveDate = Util.null2String(request.getParameter("movedater"));
	int viewType = Util.getIntValue(request.getParameter("viewtyper"), 2);  //1:�ռƻ���ʾ 2:�ܼƻ���ʾ 3:�¼ƻ���ʾ
	
	Calendar calSet = Calendar.getInstance();
	int selectYear = Util.getIntValue(selectDate.substring(0,4));
	int selectMonth = Util.getIntValue(selectDate.substring(5,7))-1;
	int selectDay = Util.getIntValue(selectDate.substring(8,10));
	calSet.set(selectYear,selectMonth,selectDay);
	/*switch (viewType) 
	{
		case 1:
		//
			if (moveDate.equals("1"))
			{
				calSet.add(Calendar.DATE,1);
			}	
			if (moveDate.equals("-1")) 
			{
				calSet.add(Calendar.DATE,-1);
			}	
			break ;
		case 2:		
			Date thedate = calSet.getTime();
			int diffdate = (-1) * thedate.getDay();//thedate.getDay()Ϊ�����ڵĵڼ��������������ڵĵ�һ��Ϊ��������-1
			calSet.add(Calendar.DATE,diffdate);
			if (moveDate.equals("1"))
			{
				calSet.add(Calendar.WEEK_OF_YEAR,1);
			}	
			if (moveDate.equals("-1"))
			{
				calSet.add(Calendar.WEEK_OF_YEAR,-1);
			}	
			calSet.add(Calendar.DATE,1);
			break ;
		case 3:
			calSet.set(selectYear,selectMonth,1);
			if (moveDate.equals("1"))
			{
				calSet.add(Calendar.MONTH,1);
			}	
			if (moveDate.equals("-1"))
			{ 
				calSet.add(Calendar.MONTH,-1);
			}	
			break;
	}*/
	
	setDate = Util.add0(calSet.get(Calendar.YEAR), 4) + "-" +
			Util.add0(calSet.get(Calendar.MONTH) + 1, 2) + "-" +
			Util.add0(calSet.get(Calendar.DAY_OF_MONTH), 2);

%>

<HTML xmlns:IE>
<HEAD>
	<LINK href="/css/Weaver.css" type="text/css" rel="STYLESHEET">
	<SCRIPT language="javascript" src="/js/weaver.js"></SCRIPT>
	<TITLE>Calendar</TITLE>
	<STYLE>
	@media all
	{
		IE\:Calendar
		{
			behavior: url(/htc/calendarForWorkplan.htc);  //����calendar��html���
		}
	}
	</STYLE>
</HEAD>


<BODY scroll="YES" onload="doSetCalendar('<%=setDate%>')">
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>

<FORM name="frmmain" action="/workplan/data/WorkPlanView.jsp#rushHour" method="post" target="workplanLeft">
<INPUT type="hidden" name="selectdate" value="<%=currDate%>">
<INPUT type="hidden" name="selectUser" value="<%=userId%>">
<INPUT type="hidden" name="hasrightview" value="1">
<INPUT type="hidden" name="viewtype" value="<%=viewType%>">
<INPUT type="hidden" name="method" value="">

<TABLE width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" class="ListStyle">
	<TR>
		<TD valign="top" height="140">
			<!--================== ��ʾ���� ==================-->
			<IE:Calendar id="cal" style="height:140;width:180;border:0px solid black;" ></IE:Calendar>
			<BR>
			<!--================== �¼ƻ����ܼƻ����ռƻ���ť ==================-->
			<BUTTON class="WorkPlan" onclick="doMonth()" ><%=SystemEnv.getHtmlLabelName(16654,user.getLanguage())%></BUTTON>&nbsp;&nbsp
			<BUTTON class="WorkPlan" onclick="doWeek()" ><%=SystemEnv.getHtmlLabelName(16655,user.getLanguage())%></BUTTON>&nbsp;&nbsp
			<BUTTON class="WorkPlan" onclick="doDay()" ><%=SystemEnv.getHtmlLabelName(16656,user.getLanguage())%></BUTTON>
		</TD>
	</TR>
	<TR>
		<TD height="1"></TD>
	</TR>

	<!--================== ��ǩ���� ==================-->
	<!-- TR class="Header" height="20" align="left">
		<TD>&nbsp;&nbsp;<B><%=SystemEnv.getHtmlLabelName(17498,user.getLanguage())%></B></TD>
	</TR>
	<TR height="20">
		<TD valign="top">	
			<TABLE>
				<TR>
					<TD><INPUT type="text" name="note" class="InputStyle"></TD>
					<TD><A href="#" onclick="doAdd()"><%=SystemEnv.getHtmlLabelName(86,user.getLanguage())%></A>
					</TD>
				</TR>
			</TABLE>	
		</TD>
	</TR>
	<TR>
		<TD height="2"></TD>
	</TR -->

	<!--================== ������Դ ==================-->
	<TR class="Header" height="20" align="left">
		<TD><%=SystemEnv.getHtmlLabelName(179,user.getLanguage())%>&nbsp;&nbsp;&nbsp;&nbsp;
		<BUTTON class="Browser" id="SelectUserID" onClick="onShowHrmID()"></BUTTON>
		<SPAN id="selectuserspan"><%=resourceComInfo.getResourcename(userId)%></SPAN></TD>
	</TR>	

	<!--================== �ҵ����� ==================-->
	<TR class="DataDark" height="20" align="left">
		<TD><%=SystemEnv.getHtmlLabelName(15089,user.getLanguage())%>&nbsp;&nbsp;&nbsp;&nbsp;
        <A href="#" onclick="javascript:doMyWork()"><%=SystemEnv.getHtmlLabelName(16657,user.getLanguage())%></A></TD>
	</TR>	

	<TR>
		<TD valign="top">
			<TABLE class="BroswerStyle" width="180" ID="HrmTable" cellspacing="1">
				<COLGROUP>
		  			<COL valign="top" align="left" width="15%">
		  			<COL valign="top" align="left" width="85%">
		  		<TBODY>
				<%
					String id = "";
					String underlingName = "";
					boolean isLight = false;				
					rs.executeProc("HrmResource_SelectByManagerID", userId);
					while (rs.next())
					{
						id = Util.null2String(rs.getString("id"));
						underlingName = resourceComInfo.getResourcename(id);				
						isLight = !isLight;
				%>
				<TR class="<%=(isLight ? "DataLight" : "DataDark")%>">		
					<TD style="display:none"><%=id%></TD>
					<TD>
				<%
						if(HrmUserVarify.isUserOnline(id)) 
						{
				%>
						<img src="/images/State_LoggedOn.gif">
				<%
						}
				%>
					</TD>
					<TD><%=underlingName%></TD>
				</TR>
				<%
					}
				%>
			</TABLE>
		</TD>
	</TR>
</TABLE>

</FORM>


<SCRIPT language="JavaScript">
function doSetCalendar(date) 
{
	day = date.substring(8, 10);
	month = date.substring(5, 7);
	cal.year = date.substring(0, 4);

	if(month=="08")
	{	
		cal.month = 08;  //�����ǳ���ֵ�Ϊ08�Ż�09�žͲ���
	}
	else if(month=="09")
	{
		cal.month = 09;
	}
	else
	{
		cal.month = month;
	}

	if(day=="08")
	{
		cal.day = 08;  //�����ǳ���ֵ�Ϊ08�Ż�09�žͲ���
	}
	else if(day=="09")
	{
		cal.day = 09;
	}
	else
	{
		cal.day = day;
	}

	document.frmmain.selectdate.value = date;
}

function doSubmit() 
{
	themonth = cal.month;
	theday = cal.day;
	if (themonth < 10) 
		themonth = "0" + themonth;

	if (theday < 10) 
		theday = "0" + theday;

	document.frmmain.selectdate.value = cal.year + '-' + themonth + '-' + theday;
	document.frmmain.submit();

	document.frmmain.action = "WorkPlanRight.jsp";
	document.frmmain.target = "workplanRight";
	document.frmmain.submit();
}

function doMyWork() 
//�鿴�ҵ��ճ�
{
	document.frmmain.selectUser.value = "<%=currUserId%>";
	document.all("selectuserspan").innerHTML = "";
	doSubmit();
}

function doDay()
//�ռƻ���ʾ 
{
	document.frmmain.viewtype.value = "1";
	doSubmit();
}

function doWeek()
//�ܼƻ���ʾ
{
	document.frmmain.viewtype.value = "2";
	doSubmit();
}

function doMonth()
//�¼ƻ���ʾ
{
	document.frmmain.viewtype.value = "3";
	doSubmit();
}

function doAdd()
//��ǩ��� 
{
	if (check_form(document.frmmain, "note")) 
	{
        document.frmmain.action = "WorkPlanOperation.jsp";
        document.frmmain.target = "workplanLeft";
        document.all("method").value = "addnote";
		document.frmmain.submit();
        document.frmmain.note.value = "";
    }
}
</SCRIPT>

<SCRIPT language="VBS">
Sub HrmTable_onclick()
   Set e = window.event.srcElement
   If e.TagName = "TD" Then
    document.all("selectUser").value = e.parentelement.cells(0).innerText
	document.all("selectuserspan").innerHtml = e.parentelement.cells(2).innerText
   ElseIf e.TagName = "A" Then
        document.all("selectUser").value = e.parentelement.parentelement.cells(0).innerText
		document.all("selectuserspan").innerHtml = e.parentelement.parentelement.cells(2).innerText
   End If
   doSubmit()
End Sub

Sub HrmTable_onmouseover()
   Set e = window.event.srcElement
   If e.TagName = "TD" Then
      e.parentelement.className = "Selected"
   ElseIf e.TagName = "A" Then
      e.parentelement.parentelement.className = "Selected"
   End If
End Sub

Sub HrmTable_onmouseout()
   Set e = window.event.srcElement
   If e.TagName = "TD" Or e.TagName = "A" Then
      If e.TagName = "TD" Then
         Set p = e.parentelement
      Else
         Set p = e.parentelement.parentelement
      End If
      If p.RowIndex Mod 2 Then
         p.className = "DataDark"
      Else
         p.className = "DataLight"
      End If
   End If
End Sub

sub onShowHrmID()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
		selectuserspan.innerHtml = id(1)
		frmmain.selectUser.value = id(0)
		doSubmit()
	else
		selectuserspan.innerHtml = ""
		frmmain.selectUser.value = ""
	end if
	end if
end sub
</SCRIPT>

</BODY>
</HTML>