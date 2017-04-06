<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">

 <%@ include file="/systeminfo/init.jsp" %>
 <%@page import="weaver.general.WeatherData"%>
<%@page import="java.util.List"%>
<%@page import="weaver.general.WeatherObj"%>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
 <%
%>



<%@page import="java.util.ArrayList"%>
<%@page import="weaver.general.Util"%><html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GBK">
		<title>�ҵ�����</title>
		<script language="javascript" type="text/javascript" src="lunar.js"></script>
		<script language="javascript" type="text/javascript" src="index.js"></script>
		<style>
			*{
				border:0;
				padding:0;
				font-family: "����",Helvetica, sans-serif  !important;
				
			}
			body{
				background: transparent;
			}
			a{
				text-decoration: none; 
			}
			#fd{display:none;position:absolute;border:1px solid #dddddf;background:#feffcd;padding:10px;line-height:21px;width:150px}
			#fd b{font-weight:normal;color:#c60a00}
			
			.ldays {
				z-index:1000;
				border-collapse:collapse; /* �ؼ����ԣ��ϲ��������߿�(��ʵ���߿���2px������1px�����滹��1pxŶ) */
				border:solid #bbb; /* ���ñ߿����ԣ���ʽ(solid=ʵ��)����ɫ(#999=��) */
				border-width:1px 0 0 1px; /* ���ñ߿�״��ϸ���� �� �� �� = ��Ӧ��1px 0 0 1px */
				TABLE-LAYOUT:fixed;word-break:break-all;
			}
			
			.ldays caption {font-size:14px;font-weight:bolder;}
			.ldays th,.ldays  td {border:solid #bbb;border-width:0 1px 1px 0;padding:0;}
			.ldays td span{display:block;padding-left:4px;font-size:12px;color:#c2c2c2;}
			.ldays tfoot td {text-align:center;}
			.ldays .th {background:url(table-head.gif) repeat-x;height:25px !important;text-align:center;}
			
			#cm .dayEn{font-size:18px !important;font-weight:bold;text-align:right;padding-right:4px;color:#444;}
			.ldays a{display:block;margin:0;padding:0;text-decoration:none;color:rgb(0,102,204) !important;border:2px solid #fff;}
			
			.ldays a:hover{border:2px solid red;}
			.ldays .fred{color:#23479a;}
			
			.ldays .active{clear:all;color:#fff  !important;background:#ffaaaa;border-color:#ffaaaa; }
			.ldays .active .dayEn{
				color:#fff  !important;
			}
			.ldays .active span{
				color:#fff  !important;
			}
			
			select{width:80px;height:20px;border-color:#cfdbe3 }
			input{border-color:#cfdbe3;}
			#header{color:white;height:37px;border:1px solid #cfdbe3;border-left: 0;border-right: 0;  }
			#header .header_in{height: 35px;border:1px solid #f9fbfc;background:#e9eff3;border-left: 0;border-right: 0;}
			#top_date{padding:7px 0 0 12px;float:left;width:200px;}
			#title{float:left;width:134px;}
			#top_toolbar{float:left;width:250px;padding-top:7px;}
			#top_toolbar .btnDate_noClick{background:url(btn.png) no-repeat;height:23px;cursor:pointer;}
			#top_toolbar .btnYearSub{width:48px;}
			#top_toolbar .btnMonthSub{width:48px;background-position:-48px 0px;}
			#top_toolbar .btnMonthAdd{width:48px;background-position:-96px 0px;}
			#top_toolbar .btnYearAdd{width:48px;background-position:-144px 0px;}
			#top_toolbar .btnToday{width:26px;background-position:-192px 0px;}
			
			
			#content{width:600px;}
			#content .calendar_main{padding:10px 8px 0 10px;}
			#content .calendar_table{width:400px;float:left;height:300px;}
			#content .ltop{
				height:34px;border:1px solid #cfdbe3; border-bottom:0;
			}
			
			#content .ltop_in{
				height:33px;background:#e9eff3 ;border:1px solid white;border-bottom: 0;border-left: 0;border-right: 0;
			}
		</style>
	</head>
	<body  onload="init()">

					<div style="width:600px">
						<div id="header" >
							<div class="header_in">
								<div id="top_date" class="top_date">
									<span> 
										<select></select>
										<select></select>
									</span>
								</div>
								<div  id="title">&nbsp;</div>
								<div  id="top_toolbar">
									<input type="button"  class="btnDate_noClick  btnYearSub " onmouseover="">
									<input type="button"  class="btnDate_noClick btnMonthSub">
									<input type="button"  class="btnDate_noClick btnMonthAdd">
									<input type="button"  class="btnDate_noClick btnYearAdd">
									<input type="button"  class="btnDate_noClick btnToday">
								</div>
							</div>
						</div>
						<div id="content" >
							<div class="calendar_main">
								<div class="calendar_table">
									<div class="calendar_table2">
										<div class="ltop" id="c_top" >
								        	<div class="ltop_in">
									        	<div style="float:left;width:160px;line-height:33px;color:#8ba4b4;padding-left:10px;" class="top_time">
													<font color="#036ebe" face="Verdana" id="nowTime">2000��0��0��&nbsp;00:00:00</font>
												</div>
												<div style="float:right;line-height:33px;display:none;color:#8ba4b4;">
													<font  size="2" id="ganzhi"></font>
												</div>
												<div id="lunar_info" style="float:right;padding-right:10px;line-height: 33px;color:#8ba4b4;"></div>
											</div>
										</div>
										
										<table  width="400px" height="256px" cellpadding=0 cellspacing=0  id="cm" class="ldays">
			        					</table>
										<div id="bm"></div>
									</div> 
								</div>
								<div style="float:left;width:164px;margin-left:10px;height:294px;background: url(wea.png) no-repeat;color: white;">
									<div style="height:220px;">
										<div style="height:36px;padding-left:10px;">
											<div style="line-height: 36px;" id="cityArea">
												<div style="width:120px;float:left;">
													<span id="city" ></span>
												</div>
												<div style="width:30px;float:left;">
													<a href="javascript:void(0)" onclick="citySetting()"><%=SystemEnv.getHtmlLabelName(22250,user.getLanguage()) %></a>
												</div>
											</div>
											<div style="padding:0;display:none;line-height: 36px;" id="citySettingArea">
												<input type="text" id="t_cityName" name="cityName" style="margin:0;width:100px;" onkeyup="this.value=this.value.replace(/[^a-z_-]/g,'')"/> <input type="button" value="<%=SystemEnv.getHtmlLabelName(86,user.getLanguage()) %>" onclick="javascript:saveCity()" style="height:20px;width:40px">
											</div>
										</div>
										<div style="height:96px;background-repeat: no-repeat;padding-left:10px;" id="conditionArea" >
											<img alt="" id="conditionImg" src="/calendar/icon/qing.png" height="96px">
											<div style="text-align:right;padding-right:10px; position: relative;margin-top: -96px;" id="w_condition"></div>
										</div>
										<div style="padding: 10px 0 0 10px;">
											<span style="display:block; line-height: 20px;"><%=SystemEnv.getHtmlLabelName(5001,user.getLanguage()) %>��<span id="w_low"></span>��~<span id="w_high"></span>��</span>
											<span style="display:table;line-height: 20px;TABLE-LAYOUT:fixed;word-break:break-all;" id="w_windCondition"></span>
											<span style="display:block;line-height: 20px;" id="w_humidity"></span>
										</div>
									</div>
									<div style="padding:4px;" id="w_forecast">
									</div>
								</div>
							</div>
						
							<div style="clear:both;height:36px;line-height:36px;border-top:1px solid #cfdbe3;border-bottom:1px solid #cfdbe3;">
								<div style="height:34px;border-top:1px solid #fff;border-bottom:1px solid #fff;background:#e9eff3;padding:0 10px 0 10px;">
									<div style="float:left;width:290px;">
										<%=SystemEnv.getHtmlLabelName(26282,user.getLanguage()) %>��
										<select onchange="changeWorldClock()" id="worldTime" style="width:220px;"> 
										  <option value="-12" selected="selected">���ʻ�����</option>
										  <option value="-11">��Ħ��</option>
										  <option value="-10">������</option>
										  <option value="-9">����˹��</option>
										  <option value="-8">̫ƽ��</option>
										  <option value="-7">����ɽ��</option>
										  <option value="-7">����ɽ��</option>
										  <option value="-6">���ô��в�</option>
										  <option value="-6">ī����</option>
										  <option value="-6">�����в�</option>
										  <option value="-5">������̫ƽ��</option>
										  <option value="-5">���Ӷ���</option>
										  <option value="-5">����</option>
										  <option value="-4">����������</option>
										  <option value="-4">������</option>
										  <option value="-3.3">Ŧ����</option>
										  <option value="-3">��������</option>
										  <option value="-3">�����޶���</option>
										  <option value="-2">�������в�</option>
										  <option value="-1">���ٶ�</option>
										  <option value="0">Ӣ������</option>
										  <option value="0">�������α�׼</option>
										  <option value="1">����</option>
										  <option value="1">��ŷ</option>
										  <option value="1">��ŷ</option>
										  <option value="2">��ɫ��</option>
										  <option value="2">��ŷ</option>
										  <option value="2">����</option>
										  <option value="2">GFT</option>
										  <option value="2">�Ϸ�</option>
										  <option value="3">ɳ�ڵذ�����</option>
										  <option value="3">����˹</option>
										  <option value="3.3">����</option>
										  <option value="4">������</option>
										  <option value="4.3">������</option>
										  <option value="5">����</option>
										  <option value="5.3">ӡ��</option>
										  <option value="6">����</option>
										  <option value="7">����</option>
										  <option value="8" selected="selected">�й�</option>
										  <option value="9">����</option>
										  <option value="9.3">�����в�</option>
										  <option value="10">ϯ����</option>
										  <option value="10">��˹÷����</option>
										  <option value="10">��̫ƽ��</option>
										  <option value="11">̫ƽ���в�</option>
										  <option value="12">Ŧ����</option>
										  <option value="12">쳼�</option>
										</select>
										</div>
										<div id="worldTimeNow" style="float:right;color:#137fb8;font-weight: bold;"></div>
									</div>
							</div>
							<div style="padding:0px 0px 10px 10px;overflow:auto;height:88px;overflow: hidden;display:none;">
								<div style="display:none;">
					        		<span  id="lm_txt"></span><br>
					            	<span style="font-size:14px;" id="date"></span>
					                <div id="lunar_info"></div>
					                <span>�������˹�����</span>
								</div>	
								
							</div>
						</div>
						
					</div>
	
		<script type="text/javascript">if(typeof(setClock)!="undefined"){setClock();}</script>
		<script id=calendar type=text/javascript src="calendar.js"></script>
	</body>
</html>

<script  type="text/javascript">
var request;
function createRequest() {
  try {
    request = new XMLHttpRequest();
  } catch (trymicrosoft) {
    try {
      request = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (othermicrosoft) {
      try {
        request = new ActiveXObject("Microsoft.XMLHTTP");
      } catch (failed) {
        request = false;
      }
    }
  }
  if (!request)
    alert("Error initializing XMLHttpRequest!");
  else{
  	return request;
  }
}
createRequest();
window.onload=loadXml;

function loadXml(){
	var request=createRequest();
	var url="weatherXML.jsp?t="+new Date().getTime();
	request.open("GET", url, true);
     request.onreadystatechange = updatePage;
     request.send(null);
}
function updatePage(){
	if(request.readyState==4){
		var jsonStr=eval('('+request.responseText+')');
		$("conditionImg").setAttribute("src",jsonStr.icon);
		$("city").innerText=decodeURI(jsonStr.city);
		$("w_condition").innerText=decodeURI(jsonStr.condition);
		$("w_low").innerText=decodeURI(jsonStr.low);
		$("w_high").innerText=decodeURI(jsonStr.high);
		$("w_windCondition").innerText=decodeURI(jsonStr.wind);
		$("w_humidity").innerText=decodeURI(jsonStr.humidity);
		var w_forecast="";
		for(var i in jsonStr.forecast  ){
			
			w_forecast+="<div style='padding:1px;float:left;width:50px;height:60px;color:black;color:#137fb8;text-align:center;'><span style=��display:block;text-align:center;'>"+decodeURI(jsonStr.forecast[i].date)+"</span><img width='50px'  alt=\"\" src=\""
						+jsonStr.forecast[i].icon+
						"\"><span style='display:block;text-align:center;font-size:12px;position:relative;margin-top:-18px;background:black;filter:alpha(opacity=30);opacity:30;color:#fff !important;'>"+
						jsonStr.forecast[i].low+"~"+jsonStr.forecast[i].high+
					"��</span></div>";
		}
		$("w_forecast").innerHTML =w_forecast.replace("+", "&nbsp;");
	}
}
function saveCity(){
	$("citySettingArea").style.display="none";
	$("city").innerText=$("t_cityName").value;
	$("cityArea").style.display="block";
	var request=createRequest();
	var url2="weatherOpration.jsp?cityName="+encodeURI(encodeURI($("t_cityName").value))+"&t="+new Date().getTime();
	request.open("GET", url2, true);
    request.onreadystatechange = saveCityOn;
    request.send(null);
	
}

function saveCityOn(){
	if(request.readyState==4){
		loadXml();
	}
}
function citySetting(){
	$("citySettingArea").style.display="block";
	$("t_cityName").value=$("city").innerText;
	$("cityArea").style.display="none";
}

</script>