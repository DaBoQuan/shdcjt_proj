<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util,weaver.docs.docs.CustomFieldManager" %>
<%@ page import="java.util.*" %>

<% /*if(!HrmUserVarify.checkUserRight("HrmResourceAdd:Add",user)) {
	response.sendRedirect("/notice/noright.jsp") ;
	return ;
   }*/
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="BrowserComInfo" class="weaver.workflow.field.BrowserComInfo" scope="page"/>
<jsp:useBean id="CustomFieldTreeManager" class="weaver.hrm.resource.CustomFieldTreeManager" scope="page" />
<HTML><HEAD>
<STYLE>.SectionHeader {
	FONT-WEIGHT: bold; COLOR: white; BACKGROUND-COLOR: teal
}
</STYLE>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="../../js/weaver.js"></script>
</HEAD>
<%
int msgid = Util.getIntValue(request.getParameter("msgid"),-1);

boolean hasFF = true;
RecordSet.executeProc("Base_FreeField_Select","hr");
if(RecordSet.getCounts()<=0)
	hasFF = false;
else
	RecordSet.first();
	
String imagefilename = "/images/hdMaintenance.gif";
String titlename = SystemEnv.getHtmlLabelName(82,user.getLanguage())+": "+ SystemEnv.getHtmlLabelName(773,user.getLanguage());
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:doSave(this),_self} " ;
RCMenuHeight += RCMenuHeightStep ;
%>	
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
<colgroup>
<col width="10">
<col width="">
<col width="10">
<tr>
<td height="0" colspan="3"></td>
</tr>
<tr>
<td ></td>
<td valign="top">
<TABLE class=Shadow>
<tr>
<td valign="top">


<%
/*��¼����ͻ*/
if(msgid!=-1){
%>
<DIV>
<font color=red size=2>
<%=SystemEnv.getErrorMsgName(msgid,user.getLanguage())%>
</font>
</DIV>
<%}%>

<FORM name=resource id=resource action="HrmCareerApplyOperation.jsp" method=post enctype="multipart/form-data">
<input class=inputstyle type=hidden name=operation value="addthree">
<%
  String id = request.getParameter("id");  
%>	
<input class=inputstyle type=hidden name=id value="<%=id%>">

        <TABLE width="100%" class=viewForm>
          <COLGROUP> <COL width=20%> <COL width=80%> <TBODY>
          <TR class=title>
            <TH colSpan=2 height="19"><%=SystemEnv.getHtmlLabelName(15688,user.getLanguage())%></TH>
          </TR>
          <TR class=spacing style="height:2px">
            <TD class=line1 colSpan=2></TD>
          </TR>

<%--begin �Զ����ֶ�--%>

<%
    int scopeId = 3;
    String needinputitems = "";
    String sql = "";
    CustomFieldManager cfm = new CustomFieldManager("HrmCustomFieldByInfoType",scopeId);
    cfm.getCustomFields();
    cfm.getCustomData(Util.getIntValue(id,0));
    while(cfm.next()){
        if(cfm.isMand()){
            needinputitems += ",customfield"+cfm.getId();
        }
        String fieldvalue = cfm.getData("field"+cfm.getId());
%>
    <tr>
      <td <%if(cfm.getHtmlType().equals("2")){%> valign=top <%}%>> <%=cfm.getLable()%> </td>
      <td class=field >
      <%
        if(cfm.getHtmlType().equals("1")){
            if(cfm.getType()==1){
                if(cfm.isMand()){
      %>
        <input datatype="text" type=text value="<%=fieldvalue%>" class=Inputstyle name="customfield<%=cfm.getId()%>" size=50 onChange="checkinput('customfield<%=cfm.getId()%>','customfield<%=cfm.getId()%>span')">
        <span id="customfield<%=cfm.getId()%>span"><%if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
      <%
                }else{
      %>
        <input datatype="text" type=text value="<%=fieldvalue%>" class=Inputstyle name="customfield<%=cfm.getId()%>" value="" size=50>
      <%
                }
            }else if(cfm.getType()==2){
                if(cfm.isMand()){
      %>
        <input  datatype="int" type=text value="<%=fieldvalue%>" class=Inputstyle name="customfield<%=cfm.getId()%>" size=10
            onKeyPress="ItemCount_KeyPress()" onBlur="checkcount1(this);checkinput('customfield<%=cfm.getId()%>','customfield<%=cfm.getId()%>span')">
        <span id="customfield<%=cfm.getId()%>span"><%if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
      <%
                }else{
      %>
      <input  datatype="int" type=text  value="<%=fieldvalue%>" class=Inputstyle name="customfield<%=cfm.getId()%>" size=10 onKeyPress="ItemCount_KeyPress()" onBlur='checkcount1(this)'>
      <%
                }
            }else if(cfm.getType()==3){
                if(cfm.isMand()){
      %>
        <input datatype="float" type=text value="<%=fieldvalue%>" class=Inputstyle name="customfield<%=cfm.getId()%>" size=10
		    onKeyPress="ItemNum_KeyPress()" onBlur="checknumber1(this);checkinput('customfield<%=cfm.getId()%>','customfield<%=cfm.getId()%>span')">
        <span id="customfield<%=cfm.getId()%>span"><%if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
      <%
                }else{
      %>
        <input datatype="float" type=text value="<%=fieldvalue%>" class=Inputstyle name="customfield<%=cfm.getId()%>" size=10 onKeyPress="ItemNum_KeyPress()" onBlur='checknumber1(this)'>
      <%
                }
            }
        }else if(cfm.getHtmlType().equals("2")){
            if(cfm.isMand()){

      %>
        <textarea class=Inputstyle name="customfield<%=cfm.getId()%>" onChange="checkinput('customfield<%=cfm.getId()%>','customfield<%=cfm.getId()%>span')"
		    rows="4" cols="40" style="width:80%" class=Inputstyle><%=fieldvalue%></textarea>
        <span id="customfield<%=cfm.getId()%>span"><%if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
      <%
            }else{
      %>
        <textarea class=Inputstyle name="customfield<%=cfm.getId()%>" rows="4" cols="40" style="width:80%"><%=fieldvalue%></textarea>
      <%
            }
        }else if(cfm.getHtmlType().equals("3")){

            String fieldtype = String.valueOf(cfm.getType());
		    String url=BrowserComInfo.getBrowserurl(fieldtype);     // �����ť����ҳ���url
		    String linkurl=BrowserComInfo.getLinkurl(fieldtype);    // ���ֵ�����ʱ�����ӵ�url
		    String showname = "";                                   // �½�ʱ��Ĭ��ֵ��ʾ������
		    String showid = "";                                     // �½�ʱ��Ĭ��ֵ

            String docfileid = Util.null2String(request.getParameter("docfileid"));   // �½��ĵ��Ĺ������ֶ�
            String newdocid = Util.null2String(request.getParameter("docid"));

            if( fieldtype.equals("37") && !newdocid.equals("")) {
                if( ! fieldvalue.equals("") ) fieldvalue += "," ;
                fieldvalue += newdocid ;
            }

            if(fieldtype.equals("2") ||fieldtype.equals("19")){
                showname=fieldvalue; // ����ʱ��
            }else if(!fieldvalue.equals("")) {
                String tablename=BrowserComInfo.getBrowsertablename(fieldtype); //������Ӧ�ı�,����������Դ��
                String columname=BrowserComInfo.getBrowsercolumname(fieldtype); //������Ӧ�ı������ֶ�
                String keycolumname=BrowserComInfo.getBrowserkeycolumname(fieldtype);   //������Ӧ�ı�ֵ�ֶ�
                sql = "";

                HashMap temRes = new HashMap();

                if(fieldtype.equals("17")|| fieldtype.equals("18")||fieldtype.equals("27")||fieldtype.equals("37")||fieldtype.equals("56")||fieldtype.equals("57")||fieldtype.equals("65")) {    // ��������Դ,��ͻ�,����飬���ĵ�
                    sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+" in( "+fieldvalue+")";
                }
                else {
                    sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+"="+fieldvalue;
                }

                RecordSet.executeSql(sql);
                while(RecordSet.next()){
                    showid = Util.null2String(RecordSet.getString(1)) ;
                    String tempshowname= Util.toScreen(RecordSet.getString(2),user.getLanguage()) ;
                    if(!linkurl.equals(""))
                        //showname += "<a href='"+linkurl+showid+"'>"+tempshowname+"</a> " ;
                        temRes.put(String.valueOf(showid),"<a href='"+linkurl+showid+"'>"+tempshowname+"</a> ");
                    else{
                        //showname += tempshowname ;
                        temRes.put(String.valueOf(showid),tempshowname);
                    }
                }
                StringTokenizer temstk = new StringTokenizer(fieldvalue,",");
                String temstkvalue = "";
                while(temstk.hasMoreTokens()){
                    temstkvalue = temstk.nextToken();

                    if(temstkvalue.length()>0&&temRes.get(temstkvalue)!=null){
                        showname += temRes.get(temstkvalue);
                    }
                }

            }



	   %>
        <button class=Browser onclick="onShowBrowser('<%=cfm.getId()%>','<%=url%>','<%=linkurl%>','<%=fieldtype%>','<%=cfm.isMand()?"1":"0"%>')" title="<%=SystemEnv.getHtmlLabelName(172,user.getLanguage())%>"></button>
        <input type=hidden name="customfield<%=cfm.getId()%>" value="<%=fieldvalue%>">
        <span id="customfield<%=cfm.getId()%>span"><%=Util.toScreen(showname,user.getLanguage())%>
            <%if(cfm.isMand() && fieldvalue.equals("")) {%><img src="/images/BacoError.gif" align=absmiddle><%}%>
        </span>
       <%
        }else if(cfm.getHtmlType().equals("4")){
       %>
        <input type=checkbox value=1 name="customfield<%=cfm.getId()%>" <%=fieldvalue.equals("1")?"checked":""%> >
       <%
        }else if(cfm.getHtmlType().equals("5")){
            cfm.getSelectItem(cfm.getId());
       %>
       <select class=InputStyle name="customfield<%=cfm.getId()%>" class=InputStyle>
       <%
            while(cfm.nextSelect()){
       %>
            <option value="<%=cfm.getSelectValue()%>" <%=cfm.getSelectValue().equals(fieldvalue)?"selected":""%>><%=cfm.getSelectName()%>
       <%
            }
       %>
       </select>
       <%
        }
       %>
            </td>
        </tr>
          <TR style="height:1px"><TD class=Line colSpan=2></TD>
  </TR>
       <%
    }
       %>
