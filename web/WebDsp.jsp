<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/web/inc/init1.jsp" %>
<%@ include file="/web/inc/WebServer.jsp" %>
<jsp:useBean id="DocNewsManager" class="weaver.docs.news.DocNewsManager" scope="page" />
<jsp:useBean id="DocNewsComInfo" class="weaver.docs.news.DocNewsComInfo" scope="page" />
<jsp:useBean id="DocManager" class="weaver.docs.docs.DocManager" scope="page" />
<jsp:useBean id="DocTypeComInfo" class="weaver.docs.type.DocTypeComInfo" scope="page" />
<jsp:useBean id="LanguageComInfo" class="weaver.systeminfo.language.LanguageComInfo" scope="page" />
<jsp:useBean id="SysDefaultsComInfo" class="weaver.docs.tools.SysDefaultsComInfo" scope="page" />
<jsp:useBean id="PicUploadManager" class="weaver.docs.tools.PicUploadManager" scope="page" />
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="DocImageManager" class="weaver.docs.docs.DocImageManager" scope="page" />
<jsp:useBean id="RecordSetImg" class="weaver.conn.RecordSet" scope="page"/>

<%
//��ȡ���������û�������
int id = Util.getIntValue(request.getParameter("id"),0);
int start= Util.getIntValue(request.getParameter("start"),1);
int hstart = Util.getIntValue(request.getParameter("hstart"),1);
int recordersize = 0;
int perpage=0;
String linkstr="";
String usertype = "" ;
String isTime=""+Util.getIntValue(request.getParameter("isTime"),0);
String isPageNo=""+Util.getIntValue(request.getParameter("isPageNo"),0);

String frontpagename = "" ;
String frontpagedesc = "" ;
String isactive = "" ;
int departmentid = 0 ;
String linktype = "" ;
String hasdocsubject = "" ;
String hasfrontpagelist = "" ;
int newsperpage = 0 ;
int titlesperpage = 0 ;
int defnewspicid = 0 ;
int backgroundpicid = 0 ;
int importdocid = 0 ;
int headerdocid = 0 ;
int footerdocid = 0 ;
String secopt = "" ;
int seclevelopt = 0;
int departmentopt = 0;
int dateopt = 0;
int languageopt = 0 ;
int languageid = 7 ;
String clauseopt = "" ;
String newsclause = "" ;
int defaultimgid= 0 ;
int defaultimgwidth=0;
int publishtype = 0;
//��ȡ����ҳ������Ϣ
if(id != 0) {
    DocNewsManager.resetParameter();
    DocNewsManager.setId(id);
    DocNewsManager.getDocNewsInfoById();
	publishtype = DocNewsManager.getPublishtype();
    frontpagename = DocNewsManager.getFrontpagename();
    frontpagedesc = DocNewsManager.getFrontpagedesc();
    isactive = DocNewsManager.getIsactive();
    departmentid = DocNewsManager.getDepartmentid();
    linktype = DocNewsManager.getLinktype();
    hasdocsubject = DocNewsManager.getHasdocsubject();
    hasfrontpagelist = DocNewsManager.getHasfrontpagelist();
    newsperpage = DocNewsManager.getNewsperpage();
    titlesperpage = DocNewsManager.getTitlesperpage();
    defnewspicid = DocNewsManager.getDefnewspicid();
    backgroundpicid = DocNewsManager.getBackgroundpicid();
    importdocid =  Util.getIntValue(DocNewsManager.getImportdocid());
    headerdocid = DocNewsManager.getHeaderdocid();
    footerdocid = DocNewsManager.getFooterdocid();
    secopt = DocNewsManager.getSecopt();
    seclevelopt = DocNewsManager.getSeclevelopt();
    departmentopt = DocNewsManager.getDepartmentopt();
    dateopt = DocNewsManager.getDateopt();
    languageopt = DocNewsManager.getLanguageopt();
    languageid = DocNewsManager.getLanguageid();
    clauseopt = Util.toScreenToEdit(DocNewsManager.getClauseopt(),languageid);
    newsclause = DocNewsManager.getNewsclause();

    DocNewsManager.closeStatement();
    perpage = newsperpage; 
}
//��ȡȱʡͼƬ��Ϣ
if(defnewspicid!=0){
    PicUploadManager.resetParameter();
    PicUploadManager.setId(defnewspicid);
    PicUploadManager.selectImageById();
    if(PicUploadManager.next()){
        defaultimgid = Util.getIntValue(PicUploadManager.getImagefileid());
        defaultimgwidth = PicUploadManager.getImagefilewidth();
    }
    int defwidth = Util.getIntValue(SysDefaultsComInfo.getFgpicwidth(),0);
    String deffix = Util.null2String(SysDefaultsComInfo.getFgpicfixtype());

    if(deffix.equals("2"))
        defaultimgwidth = defwidth;
    if(deffix.equals("3"))
        if(defaultimgwidth<defwidth)
            defaultimgwidth=defwidth;
    if(deffix.equals("4"))
        if(defaultimgwidth>defwidth)
            defaultimgwidth=defwidth;
    else if(defwidth != 0) 
        defaultimgwidth = defwidth;

    PicUploadManager.closeStatement();	
}
String remindMsg = "" ;

