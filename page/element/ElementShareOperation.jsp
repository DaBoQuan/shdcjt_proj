<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/systeminfo/init.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
 <jsp:useBean id="hpec" class= "weaver.homepage.cominfo.HomepageElementCominfo" scope="page" />
 <jsp:useBean id="rs" class= "weaver.conn.RecordSet" scope="page" />
 <jsp:useBean id="hpu" class="weaver.page.PageUtil" scope="page"/>
 <jsp:useBean id="CheckSubCompanyRight" class="weaver.systeminfo.systemright.CheckSubCompanyRight" scope="page" />
<%
	String eid = Util.null2String(request.getParameter("eid"));
	String method = Util.null2String(request.getParameter("method"));
	int subCompanyId = Util.getIntValue(request.getParameter("subCompanyId"),-1);
	
	/*
	 Ȩ���ж�
	*/
  
   boolean canEdit=false;
   boolean isDetachable=hpu.isDetachable(request);
   String esharelevel = Util.null2String(request.getParameter("esharelevel"));
   int operatelevel=0;

   if(isDetachable){
	   operatelevel=CheckSubCompanyRight.ChkComRightByUserRightCompanyId(user.getUID(),"homepage:Maint",subCompanyId);
	   if(subCompanyId==-1) operatelevel=2;
   }else{
		if(HrmUserVarify.checkUserRight("homepage:Maint", user))       operatelevel=2;
   }  
   if(operatelevel>0) canEdit=true;
   if(!(user.getLogintype()).equals("1")) canEdit=false;
   if(esharelevel.equals("2")){
	   canEdit = true;
   }
   if(!canEdit){
		response.sendRedirect("/notice/noright.jsp") ;
		return ;
   }


	
	String strSql="";
	ArrayList hrmContentList = new ArrayList();//��Ա
	
	ArrayList subContentList = new ArrayList();//�ֲ�
	ArrayList subOperateList = new ArrayList();
	ArrayList subLevelList = new ArrayList();
	
	ArrayList depContentList = new ArrayList();//����
	ArrayList depOperateList = new ArrayList();
	ArrayList depLevelList = new ArrayList();
	
	ArrayList roleContentList = new ArrayList(); //��ɫ
	ArrayList roleTypeList = new ArrayList();
	ArrayList roleOperateList = new ArrayList();
	ArrayList roleLevelList = new ArrayList();
	
	ArrayList slContentList = new ArrayList(); //��ȫ����
	ArrayList slOperateList = new ArrayList();
	
	ArrayList allContentList = new ArrayList();//������
	if(method.equals("addShare")){
        String[] shareValues = request.getParameterValues("txtShareDetail"); 
        
        String shareStr ="";
        if (shareValues!=null) {       
			int sharetype=1;
			String content="1";
            for (int i=0;i<shareValues.length;i++){              
            	//System.out.println(shareValues[i]);
            	
                String[] paras = Util.TokenizerString2(shareValues[i],"$");
            	//if()
                sharetype = Util.getIntValue(paras[0]);
                content = paras[1];
                String[] contentList ;
				switch(sharetype){
					case 1://��Ա
						contentList = Util.TokenizerString2(content,",");
						for(int j=0;j<contentList.length;j++){
							if(hrmContentList.indexOf(contentList[j])==-1&&!contentList.equals("")){
								hrmContentList.add(contentList[j]);
							}
						}
						break;
					case 2://�ֲ�
						contentList = Util.TokenizerString2(Util.TokenizerString2(content,"_")[0],",");
						
						for(int j=0;j<contentList.length;j++){
							if(subContentList.indexOf(contentList[j])==-1&&!contentList[j].equals("")||true){
								subContentList.add(contentList[j]);
								subOperateList.add(Util.TokenizerString2(content,"_")[1]);
								subLevelList.add(Util.TokenizerString2(content,"_")[2]);
							}else{
								//System.out.println("^^^"+contentList[j]);
								/*if(subLevelList.containsKey(contentList[j])){
									//System.out.println(Util.getIntValue((String)subLevelList.get(contentList[j]))+">"+Util.getIntValue(Util.TokenizerString2(content,"_")[1]));
									if(Util.getIntValue((String)subLevelList.get(contentList[j]))>Util.getIntValue(Util.TokenizerString2(content,"_")[1])){
										subLevelList.put(contentList[j],Util.TokenizerString2(content,"_")[1]);
									}
								}*/
							}
						}
						break;
					case 3://����
						contentList = Util.TokenizerString2(Util.TokenizerString2(content,"_")[0],",");
						for(int j=0;j<contentList.length;j++){
							if(depContentList.indexOf(contentList[j])==-1&&!contentList[j].equals("")||true){
								depContentList.add(contentList[j]);
								depOperateList.add(Util.TokenizerString2(content,"_")[1]);
								depLevelList.add(Util.TokenizerString2(content,"_")[2]);
							}else{
								/*if(depLevelList.containsKey(contentList[j])){
									if(Util.getIntValue((String)depLevelList.get(contentList[j]))>Util.getIntValue(Util.TokenizerString2(content,"_")[1])){
										depLevelList.put(contentList[j],Util.TokenizerString2(content,"_")[1]);
									}
								}*/
							}
						}
						break;
					
					case 5://������
						contentList = Util.TokenizerString2(Util.TokenizerString2(content,"_")[0],",");
						for(int j=0;j<contentList.length;j++){
							if(hrmContentList.indexOf(contentList[j])==-1&&!contentList[j].equals("")){
								allContentList.add(contentList[j]);
							}
						}
						break;
					case 6://��ɫ
						contentList = Util.TokenizerString2(Util.TokenizerString2(content,"_")[0],",");
						for(int j=0;j<contentList.length;j++){
							if(roleContentList.indexOf(contentList[j])==-1&&!contentList[j].equals("")||true){
								roleContentList.add(contentList[j]);
								roleTypeList.add(Util.TokenizerString2(content,"_")[1]);
								roleOperateList.add(Util.TokenizerString2(content,"_")[2]);
								roleLevelList.add(Util.TokenizerString2(content,"_")[3]);
							}else{
								/*if(roleTypeList.containsKey(contentList[j])){
									if(Util.getIntValue((String)roleTypeList.get(contentList[j]))>Util.getIntValue(Util.TokenizerString2(content,"_")[1])){
										roleTypeList.put(contentList[j],Util.TokenizerString2(content,"_")[1]);
									}
								}
								if(roleLevelList.containsKey(contentList[j])){
									if(Util.getIntValue((String)roleLevelList.get(contentList[j]))>Util.getIntValue(Util.TokenizerString2(content,"_")[2])){
										roleLevelList.put(contentList[j],Util.TokenizerString2(content,"_")[2]);
									}
								}*/
							}
						}
						break;
					case 7://��ȫ����
						contentList = Util.TokenizerString2(Util.TokenizerString2(content,"_")[0],",");
						for(int j=0;j<contentList.length;j++){
							if(slContentList.indexOf(contentList[j])==-1&&!contentList[j].equals("")){
								if(slContentList.size()>0&&false){
									if(Util.getIntValue((String)slContentList.get(0))>Util.getIntValue(contentList[j])){
										slContentList.set(0,contentList[j]);
									}else{
										slContentList.add(contentList[j]);
									}
								}else{
									slOperateList.add(Util.TokenizerString2(content,"_")[0]);
									slContentList.add(Util.TokenizerString2(content,"_")[1]);
								}
							}
						}
						break;
				}
                
            }
            shareStr +="1_";
            for(int i=0;i<hrmContentList.size();i++){
            	shareStr+=hrmContentList.get(i);
            	if(i<hrmContentList.size()-1){
            		shareStr+=",";
            	}
            }
            shareStr +="^^2_";
			for(int i=0;i<subContentList.size();i++){
				shareStr+=subContentList.get(i);
				shareStr+="_"+subOperateList.get(i);
				shareStr+="_"+subLevelList.get(i);
            	if(i<subContentList.size()-1){
            		shareStr+=",";
            	}
            }
			shareStr +="^^3_";
			for(int i=0;i<depContentList.size();i++){
				shareStr+=depContentList.get(i);
				shareStr+="_"+depOperateList.get(i);
				shareStr+="_"+depLevelList.get(i);
            	if(i<depContentList.size()-1){
            		shareStr+=",";
            	}
            }
			
			if(allContentList.size()>0){
				shareStr +="^^5_1";
			}
			
			shareStr +="^^6_";
			for(int i=0;i<roleContentList.size();i++){
				shareStr+=roleContentList.get(i);
				shareStr+="_"+roleTypeList.get(i)+"_"+roleOperateList.get(i)+"_"+roleLevelList.get(i);
            	if(i<roleContentList.size()-1){
            		shareStr+=",";
            	}
			}
			shareStr +="^^7_";
			for(int i=0;i<slContentList.size();i++){
				shareStr+=slOperateList.get(i)+"_"+slContentList.get(i);
				if(i<slContentList.size()-1){
            		shareStr+=",";
            	}	
			}

            
        }else{
        	shareStr = "5_1";
        }
        strSql = "update hpelement set shareuser = '"+shareStr+"' where id="+eid;
       	//System.out.println(strSql);
        rs.executeSql(strSql);
        hpec.updateHpElementCache(eid);
        //response.sendRedirect("HomepageShare.jsp?hpid="+hpid);
       return;
} 
%>