<input class=inputstyle type=hidden name=scopeid value="<%=scopeId%>">

          </TBODY>
        </TABLE>
   <br>
   <TABLE width="100%"  class=ListStyle cellspacing=1  cols=4 id=lanTable> 
	      <TBODY> 
          <TR class=Header> 
            <TH colspan=2><%=SystemEnv.getHtmlLabelName(815,user.getLanguage())%></TH>			
			<Td align=right colspan=2>
			<BUTTON class=btnNew type="button" accessKey=A onClick="addlanRow();"><U>A</U>-<%=SystemEnv.getHtmlLabelName(551,user.getLanguage())%></BUTTON>
			<BUTTON class=btnDelete type="button" accessKey=D onClick="javascript:if(isdel()){deletelanRow1()};"><U>D</U>-<%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></BUTTON>			 
 		    </Td>

        <TR class=spacing style="display:none">
        <TD class=Sep1 colspan=5></TD>
        </TR>
            <tr class=Header>
            <td width=10>&nbsp</td> 		    
			<td ><%=SystemEnv.getHtmlLabelName(231,user.getLanguage())%>	</td>
			<td ><%=SystemEnv.getHtmlLabelName(408,user.getLanguage())%></td>
			<td ><%=SystemEnv.getHtmlLabelName(454,user.getLanguage())%></td>
		  </tr> 	      
      </tbody>
       </table>
    <BR>
      <TABLE width="100%" class=ListStyle cellspacing=1  cols=7 id=eduTable>
          <COLGROUP>		   
	      <TBODY> 
          <TR class=Header> 
            <TH colSpan=2><%=SystemEnv.getHtmlLabelName(813,user.getLanguage())%></TH>
		  	<Td align=right colSpan=5>
			 <BUTTON class=btnNew type="button" accessKey=A onClick="addeduRow();"><U>A</U>-<%=SystemEnv.getHtmlLabelName(551,user.getLanguage())%></BUTTON>
			 <BUTTON class=btnDelete type="button" accessKey=D onClick="javascript:if(isdel()){deleteeduRow1()};"><U>D</U>-<%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></BUTTON>
 		    </Td>
          </TR>
      <TR class=spacing style="display:none">
     <TD class=Sep1 colspan=5></TD>
     </TR>
            <tr class=Header>
            <td></td>
		    <td class=Field><%=SystemEnv.getHtmlLabelName(1903,user.getLanguage())%></td>
			<td class=Field><%=SystemEnv.getHtmlLabelName(803,user.getLanguage())%></td>
			<td class=Field><%=SystemEnv.getHtmlLabelName(740,user.getLanguage())%></td>
			<td class=Field><%=SystemEnv.getHtmlLabelName(741,user.getLanguage())%></td>
			<td class=Field><%=SystemEnv.getHtmlLabelName(818,user.getLanguage())%></td>
			<td class=Field><%=SystemEnv.getHtmlLabelName(1942,user.getLanguage())%></td>
		  </tr> 
	  </table>
     <BR>
      <TABLE class=ListStyle cellspacing=1  cellpadding=1  cols=7 id="workTable">	
      <TR class=Header>
      <TH colspan=2 align=left><%=SystemEnv.getHtmlLabelName(812,user.getLanguage())%></TH>       
          <Td align=right colSpan=5>
			 <BUTTON class=btnNew type="button" accessKey=A onClick="addworkRow();"><U>A</U>-<%=SystemEnv.getHtmlLabelName(551,user.getLanguage())%></BUTTON>
			 <BUTTON class=btnDelete type="button" accessKey=D onClick="javascript:if(isdel()){deleteworkRow1()};"><U>D</U>-<%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></BUTTON>       </Td>
       </TR>
       <TR class=spacing style="display:none">
        <TD class=Sep1 colspan=5></TD>
        </TR>
               <tr class=Header>
               <td width=10></td>
    		   <td class=Field><%=SystemEnv.getHtmlLabelName(1976,user.getLanguage())%></td>
    		   <td class=Field><%=SystemEnv.getHtmlLabelName(740,user.getLanguage())%></td>
    		   <td class=Field><%=SystemEnv.getHtmlLabelName(741,user.getLanguage())%></td>
    		   <td class=Field><%=SystemEnv.getHtmlLabelName(1915,user.getLanguage())%></td>
    		   <td class=Field><%=SystemEnv.getHtmlLabelName(1977,user.getLanguage())%></td>
    		   <td class=Field><%=SystemEnv.getHtmlLabelName(15676,user.getLanguage())%></td>
    		</tr>        
       </table>     

 <BR>
      <TABLE class=ListStyle cellspacing=1  cellpadding=1  cols=6 id="trainTable">	  
       <TR class=Header>
       <TH colspan=3 align=left><%=SystemEnv.getHtmlLabelName(15677,user.getLanguage())%></TH>
       <Td colspan=3 align=right>
	     <BUTTON class=btnNew type="button" accessKey=A onClick="addtrainRow();"><U>A</U>-<%=SystemEnv.getHtmlLabelName(551,user.getLanguage())%></BUTTON> <BUTTON class=btnDelete type="button" accessKey=D onClick="javascript:if(isdel()){deletetrainRow1()};"><U>D</U>-<%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></BUTTON>	
       </Td>
      </TR>    
      <TR class=spacing style="display:none">
        <TD class=Sep1 colspan=5></TD>
        </TR>
        	<tr class=header>
               <td width=10></td>
    		   <td class=Field><%=SystemEnv.getHtmlLabelName(15678,user.getLanguage())%></td>
    		   <td class=Field><%=SystemEnv.getHtmlLabelName(15679,user.getLanguage())%></td>
    		   <td class=Field><%=SystemEnv.getHtmlLabelName(15680,user.getLanguage())%></td>
    		   <td class=Field><%=SystemEnv.getHtmlLabelName(1974,user.getLanguage())%></td>
    		   <td class=Field><%=SystemEnv.getHtmlLabelName(454,user.getLanguage())%></td>
    		</tr>        
       </table>     
            <BR>
       <TABLE class=ListStyle cellspacing=1  cellpadding=1  cols=5 id="cerTable">	  
       <TR class=Header>
       <TH colspan=2 align=left><%=SystemEnv.getHtmlLabelName(1502,user.getLanguage())%></TH>
       <Td colspan=3 align=right>
	     <BUTTON class=btnNew type="button" accessKey=A onClick="addcerRow();"><U>A</U>-<%=SystemEnv.getHtmlLabelName(551,user.getLanguage())%></BUTTON> <BUTTON class=btnDelete type="button" accessKey=D onClick="javascript:if(isdel()){deletecerRow1()};"><U>D</U>-<%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></BUTTON>	
       </Td>
      </TR>    
      <TR class=spacing style="display:none">
        <TD class=Sep1 colspan=5></TD>
        </TR>
           	<tr class=header>
               <td width=10></td>
    		   <td class=Field><%=SystemEnv.getHtmlLabelName(195,user.getLanguage())%></td>
    		   <td class=Field><%=SystemEnv.getHtmlLabelName(740,user.getLanguage())%></td>
    		   <td class=Field><%=SystemEnv.getHtmlLabelName(741,user.getLanguage())%></td>
    		   <td class=Field><%=SystemEnv.getHtmlLabelName(15681,user.getLanguage())%></td>    		   
    		</tr>        
       </table> 
        <BR>
      <TABLE class=ListStyle cellspacing=1  cellpadding=1  cols=4 id="rewardTable">	  
        <TR class=Header>
       <TH colspan=2 align=left><%=SystemEnv.getHtmlLabelName(15682,user.getLanguage())%></TH>
       <Td colspan=2 align=right>
	     <BUTTON class=btnNew type="button" accessKey=A onClick="addrewardRow();"><U>A</U>-<%=SystemEnv.getHtmlLabelName(551,user.getLanguage())%></BUTTON> <BUTTON class=btnDelete type="button" accessKey=D onClick="javascript:if(isdel()){deleterewardRow1()};"><U>D</U>-<%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></BUTTON>
       </Td>
           	<tr class=header>
               <td width=10></td>
    		   <td class=Field><%=SystemEnv.getHtmlLabelName(15666,user.getLanguage())%></td>
    		   <td class=Field><%=SystemEnv.getHtmlLabelName(1962,user.getLanguage())%></td>
    		   <td class=Field><%=SystemEnv.getHtmlLabelName(454,user.getLanguage())%></td>    		   
    		</tr>

      </table>
      <BR>   
