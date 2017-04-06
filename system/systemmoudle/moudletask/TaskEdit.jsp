<%@ page import="weaver.general.Util,java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs1" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs2" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="BrowserComInfo" class="weaver.workflow.field.BrowserComInfo" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />


<HTML><HEAD>
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
<SCRIPT language="javascript" src="/js/weaver.js"></script>
</head>
<%
String supmoduleid  = Util.null2String(request.getParameter("supmoduleid"));
String moudleid = Util.null2String(request.getParameter("moudleid"));
String inputid = Util.null2String(request.getParameter("inputid"));
String userid = "" + user.getUID() ;
String moudlename = "" ;
String moudletablename = "" ;
String needconfirm = "" ;
String isrootmoudle = "" ;

String inputsubject = "" ;
String createrid = "" ;
String confirmid = "" ;
String createdate = "" ;
String confirmdate = "" ;
String inputstatus = "" ;

boolean canEdit = false ;
boolean canConfirm = false ;
boolean hasvalue = false ;
boolean canSubmit = false ;

char separator = Util.getSeparator() ;
String para = inputid + separator + moudleid ;
rs.executeProc("SystemMoudle_SBySelMoudleID",para);
if(rs.next()) {
    moudlename = Util.toScreenToEdit(rs.getString("moudlename"),user.getLanguage()) ;
    moudletablename = Util.null2String(rs.getString("moudletablename")) ;
    needconfirm = Util.null2String(rs.getString("needconfirm")) ;
    isrootmoudle = Util.null2String(rs.getString("isrootmoudle")) ;
    createrid = Util.null2String(rs.getString("moudlecreater")) ;
}


if( isrootmoudle.equals("0") ) supmoduleid = moudleid ;

rs.executeSql(" select * from " + moudletablename + " where inputid = " + inputid ) ;
if( rs.next() ) {
    inputsubject = Util.toScreen(rs.getString("inputsubject"),user.getLanguage()) ;
    createrid = Util.null2String(rs.getString("createrid")) ;
    confirmid = Util.null2String(rs.getString("confirmid")) ;
    createdate = Util.null2String(rs.getString("createdate")) ;
    confirmdate = Util.null2String(rs.getString("confirmdate")) ;
    inputstatus = Util.null2String(rs.getString("inputstatus")) ;

    hasvalue = true ;
}


if( ( inputstatus.equals("") || inputstatus.equals("0") || inputstatus.equals("3") ) && createrid.equals(userid) ) canSubmit = true ;
if( inputstatus.equals("1") && confirmid.equals(userid) ) {
    canConfirm = true ;
}
if( canSubmit || canConfirm ) canEdit = true ;

String imagefilename = "/images/hdHRMCard.gif";
String titlename = Util.toScreen("����༭",user.getLanguage(),"0") + "-" + moudlename;
String needfav ="1";
String needhelp ="";
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>

<FORM id=frmMain name=frmMain action="TaskOperation.jsp" method=post onsubmit="return check_form(this,'inputsubject')">
<input type="hidden" name="moudleid" value="<%=moudleid%>">
<input type="hidden" name="supmoduleid" value="<%=supmoduleid%>">
<input type="hidden" name="inputid" value="<%=inputid%>">
<input type="hidden" name="oldinputstatus" value="<%=inputstatus%>">
<input type="hidden" name=operation>

