<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="weaver.cowork.*" %> 
<%@ page import="java.io.*" %>
<%@ page import="weaver.file.FileUpload" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<%
	int userid=user.getUID();//�û�id
	FileUpload fu = new FileUpload(request);
	String from = Util.null2String(fu.getParameter("from"));
	int labelid =Util.getIntValue(fu.getParameter("labelid"),0);
	String type = Util.null2String(fu.getParameter("type"));
	type=type.equals("")?"createLabel":"editLabel";
	String name="";
	String isUsed="";
	String labelOrder="";
	String labelColor="#8CC76D";
	String textColor="#ffffff";
	
	if(labelid!=0){
	  String sql="select name,isUsed,labelOrder,labelColor,textColor from cowork_label where id="+labelid;
	  RecordSet.execute(sql);
	  if(RecordSet.next()){
	     name=RecordSet.getString("name");
	     isUsed=RecordSet.getString("isUsed");
	     labelOrder=RecordSet.getString("labelOrder");
	     labelColor=RecordSet.getString("labelColor");
	     textColor=RecordSet.getString("textColor");
	  }
	}
%>
<html>
<head>
<title></title>
<LINK href="/css/Weaver.css" type='text/css' rel='STYLESHEET'>
<link href="/js/jquery/ui/jquery-ui.css" type="text/css" rel=stylesheet>
<script type="text/javascript" src="/js/jquery/ui/ui.core.js"></script>
<script type="text/javascript" src="/js/jquery/ui/ui.dialog.js"></script>
    
</head>
<body id="ViewCoWorkBody" style="overflow: auto;">
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
    RCMenu += "{"+SystemEnv.getHtmlLabelName(86,user.getLanguage())+",javascript:doSave(),_self} ";
    RCMenuHeight += RCMenuHeightStep ;
    RCMenu += "{"+SystemEnv.getHtmlLabelName(1290,user.getLanguage())+",/cowork/labelSetting.jsp,_self} ";
    RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>

<style>
  #coloPanel .ListStyle tr{height:24px !important;}
  #coloPanel .ListStyle td{padding-left:2px !important;
                padding-right:2px !important;
                padding-top:0px !important;
                padding-bottom:0px !important;
  }
  #colorPicker td{width:20px !important;text-align:center;cursor:pointer}
</style>
<div id="coloPanel" title="<%=SystemEnv.getHtmlLabelName(22975,user.getLanguage())%>">
	<div id="colorPicker">
	    <table cellpadding="0" cellspacing="5" align="center">
	       <tr>
	          <td style="background-color: #dee5f2; color: #5a6986;" colorValue="#dee5f2" textColor="#5a6986" onclick="chooseColor(this)">a</td>
	          <td style="background-color: #e0ecff; color: #206cff;" colorValue="#e0ecff" textColor="#206cff" onclick="chooseColor(this)">a</td>
	          <td style="background-color: #dfe2ff; color: #0000cc;" colorValue="#dfe2ff" textColor="#0000cc" onclick="chooseColor(this)">a</td>
	          <td style="background-color: #e0d5f9; color: #5229a3;" colorValue="#e0d5f9" textColor="#5229a3" onclick="chooseColor(this)">a</td>
	          <td style="background-color: #fde9f4; color: #854f61;" colorValue="#fde9f4" textColor="#854f61" onclick="chooseColor(this)">a</td>
	          <td style="background-color: #ffe3e3; color: #cc0000;" colorValue="#ffe3e3" textColor="#cc0000" onclick="chooseColor(this)">a</td>
	       </tr>
	       <tr>
	          <td style="background-color: #5a6986; color: #dee5f2;" colorValue="#5a6986" textColor="#dee5f2" onclick="chooseColor(this)">a</td>
	          <td style="background-color: #206cff; color: #e0ecff;" colorValue="#206cff" textColor="#e0ecff" onclick="chooseColor(this)">a</td>
	          <td style="background-color: #0000cc; color: #dfe2ff;" colorValue="#0000cc" textColor="#dfe2ff" onclick="chooseColor(this)">a</td>
	          <td style="background-color: #5229a3; color: #e0d5f9;" colorValue="#5229a3" textColor="#e0d5f9" onclick="chooseColor(this)">a</td>
	          <td style="background-color: #854f61; color: #fde9f4;" colorValue="#854f61" textColor="#fde9f4" onclick="chooseColor(this)">a</td>
	          <td style="background-color: #cc0000; color: #ffe3e3;" colorValue="#cc0000" textColor="#ffe3e3" onclick="chooseColor(this)">a</td>
	       </tr>
	       <tr>
	          <td style="background-color: #fff0e1; color: #ec7000;" colorValue="#fff0e1" textColor="#ec7000" onclick="chooseColor(this)">a</td>
	          <td style="background-color: #fadcb3; color: #b36d00;" colorValue="#fadcb3" textColor="#b36d00" onclick="chooseColor(this)">a</td>
	          <td style="background-color: #f3e7b3; color: #ab8b00;" colorValue="#f3e7b3" textColor="#ab8b00" onclick="chooseColor(this)">a</td>
	          <td style="background-color: #ffffd4; color: #636330;" colorValue="#ffffd4" textColor="#636330" onclick="chooseColor(this)">a</td>
	          <td style="background-color: #f9ffef; color: #64992c;" colorValue="#f9ffef" textColor="#64992c" onclick="chooseColor(this)">a</td>
	          <td style="background-color: #f1f5ec; color: #006633;" colorValue="#f1f5ec" textColor="#006633" onclick="chooseColor(this)">a</td>
	       </tr>
	       <tr>
	          <td style="background-color: #ec7000; color: #fff0e1;" colorValue="#ec7000" textColor="#fff0e1" onclick="chooseColor(this)">a</td>
	          <td style="background-color: #b36d00; color: #fadcb3;" colorValue="#b36d00" textColor="#fadcb3" onclick="chooseColor(this)">a</td>
	          <td style="background-color: #ab8b00; color: #f3e7b3;" colorValue="#ab8b00" textColor="#f3e7b3" onclick="chooseColor(this)">a</td>
	          <td style="background-color: #636330; color: #ffffd4;" colorValue="#636330" textColor="#ffffd4" onclick="chooseColor(this)">a</td>
	          <td style="background-color: #64992c; color: #f9ffef;" colorValue="#64992c" textColor="#f9ffef" onclick="chooseColor(this)">a</td>
	          <td style="background-color: #006633; color: #f1f5ec;" colorValue="#006633" textColor="#f1f5ec" onclick="chooseColor(this)">a</td>
	       </tr>
	       
	    </table>
	</div>
	<div align="center"><input type="text" style="color: white;" id="txtColorTemp" size="20px"  /></div>