<%----------------------------�Զ�����ϸ�ֶ� begin--------------------------------------------%>

	 <%

         RecordSet.executeSql("select id, formlabel from cus_treeform where viewtype='1' and parentid="+scopeId+" order by scopeorder");
         //System.out.println("select id from cus_treeform where parentid="+scopeId);
         int recorderindex = 0 ;
         while(RecordSet.next()){
             recorderindex = 0 ;
             int subId = RecordSet.getInt("id");
             CustomFieldManager cfm2 = new CustomFieldManager("HrmCustomFieldByInfoType",subId);
             cfm2.getCustomFields();
             CustomFieldTreeManager.getMutiCustomData("HrmCustomFieldByInfoType", subId, Util.getIntValue(id,0));
             int colcount1 = cfm2.getSize() ;
             int colwidth1 = 0 ;

             if( colcount1 != 0 ) {
                 colwidth1 = 95/colcount1 ;

     %>
	 <table Class=ListStyle  cellspacing="0" cellpadding="0">
        <tr class=header>

            <td align="left" >
            <b><%=RecordSet.getString("formlabel")%></b>
            </td>
            <td align="right"  >
            <BUTTON Class=Btn type=button accessKey=A onclick="addRow_<%=subId%>()"><U>A</U>-���</BUTTON>
            <BUTTON class=btnDelete type="button" accessKey=D onClick="if(isdel()){deleteRow_<%=subId%>();}"><U>E</U>-ɾ��</BUTTON>
            </td>
        </tr>

        <tr>
            <td colspan=2>

            <table Class=ListStyle id="oTable_<%=subId%>"  cellspacing="1" cellpadding="0">
            <COLGROUP>
            <tr class=header>
            <td width="5%">&nbsp;</td>
   <%

       while(cfm2.next()){
		  String fieldlable =String.valueOf(cfm2.getLable());

   %>
		 <td width="<%=colwidth1%>%" nowrap><%=fieldlable%></td>
           <%
	   }
       cfm2.beforeFirst();
%>
</tr>
<%

    boolean isttLight = false;
    while(CustomFieldTreeManager.nextMutiData()){
            isttLight = !isttLight ;
%>
            <TR class='<%=( isttLight ? "datalight" : "datadark" )%>'>
            <td width="5%"><input class=InputStyle type='checkbox' name='check_node_<%=subId%>' value='<%=recorderindex%>'></td>
        <%
        while(cfm2.next()){
            String fieldid=String.valueOf(cfm2.getId());  //�ֶ�id
            String ismand=cfm2.isMand()?"1":"0";   //�ֶ��Ƿ��������
            String fieldhtmltype = String.valueOf(cfm2.getHtmlType());
            String fieldtype=String.valueOf(cfm2.getType());
            String fieldvalue =  Util.null2String(CustomFieldTreeManager.getMutiData("field"+fieldid)) ;

            if(ismand.equals("1"))  needinputitems+= ",customfield"+fieldid+"_"+subId+"_"+recorderindex;
            //�����������,�����������ļ����
%>
            <td class=field nowrap style="TEXT-VALIGN: center">
<%
            if(fieldhtmltype.equals("1")){                          // �����ı���
                if(fieldtype.equals("1")){                          // �����ı����е��ı�
                    if(ismand.equals("1")) {
%>
                        <input class=InputStyle datatype="text" type=text name="customfield<%=fieldid%>_<%=subId%>_<%=recorderindex%>" size=10 value="<%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%>" onChange="checkinput('customfield<%=fieldid%>_<%=subId%>_<%=recorderindex%>','customfield<%=fieldid%>_<%=subId%>_<%=recorderindex%>span')">
                        <span id="customfield<%=fieldid%>_<%=subId%>_<%=recorderindex%>span"><% if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
<%
                    }else{
%>
                        <input  class=InputStyle datatype="text" type=text name="customfield<%=fieldid%>_<%=subId%>_<%=recorderindex%>" value="<%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%>" size=10>
<%
                    }

                }else if(fieldtype.equals("2")){                     // �����ı����е�����
                    if(ismand.equals("1")) {
%>
                        <input class=InputStyle datatype="int" type=text name="customfield<%=fieldid%>_<%=subId%>_<%=recorderindex%>" size=10 value="<%=fieldvalue%>"
                            onKeyPress="ItemCount_KeyPress()" onBlur="checkinput('customfield<%=fieldid%>_<%=subId%>_<%=recorderindex%>','customfield<%=fieldid%>_<%=subId%>_<%=recorderindex%>span')">
                        <span id="customfield<%=fieldid%>_<%=subId%>_<%=recorderindex%>span"><% if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
<%
                    }else{
%>
                        <input  class=InputStyle datatype="int" type=text name="customfield<%=fieldid%>_<%=subId%>_<%=recorderindex%>" size=10 value="<%=fieldvalue%>" onKeyPress="ItemCount_KeyPress()" onBlur='checkcount1(this)'>
<%
                    }
                }else if(fieldtype.equals("3")){                     // �����ı����еĸ�����
                    if(ismand.equals("1")) {
%>
                        <input class=InputStyle datatype="float" type=text name="customfield<%=fieldid%>_<%=subId%>_<%=recorderindex%>" size=10 value="<%=fieldvalue%>"
                            onKeyPress="ItemNum_KeyPress()" onBlur="checknumber1(this);checkinput('customfield<%=fieldid%>_<%=subId%>_<%=recorderindex%>','customfield<%=fieldid%>_<%=subId%>_<%=recorderindex%>span')">
                        <span id="customfield<%=fieldid%>_<%=subId%>_<%=recorderindex%>span"><% if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
<%
                    }else{
%>
                        <input class=InputStyle  datatype="float" type=text name="customfield<%=fieldid%>_<%=subId%>_<%=recorderindex%>" size=10 value="<%=fieldvalue%>" onKeyPress="ItemNum_KeyPress()" onBlur='checknumber1(this)'>
<%
                    }
                }
            }else if(fieldhtmltype.equals("2")){                     // �����ı���
                if(ismand.equals("1")) {
%>
                    <textarea class=InputStyle name="customfield<%=fieldid%>_<%=subId%>_<%=recorderindex%>"  onChange="checkinput('customfield<%=fieldid%>_<%=subId%>_<%=recorderindex%>','customfield<%=fieldid%>_<%=subId%>_<%=recorderindex%>span')"
                        rows="4" cols="40" style="width:80%" ><%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%></textarea>
                    <span id="customfield<%=fieldid%>_<%=subId%>_<%=recorderindex%>span"><% if(fieldvalue.equals("")){%><img src="/images/BacoError.gif" align=absmiddle><%}%></span>
<%
                }else{
%>
                    <textarea class=InputStyle name="customfield<%=fieldid%>_<%=subId%>_<%=recorderindex%>" rows="4" cols="40" style="width:80%"><%=Util.toScreenToEdit(fieldvalue,user.getLanguage())%></textarea>
<%
                }
            }else if(fieldhtmltype.equals("3")){                         // �����ť (�漰workflow_broswerurl��)
                String url=BrowserComInfo.getBrowserurl(fieldtype);     // �����ť����ҳ���url
                String linkurl=BrowserComInfo.getLinkurl(fieldtype);    // ���ֵ�����ʱ�����ӵ�url
                String showname = "";                                   // �½�ʱ��Ĭ��ֵ��ʾ������
                String showid = "";                                     // �½�ʱ��Ĭ��ֵ

                String newdocid = Util.null2String(request.getParameter("docid"));

                if( fieldtype.equals("37") && !newdocid.equals("")) {
                    if( ! fieldvalue.equals("") ) fieldvalue += "," ;
                    fieldvalue += newdocid ;
                }

                if(fieldtype.equals("2") ||fieldtype.equals("19")){
                    showname=fieldvalue; // ����ʱ��
                }else if(!fieldvalue.equals("")) {
                    String tablename=BrowserComInfo.getBrowsertablename(fieldtype); //������Ӧ�ı�,����������Դ��
                    String columname=BrowserComInfo.getBrowsercolumname(fieldtype); //������Ӧ�ı������ֶ�
                    String keycolumname=BrowserComInfo.getBrowserkeycolumname(fieldtype);   //������Ӧ�ı�ֵ�ֶ�
                    sql = "";

                    HashMap temRes = new HashMap();

                    if(fieldtype.equals("17")|| fieldtype.equals("18")||fieldtype.equals("27")||fieldtype.equals("37")||fieldtype.equals("56")||fieldtype.equals("57")||fieldtype.equals("65")) {    // ��������Դ,��ͻ�,����飬���ĵ�
                        sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+" in( "+fieldvalue+")";
                    }
                    else {
                        sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+"="+fieldvalue;
                    }

                    rs.executeSql(sql);
                    while(rs.next()){
                        showid = Util.null2String(rs.getString(1)) ;
                        String tempshowname= Util.toScreen(rs.getString(2),user.getLanguage()) ;
                        if(!linkurl.equals(""))
                        //showname += "<a href='"+linkurl+showid+"'>"+tempshowname+"</a> " ;
                            temRes.put(String.valueOf(showid),"<a href='"+linkurl+showid+"'>"+tempshowname+"</a> ");
                        else{
                            //showname += tempshowname ;
                            temRes.put(String.valueOf(showid),tempshowname);
                        }
                    }
                    StringTokenizer temstk = new StringTokenizer(fieldvalue,",");
                    String temstkvalue = "";
                    while(temstk.hasMoreTokens()){
                        temstkvalue = temstk.nextToken();

                        if(temstkvalue.length()>0&&temRes.get(temstkvalue)!=null){
                            showname += temRes.get(temstkvalue);
                        }
                    }

                }
%>
                    <button class=Browser onclick="onShowBrowser('<%=fieldid%>_<%=subId%>_<%=recorderindex%>','<%=url%>','<%=linkurl%>','<%=fieldtype%>','<%=ismand%>')" title="ѡ��"></button>
                    <span id="customfield<%=fieldid%>_<%=subId%>_<%=recorderindex%>span"><%=showname%>
<%
                if( ismand.equals("1") && fieldvalue.equals("") ){
%>
                       <img src="/images/BacoError.gif" align=absmiddle>
<%
                }
%>
                    </span> <input type=hidden name="customfield<%=fieldid%>_<%=subId%>_<%=recorderindex%>" value="<%=fieldvalue%>">
<%
            }else if(fieldhtmltype.equals("4")) {                    // check��
%>
                <input class=InputStyle type=checkbox value=1 name="customfield<%=fieldid%>_<%=subId%>_<%=recorderindex%>" <%if(fieldvalue.equals("1")){%> checked <%}%> >
                <input type= hidden name="customfield<%=fieldid%>_<%=subId%>_<%=recorderindex%>" value="<%=fieldvalue%>">
<%
            }else if(fieldhtmltype.equals("5")){                     // ѡ���   select
                cfm2.getSelectItem(cfm2.getId());
%>
                <select class=InputStyle name="customfield<%=fieldid%>_<%=subId%>_<%=recorderindex%>" class=InputStyle>
<%
                while(cfm2.nextSelect()){
%>
                    <option value="<%=cfm2.getSelectValue()%>" <%=cfm2.getSelectValue().equals(fieldvalue)?"selected":""%>><%=cfm2.getSelectName()%>
<%
                }
%>
                </select>
<%
            }
%>
            </td>
<%
        }
        cfm2.beforeFirst();
        recorderindex ++ ;
    }

%>
</tr>

        </table>
        </td>
        </tr>
</table>
<input type='hidden' id=nodesnum name=nodesnum_<%=subId%> value="<%=recorderindex%>">

<script language=javascript>
var rowindex_<%=subId%> = <%=recorderindex%> ;
var curindex_<%=subId%> = <%=recorderindex%> ;
function addRow_<%=subId%>(){
    oRow = oTable_<%=subId%>.insertRow(rowindex_<%=subId%>+1);

    oCell = oRow.insertCell(-1);
    oCell.style.height=24;
    oCell.style.background= "#E7E7E7";

    var oDiv = document.createElement("div");
    var sHtml = "<input class=InputStyle type='checkbox' name='check_node_<%=subId%>' value='"+rowindex_<%=subId%>+"'>";
    oDiv.innerHTML = sHtml;
    oCell.appendChild(oDiv);
<%
    while(cfm2.next()){         // ѭ����ʼ
        String fieldhtml = "" ;
        String fieldid=String.valueOf(cfm2.getId());  //�ֶ�id
        String ismand=cfm2.isMand()?"1":"0";   //�ֶ��Ƿ��������
        String fieldhtmltype = String.valueOf(cfm2.getHtmlType());
        String fieldtype=String.valueOf(cfm2.getType());

        if(ismand.equals("1"))  needinputitems+= ",customfield"+fieldid+"_"+subId+"_"+recorderindex;
        //�����������,�����������ļ����

        // ���濪ʼ������ʾ�ֶ�

        if(fieldhtmltype.equals("1")){                          // �����ı���
            if(fieldtype.equals("1")){                          // �����ı����е��ı�
                if(ismand.equals("1")) {
                    fieldhtml = "<input class=InputStyle datatype='text' type=text name='customfield"+fieldid+"_"+subId+"_\"+rowindex_"+subId+"+\"' size=10 onChange='checkinput1(customfield"+fieldid+"_"+subId+"_\"+rowindex_"+subId+"+\",customfield"+fieldid+"_"+subId+"_\"+rowindex_"+subId+"+\"span)'><span id='customfield"+fieldid+"_"+subId+"_\"+rowindex_"+subId+"+\"span'><img src='/images/BacoError.gif' align=absmiddle></span>" ;
                }else{
                    fieldhtml = "<input class=InputStyle datatype='text' type=text name='customfield"+fieldid+"_"+subId+"_\"+rowindex_"+subId+"+\"' value='' size=10>";
                }
            }else if(fieldtype.equals("2")){                     // �����ı����е�����
                if(ismand.equals("1")) {
                    fieldhtml = "<input class=InputStyle  datatype='int' type=text name='customfield"+fieldid+"_"+subId+"_\"+rowindex_"+subId+"+\"' size=10 onKeyPress='ItemCount_KeyPress()' onBlur='checkcount1(this);checkinput1(customfield"+fieldid+"_"+subId+"_\"+rowindex_"+subId+"+\",customfield"+fieldid+"_"+subId+"_\"+rowindex_"+subId+"+\"span)'><span id='customfield"+fieldid+"_"+subId+"_\"+rowindex_"+subId+"+\"span'><img src='/images/BacoError.gif' align=absmiddle></span>" ;
                }else{
                    fieldhtml = "<input class=InputStyle datatype='int' type=text name='customfield"+fieldid+"_"+subId+"_\"+rowindex_"+subId+"+\"' size=10 onKeyPress='ItemCount_KeyPress()' onBlur='checkcount1(this)'>" ;
                }
            }else if(fieldtype.equals("3")){                     // �����ı����еĸ�����
                if(ismand.equals("1")) {
                    fieldhtml = "<input class=InputStyle datatype='float' type=text name='customfield"+fieldid+"_"+subId+"_\"+rowindex_"+subId+"+\"' size=10 onKeyPress='ItemNum_KeyPress()' onBlur='checknumber1(this);checkinput1(customfield"+fieldid+"_"+subId+"_\"+rowindex_"+subId+"+\",customfield"+fieldid+"_"+subId+"_\"+rowindex_"+subId+"+\"span)'><span id='customfield"+fieldid+"_"+subId+"_\"+rowindex_"+subId+"+\"span'><img src='/images/BacoError.gif' align=absmiddle></span>" ;
                }else{
                    fieldhtml = "<input class=InputStyle datatype='float' type=text name='customfield"+fieldid+"_"+subId+"_\"+rowindex_"+subId+"+\"' size=10 onKeyPress='ItemNum_KeyPress()' onBlur='checknumber1(this)'>" ;
                }
            }
        }else if(fieldhtmltype.equals("2")){                     // �����ı���
            if(ismand.equals("1")) {
                fieldhtml = "<textarea class=InputStyle name='customfield"+fieldid+"_"+subId+"_\"+rowindex_"+subId+"+\"' onChange='checkinput1(customfield"+fieldid+"_"+subId+"_\"+rowindex_"+subId+"+\",customfield"+fieldid+"_"+subId+"_\"+rowindex_"+subId+"+\"span)' rows='4' cols='40' style='width:80%'></textarea><span id='customfield"+fieldid+"_"+subId+"_\"+rowindex_"+subId+"+\"span'><img src='/images/BacoError.gif' align=absmiddle></span>" ;
            }else{
                fieldhtml = "<textarea class=InputStyle name='customfield"+fieldid+"_"+subId+"_\"+rowindex_"+subId+"+\"' rows='4' cols='40' style='width:80%'></textarea>" ;
            }
        }else if(fieldhtmltype.equals("3")){                         // �����ť (�漰workflow_broswerurl��)
            String url=BrowserComInfo.getBrowserurl(fieldtype);     // �����ť����ҳ���url
            String linkurl=BrowserComInfo.getLinkurl(fieldtype);    // ���ֵ�����ʱ�����ӵ�url

            if (!fieldtype.equals("37")) {    //  ���ĵ����⴦��
                fieldhtml = "<button class=Browser onclick=\\\"onShowBrowser('" + fieldid + "_"+subId+"_\"+rowindex_"+subId+"+\"','" + url + "','" + linkurl + "','" + fieldtype + "','" + ismand + "')\\\" title='" + SystemEnv.getHtmlLabelName(172, user.getLanguage()) + "'></button>";
            } else {                         // ����Ƕ��ĵ��ֶ�,�����½��ĵ���ť
                fieldhtml = "<button class=AddDoc onclick=\\\"onShowBrowser('" + fieldid + "_"+subId+"_\"+rowindex_"+subId+"+\"','" + url + "','" + linkurl + "','" + fieldtype + "','" + ismand + "')\\\">" + SystemEnv.getHtmlLabelName(611, user.getLanguage()) + "</button>";
            }
            fieldhtml += "<input type=hidden name='customfield"+fieldid+"_"+subId+"_\"+rowindex_"+subId+"+\"' value=''><span id='customfield"+fieldid+"_"+subId+"_\"+rowindex_"+subId+"+\"span'>" ;

            if(ismand.equals("1")) {
                fieldhtml += "<img src='/images/BacoError.gif' align=absmiddle>" ;
            }
            fieldhtml += "</span>" ;
        }else if(fieldhtmltype.equals("4")) {                    // check��
            fieldhtml += "<input class=InputStyle type=checkbox value=1 name='customfield"+fieldid+"_"+subId+"_\"+rowindex_"+subId+"+\"' " ;
            fieldhtml += ">" ;
        }else if(fieldhtmltype.equals("5")){                     // ѡ���   select
            fieldhtml += "<select class=InputStyle name='customfield"+fieldid+"_"+subId+"_\"+rowindex_"+subId+"+\"' " ;
            fieldhtml += ">" ;

            // ��ѯѡ�������п���ѡ���ֵ
            cfm2.getSelectItem(cfm2.getId());
            while(cfm2.nextSelect()){
                String tmpselectvalue = Util.null2String(cfm2.getSelectValue());
                String tmpselectname = Util.toScreen(cfm2.getSelectName(),user.getLanguage());
                fieldhtml += "<option value='"+tmpselectvalue+"'>"+tmpselectname+"</option>" ;
            }
            fieldhtml += "</select>" ;
        }                                          // ѡ����������� ���������ж�����
%>
    oCell = oRow.insertCell(-1);
    oCell.style.height=24;
    oCell.style.background= "#E7E7E7";

    var oDiv = document.createElement("div");
    var sHtml = "<%=fieldhtml%>" ;
    oDiv.innerHTML = sHtml;
    oCell.appendChild(oDiv);
<%
    }       // ѭ������
%>
    rowindex_<%=subId%> += 1;
    jQuery("#nodesnum_<%=subId%>").val(rowindex_<%=subId%>) ;
}


function deleteRow_<%=subId%>(){

    len = document.forms[0].elements.length;
    var i=0;
    var rowsum1 = 0;
    for(i=len-1; i >= 0;i--) {
        if (document.forms[0].elements[i].name=='check_node_<%=subId%>')
            rowsum1 += 1;
    }
    for(i=len-1; i >= 0;i--) {
        if (document.forms[0].elements[i].name=='check_node_<%=subId%>'){
            if(document.forms[0].elements[i].checked==true) {
                oTable_<%=subId%>.deleteRow(rowsum1);
				curindex_<%=subId%>--;
            }
            rowsum1 -=1;
        }
    }
}
</script>
<%
             }
%>
<br>
<%
         }