<DIV class=HdrProps></DIV>
<DIV>
<% if( canSubmit ) {%>
<BUTTON class=btnSave accessKey=C onclick="doDraft()"><U>C</U>-�ݸ�</BUTTON>
<BUTTON class=btnSave accessKey=S onclick="doSubmit()"><U>S</U>-�ύ</BUTTON>
<%} if( canConfirm ) { %>
<BUTTON class=btnSave accessKey=S onclick="doDraft()"><U>S</U>-����</BUTTON>
<%}%>
<BUTTON class=Btn id=button1 accessKey=R name=button1 onclick="location.href='TaskView.jsp?inputid=<%=inputid%>&moudleid=<%=supmoduleid%>'"><U>R</U>-����</BUTTON>
</DIV>
<br>
<% if ( canEdit ) { %>
  <table class=form>
  <COLGROUP>
  <COL width="15%">
  <COL width="85%">
    <tbody> 
    <tr class=Section>
      <td><nobr><b><%=moudlename%></font></b></td>
      <td align=right colspan=2></td>
    </tr>
	<tr class=separator> 
      <td class=Sep2 colspan=2></td>
    </tr>
    <% if( isrootmoudle.equals("0") ) { %>
    <TR> 
      <TD>��������</TD>
      <TD class=Field> 
        <INPUT type=text size=50 name="inputsubject" onchange='checkinput("inputsubject","inputsubjectimage")' value="<%=inputsubject%>">
        <SPAN id=inputsubjectimage></SPAN></TD>
    </TR>
    <%}%>
	<% 
	rs1.executeProc("SysModItemDsp_SByModid",""+moudleid);
	while(rs1.next()) {
		String itemid = Util.null2String(rs1.getString("itemid")) ;
		String itemdspname = Util.toScreen(rs1.getString("itemdspname"),user.getLanguage()) ;
        String itemfieldname = Util.null2String(rs1.getString("itemfieldname")) ;
        String itemfieldtype = Util.null2String(rs1.getString("itemfieldtype")) ;
        String itembroswertype = Util.null2String(rs1.getString("itembroswertype")) ;
        String fieldvalue = "" ;
        if( hasvalue ) fieldvalue = Util.toScreenToEdit(rs.getString(itemfieldname),user.getLanguage()) ;
	%>
	<TR>
      <td <%if(itemfieldtype.equals("6")){%> valign=top <%}%>><%=itemdspname%></td>
      <td class=Field>
      <%
        if(itemfieldtype.equals("1")){                          // �����ı����е��ı�
      %>
        <input type=text name="field_<%=itemid%>" size=50 value="<%=fieldvalue%>">
      <%
        } else if(itemfieldtype.equals("2")){                     // �����ı����е�����
      %>
        <input type=text name="field_<%=itemid%>" size=10 onKeyPress="ItemCount_KeyPress()" onBlur="checkcount1(this)" value="<%=fieldvalue%>">
       <%
        } else if(itemfieldtype.equals("3")){                     // �����ı����еĸ�����
       %>
        <input type=text name="field_<%=itemid%>" size=10 onKeyPress="ItemNum_KeyPress()" onBlur="checknumber1(this)" value="<%=fieldvalue%>">
       <%
	    } else if(itemfieldtype.equals("6")){                     // �����ı���
       %>
        <textarea name="field_<%=itemid%>" rows="4" cols="40" style="width:80%"><%=fieldvalue%></textarea>
       <%
	    } else if(itemfieldtype.equals("5")){                         // �����ť (�漰workflow_broswerurl��)
		    String url=BrowserComInfo.getBrowserurl(itembroswertype);     // �����ť����ҳ���url
		    String linkurl=BrowserComInfo.getLinkurl(itembroswertype);    // ���ֵ�����ʱ�����ӵ�url

            String showname = "" ;
            String sql = "" ;
            if(itembroswertype.equals("2") || itembroswertype.equals("19") )  showname=fieldvalue; // ����ʱ��
            else if(!fieldvalue.equals("")) {
                String tablename=BrowserComInfo.getBrowsertablename(itembroswertype); //������Ӧ�ı�,����������Դ��
                String columname=BrowserComInfo.getBrowsercolumname(itembroswertype); //������Ӧ�ı������ֶ�
                String keycolumname=BrowserComInfo.getBrowserkeycolumname(itembroswertype);   //������Ӧ�ı�ֵ�ֶ�
                
                if(itembroswertype.equals("17")|| itembroswertype.equals("18")||itembroswertype.equals("27")||itembroswertype.equals("37")) {    // ��������Դ,��ͻ�,����飬���ĵ�
                    sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+" in( "+fieldvalue+")";
                }
                else {
                    sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+"="+fieldvalue;
                }

                rs2.executeSql(sql);
                while(rs2.next()) showname += Util.toScreen(rs2.getString(2),user.getLanguage()) + " " ;
            }
	   %>
        <button class=Browser onclick="onShowBrowser('<%=itemid%>','<%=url%>','<%=linkurl%>','<%=itembroswertype%>')" title="ѡ��"></button> 
        <input type=hidden name="field_<%=itemid%>" value="<%=fieldvalue%>">
        <span id="field_<%=itemid%>span"><%=showname%></span> 
       <%
	    } else if(itemfieldtype.equals("4")){                     // ѡ���   select
	   %>
        <select name="field_<%=itemid%>">
	   <%
            // ��ѯѡ�������п���ѡ���ֵ
            rs2.executeProc("SystemModItemDetail_SByItemid",itemid);
            while(rs2.next()){
                String tmpselectvalue = Util.toScreenToEdit(rs2.getString("itemvalue"),user.getLanguage());
	   %>
	    <option value="<%=tmpselectvalue%>" <% if(tmpselectvalue.equals(fieldvalue)){%>selected<%}%>><%=tmpselectvalue%></option>
	   <%
            }
       %>
	    </select>
       <%   
        }                                          // ѡ����������� ���������ж�����
       %>
       </td>
    </tr>
	<%}%>
    </tbody>
  </table>
<%} else {%>
  <table class=form>
  <COLGROUP>
  <COL width="15%">
  <COL width="85%">
    <tbody> 
    <tr class=Section>
      <td><nobr><b><%=moudlename%></font></b></td>
      <td align=right colspan=2></td>
    </tr>
	<tr class=separator> 
      <td class=Sep2 colspan=2></td>
    </tr>
    <% if( isrootmoudle.equals("0") ) { %>
    <TR> 
      <TD>��������</TD>
      <TD class=Field><%=inputsubject%></TD>
    </TR>
    <% }%>
	<% 
	rs1.executeProc("SysModItemDsp_SByModid",""+moudleid);
	while(rs1.next()) {
		String itemid = Util.null2String(rs1.getString("itemid")) ;
        String itemfieldname = Util.null2String(rs1.getString("itemfieldname")) ;
		String itemdspname = Util.toScreen(rs1.getString("itemdspname"),user.getLanguage()) ;
        String itemfieldtype = Util.null2String(rs1.getString("itemfieldtype")) ;
        String itembroswertype = Util.null2String(rs1.getString("itembroswertype")) ;
	%>
	<TR>
      <td <%if(itemfieldtype.equals("6")){%> valign=top <%}%>><%=itemdspname%></td>
      <td class=Field>
      <%
        if(!itemfieldtype.equals("5")){                          // �ı�
      %>
        <%=Util.toScreen(rs.getString(itemfieldname),user.getLanguage())%>
      <%
        } else {                                                // �����ť (�漰workflow_broswerurl��)
            String showname = "" ;
            String sql = "" ;
            String fieldvalue = Util.null2String(rs.getString(itemfieldname)) ;
            if(itembroswertype.equals("2") || itembroswertype.equals("19") )  showname=fieldvalue; // ����ʱ��
            else if(!fieldvalue.equals("")) {
                String tablename=BrowserComInfo.getBrowsertablename(itembroswertype); //������Ӧ�ı�,����������Դ��
                String columname=BrowserComInfo.getBrowsercolumname(itembroswertype); //������Ӧ�ı������ֶ�
                String keycolumname=BrowserComInfo.getBrowserkeycolumname(itembroswertype);   //������Ӧ�ı�ֵ�ֶ�
                String linkurl=BrowserComInfo.getLinkurl(itembroswertype);    // ���ֵ�����ʱ�����ӵ�url
                
                if(itembroswertype.equals("17")|| itembroswertype.equals("18")||itembroswertype.equals("27")||itembroswertype.equals("37")) {    // ��������Դ,��ͻ�,����飬���ĵ�
                    sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+" in( "+fieldvalue+")";
                }
                else {
                    sql= "select "+keycolumname+","+columname+" from "+tablename+" where "+keycolumname+"="+fieldvalue;
                }

                rs2.executeSql(sql);
                while(rs2.next()) {
                    String tempshowid = Util.null2String(rs2.getString(1)) ;
                    String tempshowname = Util.toScreen(rs2.getString(2),user.getLanguage()) ;
                    if(!linkurl.equals("")){
                        showname += "<a href='"+linkurl+tempshowid+"'>"+tempshowname+"</a> " ;
                    }
                    else 
                        showname += tempshowname + " " ;
                }
            }
      %>
        <%=showname%>
      <%
        } 
      %>
       </td>
    </tr>
	<%}%>
    </tbody>
  </table>
<% } %>