</div>

<form action="/cowork/CoworkItemMarkOperation.jsp"  id="labelForm" method="post">
<input type="hidden" name="type" value="<%=type%>"/>
<input type="hidden" name="id" value="<%=labelid%>"> 
<input type="hidden" name="labelType" value="label">
<input type="hidden" name="labelOrder" value="<%=labelOrder%>"> 
<table class=viewform >
  <COL width="30%">
  <COL width="70%">
  <TR>
    <TD height="20px" colspan=2></TD>
  </TR> 
  <tr>
      <td><%=SystemEnv.getHtmlLabelName(176,user.getLanguage())+SystemEnv.getHtmlLabelName(22009,user.getLanguage())%></td>
      <td class=Field><input type="text" style="width: 80%" onblur="changeLabelName(<%=labelid%>)"  maxlength="50" id="labelName" value="<%=name%>" name="name"/></td>
  </tr>
  <TR style="height: 1px;"><TD class=Line colspan=2></TD></TR> 
  <tr>
      <td><%=SystemEnv.getHtmlLabelName(18624,user.getLanguage())%></td>
      <td class=Field><input type="checkbox" name="isUsed_<%=labelid%>" <%if(isUsed.equals("1")){%>checked="checked"<%}%> value="1" /></td>
  </tr>
  <TR style="height: 1px;"><TD class=Line colspan=2></TD></TR>
  <tr>
      <td><%=SystemEnv.getHtmlLabelName(176,user.getLanguage())+SystemEnv.getHtmlLabelName(495,user.getLanguage())%></td>
      <td class=Field>
         <input type="hidden" value="<%=labelColor%>" name="labelColor" id="labelColor_<%=labelid%>">
         <input type="hidden" value="<%=textColor%>" name="textColor" id="textColor_<%=labelid%>">
		  <SPAN style="BACKGROUND-COLOR: <%=labelColor%>; COLOR: <%=textColor%>;padding:2px" id="<%=labelid%>" class=colorblock r_attr="background-color" r_id="menuhContainer" colorValue="<%=labelColor%>" textColor="<%=textColor%>"><%=name%></SPAN>
		  <img src='/js/jquery/plugins/farbtastic/color.png' style='cursor:hand;margin-left:3px' align="absmiddle"  onclick='doColorClick(this,<%=labelid%>)' border=0/>
      </td>
  </tr>
  <TR style="height: 1px;"><TD class=Line colspan=2></TD></TR>