%>

<%----------------------------�Զ�����ϸ�ֶ� end  --------------------------------------------%>

     <input class=inputstyle type=hidden name="edurownum">
     <input class=inputstyle type=hidden name="workrownum">
     <input class=inputstyle type=hidden name="trainrownum">
     <input class=inputstyle type=hidden name="rewardrownum">
     <input class=inputstyle type=hidden name="cerrownum">
     <input class=inputstyle type=hidden name="lanrownum">
  </FORM>

</td>
</tr>
</TABLE>
</td>
<td></td>
</tr>
<tr>
<td height="0" colspan="3"></td>
</tr>
</table>
<script language="JavaScript" src="/js/addRowBg.js" >   
</script>  
<script language=javascript>
edurowindex = "0";
var rowColor="" ;
function addeduRow(){        
	oRow = eduTable.insertRow(-1);
	ncol = jQuery(eduTable).find("tr:nth-child(3)").find("td").length;
    rowColor = getRowBg();
	for(j=0; j<ncol; j++) {
		oCell = oRow.insertCell(-1); 
		oCell.style.height=24;
		oCell.style.background= rowColor;
		switch(j) {
			case 0:
                oCell.style.width=10;
				var oDiv = document.createElement("div");
				var sHtml = "<input class=inputstyle type='checkbox'  name='check_edu' value='0'>"; 
				oDiv.innerHTML = sHtml;
				oCell.appendChild(oDiv);
				break;
			case 1:
				var oDiv = document.createElement("div");
				var sHtml = "<input class=inputstyle type=text style='width:100%' name='school_"+edurowindex+"'>"; 
				oDiv.innerHTML = sHtml;
				oCell.appendChild(oDiv);
				break;
			case 2: 
				var oDiv = document.createElement("div"); 
				var sHtml = "<input class='wuiBrowser' type=hidden name='speciality_"+edurowindex+"' _url='/systeminfo/BrowserMain.jsp?url=/hrm/speciality/SpecialityBrowser.jsp'>";
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				jQuery(oDiv).find(".wuiBrowser").modalDialog();
				break;			
			case 3: 
                oCell.style.width=100;
				var oDiv = document.createElement("div"); 
				var sHtml = "<BUTTON class=Calendar type='button' id=selectcontractdate onclick='getDate(edustartdatespan_"+edurowindex+" , edustartdate_"+edurowindex+")' > </BUTTON><SPAN id='edustartdatespan_"+edurowindex+"'></SPAN> <input class=inputstyle type=hidden id='edustartdate_"+edurowindex+"' name='edustartdate_"+edurowindex+"'>";
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;
         case 4: 
                oCell.style.width=100;
				var oDiv = document.createElement("div"); 
				var sHtml = "<BUTTON class=Calendar type='button' id=selectcontractdate onclick='getDate(eduenddatespan_"+edurowindex+" , eduenddate_"+edurowindex+")' > </BUTTON><SPAN id='eduenddatespan_"+edurowindex+"'></SPAN> <input class=inputstyle type=hidden id='eduenddate_"+edurowindex+"' name='eduenddate_"+edurowindex+"'>";
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;
		 case 5: 
				var oDiv = document.createElement("div"); 				
	            var sHtml = "<input class='wuiBrowser' type=hidden name='educationlevel_"+edurowindex+"' _url='/systeminfo/BrowserMain.jsp?url=/hrm/educationlevel/EduLevelBrowser.jsp'>"; 
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv); 
				jQuery(oDiv).find(".wuiBrowser").modalDialog();
				break;
			case 6: 
				var oDiv = document.createElement("div");
				var sHtml = "<input class=inputstyle type=text style='width:100%' name='studydesc_"+edurowindex+"'>";
				oDiv.innerHTML = sHtml;
				oCell.appendChild(oDiv);
				break;
				
		}
	}
	edurowindex = edurowindex*1 +1;	
}
function deleteeduRow1()
{
	len = document.forms[0].elements.length;	
	var i=0;
	var rowsum1 = 0 ;
	for(i=len-1; i >= 0;i--) {
		if (document.forms[0].elements[i].name=='check_edu')
			rowsum1 += 1;
	} 
	for(i=len-1; i >= 0;i--) {
		if (document.forms[0].elements[i].name=='check_edu'){
			if(document.forms[0].elements[i].checked==true) {
				eduTable.deleteRow(rowsum1+2);	
			}
			rowsum1 -=1;
		}
	
	}	
}

