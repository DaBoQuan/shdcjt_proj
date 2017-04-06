<%@ page language="java" contentType="text/html; charset=GBK" %> 

<%@ include file="/systeminfo/init.jsp" %>

<jsp:useBean id="WorkflowKeywordComInfo" class="weaver.docs.senddoc.WorkflowKeywordComInfo" scope="page"/>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />

<%
if(!HrmUserVarify.checkUserRight("SendDoc:Manage", user)){
    response.sendRedirect("/notice/noright.jsp");
    return;
}
%>

<%
int hisId=Util.getIntValue(request.getParameter("hisId"),0);
int  parentId=Util.getIntValue(request.getParameter("parentId"),0);
%>

<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="/js/weaver.js"></script>

</head>
<%

String imagefilename = "/images/hdMaintenance.gif";

String titlename = SystemEnv.getHtmlLabelName(16978,user.getLanguage())+"��"+SystemEnv.getHtmlLabelName(365,user.getLanguage());
String needfav ="1";
String needhelp ="";

%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>

<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:onSave(this),_TOP} " ;
RCMenuHeight += RCMenuHeightStep ;

if(hisId>0){
    RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",/docs/sendDoc/WorkflowKeywordDsp.jsp?id="+hisId+",_self} " ;
    RCMenuHeight += RCMenuHeightStep ;
}else{
    RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",/docs/sendDoc/WorkflowKeyword.jsp,_self} " ;
    RCMenuHeight += RCMenuHeightStep ;
}

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

<div id=divMessage style="color:red">
</div>

<FORM id=weaver name=frmMain action="WorkflowKeywordOperation.jsp" method=post  target="_parent">

        <TABLE class=ViewForm width="100%">
          <COLGROUP> 
		  <COL width="30%">
		  <COL width="70%">
		  <TBODY> 

          <TR class=Title> 
              <TH><%=SystemEnv.getHtmlLabelName(16261,user.getLanguage())%></TH>
          </TR>
          <TR class=Spacing style="height: 1px!important;"> 
            <TD class=Line1 colSpan=2></TD>
          </TR>

          <TR> 
            <TD><%=SystemEnv.getHtmlLabelName(21510,user.getLanguage())%></TD>
            <TD class=FIELD> 
              <INPUT class=InputStyle  name=keywordName onchange='checkinput("keywordName","keywordNameImage")' value="">
              <SPAN id=keywordNameImage>
			  <IMG src="/images/BacoError.gif" align=absMiddle>
			  </SPAN>
              </TD>
          </TR>
    <TR style="height: 1px!important;"><TD class=Line colSpan=2></TD></TR> 

	 <TR> 
            <TD><%=SystemEnv.getHtmlLabelName(21511,user.getLanguage())%></TD>
            <TD class=FIELD> 
				<INPUT class=InputStyle  name=keywordDesc value="" style="width:80%">             
              </TD>
          </TR>
    <TR style="height: 1px!important;"><TD class=Line colSpan=2></TD></TR> 

          <TR>
            <TD><%=SystemEnv.getHtmlLabelName(19411,user.getLanguage())%></TD>
            <TD class=Field>
              <INPUT class="wuiBrowser" _url="/systeminfo/BrowserMain.jsp?url=/docs/sendDoc/WorkflowKeywordBrowserSingle.jsp?keywordId=<%=parentId%>" 
				 type=hidden name=parentId value="<%=parentId%>">
			  <SPAN id=parentIdSpan>
			  <%=WorkflowKeywordComInfo.getKeywordName(""+parentId)%>
              </SPAN>
              <!--	 
              <BUTTON class=Browser type="button" id=SelectParentId onclick="onShowParent()"></BUTTON>
              <INPUT id=parentId type=hidden name=parentId value="<%=parentId%>">
              -->
            </TD>
          </TR>
          <TR style="height: 1px!important;"><TD class=Line colSpan=2></TD></TR>

			<TR> 
				<TD><%=SystemEnv.getHtmlLabelName(21512,user.getLanguage())%></TD>
				 <TD class=FIELD>
				     <select name="isKeyword" class=InputStyle>
					     <option value="0" <%=parentId<=0?"selected":""%>><%=SystemEnv.getHtmlLabelName(161,user.getLanguage())%></option>
					     <option value="1" <%=parentId>0?"selected":""%>><%=SystemEnv.getHtmlLabelName(163,user.getLanguage())%></option>
				     </select>				 
				 </TD>
			  </TR>
			<TR style="height: 1px!important;"><TD class=Line colSpan=2></TD></TR> 
