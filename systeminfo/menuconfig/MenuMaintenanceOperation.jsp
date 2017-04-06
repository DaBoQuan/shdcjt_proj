<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.systeminfo.menuconfig.MenuUtil" %>
<%@ page import="weaver.systeminfo.menuconfig.MenuMaint" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="weaver.file.FileUpload" %>

<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<%
	//if(!HrmUserVarify.checkUserRight("HeadMenu:Maint", user)&&!HrmUserVarify.checkUserRight("SubMenu:Maint", user)){
	//    response.sendRedirect("/notice/noright.jsp");
	//    return;
	//}
	 
	
	FileUpload fu = new FileUpload(request,false,"images/menu/others");
	String method = Util.null2String(fu.getParameter("method"));	
	String resourceId = Util.null2String(fu.getParameter("resourceId"));	
	String resourceType = Util.null2String(fu.getParameter("resourceType"));	
	String infoId = Util.null2String(fu.getParameter("infoId"));	
	String isCustom = Util.null2String(fu.getParameter("isCustom"));	
	int sync = Util.getIntValue(fu.getParameter("chkSynch"),0);
	

	String type = Util.null2String(fu.getParameter("type"));	

	//System.out.println("sync:"+sync);

	int userid = user.getUID();
	MenuUtil mu=new MenuUtil(type,Util.getIntValue(resourceType),Util.getIntValue(resourceId),user.getLanguage());
	MenuMaint  mm=new MenuMaint(type,Util.getIntValue(resourceType),Util.getIntValue(resourceId),user.getLanguage());
	//System.out.println("method"+method);
	
	if(method.equalsIgnoreCase("maintenance")){		
		mm.maintance(request);
		response.sendRedirect("MenuMaintenanceList.jsp?isCustom="+isCustom+"&type="+type+"&resourceType="+resourceType+"&resourceId="+resourceId);
	} else if (method.equalsIgnoreCase("synchall")){
		//�õ����в˵��б�
		ArrayList infoList=mu.getAllMenuList(0,"visible");
		if(sync==1)	mm.synchSubMenuConfig(infoList);
		response.sendRedirect("MenuMaintenanceList.jsp?isCustom="+isCustom+"&type="+type+"&resourceType="+resourceType+"&resourceId="+resourceId);
	}else if(method.equalsIgnoreCase("delthisall")){		
		mm.delMenu(Util.getIntValue(infoId),1);			
	} else if(method.equalsIgnoreCase("del")){		
		mm.delMenu(Util.getIntValue(infoId),0);			
	} else 	if(method.equalsIgnoreCase("add")){	

		String targetBase = Util.null2String(fu.getParameter("targetframe"));	
		int parentId = Util.getIntValue(fu.getParameter("parentId"),0);	
		String customMenuName = Util.null2String(fu.getParameter("customMenuName"));	
		String customMenuLink = Util.null2String(fu.getParameter("customMenuLink"));	
		String customName_e = Util.null2String(fu.getParameter("customName_e"));	
		String customName_t = Util.null2String(fu.getParameter("customName_t"));	
		
		
		int customMenuViewIndex=mu.getMaxCustomViewIndex(parentId);
		
		String iconUrl="";
		String tempIconUrl = Util.null2String(fu.uploadFiles("customIconUrl"));
		String topIconUrl = Util.null2String(fu.uploadFiles("topIconUrl"));
		if(tempIconUrl.equals(""))     iconUrl= "/images_face/ecologyFace_2/LeftMenuIcon/level3.gif";
		else iconUrl=mu.getRealAddr(tempIconUrl);
		
		if(topIconUrl.equals(""))     
			topIconUrl= "";
		else 
			topIconUrl=mu.getRealAddr(topIconUrl);

		int menuLevel = 1;
		if(parentId!=0) menuLevel = 2;
		//����ϵͳά���˵�
		int currInfoId = mm.addMenu(customMenuName,customMenuLink,customMenuViewIndex,menuLevel,""+parentId,iconUrl,topIconUrl,targetBase,customName_e,customName_t);
		//ͬ��Config
		mm.addMenuConfig(currInfoId,customMenuViewIndex,0,0,0,customMenuName,customName_e,customName_t);			
		//ͬ���¼�
		if(sync==1) {					
			mm.synchSubMenuConfig(currInfoId);
		}
		
		out.println("<input type='hidden' value=\""+customMenuName+"\" id='sText'/>");	
		out.println("<input type='hidden' value=\""+iconUrl+"\" id='sIcon'/>");	
		out.println("<input type='hidden' value=\""+currInfoId+"\" id='curMenuid'/>");	
		out.println("<input type='hidden' value=\""+customMenuLink+"\" id='linkAddress'/>");	
		out.println("<input type='hidden' value=\""+customMenuViewIndex+"\" id='customMenuViewIndex'/>");

		out.println("<script language=javaScript>parent.addwin.hide()</script>");
	} else if(method.equalsIgnoreCase("edit")){
		String targetBase = Util.null2String(fu.getParameter("targetframe"));	
		String parentId = Util.null2String(fu.getParameter("parentId"));	
		String customMenuName = Util.null2String(fu.getParameter("customMenuName"));	
		String customMenuLink = Util.null2String(fu.getParameter("customMenuLink"));	
		String customName_e = Util.null2String(fu.getParameter("customName_e"));	
		String customName_t = Util.null2String(fu.getParameter("customName_t"));
		int customMenuViewIndex=mu.getMaxCustomViewIndex(Util.getIntValue(parentId));

	
		String iconUrl="";
		String tempIconUrl = Util.null2String(fu.uploadFiles("customIconUrl"));
		if(tempIconUrl.equals(""))     iconUrl= "";
		else iconUrl=mu.getRealAddr(tempIconUrl);
		
		String topIconUrl = Util.null2String(fu.uploadFiles("topIconUrl"));
		if(topIconUrl.equals(""))     
			topIconUrl= "";
		else 
			topIconUrl=mu.getRealAddr(topIconUrl);

		
		mm.editMenu(customMenuName,customMenuLink,customMenuViewIndex,Util.getIntValue(infoId),iconUrl,topIconUrl,targetBase,customName_e,customName_t);	

		//ͬ���¼�
		if(sync==1) {					
			mm.synchSubMenuConfig(Util.getIntValue(infoId));
		}

		out.println("<input type='hidden' value=\""+iconUrl+"\" id='iconUrl'/>");	
		out.println("<input type='hidden' value=\""+customMenuName+"\" id='sText'/>");	
		out.println("<script language=javaScript>parent.editwin.hide()</script>");
		
	} 	else if(method.equalsIgnoreCase("addadvanced")){

		int parentId = Util.getIntValue(fu.getParameter("parentId"),0);		
			
		String customMenuName = Util.null2String(fu.getParameter("customMenuName"));		
		String customName_e = Util.null2String(fu.getParameter("customName_e"));
		String customName_t = Util.null2String(fu.getParameter("customName_t"));
		int customMenuViewIndex=mu.getMaxCustomViewIndex(parentId);
		String iconUrl="";		
		String tempIconUrl = Util.null2String(fu.uploadFiles("customIconUrl"));
		if(tempIconUrl.equals(""))     iconUrl= "/images_face/ecologyFace_2/LeftMenuIcon/level3.gif";
		else iconUrl=mu.getRealAddr(tempIconUrl);
		
		String topIconUrl = Util.null2String(fu.uploadFiles("topIconUrl"));
		if(topIconUrl.equals(""))     
			topIconUrl= "";
		else 
			topIconUrl=mu.getRealAddr(topIconUrl);
		
		int menuLevel = 1;
		if(parentId!=0) menuLevel = 2;
		
		String customModule = Util.null2String(fu.getParameter("customModule"));//ģ��
		String customType = Util.null2String(fu.getParameter("customType_"+customModule));//�˵�����
		String displayUsage = "";//Ĭ����ʾ��ʽ
		String customMenuLink = "";//���ӵ�ַ
		String selectedContent="";
		
		//����ϵͳά���˵�
		int currInfoId = mm.addMenu(customMenuName,customMenuLink,customMenuViewIndex,menuLevel,""+parentId,iconUrl,topIconUrl,"",customName_e,customName_t);
		
		if("1".equals(customModule)){//�ĵ�
			if("1".equals(customType)){//�½��ĵ�
				//ȡ��ѡ���ĵ�Ŀ¼��
				for(Enumeration En=fu.getParameterNames();En.hasMoreElements();){
					String[] value=fu.getParameterValues((String) En.nextElement());
					for(int i=0;i<value.length;i++){
						value[i]=Util.null2String(value[i]);
						if(value[i].indexOf("docdir_ND_M")!=-1||value[i].indexOf("docdir_ND_S")!=-1){
							String addedStr = value[i].substring(10);
							if (selectedContent.equals("")){
								selectedContent+=addedStr;
							} else {
								selectedContent+="|"+addedStr;
							}
						}
					}
				}
				customMenuLink = "/docs/docs/DocList.jsp?fromadvancedmenu=1&infoId="+currInfoId;
			} else if("2".equals(customType)){//�ҵ��ĵ�
				displayUsage = Util.null2String(fu.getParameter("displayUsage_2"));
				//ȡ��ѡ���ĵ�Ŀ¼��
				for(Enumeration En=fu.getParameterNames();En.hasMoreElements();){
					String[] value=fu.getParameterValues((String) En.nextElement());
					for(int i=0;i<value.length;i++){
						value[i]=Util.null2String(value[i]);
						if(value[i].indexOf("docdir_MD_M")!=-1||value[i].indexOf("docdir_MD_S")!=-1){
							String addedStr = value[i].substring(10);
							if (selectedContent.equals("")){
								selectedContent+=addedStr;
							} else {
								selectedContent+="|"+addedStr;
							}
						}
					}
				}
				customMenuLink = "/docs/search/DocView.jsp?fromadvancedmenu=1&infoId="+currInfoId+"&displayUsage="+displayUsage;
			} else if("3".equals(customType)){//�����ĵ�
				displayUsage = Util.null2String(fu.getParameter("displayUsage_3"));
				//ȡ��ѡ���ĵ�Ŀ¼��
				for(Enumeration En=fu.getParameterNames();En.hasMoreElements();){
					String[] value=fu.getParameterValues((String) En.nextElement());
					for(int i=0;i<value.length;i++){
						value[i]=Util.null2String(value[i]);
						if(value[i].indexOf("docdir_NESTD_M")!=-1||value[i].indexOf("docdir_NESTD_S")!=-1){
							String addedStr = value[i].substring(13);
							if (selectedContent.equals("")){
								selectedContent+=addedStr;
							} else {
								selectedContent+="|"+addedStr;
							}
						}
					}
				}
				customMenuLink = "/docs/search/DocSearchTemp.jsp?fromadvancedmenu=1&infoId="+currInfoId+"&list=all&isNew=yes&loginType=1&containreply=1&displayUsage="+displayUsage;
			} else if("4".equals(customType)){//�ĵ�Ŀ¼
				displayUsage = Util.null2String(fu.getParameter("displayUsage_4"));
				//ȡ��ѡ���ĵ�Ŀ¼��
				for(Enumeration En=fu.getParameterNames();En.hasMoreElements();){
					String[] value=fu.getParameterValues((String) En.nextElement());
					for(int i=0;i<value.length;i++){
						value[i]=Util.null2String(value[i]);
						if(value[i].indexOf("docdir_DC_M")!=-1||value[i].indexOf("docdir_DC_S")!=-1){
							String addedStr = value[i].substring(10);
							if (selectedContent.equals("")){
								selectedContent+=addedStr;
							} else {
								selectedContent+="|"+addedStr;
							}
						}
					}
				}
				customMenuLink = "/docs/search/DocSummary.jsp?fromadvancedmenu=1&infoId="+currInfoId+"&displayUsage="+displayUsage;
			}
		}
		else if("2".equals(customModule)){//����
			if("1".equals(customType)){//�½�����
				//ȡ��ѡ��Ĺ�����
				for(Enumeration En=fu.getParameterNames();En.hasMoreElements();){
					String[] value=fu.getParameterValues((String) En.nextElement());
					for(int i=0;i<value.length;i++){
						value[i]=Util.null2String(value[i]);
						if(value[i].indexOf("workflow_NF_T")!=-1||value[i].indexOf("workflow_NF_W")!=-1||value[i].indexOf("workflow_NF_R")!=-1){
							String addedStr = value[i].substring(12);
							if (selectedContent.equals("")){
								selectedContent+=addedStr;
							} else {
								selectedContent+="|"+addedStr;
							}
						}
					}
				}
				customMenuLink = "/workflow/request/RequestType.jsp?fromadvancedmenu=1&infoId="+currInfoId;
			} else if("2".equals(customType)){//��������
				//ȡ��ѡ��Ĺ�����
				for(Enumeration En=fu.getParameterNames();En.hasMoreElements();){
					String[] value=fu.getParameterValues((String) En.nextElement());
					for(int i=0;i<value.length;i++){
						value[i]=Util.null2String(value[i]);
						if(value[i].indexOf("workflow_PM_T")!=-1||value[i].indexOf("workflow_PM_W")!=-1){
							String addedStr = value[i].substring(12);
							if (selectedContent.equals("")){
								selectedContent+=addedStr;
							} else {
								selectedContent+="|"+addedStr;
							}

							if(value[i].indexOf("workflow_PM_W")!=-1){
								int t_wfid = Util.getIntValue(addedStr.substring(1), 0);
								if(t_wfid != 0){
									String t_nodeids = fu.getParameter2("workflow_PM_v" + t_wfid);
									String s_nodeName = fu.getParameter("workflow_PM_n" + t_wfid);
									//System.out.println("t_nodeids = " + t_nodeids);
									if(!"0".equals(t_nodeids) && !"".equals(t_nodeids)){
										selectedContent+="|P"+addedStr+"N"+t_nodeids + "SP^AN" + s_nodeName;
									}
								}
							}

						}
					}
				}
				//System.out.println(selectedContent);
				customMenuLink = "/workflow/request/RequestView.jsp?fromadvancedmenu=1&infoId="+currInfoId;
			} else if("3".equals(customType)){//�Ѱ�����
				//ȡ��ѡ��Ĺ�����
				for(Enumeration En=fu.getParameterNames();En.hasMoreElements();){
					String[] value=fu.getParameterValues((String) En.nextElement());
					for(int i=0;i<value.length;i++){
						value[i]=Util.null2String(value[i]);
						if(value[i].indexOf("workflow_HM_T")!=-1||value[i].indexOf("workflow_HM_W")!=-1){
							String addedStr = value[i].substring(12);
							if (selectedContent.equals("")){
								selectedContent+=addedStr;
							} else {
								selectedContent+="|"+addedStr;
							}
						}
					}
				}
				customMenuLink = "/workflow/request/RequestHandled.jsp?fromadvancedmenu=1&infoId="+currInfoId;
			} else if("4".equals(customType)){//�������
				//ȡ��ѡ��Ĺ�����
				for(Enumeration En=fu.getParameterNames();En.hasMoreElements();){
					String[] value=fu.getParameterValues((String) En.nextElement());
					for(int i=0;i<value.length;i++){
						value[i]=Util.null2String(value[i]);
						if(value[i].indexOf("workflow_CM_T")!=-1||value[i].indexOf("workflow_CM_W")!=-1){
							String addedStr = value[i].substring(12);
							if (selectedContent.equals("")){
								selectedContent+=addedStr;
							} else {
								selectedContent+="|"+addedStr;
							}
						}
					}
				}
				customMenuLink = "/workflow/request/RequestComplete.jsp?fromadvancedmenu=1&infoId="+currInfoId;
			} else if("5".equals(customType)){//�ҵ�����
				//ȡ��ѡ��Ĺ�����
				for(Enumeration En=fu.getParameterNames();En.hasMoreElements();){
					String[] value=fu.getParameterValues((String) En.nextElement());
					for(int i=0;i<value.length;i++){
						value[i]=Util.null2String(value[i]);
						if(value[i].indexOf("workflow_MR_T")!=-1||value[i].indexOf("workflow_MR_W")!=-1){
							String addedStr = value[i].substring(12);
							if (selectedContent.equals("")){
								selectedContent+=addedStr;
							} else {
								selectedContent+="|"+addedStr;
							}
						}
					}
				}
				customMenuLink = "/workflow/request/MyRequestView.jsp?fromadvancedmenu=1&infoId="+currInfoId;
			} else if("6".equals(customType)){//��������
				//ȡ��ѡ��Ĺ�����
				for(Enumeration En=fu.getParameterNames();En.hasMoreElements();){
					String[] value=fu.getParameterValues((String) En.nextElement());
					for(int i=0;i<value.length;i++){
						value[i]=Util.null2String(value[i]);
						if(value[i].indexOf("workflow_RM_T")!=-1||value[i].indexOf("workflow_RM_W")!=-1){
							String addedStr = value[i].substring(12);
							if (selectedContent.equals("")){
								selectedContent+=addedStr;
							} else {
								selectedContent+="|"+addedStr;
							}
						}
					}
				}
				customMenuLink = "/workflow/search/WFSearchCustom.jsp?fromadvancedmenu=1&infoId="+currInfoId;
			} else if("7".equals(customType)){//��������
				//ȡ��ѡ��Ĺ�����
				for(Enumeration En=fu.getParameterNames();En.hasMoreElements();){
					String[] value=fu.getParameterValues((String) En.nextElement());
					for(int i=0;i<value.length;i++){
						value[i]=Util.null2String(value[i]);
						if(value[i].indexOf("workflow_SM_T")!=-1||value[i].indexOf("workflow_SM_W")!=-1){
							String addedStr = value[i].substring(12);
							if (selectedContent.equals("")){
								selectedContent+=addedStr;
							} else {
								selectedContent+="|"+addedStr;
							}
						}
					}
				}
				customMenuLink = "/workflow/search/WFSearchCustom.jsp?fromadvancedmenu=1&infoId="+currInfoId;
			} else if("8".equals(customType)){//��ʱ����
				//ȡ��ѡ��Ĺ�����
				for(Enumeration En=fu.getParameterNames();En.hasMoreElements();){
					String[] value=fu.getParameterValues((String) En.nextElement());
					for(int i=0;i<value.length;i++){
						value[i]=Util.null2String(value[i]);
						if(value[i].indexOf("workflow_OM_T")!=-1||value[i].indexOf("workflow_OM_W")!=-1){
							String addedStr = value[i].substring(12);
							if (selectedContent.equals("")){
								selectedContent+=addedStr;
							} else {
								selectedContent+="|"+addedStr;
							}
						}
					}
				}
				customMenuLink = "/workflow/search/WFSearchCustom.jsp?fromadvancedmenu=1&infoId="+currInfoId;
			} else if("9".equals(customType)){//��������
				//ȡ��ѡ��Ĺ�����
				for(Enumeration En=fu.getParameterNames();En.hasMoreElements();){
					String[] value=fu.getParameterValues((String) En.nextElement());
					for(int i=0;i<value.length;i++){
						value[i]=Util.null2String(value[i]);
						if(value[i].indexOf("workflow_FM_T")!=-1||value[i].indexOf("workflow_FM_W")!=-1){
							String addedStr = value[i].substring(12);
							if (selectedContent.equals("")){
								selectedContent+=addedStr;
							} else {
								selectedContent+="|"+addedStr;
							}
						}
					}
				}
				customMenuLink = "/workflow/search/WFSearchCustom.jsp?fromadvancedmenu=1&infoId="+currInfoId;
			}
		}
		else if("3".equals(customModule)){//�ͻ�
			if("1".equals(customType)){//�½��ͻ�
				customMenuLink = "/CRM/data/AddCustomerExist.jsp";
			}
		}
		else if("4".equals(customModule)){//��Ŀ
			if("1".equals(customType)){//�½���Ŀ
				//ȡ��ѡ�����Ŀ����
				for(Enumeration En=fu.getParameterNames();En.hasMoreElements();){
					String[] value=fu.getParameterValues((String) En.nextElement());
					for(int i=0;i<value.length;i++){
						value[i]=Util.null2String(value[i]);
						if(value[i].indexOf("project_P")!=-1){
							String addedStr = value[i].substring(8);
							if (selectedContent.equals("")){
								selectedContent+=addedStr;
							} else {
								selectedContent+="|"+addedStr;
							}
						}
					}
				}
				customMenuLink = "/proj/Templet/ProjTempletSele.jsp?fromadvancedmenu=1&infoId="+currInfoId;
			} else if("2".equals(customType)){//��Ŀִ��
				customMenuLink = "/proj/data/MyProject.jsp";
			} else if("3".equals(customType)){//������Ŀ
				customMenuLink = "/proj/data/ProjectApproval.jsp";
			} else if("4".equals(customType)){//��������
				customMenuLink = "/proj/process/ProjectTaskApproval.jsp";
			} else if("5".equals(customType)){//��ǰ����
				customMenuLink = "/proj/data/CurrentTask.jsp";
			} else if("6".equals(customType)){//��������
				customMenuLink = "/proj/data/OverdueTask.jsp";
			}
		}
		//���²˵��߼���Ϣ
		mm.updateMenuAdvancedInfo(currInfoId,customMenuLink,"1",customModule,customType,displayUsage,selectedContent);
		//ͬ��Config
		mm.addMenuConfig(currInfoId,customMenuViewIndex,0,0,0,customMenuName,customName_e,customName_t);	
		
		//ͬ���¼�
		if(sync==1) mm.synchSubMenuConfig(currInfoId);		

		out.println("<input type='hidden' value=\""+customMenuName+"\" id='sText'/>");	
		out.println("<input type='hidden' value=\""+iconUrl+"\" id='sIcon'/>");	
		out.println("<input type='hidden' value=\""+currInfoId+"\" id='curMenuid'/>");	
		out.println("<input type='hidden' value=\""+customMenuLink+"\" id='linkAddress'/>");	
		out.println("<input type='hidden' value=\""+customMenuViewIndex+"\" id='customMenuViewIndex'/>");

		out.println("<script language=javaScript>parent.addwin.hide()</script>");
	} else if(method.equalsIgnoreCase("editadvanced")){
		String parentId = Util.null2String(fu.getParameter("parentId"));
		String customMenuName = Util.null2String(fu.getParameter("customMenuName"));
		String customName_e = Util.null2String(fu.getParameter("customName_e"));
		String customName_t = Util.null2String(fu.getParameter("customName_t"));
		
		int customMenuViewIndex=mu.getMaxCustomViewIndex(Util.getIntValue(parentId));
		String iconUrl="";
		String tempIconUrl = Util.null2String(fu.uploadFiles("customIconUrl"));
		if(tempIconUrl.equals(""))     iconUrl= "";
		else iconUrl=mu.getRealAddr(tempIconUrl);
        
		String topIconUrl = Util.null2String(fu.uploadFiles("topIconUrl"));
		if(topIconUrl.equals(""))     
			topIconUrl= "";
		else 
			topIconUrl=mu.getRealAddr(topIconUrl);
		
		int menuLevel = 1;
		if(Util.getIntValue(parentId,0)!=0) menuLevel = 2;
		
		String customModule = Util.null2String(fu.getParameter("customModule"));//ģ��
		String customType = Util.null2String(fu.getParameter("customType_"+customModule));//�˵�����
		String displayUsage = "";//Ĭ����ʾ��ʽ
		String customMenuLink = "";//���ӵ�ַ
		String selectedContent="";
		
		if("1".equals(customModule)){//�ĵ�
			if("1".equals(customType)){//�½��ĵ�
				//ȡ��ѡ���ĵ�Ŀ¼��
				for(Enumeration En=fu.getParameterNames();En.hasMoreElements();){
					String[] value=fu.getParameterValues((String) En.nextElement());
					for(int i=0;i<value.length;i++){
						value[i]=Util.null2String(value[i]);
						if(value[i].indexOf("docdir_ND_M")!=-1||value[i].indexOf("docdir_ND_S")!=-1){
							String addedStr = value[i].substring(10);
							if (selectedContent.equals("")){
								selectedContent+=addedStr;
							} else {
								selectedContent+="|"+addedStr;
							}
						}
					}
				}
				customMenuLink = "/docs/docs/DocList.jsp?fromadvancedmenu=1&infoId="+infoId;
			} else if("2".equals(customType)){//�ҵ��ĵ�
				displayUsage = Util.null2String(fu.getParameter("displayUsage_2"));
				//ȡ��ѡ���ĵ�Ŀ¼��
				for(Enumeration En=fu.getParameterNames();En.hasMoreElements();){
					String[] value=fu.getParameterValues((String) En.nextElement());
					for(int i=0;i<value.length;i++){
						value[i]=Util.null2String(value[i]);
						if(value[i].indexOf("docdir_MD_M")!=-1||value[i].indexOf("docdir_MD_S")!=-1){
							String addedStr = value[i].substring(10);
							if (selectedContent.equals("")){
								selectedContent+=addedStr;
							} else {
								selectedContent+="|"+addedStr;
							}
						}
					}
				}
				customMenuLink = "/docs/search/DocView.jsp?fromadvancedmenu=1&infoId="+infoId+"&displayUsage="+displayUsage;
			} else if("3".equals(customType)){//�����ĵ�
				displayUsage = Util.null2String(fu.getParameter("displayUsage_3"));
				//ȡ��ѡ���ĵ�Ŀ¼��
				for(Enumeration En=fu.getParameterNames();En.hasMoreElements();){
					String[] value=fu.getParameterValues((String) En.nextElement());
					for(int i=0;i<value.length;i++){
						value[i]=Util.null2String(value[i]);
						if(value[i].indexOf("docdir_NESTD_M")!=-1||value[i].indexOf("docdir_NESTD_S")!=-1){
							String addedStr = value[i].substring(13);
							if (selectedContent.equals("")){
								selectedContent+=addedStr;
							} else {
								selectedContent+="|"+addedStr;
							}
						}
					}
				}
				customMenuLink = "/docs/search/DocSearchTemp.jsp?fromadvancedmenu=1&infoId="+infoId+"&list=all&isNew=yes&loginType=1&containreply=1&displayUsage="+displayUsage;
			} else if("4".equals(customType)){//�ĵ�Ŀ¼
				displayUsage = Util.null2String(fu.getParameter("displayUsage_4"));
				//ȡ��ѡ���ĵ�Ŀ¼��
				for(Enumeration En=fu.getParameterNames();En.hasMoreElements();){
					String[] value=fu.getParameterValues((String) En.nextElement());
					for(int i=0;i<value.length;i++){
						value[i]=Util.null2String(value[i]);
						if(value[i].indexOf("docdir_DC_M")!=-1||value[i].indexOf("docdir_DC_S")!=-1){
							String addedStr = value[i].substring(10);
							if (selectedContent.equals("")){
								selectedContent+=addedStr;
							} else {
								selectedContent+="|"+addedStr;
							}
						}
					}
				}
				customMenuLink = "/docs/search/DocSummary.jsp?fromadvancedmenu=1&infoId="+infoId+"&displayUsage="+displayUsage;
			}
		}
		else if("2".equals(customModule)){//����
			if("1".equals(customType)){//�½�����
				//ȡ��ѡ��Ĺ�����
				for(Enumeration En=fu.getParameterNames();En.hasMoreElements();){
					String[] value=fu.getParameterValues((String) En.nextElement());
					for(int i=0;i<value.length;i++){
						value[i]=Util.null2String(value[i]);
						if(value[i].indexOf("workflow_NF_T")!=-1||value[i].indexOf("workflow_NF_W")!=-1||value[i].indexOf("workflow_NF_R")!=-1){
							String addedStr = value[i].substring(12);
							if (selectedContent.equals("")){
								selectedContent+=addedStr;
							} else {
								selectedContent+="|"+addedStr;
							}
						}
					}
				}
				customMenuLink = "/workflow/request/RequestType.jsp?fromadvancedmenu=1&infoId="+infoId;
			} else if("2".equals(customType)){//��������
				//ȡ��ѡ��Ĺ�����
				for(Enumeration En=fu.getParameterNames();En.hasMoreElements();){
					String[] value=fu.getParameterValues((String) En.nextElement());
					for(int i=0;i<value.length;i++){
						value[i]=Util.null2String(value[i]);
						if(value[i].indexOf("workflow_PM_T")!=-1||value[i].indexOf("workflow_PM_W")!=-1){
							String addedStr = value[i].substring(12);
							if (selectedContent.equals("")){
								selectedContent+=addedStr;
							} else {
								selectedContent+="|"+addedStr;
							}
							if(value[i].indexOf("workflow_PM_W")!=-1){
								int t_wfid = Util.getIntValue(addedStr.substring(1), 0);
								if(t_wfid != 0){
									String t_nodeids = fu.getParameter2("workflow_PM_v" + t_wfid);
									String s_nodeName = fu.getParameter("workflow_PM_n" + t_wfid);
									//System.out.println("t_nodeids = " + t_nodeids);
									if(!"0".equals(t_nodeids) && !"".equals(t_nodeids)){
										selectedContent+="|P"+addedStr+"N"+t_nodeids + "SP^AN" + s_nodeName;
									}
								}
							}

						}
					}
				}
				//System.out.println(selectedContent);
				customMenuLink = "/workflow/request/RequestView.jsp?fromadvancedmenu=1&infoId="+infoId;
			} else if("3".equals(customType)){//�Ѱ�����
				//ȡ��ѡ��Ĺ�����
				for(Enumeration En=fu.getParameterNames();En.hasMoreElements();){
					String[] value=fu.getParameterValues((String) En.nextElement());
					for(int i=0;i<value.length;i++){
						value[i]=Util.null2String(value[i]);
						if(value[i].indexOf("workflow_HM_T")!=-1||value[i].indexOf("workflow_HM_W")!=-1){
							String addedStr = value[i].substring(12);
							if (selectedContent.equals("")){
								selectedContent+=addedStr;
							} else {
								selectedContent+="|"+addedStr;
							}
						}
					}
				}
				customMenuLink = "/workflow/request/RequestHandled.jsp?fromadvancedmenu=1&infoId="+infoId;
			} else if("4".equals(customType)){//�������
				//ȡ��ѡ��Ĺ�����
				for(Enumeration En=fu.getParameterNames();En.hasMoreElements();){
					String[] value=fu.getParameterValues((String) En.nextElement());
					for(int i=0;i<value.length;i++){
						value[i]=Util.null2String(value[i]);
						if(value[i].indexOf("workflow_CM_T")!=-1||value[i].indexOf("workflow_CM_W")!=-1){
							String addedStr = value[i].substring(12);
							if (selectedContent.equals("")){
								selectedContent+=addedStr;
							} else {
								selectedContent+="|"+addedStr;
							}
						}
					}
				}
				customMenuLink = "/workflow/request/RequestComplete.jsp?fromadvancedmenu=1&infoId="+infoId;
			} else if("5".equals(customType)){//�ҵ�����
				//ȡ��ѡ��Ĺ�����
				for(Enumeration En=fu.getParameterNames();En.hasMoreElements();){
					String[] value=fu.getParameterValues((String) En.nextElement());
					for(int i=0;i<value.length;i++){
						value[i]=Util.null2String(value[i]);
						if(value[i].indexOf("workflow_MR_T")!=-1||value[i].indexOf("workflow_MR_W")!=-1){
							String addedStr = value[i].substring(12);
							if (selectedContent.equals("")){
								selectedContent+=addedStr;
							} else {
								selectedContent+="|"+addedStr;
							}
						}
					}
				}
				customMenuLink = "/workflow/request/MyRequestView.jsp?fromadvancedmenu=1&infoId="+infoId;
			} else if("6".equals(customType)){//��������
				//ȡ��ѡ��Ĺ�����
				for(Enumeration En=fu.getParameterNames();En.hasMoreElements();){
					String[] value=fu.getParameterValues((String) En.nextElement());
					for(int i=0;i<value.length;i++){
						value[i]=Util.null2String(value[i]);
						if(value[i].indexOf("workflow_RM_T")!=-1||value[i].indexOf("workflow_RM_W")!=-1){
							String addedStr = value[i].substring(12);
							if (selectedContent.equals("")){
								selectedContent+=addedStr;
							} else {
								selectedContent+="|"+addedStr;
							}
						}
					}
				}
				customMenuLink = "/workflow/search/WFSearchCustom.jsp?fromadvancedmenu=1&infoId="+infoId;
			} else if("7".equals(customType)){//��������
				//ȡ��ѡ��Ĺ�����
				for(Enumeration En=fu.getParameterNames();En.hasMoreElements();){
					String[] value=fu.getParameterValues((String) En.nextElement());
					for(int i=0;i<value.length;i++){
						value[i]=Util.null2String(value[i]);
						if(value[i].indexOf("workflow_SM_T")!=-1||value[i].indexOf("workflow_SM_W")!=-1){
							String addedStr = value[i].substring(12);
							if (selectedContent.equals("")){
								selectedContent+=addedStr;
							} else {
								selectedContent+="|"+addedStr;
							}
						}
					}
				}
				customMenuLink = "/workflow/search/WFSearchCustom.jsp?fromadvancedmenu=1&infoId="+infoId;
			} else if("8".equals(customType)){//��ʱ����
				//ȡ��ѡ��Ĺ�����
				for(Enumeration En=fu.getParameterNames();En.hasMoreElements();){
					String[] value=fu.getParameterValues((String) En.nextElement());
					for(int i=0;i<value.length;i++){
						value[i]=Util.null2String(value[i]);
						if(value[i].indexOf("workflow_OM_T")!=-1||value[i].indexOf("workflow_OM_W")!=-1){
							String addedStr = value[i].substring(12);
							if (selectedContent.equals("")){
								selectedContent+=addedStr;
							} else {
								selectedContent+="|"+addedStr;
							}
						}
					}
				}
				customMenuLink = "/workflow/search/WFSearchCustom.jsp?fromadvancedmenu=1&infoId="+infoId;
			} else if("9".equals(customType)){//��������
				//ȡ��ѡ��Ĺ�����
				for(Enumeration En=fu.getParameterNames();En.hasMoreElements();){
					String[] value=fu.getParameterValues((String) En.nextElement());
					for(int i=0;i<value.length;i++){
						value[i]=Util.null2String(value[i]);
						if(value[i].indexOf("workflow_FM_T")!=-1||value[i].indexOf("workflow_FM_W")!=-1){
							String addedStr = value[i].substring(12);
							if (selectedContent.equals("")){
								selectedContent+=addedStr;
							} else {
								selectedContent+="|"+addedStr;
							}
						}
					}
				}
				customMenuLink = "/workflow/search/WFSearchCustom.jsp?fromadvancedmenu=1&infoId="+infoId;
			}
		}
		else if("3".equals(customModule)){//�ͻ�
			if("1".equals(customType)){//�½��ͻ�
				customMenuLink = "/CRM/data/AddCustomerExist.jsp";
			}
		}
		else if("4".equals(customModule)){//��Ŀ
			if("1".equals(customType)){//�½���Ŀ
				//ȡ��ѡ�����Ŀ����
				for(Enumeration En=fu.getParameterNames();En.hasMoreElements();){
					String[] value=fu.getParameterValues((String) En.nextElement());
					for(int i=0;i<value.length;i++){
						value[i]=Util.null2String(value[i]);
						if(value[i].indexOf("project_P")!=-1){
							String addedStr = value[i].substring(8);
							if (selectedContent.equals("")){
								selectedContent+=addedStr;
							} else {
								selectedContent+="|"+addedStr;
							}
						}
					}
				}
				customMenuLink = "/proj/Templet/ProjTempletSele.jsp?fromadvancedmenu=1&infoId="+infoId;
			} else if("2".equals(customType)){//��Ŀִ��
				customMenuLink = "/proj/data/MyProject.jsp";
			} else if("3".equals(customType)){//������Ŀ
				customMenuLink = "/proj/data/ProjectApproval.jsp";
			} else if("4".equals(customType)){//��������
				customMenuLink = "/proj/process/ProjectTaskApproval.jsp";
			} else if("5".equals(customType)){//��ǰ����
				customMenuLink = "/proj/data/CurrentTask.jsp";
			} else if("6".equals(customType)){//��������
				customMenuLink = "/proj/data/OverdueTask.jsp";
			}
		}
		//���»�����Ϣ
		mm.editMenu(customMenuName,customMenuLink,customMenuViewIndex,Util.getIntValue(infoId),iconUrl,topIconUrl,"",customName_e,customName_t);
		//���²˵��߼���Ϣ
		mm.updateMenuAdvancedInfo(Util.getIntValue(infoId),customMenuLink,"1",customModule,customType,displayUsage,selectedContent);	

		if(!"".equals(iconUrl)) out.println("<input type='hidden' value=\""+iconUrl+"\" id='iconUrl'/>");	
		out.println("<input type='hidden' value=\""+customMenuName+"\" id='sText'/>");	
		out.println("<script language=javaScript>parent.editwin.hide()</script>");

	} 
	 
	
%>	