workrowindex = "0"

function addworkRow()
{
	ncol = jQuery(workTable).find("tr:nth-child(3)").find("td").length;
	oRow = workTable.insertRow(-1);
	rowColor = getRowBg();
	for(j=0; j<ncol; j++) {
		oCell = oRow.insertCell(-1); 
		oCell.style.height=24;
		oCell.style.background= rowColor;
		switch(j) {
			case 0:
                oCell.style.width=10;
				var oDiv = document.createElement("div");
				var sHtml = "<input class=inputstyle type='checkbox'  style='width:100%' name='check_work' value='0'>"; 
				oDiv.innerHTML = sHtml;                
				oCell.appendChild(oDiv);
				break;
			case 1:
				var oDiv = document.createElement("div");
				var sHtml = "<input class=inputstyle type=text  style='width:100%' name='company_"+workrowindex+"'>"; 
				oDiv.innerHTML = sHtml;
				oCell.appendChild(oDiv);
				break;
			case 2: 
                                oCell.style.width=100;
				var oDiv = document.createElement("div"); 
				var sHtml = "<BUTTON class=Calendar type='button' id=selectcontractdate onclick='getDate(workstartdatespan_"+workrowindex+" , workstartdate_"+workrowindex+")' > </BUTTON><SPAN id='workstartdatespan_"+workrowindex+"'></SPAN> <input class=inputstyle type=hidden id='workstartdate_"+workrowindex+"' name='workstartdate_"+workrowindex+"'>";

				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;			
			case 3: 
			    oCell.style.width=100;
				var oDiv = document.createElement("div"); 
				var sHtml = "<BUTTON class=Calendar type='button' id=selectcontractdate onclick='getDate(workenddatespan_"+workrowindex+" , workenddate_"+workrowindex+")' > </BUTTON><SPAN id='workenddatespan_"+workrowindex+"'></SPAN> <input class=inputstyle type=hidden id='workenddate_"+workrowindex+"' name='workenddate_"+workrowindex+"'>";
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;
                        case 4: 
				var oDiv = document.createElement("div"); 
				var sHtml = "<input class=inputstyle type=text style='width:100%' name='jobtitle_"+workrowindex+"'>";
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;
		        case 5:
				var oDiv = document.createElement("div"); 
				var sHtml = "<input class=inputstyle type=text style='width:100%' name='workdesc_"+workrowindex+"'>";
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;
			case 6: 
				var oDiv = document.createElement("div");
				var sHtml = "<input class=inputstyle type=text style='width:100%' name='leavereason_"+workrowindex+"'>";
				oDiv.innerHTML = sHtml;
				oCell.appendChild(oDiv);
				break;				
		}
	}
	workrowindex = workrowindex*1 +1;
	
}