<% if( isrootmoudle.equals("0") && canEdit ) { %>
<br>
<TABLE class=ListShort>
  <COLGROUP>
  <COL width="5%">
  <COL width="50%">
  <COL width="45%">
  <TBODY>
  <tr class=Section> 
      <th colspan=3>ѡ����Ҫִ�е����񼰸�����</th>
    </tr>
  <TR class=separator>
    <TD class=Sep1 colSpan=3 ></TD>
  </TR>
  <TR class=Header>
  <th>ѡ��</th>
  <th>��������</th>
  <th>������</th>
  </tr>
<%
    boolean isLight = false;
    ArrayList selectmoduleids = new ArrayList() ;
    ArrayList selectcreaterids = new ArrayList() ;

    rs.executeProc("SystemMoudle_SBySelID",inputid);
    while(rs.next()) {
        String submoudleid = Util.null2String(rs.getString("moudleid")) ;
        String submoudlecreater = Util.null2String(rs.getString("moudlecreater")) ;
        selectmoduleids.add(submoudleid) ;
        selectcreaterids.add(submoudlecreater) ;
    }

    rs.executeProc("SystemMoudle_SBySupID",moudleid);
    while(rs.next()) {
        String submoudleid = Util.null2String(rs.getString("moudleid")) ;
        String submoudletablename = Util.null2String(rs.getString("moudletablename")) ;
        String submoudlename = Util.toScreen(rs.getString("moudlename"),user.getLanguage()) ;
        String submoudlecreater = Util.null2String(rs.getString("moudlecreater")) ;
        int selectindex = selectmoduleids.indexOf(submoudleid) ;
        String selectmoudlecreater = "" ;
        if( selectindex != -1 ) selectmoudlecreater = (String) selectcreaterids.get(selectindex) ; 
    %>
       <tr class='<%=( isLight ? "datalight" : "datadark" )%>'>
         <TD><input type=checkbox name="checkmoduleid" value="<%=submoudleid%>" <% if( selectindex != -1 ) {%>checked<%}%>></TD>
         <td><%=submoudlename%></td>
         <td>
          <select name="checkmoudlecreater_<%=submoudleid%>">
           <%
                // ��ѯѡ�������п���ѡ���ֵ
                String[]  submoudlecreaters = Util.TokenizerString2(submoudlecreater, ",") ;
                for( int i=0 ; i< submoudlecreaters.length ; i++ ) {
                    String tempmoudlecreater = submoudlecreaters[i] ;
                    String tempmoudlecreatername =  Util.toScreen(ResourceComInfo.getResourcename(tempmoudlecreater),user.getLanguage()) ;
           %>
            <option value="<%=tempmoudlecreater%>" <% if(tempmoudlecreater.equals(selectmoudlecreater)) {%> selected <%}%>><%=tempmoudlecreatername%></option>
           <%
                }
           %>
            </select>
         </TD>
	  </TR>
<%  } %>
    </tbody> 
 </table>
<br>
<% } %>
</form>

