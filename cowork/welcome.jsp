<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%
int language=user.getLanguage();
String from = Util.null2String(request.getParameter("from"));
String title="";
 if(language==7)
	title="��ӭ����Эͬ������";
 else if(language==8)
	title="Welcome to Co-Work Zone";
 else if(language==9)
	title="�gӭ�M��ϵ�y�����^";
%>
<HTML>
 <HEAD>
 <title><%=title%></title>
 <style>
  body{
  	background:url('/cowork/images/welcomebg.png') no-repeat; 
  }
 </style>
 <script type="text/javascript" src="/js/jquery/jquery.js"></script>
 <link href="/css/Weaver.css" type="text/css" rel=stylesheet>
  <script type="text/javascript">
  jQuery(document).ready(function(){
  //�����������
  if($(window.parent.document).find("#ifmCoworkItemContent")[0]!=undefined){
	    jQuery(document.body).bind("mouseup",function(){
		   parent.jQuery("html").trigger("mouseup.jsp");	
	    });
	    jQuery(document.body).bind("click",function(){
			jQuery(parent.document.body).trigger("click");		
	    });
    }
  });
  
  //�½�Э��
function addCowork(){
	if("<%=from%>"=="cowork")
       $(window.parent.document).find("#ifmCoworkItemContent").attr("src","/cowork/AddCoWork.jsp?from=<%=from%>");
	else
       window.location.href="/cowork/AddCoWork.jsp?from=<%=from%>";
   
}

  //��ת����ѯЭ��
function toSearch(){
	if("<%=from%>"=="cowork")
		$(window.parent.document).find("#ifmCoworkItemContent").attr("src","/cowork/SearchCowork.jsp?from=<%=from%>");
	else
        window.location.href="/cowork/SearchCowork.jsp?from=<%=from%>";
    
}
  
 </script>
 </HEAD>
 <%
 String needfresh =request.getParameter("needfresh");//ˢ������б���� 1 ˢ��
  //�Ƿ���Ҫˢ��Э���б�
  if("1".equals(needfresh)){
 %>
	<script language=javascript>
	if($(window.parent.document).find("#ifmCoworkItemContent")[0]!=undefined)
	   window.parent.reloadItemListContent();
	</script>
 <%}%>

 <BODY> 
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
    RCMenu += "{"+SystemEnv.getHtmlLabelName(82,user.getLanguage())+",javascript:addCowork(),_self} ";
    RCMenuHeight += RCMenuHeightStep ;
	if(from.equals("cowork")){
		RCMenu += "{"+SystemEnv.getHtmlLabelName(527,user.getLanguage())+",javascript:toSearch(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
	}
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<!--  
    <%if(language==7){ %>
    <div style="margin-top: 40px;margin-left: 60px;width: 400px">
         <span style="font-size: 22px;color:#4f8cc5;font-weight:900;">��ӭ����Эͬ������</span>
         <div style="border-top:#4f8cc5 solid 1px;width:300px;"> 
           <div style="color: #5b97cf;margin-left: 40px;font-size: 12px;font-weight: bold" align="right">Welcome to Co-Work Zone</div>
         </div>
         <div style="margin-top: 20px">
	         <span style="color: #009A07;font-size: 12px;margin-right: 20px"><img src="/cowork/images/point.gif" align="absmiddle"> Эͬ</span>
	         <span style="color: #009A07;font-size: 12px;margin-right: 20px"><img src="/cowork/images/point.gif" align="absmiddle"> �粿��</span>
	         <span style="color: #009A07;font-size: 12px;margin-right: 20px"><img src="/cowork/images/point.gif" align="absmiddle"> ������</span>
	         <span style="color: #009A07;font-size: 12px;margin-right: 20px"><img src="/cowork/images/point.gif" align="absmiddle"> ��Ч����</span>
         </div>
         <div style="margin-top: 20px">
             ע��������Э����(Co-Work Zone)���п粿�š�������Эͬ������<br><br>
             ����Э������������������Զ��壬������Ҫ����Э�����������<br><br>
             ����ϵͳ����Ա��ϵ��
         </div>
      </div>
    <%}else if(language==8){%>
        <div style="margin-top: 40px;margin-left: 60px;">
         <span style="font-size: 22px;color: #003279;font-weight:900;">Welcome to Co-Work Zone</span>
         <div style="border-top:#003279 solid 1px;width:330px;">
           <div style="color: #00B4FF;margin-left: 40px;font-size: 12px;font-weight: bold" align="right">Welcome to Co-Work Zone</div>
         </div>
         <div style="margin-top: 20px">
	         <span style="color: #009A07;font-size: 12px;margin-right: 20px"><img src="/cowork/images/point.gif" align="absmiddle"> Coordination </span>
	         <span style="color: #009A07;font-size: 12px;margin-right: 20px"><img src="/cowork/images/point.gif" align="absmiddle"> Trans-departmental </span>
	         <span style="color: #009A07;font-size: 12px;margin-right: 20px"><img src="/cowork/images/point.gif" align="absmiddle"> Multi-items </span>
	         <span style="color: #009A07;font-size: 12px;margin-right: 20px"><img src="/cowork/images/point.gif" align="absmiddle"> Highly effective operation</span>
         </div>
         <div style="margin-top: 20px;width: 650px">
             Note: You may (Co-Work Zone) carry on trans-departmental, the multi-duty coordination operation in the cooperation area .<br><br>
             All cooperation area's subject item may from the definition, if you need to increase the cooperation area subject item ,<br><br>
             Please relate with the system manager .
         </div>
      </div>
    <%}else if(language==9){%>
            <div style="margin-top: 40px;margin-left: 60px;width: 400px">
         <span style="font-size: 22px;color: #003279;font-weight:900;">�gӭ�M��ϵ�y�����^</span>
         <div style="border-top:#003279 solid 1px;width:300px;">
           <div style="color: #00B4FF;margin-left: 40px;font-size: 12px;font-weight: bold" align="right">Welcome to Co-Work Zone</div>
         </div>
         <div style="margin-top: 20px">
	         <span style="color: #009A07;font-size: 12px;margin-right: 20px"><img src="/cowork/images/point.gif" align="absmiddle"> �fͬ</span>
	         <span style="color: #009A07;font-size: 12px;margin-right: 20px"><img src="/cowork/images/point.gif" align="absmiddle"> �粿�T</span>
	         <span style="color: #009A07;font-size: 12px;margin-right: 20px"><img src="/cowork/images/point.gif" align="absmiddle"> �����</span>
	         <span style="color: #009A07;font-size: 12px;margin-right: 20px"><img src="/cowork/images/point.gif" align="absmiddle"> ��Ч�\��</span>
         </div>
         <div style="margin-top: 20px">
             ע�������څf���^(Co-Work Zone)�M�п粿�T�����΄Յfͬ�\����<br><br>
             ���Ѕf���^�����}��헶������Զ��x��������Ҫ���Ӆf���^���}���<br><br>
             Ո�c����T�M�� 
          </div>
      </div>
    <%} %>
    -->
 </BODY>
</HTML>