function deleteworkRow1()
{
	len = document.forms[0].elements.length;
	var i=0;
	var rowsum1 = 0;
	for(i=len-1; i >= 0;i--) {
		if (document.forms[0].elements[i].name=='check_work')
			rowsum1 += 1;
	}
	for(i=len-1; i >= 0;i--) {
		if (document.forms[0].elements[i].name=='check_work'){
			if(document.forms[0].elements[i].checked==true) {
				workTable.deleteRow(rowsum1+2);	
			}
			rowsum1 -=1;
		}
	
	}	
}	

trainrowindex = "0"
function addtrainRow()
{
	ncol = jQuery(trainTable).find("tr:nth-child(3)").find("td").length;
	oRow = trainTable.insertRow(-1);
	rowColor = getRowBg();
	for(j=0; j<ncol; j++) {
		oCell = oRow.insertCell(-1); 
		oCell.style.height=24;
		oCell.style.background= rowColor;
		switch(j) {
			case 0:
                oCell.style.width=10;
				var oDiv = document.createElement("div");
				var sHtml = "<input class=inputstyle type='checkbox'  style='width:100%' name='check_train' value='0'>"; 
				oDiv.innerHTML = sHtml;
				oCell.appendChild(oDiv);
				break;
			case 1:
				var oDiv = document.createElement("div");
				var sHtml = "<input class=inputstyle type=text style='width:100%' name='trainname_"+trainrowindex+"'>"; 
				oDiv.innerHTML = sHtml;
				oCell.appendChild(oDiv);
				break;
			case 2: 
                oCell.style.width=100;
				var oDiv = document.createElement("div"); 
				var sHtml = "<BUTTON class=Calendar type='button' id=selectcontractdate onclick='getDate(trainstartdatespan_"+trainrowindex+" , trainstartdate_"+trainrowindex+")' > </BUTTON><SPAN id='trainstartdatespan_"+trainrowindex+"'></SPAN> <input class=inputstyle type=hidden id='trainstartdate_"+trainrowindex+"' name='trainstartdate_"+trainrowindex+"'>";				
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;			
			case 3: 
                oCell.style.width=100;
				var oDiv = document.createElement("div"); 
				var sHtml = "<BUTTON class=Calendar type='button' id=selectcontractdate onclick='getDate(trainenddatespan_"+trainrowindex+" , trainenddate_"+trainrowindex+")' > </BUTTON><SPAN id='trainenddatespan_"+trainrowindex+"'></SPAN> <input class=inputstyle type=hidden id='trainenddate_"+trainrowindex+"' name='trainenddate_"+trainrowindex+"'>";				
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;
            case 4: 
				var oDiv = document.createElement("div"); 
				var sHtml = "<input class=inputstyle type=text style='width:100%' name='trainresource_"+trainrowindex+"'>";
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;
		    case 5: 
				var oDiv = document.createElement("div"); 
				var sHtml = "<input class=inputstyle type=text style='width:100%' name='trainmemo_"+trainrowindex+"'>";
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;				
		}
	}
	trainrowindex = trainrowindex*1 +1;
	
}