<script language=javascript>

function doDraft(){
    <% if( isrootmoudle.equals("0") ) { %>
        if( check_form(document.frmMain,"inputsubject")) {
            document.frmMain.operation.value="editdraft";
            document.frmMain.submit();
        }
    <% } else {
            if( hasvalue ) {
    %>
            document.frmMain.operation.value="editdraft";
            document.frmMain.submit();
    <%
            } else { 
    %>
            document.frmMain.operation.value="adddraft";
            document.frmMain.submit();
    <%
            }
       }
    %>
}


function doSubmit(){
    <% if( isrootmoudle.equals("0") ) { %>
        if( check_form(document.frmMain,"inputsubject")) {
            document.frmMain.operation.value="editnew";
            document.frmMain.submit();
        }
    <% } else {
            if( hasvalue ) {
    %>
            document.frmMain.operation.value="editnew";
            document.frmMain.submit();
    <%
            } else { 
    %>
            document.frmMain.operation.value="addnew";
            document.frmMain.submit();
    <%
            }
       }
    %>
}
</script>
 
<script language=vbs>
 
sub onShowBrowser(id,url,linkurl,type1)
	if type1= 2 or type1 = 19 then
		id1 = window.showModalDialog(url,,"dialogHeight:320px;dialogwidth:275px")
		
		document.all("field_"+id+"span").innerHtml = id1
		document.all("field_"+id).value=id1
	else
		if type1 <> 17 and type1 <> 18 and type1<>27 and type1<>37 and type1<>4 and type1<>167 and type1<>164 and type1<>169 and type1<>170 then
			id1 = window.showModalDialog(url)
		elseif type1=4 or type1=167 or type1=164 or type1=169 or type1=170 then
            tmpids = document.all("field_"+id).value
			id1 = window.showModalDialog(url&"?selectedids="&tmpids)
		else
			tmpids = document.all("field_"+id).value
			id1 = window.showModalDialog(url&"?resourceids="&tmpids)
		end if
		if NOT isempty(id1) then
			if type1 = 17 or type1 = 18 or type1=27 or type1=37 then
				if id1(0)<> ""  and id1(0)<> "0"  then
					resourceids = id1(0)
					resourcename = id1(1)
					sHtml = ""
					resourceids = Mid(resourceids,2,len(resourceids))
					document.all("field_"+id).value= resourceids
					resourcename = Mid(resourcename,2,len(resourcename))
					while InStr(resourceids,",") <> 0
						curid = Mid(resourceids,1,InStr(resourceids,",")-1)
						curname = Mid(resourcename,1,InStr(resourcename,",")-1)
						resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
						resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
						sHtml = sHtml&"<a href="&linkurl&curid&">"&curname&"</a>&nbsp"
					wend
					sHtml = sHtml&"<a href="&linkurl&resourceids&">"&resourcename&"</a>&nbsp"
					document.all("field_"+id+"span").innerHtml = sHtml
					
				else
					document.all("field_"+id+"span").innerHtml = empty
					document.all("field_"+id).value=""
				end if
				
			else	
			   if  id1(0)<>""  and id1(0)<> "0"  then
			        if linkurl = "" then 
						document.all("field_"+id+"span").innerHtml = id1(1)
					else 
						document.all("field_"+id+"span").innerHtml = "<a href="&linkurl&id1(0)&">"&id1(1)&"</a>"
					end if
					document.all("field_"+id).value=id1(0)
				else
					document.all("field_"+id+"span").innerHtml = empty
					document.all("field_"+id).value=""
				end if
			end if
		end if
	end if
end sub

</script>
 
</BODY></HTML>