</table>
</form>
<script type="text/javascript">

  function changeLabelName(labelid){
     var labelName=jQuery("#labelName").val();
     jQuery("#"+labelid).text(labelName);
  }

  function chooseColor(obj){
     
     var colorValue=jQuery(obj).attr("colorValue");
     var textColor=jQuery(obj).attr("textColor");
     
     jQuery("#txtColorTemp").attr("colorValue",colorValue);
     jQuery("#txtColorTemp").attr("textColor",textColor);
     jQuery("#txtColorTemp").css("background-color",colorValue);
     jQuery("#txtColorTemp").css("color",textColor);
  }

  function doSave(){
     var name=$("#labelName").val();
     if(name==""){
        alert("<%=SystemEnv.getHtmlLabelName(23073,user.getLanguage())+SystemEnv.getHtmlLabelName(176,user.getLanguage())+SystemEnv.getHtmlLabelName(22009,user.getLanguage())%>"); 
        return false;
     }
     if("<%=type%>"=="createLabel"||("<%=type%>"=="editLabel"&&"<%=name%>"!=$("#labelName").val())){
	     $.post("/cowork/CoworkItemMarkOperation.jsp?name="+name,{type:'isExist'},function(data){
	        if($.trim(data)=="true")
	           alert("<%=SystemEnv.getHtmlLabelName(176,user.getLanguage())+SystemEnv.getHtmlLabelName(22009,user.getLanguage())+SystemEnv.getHtmlLabelName(24943,user.getLanguage())%>");
	        else
	           $("#labelForm").submit();          
	     });
     }else
         $("#labelForm").submit();
  }

  $(document).ready(function(){
   
     if(jQuery(window.parent.document).find("#ifmCoworkItemContent")[0]!=undefined){
	     //�����������
	    jQuery(document.body).bind("mouseup",function(){
		   parent.jQuery("html").trigger("mouseup.jsp");	
	    });
	    jQuery(document.body).bind("click",function(){
			jQuery(parent.document.body).trigger("click");		
	    });
      }
	 $("#coloPanel").dialog({
				autoOpen: false,
				draggable:false,
				resizable:false,
				width:200,
				buttons: {
					"<%=SystemEnv.getHtmlLabelName(201,user.getLanguage())%>":function(){  // ȡ��
					    $(this).dialog("close");
					},
					"<%=SystemEnv.getHtmlLabelName(826,user.getLanguage())%>": function() { //ȷ��
						var colorValue=$("#txtColorTemp").attr("colorValue");
						var textColor=$("#txtColorTemp").attr("textColor");
						var objFormId=$("#txtColorTemp").attr("from");	
						
						$("#labelColor_"+objFormId).val(colorValue);	
						$("#textColor_"+objFormId).val(textColor);
						
						$("#"+objFormId).css("background-color",colorValue);
						$("#"+objFormId).css("color",textColor);
						
                        $("#"+objFormId).attr("colorValue",colorValue); 
                        $("#"+objFormId).attr("textColor",textColor); 
                        
						$(this).dialog("close"); 
					}
				} 
	  });	
  });

  //�����ɫ������
	function doColorClick(obj,labelid){
	    var colorSpan=jQuery("#"+labelid);
	    
	    var labelName=colorSpan.text()!=""?colorSpan.text():$("#labelName").val();
	    if(labelName==""){
	         alert("<%=SystemEnv.getHtmlLabelName(23073,user.getLanguage())+SystemEnv.getHtmlLabelName(176,user.getLanguage())+SystemEnv.getHtmlLabelName(22009,user.getLanguage())%>");
             return false;
        }else
             colorSpan.text(labelName);
	    
		$("#txtColorTemp").val(colorSpan.text());
		$("#txtColorTemp").css("background-color",colorSpan.attr("colorValue"));
		$("#txtColorTemp").css("color",colorSpan.attr("textColor"));
		$("#txtColorTemp").attr("from",colorSpan.attr("id")); 

		$("#coloPanel").dialog('open');	
		var offset = $(obj).offset();
		

		var coloPanelWidth=$("#coloPanel")[0].parentNode.offsetWidth;
		var coloPanelHeight=$("#coloPanel")[0].parentNode.offsetHeight;


		var rightedge=document.body.clientWidth-event.clientX
		var bottomedge=document.body.clientHeight-event.clientY
		
		if (rightedge<coloPanelWidth)
			$("#coloPanel")[0].parentNode.style.left=document.body.scrollLeft+event.clientX-$("#coloPanel")[0].parentNode.offsetWidth-10
		else
			$("#coloPanel")[0].parentNode.style.left=document.body.scrollLeft+event.clientX+10
			
		
		if (bottomedge<coloPanelHeight)
			$("#coloPanel")[0].parentNode.style.top=document.body.scrollTop+event.clientY-$("#coloPanel")[0].parentNode.offsetHeight
		else
			$("#coloPanel")[0].parentNode.style.top=document.body.scrollTop+event.clientY
	}
</script>
</body>
</html>