function deletetrainRow1()
{
	len = document.forms[0].elements.length;
	var i=0;
	var rowsum1 = 0;
	for(i=len-1; i >= 0;i--) {
		if (document.forms[0].elements[i].name=='check_train')
			rowsum1 += 1;
	}
	for(i=len-1; i >= 0;i--) {
		if (document.forms[0].elements[i].name=='check_train'){
			if(document.forms[0].elements[i].checked==true) {
				trainTable.deleteRow(rowsum1+2);	
			}
			rowsum1 -=1;
		}
	
	}	
}	

rewardrowindex = "0"
function addrewardRow()
{
	ncol = jQuery(rewardTable).find("tr:nth-child(2)").find("td").length;
	oRow = rewardTable.insertRow(-1);
	rowColor = getRowBg();
	for(j=0; j<ncol; j++) {
		oCell = oRow.insertCell(-1); 
		oCell.style.height=24;
		oCell.style.background= rowColor;
		switch(j) {
            case 0:
                oCell.style.width=10;
				var oDiv = document.createElement("div");
				var sHtml = "<input class=inputstyle type='checkbox' name='check_reward' value='0'>"; 
				oDiv.innerHTML = sHtml;
				oCell.appendChild(oDiv);
				break;
			case 1:
				var oDiv = document.createElement("div");
				var sHtml = "<input class=inputstyle type=text style='width:100%' name='rewardname_"+rewardrowindex+"'>"; 
				oDiv.innerHTML = sHtml;
				oCell.appendChild(oDiv);
				break;
			case 2: 
                oCell.style.width=100;
				var oDiv = document.createElement("div"); 
				var sHtml = "<BUTTON class=Calendar type='button' id=selectcontractdate onclick='getDate(rewarddatespan_"+rewardrowindex+" , rewarddate_"+rewardrowindex+")' > </BUTTON><SPAN id='rewarddatespan_"+rewardrowindex+"'></SPAN> <input class=inputstyle type=hidden id='rewarddate_"+rewardrowindex+"' name='rewarddate_"+rewardrowindex+"'>";
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;			
			case 3: 
				var oDiv = document.createElement("div"); 
				var sHtml = "<input class=inputstyle type=text style='width:100%' name='rewardmemo_"+rewardrowindex+"'>";
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;
		}
	}
	rewardrowindex = rewardrowindex*1 +1;
	
}

function deleterewardRow1()
{
	len = document.forms[0].elements.length;
	var i=0;
	var rowsum1 = 0;
	for(i=len-1; i >= 0;i--) {
		if (document.forms[0].elements[i].name=='check_reward')
			rowsum1 += 1;
	}
	for(i=len-1; i >= 0;i--) {
		if (document.forms[0].elements[i].name=='check_reward'){
			if(document.forms[0].elements[i].checked==true) {
				rewardTable.deleteRow(rowsum1+1);	
			}
			rowsum1 -=1;
		}
	
	}	
}	

cerrowindex = "0"
function addcerRow()
{
	ncol = jQuery(cerTable).find("tr:nth-child(3)").find("td").length;
	
	oRow = cerTable.insertRow(-1);
	
	for(j=0; j<ncol; j++) {
		oCell = oRow.insertCell(-1); 
		oCell.style.height=24;
		oCell.style.background= "#efefef";
		switch(j) {
			case 0:
                oCell.style.width=10;
				var oDiv = document.createElement("div");
				var sHtml = "<input class=inputstyle type='checkbox'  style='width:100%' name='check_cer' value='0'>"; 
				oDiv.innerHTML = sHtml;
				oCell.appendChild(oDiv);
				break;
			case 1:
				var oDiv = document.createElement("div");
				var sHtml = "<input class=inputstyle type=text style='width:100%' name='cername_"+cerrowindex+"'>"; 
				oDiv.innerHTML = sHtml;
				oCell.appendChild(oDiv);
				break;
			case 2: 
                oCell.style.width=100;
				var oDiv = document.createElement("div"); 
				var sHtml = "<BUTTON class=Calendar type='button' id=selectcontractdate onclick='getDate(cerstartdatespan_"+cerrowindex+" , cerstartdate_"+cerrowindex+")' > </BUTTON><SPAN id='cerstartdatespan_"+cerrowindex+"'></SPAN> <input class=inputstyle type=hidden id='cerstartdate_"+cerrowindex+"' name='cerstartdate_"+cerrowindex+"'>";				
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;			
			case 3: 
                                oCell.style.width=100;
				var oDiv = document.createElement("div"); 
				var sHtml = "<BUTTON class=Calendar type='button' id=selectcontractdate onclick='getDate(cerenddatespan_"+cerrowindex+" , cerenddate_"+cerrowindex+")' > </BUTTON><SPAN id='cerenddatespan_"+cerrowindex+"'></SPAN> <input class=inputstyle type=hidden id='cerenddate_"+cerrowindex+"' name='cerenddate_"+cerrowindex+"'>";				
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;
                        case 4: 
				var oDiv = document.createElement("div"); 
				var sHtml = "<input class=inputstyle type=text style='width:100%' name='cerresource_"+cerrowindex+"'>";
				oDiv.innerHTML = sHtml;   
				oCell.appendChild(oDiv);  
				break;		    
		}
	}
	cerrowindex = cerrowindex*1 +1;
	
}

