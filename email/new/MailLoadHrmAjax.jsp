<%@page import="weaver.hrm.company.DepartmentComInfo"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/page/maint/common/initNoCache.jsp" %>
<%@page import="weaver.email.WeavermailComInfo"%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="hrm" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<%
		String type=Util.null2String(request.getParameter("type"));
		WeavermailComInfo wmc = new WeavermailComInfo();
		Object obj=session.getAttribute("WeavermailComInfo");
		if(null!=obj){
			wmc=(WeavermailComInfo)obj;
		}
		//[1--��ʾ�����ˣ�2--��ʾ�����ˣ�3--������]
		String all=wmc.getToall();
		String dpids=wmc.getTodpids();
		String ids=wmc.getToids();
		String showname = "";
		if("2".equals(type)){
			 all=wmc.getCcall();
			 dpids=wmc.getCcdpids();
			 ids=wmc.getCcids();
		}else if("3".equals(type)){
			 all=wmc.getBccall();
			 dpids=wmc.getBccdpids();
			 ids=wmc.getBccids();
			 //1340
		}
		if("1".equals(all)){
			showname+="������";
		}else{
				DepartmentComInfo departmentComInfo=new DepartmentComInfo();
				String dep_ids[] = Util.TokenizerString2(dpids, ",");
		        for(int i=0;i<dep_ids.length;i++){
		        	String hrmid = Util.null2String(dep_ids[i]);
		        	if(!hrmid.equals("")){
		        		showname+="<a onclick=\"openShowNameHref('&internaltodpids="+hrmid+"&isInternal=1',this,1)\" style='cursor: pointer;'>"+departmentComInfo.getDepartmentname(hrmid)+"</a>&nbsp;";
		        	}
		        }	
		       	String hrmids[] = Util.TokenizerString2(ids, ",");
		        for(int i=0;i<hrmids.length;i++){
		        	String hrmid = Util.null2String(hrmids[i]);
		        	if(!hrmid.equals("")){
		        		showname+="<a onclick='openShowNameHref(\"&internalto="+hrmid+"&isInternal=1\",this)' style='cursor: pointer;'>"+hrm.getResourcename(hrmid)+"</a>&nbsp";
		        		showname+="<a class='ico_profileTips' href='javaScript:openhrm("+hrmid+");' onclick='pointerXY(event);'>&nbsp;&nbsp;&nbsp;&nbsp;</a>&nbsp";
		        	}
		        }       
		}
        out.clear();
        out.println(showname);
%>