<%
    double showOrder=0;
    RecordSet.executeSql("    select max(showOrder) as showOrder from Workflow_Keyword");
    if(RecordSet.next()){
	    showOrder=Util.getDoubleValue(RecordSet.getString("showOrder"),0)+1.0;
    }
%>
            <TR> 
            <TD><%=SystemEnv.getHtmlLabelName(15513,user.getLanguage())%></TD>
            <TD class=Field> 
              <INPUT class=InputStyle name=showOrder value="<%=showOrder%>" size=7 maxlength=7  onKeyPress='ItemDecimal_KeyPress("showOrder",6,2)' onBlur='checknumber("showOrder");checkDigit("showOrder",6,2);checkinput("showOrder","showOrderImage")' onchange='checkinput("showOrder","showOrderImage")' >
              <SPAN id=showOrderImage></SPAN>
            </TD>
          </TR>
          <TR style="height: 1px!important;"><TD class=Line colSpan=2></TD></TR> 
          </TBODY> 
        </TABLE>

   <input class=inputstyle type=hidden name=operation value="AddSave">
</FORM>

<iframe id="workflowKeywordIframe" frameborder=0 scrolling=no src=""  style="display:none"></iframe>
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

</BODY>
</HTML>


<script language=javascript>

//oΪ�������� 1:ϵͳ��֧��10�����ϵ���״�ֶΣ�
//           2:ͬ���ֶ����Ʋ����ظ�

function checkForAddSave(o){
	if(o=="2"){
		divMessage.innerHTML="<%=SystemEnv.getHtmlLabelName(21515,user.getLanguage())%>";
		return;
	}else if(o==""){
		document.frmMain.submit();	
	}
}

function onSave(obj) {
	if(check_form(frmMain,'keywordName,showOrder')){
		var newKeywordName=document.all("keywordName").value;
		var newParentId=document.all("parentId").value;
		document.all("workflowKeywordIframe").src="WorkflowKeywordIframe.jsp?operation=AddSave&newParentId="+newParentId+"&newKeywordName="+newKeywordName;
    }
}

function encode(str){
    return escape(str);
}

/*
p�����ȣ�
ָ��С������ߺ��ұ߿��Դ洢��ʮ�������ֵ������������ȱ����Ǵ� 1 ����󾫶�֮���ֵ����󾫶�Ϊ 38��

s��С��λ����
ָ��С�����ұ߿��Դ洢��ʮ�������ֵ���������С��λ�������Ǵ� 0 �� p ֮���ֵ��Ĭ��С��λ���� 0����� 0 <= s <= p�����洢��С���ھ��ȶ��仯��
*/
function checkDigit(elementName,p,s){
	tmpvalue = document.all(elementName).value;

    var len = -1;
    if(elementName){
		len = tmpvalue.length;
    }

	var integerCount=0;
	var afterDotCount=0;
	var hasDot=false;

    var newIntValue="";
	var newDecValue="";
    for(i = 0; i < len; i++){
		if(tmpvalue.charAt(i) == "."){ 
			hasDot=true;
		}else{
			if(hasDot==false){
				integerCount++;
				if(integerCount<=p-s){
					newIntValue+=tmpvalue.charAt(i);
				}
			}else{
				afterDotCount++;
				if(afterDotCount<=s){
					newDecValue+=tmpvalue.charAt(i);
				}
			}
		}		
    }

    var newValue="";
	if(newDecValue==""){
		newValue=newIntValue;
	}else{
		newValue=newIntValue+"."+newDecValue;
	}
    document.all(elementName).value=newValue;
}

function onShowParent(){
	var opts={
			_dwidth:'550px',
			_dheight:'550px',
			_url:'about:blank',
			_scroll:"no",
			_dialogArguments:"",
			
			value:""
		};
	var iTop = (window.screen.availHeight-30-parseInt(opts._dheight))/2+"px"; //��ô��ڵĴ�ֱλ��;
	var iLeft = (window.screen.availWidth-10-parseInt(opts._dwidth))/2+"px"; //��ô��ڵ�ˮƽλ��;
	opts.top=iTop;
	opts.left=iLeft;
	parentId=document.frmMain.parentId.value
	url="/docs/sendDoc/WorkflowKeywordBrowserSingle.jsp?keywordId="+parentId
	data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url="+url,"","addressbar=no;status=0;scroll="+opts._scroll+";dialogHeight="+opts._dheight+";dialogWidth="+opts._dwidth+";dialogLeft="+opts.left+";dialogTop="+opts.top+";resizable=0;center=1;");
	
	if (data){
	    if (data.id!="") {
	        parentSpan.innerHtml = id(1)
	        frmMain.parentId.value=id(0)
	    }else{
	        parentSpan.innerHtml = ""
	        frmMain.parentId.value="0"
	    }
	}
}

</script>