function deletecerRow1()
{
	len = document.forms[0].elements.length;
	var i=0;
	var rowsum1 = 0;
	for(i=len-1; i >= 0;i--) {
		if (document.forms[0].elements[i].name=='check_cer')
			rowsum1 += 1;
	}
	for(i=len-1; i >= 0;i--) {
		if (document.forms[0].elements[i].name=='check_cer'){
			if(document.forms[0].elements[i].checked==true) {
				cerTable.deleteRow(rowsum1+2);	
			}
			rowsum1 -=1;
		}
	
	}	
}	

lanrowindex = 0;
function addlanRow(){        
	oRow = lanTable.insertRow(-1);
	ncol = jQuery(lanTable).find("tr:nth-child(3)").find("td").length;
	for(j=0; j<ncol; j++) {
		oCell = oRow.insertCell(-1); 
		oCell.style.height=24;
		oCell.style.background= "#efefef";
		switch(j) {
			case 0:
                oCell.style.width=10;
				var oDiv = document.createElement("div");
				var sHtml = "<input class=inputstyle type='checkbox'  name='check_lan' value='0'>"; 
				oDiv.innerHTML = sHtml;
				oCell.appendChild(oDiv);
				break;
			case 1:
				var oDiv = document.createElement("div");
				var sHtml = "<input class=inputstyle type=text style='width:100%' name='language_"+lanrowindex+"'>"; 
				oDiv.innerHTML = sHtml;
				oCell.appendChild(oDiv);
				break;			
		    case 2: 
				var oDiv = document.createElement("div"); 				
				var sHtml = "<select class=inputstyle id=level style='width:100%' name='level_"+lanrowindex+"'><option value=0 selected ><%=SystemEnv.getHtmlLabelName(154,user.getLanguage())%></option><option value=1 ><%=SystemEnv.getHtmlLabelName(821,user.getLanguage())%></option><option value=2 ><%=SystemEnv.getHtmlLabelName(822,user.getLanguage())%></option><option value=3 ><%=SystemEnv.getHtmlLabelName(823,user.getLanguage())%></option></select>"
				oDiv.innerHTML = sHtml;
				oCell.appendChild(oDiv);
				break;
			case 3:
				var oDiv = document.createElement("div");
				var sHtml = "<input class=inputstyle type=text style='width:100%' name='memo_"+lanrowindex+"'>";
				oDiv.innerHTML = sHtml;
				oCell.appendChild(oDiv);
				break;

		}
	}
	lanrowindex = lanrowindex*1 +1;
}
function deletelanRow1()
{
	len = document.forms[0].elements.length;
	var i=0;
	var rowsum1 = 0 ;
	for(i=len-1; i >= 0;i--) {
		if (document.forms[0].elements[i].name=='check_lan')
			rowsum1 += 1;
	}
	for(i=len-1; i >= 0;i--) {
		if (document.forms[0].elements[i].name=='check_lan'){
			if(document.forms[0].elements[i].checked==true) {
				lanTable.deleteRow(rowsum1+2);
			}
			rowsum1 -=1;
		}

	}
}


function doSave(obj) {
   obj.disabled = true;
   document.resource.lanrownum.value = lanrowindex;
   document.resource.rewardrownum.value = rewardrowindex;
   document.resource.workrownum.value = workrowindex;
   document.resource.edurownum.value = edurowindex;
   document.resource.trainrownum.value = trainrowindex;
   document.resource.cerrownum.value = cerrowindex;
   document.resource.submit() ;

}

function onShowBrowser(id,url,linkurl,type1,ismand){
	if (type1== 2 || type1 == 19){
		id1 == window.showModalDialog(url,"","dialogHeight:320px;dialogwidth:275px");
		jQuery("#customfield"+id+"span]").html(id1);
		jQuery("input[name=customfield"+id+"]").val(id1);
	}else{
		if (type1 != 17 && type1 != 18 && type1!=27 && type1!=37 && type1!=56 && type1!=57 && type1!=65 && type1!=4 && type1!=167 && type1!=164 && type1!=169 && type1!=170){
			id1 = window.showModalDialog(url);
		}else if (type1==4 || type1==167 || type1==164 || type1==169 || type1==170){
            tmpids = jQuery("input[name=customfield"+id+"]").val();
			id1 = window.showModalDialog(url+"?selectedids="+tmpids);
		}else{
			tmpids = jQuery("input[name=customfield"+id+"]").val();
			id1 = window.showModalDialog(url+"?resourceids="+tmpids);
		}
		if(id1!=null){
			if (type1 == 17 || type1 == 18 || type1==27 || type1==37 || type1==56 || type1==57 || type1==65){
				if (id1.id!= ""  && id1.id!= "0"){
					ids = id1.id.split(",");
					names =id1.name.split(",");
					sHtml = "";
					for( var i=0;i<ids.length;i++){
						if(ids[i]!=""){
							sHtml = sHtml+"<a target='_blank' href="+linkurl+ids[i]+">"+names[i]+"</a>&nbsp;";
						}
					}
					
					jQuery("#customfield"+id+"span]").html(sHtml);
					
				}else{
					if (ismand==0){
						jQuery("#customfield"+id+"span]").html();
					}else{
						jQuery("#customfield"+id+"span]").html("<img src='/images/BacoError.gif' align=absmiddle>");
					}
					jQuery("input[name=customfield"+id+"]").val("");
				}

			}else{
			   if  (id1.id!=""   && id1.id!= "0"){
			        if (linkurl == ""){
						jQuery("#customfield"+id+"span]").html(id1.name);
					}else{
						jQuery("#customfield"+id+"span").html("<a target='_blank' href="+linkurl+id1.id+">"+id1.name+"</a>");
					}
					jQuery("input[name=customfield"+id+"]").val(id1.id);
			   }else{
					if (ismand==0){
						jQuery("#customfield"+id+"span]").html();
					}else{
						jQuery("#customfield"+id+"span]").html("<img src='/images/BacoError.gif' align=absmiddle>");
					}
					jQuery("input[name=customfield"+id+"]").val("");
			   }
			}
		}
	}

}
</script>
<script language=vbs>

sub onShowUsekind()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/usekind/UseKindBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	usekindspan.innerHtml = id(1)
	resource.usekind.value=id(0)
	else
	usekindspan.innerHtml = ""
	resource.usekind.value=""
	end if
	end if
end sub
sub onShowSpeciality(inputspan,inputname)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/speciality/SpecialityBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	inputspan.innerHtml = id(1)
	inputname.value=id(0)
	else
	inputspan.innerHtml = ""
	inputname.value=""
	end if
	end if
end sub
sub onShowEduLevel(inputspan,inputname)
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/educationlevel/EduLevelBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	inputspan.innerHtml = id(1)
	inputname.value=id(0)
	else
	inputspan.innerHtml = ""
	inputname.value=""
	end if
	end if
end sub
</script>
</BODY>
<SCRIPT language="javascript" src="/js/datetime.js"></script>
<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker.js"></script>
</HTML>