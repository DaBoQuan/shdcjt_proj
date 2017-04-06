<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="java.util.Properties"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.io.LineNumberReader"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.FileOutputStream"%>
<%@ page import="java.io.BufferedInputStream"%>
<%@ page import="java.io.BufferedOutputStream"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.lang.management.ManagementFactory"%>
<%@ page import="java.lang.management.MemoryPoolMXBean"%>
<%@ page import="java.lang.management.MemoryUsage"%>
<%@ page import="java.lang.management.RuntimeMXBean"%>
<%@ page import="com.sun.tools.attach.VirtualMachine"%>

<%@ page import="java.lang.reflect.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.regex.*"%>
<%@ page import="com.caucho.util.LruCache"%>
<%@ page import="com.caucho.vfs.Path"%>

<%
	response.setHeader("cache-control", "no-cache");
	response.setHeader("pragma", "no-cache");
	response.setHeader("expires", "Mon 1 Jan 1990 00:00:00 GMT");
%>

<%@ include file="init.jsp" %>

<%
try{
	boolean isUse = false;
	Class debugAgent = null;
    if (!isInitDebug()) {
        
        loadAgent();
        debugAgent = Class.forName("com.weaver.onlinedebug.DebugAgent");
        
        long maxPermGenSize = 0;
        Long maxPermGenSizeObj = (Long) debugAgent.getDeclaredMethod("getMaxPermSize", new Class[] {}).invoke(null, new Object[] {});
        if(maxPermGenSizeObj != null){
            maxPermGenSize = maxPermGenSizeObj.longValue();
        }
        
        if(maxPermGenSize < 192 *1024 * 1024){
            out.append("java �������� -XX:MaxPermSize="+(int)(maxPermGenSize/1024/1024)+"m ���õ�̫С�����Ի���ɲ��ȶ�����ʹ�� -XX:MaxPermSize=256m  ���ߴ���256m ���������");
            return;
        }
        
        String jspRoot = getServletContext().getRealPath("/");
        
        String loader = debugAgent.getClassLoader().getClass().getName();
        if(loader.indexOf("SystemClassLoader") != -1){
            out.print("��һ����resin3�Ͻ��е��ԣ��������һ�������ſ��Ե��ԣ�������resin����");
            return;
        }
        // System.out.println("~~~debugAgent="+debugAgent.getClassLoader());
        Method method = debugAgent.getDeclaredMethod("initDebug", new Class[] { String.class });
        method.invoke(null, new Object[]{jspRoot});
    }
    debugAgent = Class.forName("com.weaver.onlinedebug.DebugAgent");
    Class dataClass = Class.forName("com.weaver.onlinedebug.data.DebugData");
    
    Object debugData = session.getAttribute(debugDataKey);
    if(debugData == null){
        debugData = dataClass.newInstance();
        session.setAttribute(debugDataKey, debugData);
    }
    
    String trackType = ""+dataClass.getDeclaredMethod("getTrackType",(Class[])null).invoke(debugData, new Object[]{});
    String isTrackSeq = ""+dataClass.getDeclaredMethod("isTrackSeq",(Class[])null).invoke(debugData, new Object[]{});
    
    String action = request.getParameter("action");
    String message = "";
    
    Integer seq = (Integer)session.getAttribute(debugCurrentSeqKey);
	if(seq == null){
		seq = (Integer)debugAgent.getDeclaredMethod("getManualSeq", new Class[] {}).invoke(null, new Object[] {});
		session.setAttribute(debugCurrentSeqKey, seq);
	}
    if ("start".equals(action)) {
        
        String currentUser = (String)user.getClass().getDeclaredMethod("getLoginid",(Class[])null).invoke(user, new Object[]{});

        String cu = (String) debugAgent.getDeclaredMethod("startDebug", new Class[] { dataClass, String.class, int.class}).invoke(null, new Object[]{ debugData, currentUser, seq});

        if (!"".equals(cu)) {
        	isUse = true;
            message = "��ǰϵͳ���ڱ�"+cu+"���ԣ�����ֹͣ";
        } else {
        	isUse = true;
            message = "�����ɹ����������Ҫ���ԵĲ�����Ȼ���ֹͣ,���ɵ�������";
        }

    } else if ("stop".equals(action)) {

        boolean success = ((Boolean) debugAgent.getDeclaredMethod("stopDebug", null).invoke(null, new Object[]{})).booleanValue();
		
		isUse = false;
		
        if (success) {
            message = "�����ص�������";
        } else {
            message = "��������δ�����ɵ�������";
        }
    }

%>
<HTML>
 <HEAD>
  <TITLE> Զ�̵���</TITLE>
  <META NAME="Generator" CONTENT="EditPlus">
  <META NAME="Author" CONTENT="">
  <META NAME="Keywords" CONTENT="">
  <META NAME="Description" CONTENT="">
  <meta http-equiv=Content-Type content="text/html; charset=utf8">
<link type='text/css' rel='stylesheet'  href='css/main.css'/>
<script type="text/javascript" src="javascripts/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="javascripts/main.js"></script>
<script type="text/javascript">

	var debugCurrentClass = '<%=debugCurrentClass%>';
	var debugCurrentLine = '<%=debugCurrentLine%>';

	function setCurrent(className, line){
		debugCurrentClass = className;
		debugCurrentLine = line;
		var box = document.getElementById('vardataedit');
		box.src = 'debugAction.jsp?action=setcurrent&classname='+className+'&line='+line;
	}

	/**
	ɾ���ϵ�
	*/
	function deleteCurrent(){
		var box = document.getElementById('vardatalist');
		box.src = 'debugAction.jsp?action=deletecurrent&classname='+debugCurrentClass+'&line='+debugCurrentLine;
			
	}

	function deleteAll(){
		var box = document.getElementById('vardatalist');
		box.src = 'debugAction.jsp?action=deleteall';
			
	}
</script>
<style type="text/css">
<!--
body{
    overflow:hidden;
}
-->
</style>
 </HEAD>

 <BODY>
	<!--������-->
	<div id="content">
		<table border="0" width="100%" cellspacing="0" cellpadding="0">
			<tr>
				<td class="contentHead">&nbsp;</td>
				<td class="contentCenter"></td>
				<td class="contentBottom"></td>
			</tr>
			<tr>
				<td class="cLeft">&nbsp;</td>
				<td class="cCenter">
					<!--����������-->
					<div id="top">
						<table border="0" width="100%" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<div class="btnStart">
										<% if (!isUse) { %>
											<input type="hidden" name="flag" id="flag" value="0"/>
											<table border="0" width="100%" cellspacing="0" cellpadding="0">
												<tr>
													<td><div><img src="images/start.png"  style="margin-top:5px;margin-left:15px"  id="sos"></img></div></td>
													<td><div id="sosTxt" onclick="startOrStop(this);" class="debug">��ʼ����</div></td>
												</tr>
											</table>
										<% }else{ %>
											<input type="hidden" name="flag" id="flag" value="1"/>
											<table border="0" width="100%" cellspacing="0" cellpadding="0">
												<tr>
													<td><div style="float:left;"><img src="images/stop.png"  style="margin-top:5px;margin-left:15px"  id="sos"></img></div></td>
													<td><div id="sosTxt" onclick="startOrStop(this);" class="debug">ֹͣ����</div></td>
												</tr>
											</table>
										<%} %>
									</div>
								</td>
								<td>
									<div class="btnPoint">
										<form id='statusForm' action='debugAction.jsp' target='emptyiframe'>
											<div style="margin-top:5px;">
												<span style="margin-left:3px;cursor:pointer;padding-right:30px;" onclick="setTrackType1(this);">
													<%if("1".equals(trackType) || trackType==null){ %>
														<img src="images/radio_true.png" class="imgTxt"/>&nbsp;ֻ���ٶϵ���
													<%}else{%>
														<img src="images/radio_false.png"class="imgTxt"/>&nbsp;ֻ���ٶϵ���
													<%}%>
												</span>
												<span style="cursor:pointer;padding-right:30px;" onclick="setTrackType2(this);">
													<%if("2".equals(trackType) || trackType==null){ %>
														<img src="images/radio_true.png"class="imgTxt"/>&nbsp;����������
													<%}else{%>
														<img src="images/radio_false.png"class="imgTxt"/>&nbsp;����������
													<%}%>
												</span>
												<span style="cursor:pointer;" onclick="setTrackSeq(this);">
													<%if("true".equals(isTrackSeq) || isTrackSeq==null){ %>
														<img src="images/checkbox_true.png"class="imgTxt"/>&nbsp;����ִ�й���
													<%}else{%>
														<img src="images/checkbox_false.png"class="imgTxt"/>&nbsp;����ִ�й���
													<%}%>
												</span>
											</div>
											<input type="hidden" name="tracktype" value="<%= "2".equals(trackType)?"all":"var"%>" id="tracktype"/>
											<span id="trackseqspan">
												<% if("true".equals(isTrackSeq)){ %>
													<input type='hidden' name='trackseq' id="trackseq" value="trackseq" />
												<% } %>
											</span>
											<input type='hidden' name='action' value='updatestatus' style='display:none'>
										  </form>
										  <iframe name='emptyiframe' style='display:none'></iframe>
									</div>
								</td>
								<td>
									<div>
										<table border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td class="downloadLeft"></td>
												<td class="downloadCenter">
													<table border="0" cellspacing="0" cellpadding="0">
														<tr>
															<td><div  style="cursor:pointer;margin-top:5px;padding-right:5px;display:inline;" onclick="javascript:window.location='log.txt'">������־�ļ�	</div></td>
															<td><span><img src="images/btn_center_line.png" width="2px;"></span></td>
															<td><div style="cursor:pointer;margin-top:5px;padding-left:5px;display:inline;" onclick="javascript:window.location='tracklog/manual/<%=seq%>.zip'" >���ظ����ļ�</div></td>
														</tr>
													</table>
												</td>
												<td class="downloadRight"></td>
											</tr>
										</table>
									</div>
								</td>
								<td>
										  <form id='uploadForm' action='upload.jsp' action='upload.jsp' method='post' enctype='multipart/form-data' style="margin-top:10px;">
											<div>
											<table border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td class="uploadL"></td>
													<td class="uploadC">
														<input type="file" name="file"/>
													</td>
													<td class="uploadR"></td>
												</tr>
											</table>
											</div>
											</form>
									
								</td>
								<td>
									<div class="btnUpload" align="center">
										<div onclick="$('#uploadForm').submit();" class="btnImp">�ϴ������ļ�</div>
									</div>
								</td>
							</tr>								
							</table>
					</div>
					<div style="margin-top:10px;">
						<!--������Ϣ�����-->
						<div id="left">
							<table border="0" style="width:100%;height:100%" cellspacing="0" cellpadding="0">
								<tr>
									<td class="debugTL" height="15px"></td>
									<td class="debugTC" height="15px"></td>
									<td class="debugTR" height="15px"></td>
								</tr>
								<tr>
									<td class="debugCL"></td>
									<td class="debugCC" id="outputTD">
										<iframe frameborder="no" marginheight="0" marginwidth="0" border="0" src="viewLog.jsp" style="width:100%;height:100%">
										</iframe>
									</td>
									<td class="debugCR"></td>
								</tr>
								<tr>
									<td class="debugFL" height="15px"></td>
									<td class="debugFC" height="15px"></td>
									<td class="debugFR" height="15px"></td>
								</tr>
							</table>
							<div style="margin-top:10px;"><%= message %></div>
						</div>
						<!--����������-->
						<div id="right">
							<table  border="0" style="width:100%;height:100%" cellspacing="0" cellpadding="0">
								<tr>
									<td class="pointTL"></td>
									<td class="pointTC" height="15px"></td>
									<td class="pointTR" height="15px"></td>
								</tr>
								<tr>
									<td class="pointCL"></td>
									<td class="pointCC">
										<!--�ϵ�����-->
										<div id="classLine">
										<form action='debugAction.jsp?action=addvardata' target='vardatalist' id="addvardataForm">
											<input type="hidden" value="addvardata" name="action"/>
											<div>
												<span>�ࣺ</span>
												<span>
													<input type="text" name="classname" style="width:80%;padding-right:10px;"/>
												</span>
											</div>
											<div>
												<table  border="0" style="width:100%;" cellspacing="0" cellpadding="0">
													<tr>
														<td width="60%">
															<div style="margin-top:10px;">
																<span>�У�</span>
																<span>
																	<input type="text" name="line" style="width:80%;padding-right:10px;"/>
																</span>
															</div>
														</td>
														<td>
															
																<div style="margin-top:10px;width:100%;margin-left:10px">
																	<table border="0" cellspacing="0" cellpadding="0">
																		<tr>
																			<td class="pointList"></td>
																			<td height="27px;" class="pointOper">
																				<table border="0" cellspacing="0" cellpadding="0">
																					<tr>
																						<td><div style="cursor:pointer" onclick="$('#addvardataForm').submit();">��Ӷϵ�</div></td>
																					</tr>
																				</table>
																			</td>
																			<td class="btnCR"></td>
																		</tr>
																	</table>
																</div>
															
														</td>
													</tr>
												</table>
											</div>
											</form>
											<div style="margin-top:10px;">
												<table border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td><span>�ϵ��б�</span></td>
														<td class="pointList"></td>
														<td height="27px;" class="pointOper">
															<table border="0" cellspacing="0" cellpadding="0">
																<tr>
																	<td><div  style="cursor:pointer;margin-top:5px;padding-right:5px;display:inline;" onclick="deleteCurrent();">ɾ��</div></td>
																	<td><span><img src="images/btn_center_line.png" width="2px;"></span></td>
																	<td><div style="cursor:pointer;margin-top:5px;padding-left:5px;display:inline;" onclick="deleteAll();" >ɾ������</div></td>
																</tr>
															</table>
														</td>
														<td class="btnCR"></td>
													</tr>
												</table>
											</div>
										</div>										
										<!--�ϵ��б���-->
										<div id="breakpoint" style="margin-top:10px;background-color:#fff">
											<iframe frameborder="no" marginheight="0" marginwidth="0" border="0" src="varDataList.jsp" name="vardatalist" id="vardatalist" style="width:100%"></iframe>
										</div>
										<!--�ϵ���ϸ��Ϣ-->
										<div id="bpLabel" style="margin-top:10px;">�ϵ���ϸ��Ϣ��</div>
										<div id="bpDetail" style="margin-top:10px;background-color:#fff">
											<iframe frameborder="no" marginheight="0" marginwidth="0" border="0" src="varDataEdit.jsp" id="vardataedit" name="vardataedit" style="width:100%"></iframe>
										</div>
									</td>
									<td class="pointCR"></td>
								</tr>
								<tr>
									<td class="pointFL" height="15px"></td>
									<td class="pointFC" height="15px"></td>
									<td class="pointFR" height="15px"></td>
								</tr>
							</table>
						</div>
						<div style="clear:both"></div>
					</div>
				</td>
				<td class="cRight"></td>
			</tr>
			<tr>
				<td class="bodyFL">&nbsp;</td>
				<td class="bodyFC"></td>
				<td class="bodyFR"></td>
			</tr>
		</table>
	</div>
 </BODY>
</HTML>
<%
}catch(Exception e){
    e.printStackTrace();
}
%>
<%!
 private void loadAgent(){
     String workRoot = "";
     String resinHome = "";
     try {
        try {
            Class csClass = Thread.currentThread().getContextClassLoader().loadClass("com.caucho.util.CauchoSystem");
            Path workPath = (Path) csClass.getDeclaredMethod("getWorkPath", new Class[] {}).invoke(null, new Object[] {});
            Path resinPath = (Path) csClass.getDeclaredMethod("getResinHome", new Class[] {}).invoke(null, new Object[] {});

            workRoot = workPath.getNativePath().replace('\\', '/');
            resinHome = resinPath.getNativePath().replace('\\', '/');

        } catch (ClassNotFoundException e) {
            Class csClass = Thread.currentThread().getContextClassLoader().loadClass("com.caucho.server.util.CauchoSystem");
            Path workPath = (Path) csClass.getDeclaredMethod("getWorkPath", new Class[] {}).invoke(null, new Object[] {});
            Path resinPath = (Path) csClass.getDeclaredMethod("getResinHome", new Class[] {}).invoke(null, new Object[] {});

            workRoot = workPath.getNativePath().replace('\\', '/');
            resinHome = resinPath.getNativePath().replace('\\', '/');
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    String agentPath = resinHome + "/lib/onlinedebug.jar";
    System.out.println("~~~~~~~" + agentPath);
    
    String pid = null;
    RuntimeMXBean runtime = ManagementFactory.getRuntimeMXBean();
    String name = runtime.getName();
    pid = name.substring(0, name.indexOf("@"));
    try {
        VirtualMachine vm = VirtualMachine.attach(pid);
        vm.loadAgent(agentPath);
    } catch ( Exception e) {
        e.printStackTrace();
    } 
 }
 
%>