String bgcolor = Util.null2String(request.getParameter("bgcolor"));
if (bgcolor.equals("")) bgcolor = "#FFFFFF" ;
%>
<HTML><HEAD>
<script language="JavaScript">
function click() {
if (event.button==2) {return false //alert('��Ϣ�鿴') 
}
}
document.onmousedown=click

//-->
</script>
<META http-equiv=Content-Type content="text/html; charset=gbk">
<LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
</head>
<BODY bgcolor="<%=bgcolor%>">
<FORM id=form1 name=form1  method="post"  action="/web/WebDsp.jsp?id=<%=id%>">
  <TABLE class=form valign=top>
    <TBODY> 
    <tr> 
    <tr> 
	<!--�Ƿ�������ҳ�汳��ͼƬ:begin-->
    <%
    if(backgroundpicid!=0){    
    	String imgid="";
    	int imgwidth=0;
    	PicUploadManager.resetParameter();
	    PicUploadManager.setId(backgroundpicid);
	    PicUploadManager.selectImageById();
	    if(PicUploadManager.next()){
            imgid = PicUploadManager.getImagefileid();
            imgwidth = PicUploadManager.getImagefilewidth();
	    }
	    PicUploadManager.closeStatement();
    %>
      <td background = "/weaver/weaver.file.FileDownload?fileid=<%=imgid%>">
    <%}else{%>
	  <td>
    <%}%>
	<!--�Ƿ�������ҳ�汳��ͼƬ:end-->

        <table width="100%" border="0" cellspacing="0" cellpadding="0" valign=top>
          <tr>
            <td width="100%" valign=top> 
				  <!--����������ʾ:begin-->
				  <table class=form valign=top>
					<tr> 
						  <!--�������������Զ���ȡ������������ʾ:begin-->
						  <%
							boolean isDark = false ;
							int needtr = 0;
							int currec = 0;
							String whereOrAnd = "" ;
							//if (publishtype ==0 ) whereOrAnd =" where " ; //0Ϊ��������Ϊ�ⲿ�Ĳ���Ҫ�ж�Ȩ��
							whereOrAnd =" and " ;
							String newslistclause=newsclause.trim();					
							if(!newslistclause.equals(""))  newslistclause = whereOrAnd + newslistclause ;
							newslistclause = newslistclause + " and docpublishtype='2' and docstatus in('1','2') order by doclastmoddate desc, doclastmodtime desc";
							if (publishtype ==0 )//0Ϊ��������Ϊ�ⲿ�Ĳ���Ҫ�ж�Ȩ��
							{
								DocManager.setSql_where(newslistclause);
								DocManager.selectDocInfo();
							}
							else 
							{
								if (userid==0) 
								{
									DocManager.closeStatement();
									response.sendRedirect("/web/login/noLogin.jsp");
									return;
								}

								DocManager.selectNewsDocInfo(newslistclause,user);
							}

							if (DocManager.getCount()==0) 
								{
								if (language==7)	remindMsg = "����ĿĿǰ��û���κ����ϣ�" ;
								if (language==8)	remindMsg = "Sorry,there is not any message for the page!" ;
								}

							while(DocManager.next()){
								int docid = DocManager.getDocid();
								if(docid == importdocid) continue;
								recordersize += 1;
								currec +=1;
								if(currec < start) continue;
								if(currec >= start + perpage) continue;
								needtr =2;		//needtr +=1;
								
								String docsubject=DocManager.getDocsubject();
								String doccontent=DocManager.getDoccontent();
								String doclastmoddate=DocManager.getDoclastmoddate();
								RecordSetImg.executeSql("select imagefileid from DocImageFile where docid = " + docid + " and docfiletype = '1' ");
								int curimgid = 0 ;
								if (RecordSetImg.next())
								curimgid = Util.getIntValue(RecordSetImg.getString("imagefileid"),0);
						%>

						<td width="100%" class="p9grey" valign="top">
							<table width="90%" border="0" cellspacing="0" cellpadding="0">
							  <tr> 
								 <td width="17%" valign="top">

								 <%
								 int curpos = doccontent.indexOf("/weaver/weaver.file.FileDownload?fileid=");
								 if(curpos!=-1){
									curpos =  doccontent.indexOf("?fileid=",curpos);
									int endpos = doccontent.indexOf("\"",curpos);
									String tmppicid = doccontent.substring(curpos+8,endpos);
								%>
									<a href="<%=webServer%>/web/WebDetailDsp.jsp?id=<%=docid%>&languageid=<%=languageid%>&isTime=<%=isTime%>" target="_top"> 
									<img border=0 width="35" src="/weaver/weaver.file.FileDownload?fileid=<%=tmppicid%>"> 
									</a> 
								<% }else if(defaultimgid!=0){ %>
									<a href="<%=webServer%>/web/WebDetailDsp.jsp?id=<%=docid%>&languageid=<%=languageid%>&isTime=<%=isTime%>" target="_blank"> 
									<img border=0 width="35" src="/weaver/weaver.file.FileDownload?fileid=<%=defaultimgid%>"> 
									</a> 
								<%}%>

								 </td>
								 <td width="83%" class="p91" valign="top">
								 <strong>
								 <a href="<%=webServer%>/web/WebDetailDsp.jsp?id=<%=docid%>&languageid=<%=languageid%>&isTime=<%=isTime%>" target="_blank">
								 <%=docsubject%>
								 </a>
								 </strong>
								 <br>
								 <%
								 String disptmp = "";
								 int tmppos = doccontent.indexOf("!@#$%^&*");
								 if(tmppos!=-1)	disptmp = doccontent.substring(0,tmppos);
								 %>
								 <%if(isTime.equals("1")){%>[<%=doclastmoddate%>]&nbsp;<%}%>
								 <%=disptmp%>&nbsp&nbsp
								 <%if(curimgid>0){%>[ͼ��]&nbsp;&nbsp;<%}%>
								 <a href="<%=webServer%>/web/WebDetailDsp.jsp?id=<%=docid%>&languageid=<%=languageid%>&isTime=<%=isTime%>" target="_top"><%=SystemEnv.getHtmlLabelName(361,languageid)%>>></a> 
								 
								 <br><br> 
								 </td>
							 </tr>
						  </table>
					   </td>
					   <%
						  if(needtr ==1){
					   %>
					   <td width="1" background="/web/images/bg_votline.gif">
					   <img src="/web/images/spacer.gif">
					   </td>
					   <%}%>						 
						<%
						  if(needtr ==2){
							needtr=0;
							isDark = !isDark ;
						%>
							</tr>
							<tr> 
							<td height="1" colspan="3" background="/web/images/bg_hdotline.gif" class="p9grey"><img src="/web/images/spacer.gif" width="1" height="1"></td>
							</tr>
							<%if(isDark) {%>
								<tr bgcolor="F7F6ED"> 
							<%} else {%>
								<tr bgcolor="FFFFFF"> 
							<%}%>	
						<%}%>

						<%
							}
							DocManager.closeStatement();
						%>
						  <!--�������������Զ���ȡ������������ʾ:end-->
						<%if(needtr!=0){ //����������еĲ������µĿ���%> 
							<td width="50%">					    
							</td>
						</tr>
						<tr> 
							<td height="1" colspan="3" background="/web/images/bg_hdotline.gif" class="p9grey"><img src="/web/images/spacer.gif" width="1" height="1"></td>
						</tr>
						<%}%>
					</tr>

				<%if (!remindMsg.equals("")) {%>
					 <tr>
					 <td width=100% height=100% align=center valign=middle style="color:red"> 
					 <%=remindMsg%>
					 </td>
					 </tr>
				 <%}%>

				  </table>
				  <!--����������ʾ:end-->
            </td>
          </tr>
          
          </tr>
		  <tr><td>&nbsp</td><td></td></tr>
		  <%if (!remindMsg.equals("")) {%>
          <tr>
			  <!--�������ŷ�ҳ����:begin-->
			  <td align=center  noWrap > 
					<%linkstr = "/web/WebDsp.jsp?id="+id+"&hstart="+hstart+"&isTime="+isTime;%>
					<%=Util.makeNavbar4(start, recordersize , perpage, linkstr)%> 
			  </td>
			  <!--�������ŷ�ҳ����:end-->			 
          </tr>
		 <%}%>
        </table>
      </td>
    </tbody> 
  </table>

<!--ҳ������:begin-->
  <TABLE class=form valign=top>
    <TBODY> 
              <%
                if(footerdocid!=0){
                    DocManager.resetParameter();
                    DocManager.setId(footerdocid);
                    DocManager.getDocInfoById();
                    String footerdoccontent=DocManager.getDoccontent();
                    DocManager.closeStatement();
              %>
            <tr>
				<td clospan=2> <%=footerdoccontent%> </td>
            </tr>
            <%}%>
    </tbody> 
  </table>
<!--ҳ������:end-->

</FORM>
</body>