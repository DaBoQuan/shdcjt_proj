<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/homepage/element/content/Common.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page"/>
<jsp:useBean id="sppb" class="weaver.general.SplitPageParaBean" scope="page"/>
<jsp:useBean id="spu" class="weaver.general.SplitPageUtil" scope="page"/>
<jsp:useBean id="SptmForWorktask" class="weaver.splitepage.transform.SptmForWorktask" scope="page"/>
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page"/>
<jsp:useBean id="requestShare" class="weaver.worktask.request.RequestShare" scope="page"/>
<%
	/*
		������Ϣ
		--------------------------------------
		hpid:����ҳID
		subCompanyId:��ҳ�����ֲ��ķֲ�ID
		eid:Ԫ��ID
		ebaseid:����Ԫ��ID
		styleid:��ʽID
		
		������Ϣ
		--------------------------------------
		String strsqlwhere ��ʽΪ ����1^,^����2...
		int perpage  ��ʾҳ��
		String linkmode �鿴��ʽ  1:��ǰҳ 2:����ҳ

		
		�ֶ���Ϣ
		--------------------------------------
		fieldIdList
		fieldColumnList
		fieldIsDate
		fieldTransMethodList
		fieldWidthList
		linkurlList
		valuecolumnList
		isLimitLengthList

		��ʽ��Ϣ
		----------------------------------------
		String hpsb.getEsymbol() ����ͼ��
		String hpsb.getEsparatorimg()   �зָ��� 
	*/

	
	String returnStr="";		
	String[] toalList = strsqlwhere.split("\\^\\,\\^");
	ArrayList workTaskCreatorList=new ArrayList();
	ArrayList userRoleList=new ArrayList();
	ArrayList taskStatusList=new ArrayList();
	ArrayList taskTypeList=new ArrayList();
	String strWorkTaskCreator="";
	String strUserRole="";
	String strTaskStatus="";
	String strTaskType="";
	if(toalList.length>0){
		strWorkTaskCreator=toalList[0];
		workTaskCreatorList=Util.TokenizerString(strWorkTaskCreator, "|");	
	}
	if(toalList.length>1){
		strUserRole=(String)toalList[1];
		userRoleList=Util.TokenizerString(strUserRole, "|");	
	}
	if(toalList.length>2){
		strTaskStatus=toalList[2];
		taskStatusList=Util.TokenizerString(strTaskStatus, "|");	
	}
	if(toalList.length>3){
		strTaskType=toalList[3];
		taskTypeList=Util.TokenizerString(strTaskType, "|");	
	}
	
	
	String backfields = " o.id, o.optstatus, o.userid, r.creater, r.createdate, r.createtime, r.planstartdate, r.planstarttime, r.planenddate, r.planendtime, r.taskid, r.taskcontent, r.checkor, r.needcheck, o.viewtype, o.createrviewtype, o.checkorviewtype ";
	String fromSql  = " from worktask_operator o, worktask_requestbase r ";
	String sqlWhere = " where o.requestid=r.requestid and r.deleted=0 and o.type=1 and r.istemplate=0 and r.status in (6,7,8,9,10) ";
	if(workTaskCreatorList.indexOf("self")==-1 && workTaskCreatorList.indexOf("other")!=-1 ){//�����˲����Լ�
		sqlWhere += " and r.creater<>"+user.getUID()+" ";
	}else if(workTaskCreatorList.indexOf("self")!=-1 && workTaskCreatorList.indexOf("other")==-1){//���������Լ�
		sqlWhere += " and r.creater="+user.getUID()+" ";
	}
	
	String optStatus = "";
	if(taskStatusList.indexOf("waitdo")!=-1){//��ִ��
		optStatus += "0,-1,7,8,";
	}else{
		if(taskStatusList.indexOf("waitbegin")!=-1){
			optStatus += "0,";
		}
		if(taskStatusList.indexOf("process")!=-1){
			optStatus += "-1,7,";
		}
		if(taskStatusList.indexOf("over")!=-1){
			optStatus += "8,";
		}
	}
	if(taskStatusList.indexOf("waitvalidate")!=-1){
		optStatus += "1,";
	}
	if(!"".equals(optStatus)){
		optStatus = optStatus.substring(0, optStatus.length()-1);
		sqlWhere += " and o.optstatus in ("+optStatus+") ";
	}
	
	strTaskType=Util.StringReplace(strTaskType,"|",",");	
	if(!"".equals(strTaskType)){		
		sqlWhere += " and r.taskid in ("+strTaskType+") ";
	}
	
	String userRole_sql = "";
	if(userRoleList.indexOf("duty")!=-1){
		userRole_sql += "or o.userid = "+user.getUID()+" ";
	}
	if(userRoleList.indexOf("validate")!=-1){
		userRole_sql += "or r.checkor = "+user.getUID()+" ";
	}
	if(userRoleList.indexOf("creator")!=-1){
		userRole_sql += "or r.creater = "+user.getUID()+" ";
	}
	if(userRoleList.indexOf("assist")!=-1){
		if(rs.getDBType().equalsIgnoreCase("oracle")){
			userRole_sql += "or concat(concat(',',r.coadjutant),',') like '%,"+user.getUID()+",%'";
		}else{
			userRole_sql += "or ','+CONVERT(varchar,r.coadjutant)+',' like '%,"+user.getUID()+",%'";
		}
	}
	if(!"".equals(userRole_sql)){
		userRole_sql = userRole_sql.substring(2);
		sqlWhere += (" and (" + userRole_sql + ") ");
	}
	if(userRoleList.indexOf("validate")==-1){
		sqlWhere += requestShare.getCreateShareStr(user.getUID());
	}
	sppb.setBackFields(backfields);
	sppb.setPrimaryKey("o.id");
	sppb.setDistinct(true);
	sppb.setSqlFrom(fromSql);
	sppb.setSqlWhere(sqlWhere); 
	sppb.setSqlOrderBy("o.id");
	sppb.setSortWay(sppb.DESC);
	
	//spu.setRecordCount(perpage);
	spu.setSpp(sppb);
	
	
	String imgSymbol="";
	if (!"".equals(esc.getIconEsymbol(hpec.getStyleid(eid)))) imgSymbol="<img name='esymbol' src='"+esc.getIconEsymbol(hpec.getStyleid(eid))+"'>";
%>


<TABLE  id="_contenttable_<%=eid%>" class=Econtent  width=100%>
   <TR>
	 <TD width=1px></TD>
	 <TD width='*' valign="top">
		<TABLE width="100%">    
		<%
		int rowcount=0;
				
		rs=spu.getCurrentPageRs(1,perpage);	
		 int size=fieldIdList.size();
          while(rs.next()&&size>0){
			//taskcontent planstartdate planstarttime planenddate planendtime optstatus
			String optid=Util.null2String(rs.getString("id"));
			String taskcontent=Util.null2String(rs.getString("taskcontent"));
			String planstartdate=Util.null2String(rs.getString("planstartdate"));
			String planstarttime=Util.null2String(rs.getString("planstarttime"));
			String planenddate=Util.null2String(rs.getString("planenddate"));
			String planendtime=Util.null2String(rs.getString("planendtime"));
			String optstatus=Util.null2String(rs.getString("optstatus"));
			String principalid=Util.null2String(rs.getString("userid"));
			
			
			//System.out.println("optstatus:"+optstatus);
			
		%>
		<TR  height="18px">
                <TD width="8"><%=imgSymbol%></TD>	
			<%
//			int size=fieldIdList.size();
			for(int i=0;i<size;i++){
                      String fieldId=(String)fieldIdList.get(i);
                      String columnName=(String)fieldColumnList.get(i);
                      String strIsDate=(String)fieldIsDate.get(i);
                      String fieldTransMethod=(String)fieldTransMethodList.get(i);
                      String fieldwidth=(String)fieldWidthList.get(i);
                      String linkurl=(String)linkurlList.get(i);
                      String valuecolumn=(String)valuecolumnList.get(i);	

                      String isLimitLength=(String)isLimitLengthList.get(i);
                      String showValue="";                    
                      String cloumnValue=Util.null2String(rs.getString(columnName));   
                      String nameTdTitle="";
                      
                      //System.out.println("fieldId:"+fieldId);
			 %>			
			  <%if("WorktaskContent".equals(columnName)){%>
				<td width="*">
					<%	
						int liableperson_tmp = Util.getIntValue(rs.getString("userid"), 0);
						int viewtype_tmp = Util.getIntValue(rs.getString("viewtype"), 0);
						int createrviewtype_tmp = Util.getIntValue(rs.getString("createrviewtype"), 0);
						int checkorviewtype_tmp = Util.getIntValue(rs.getString("checkorviewtype"), 0);
						int checkor_tmp = Util.getIntValue(rs.getString("checkor"), 0);
						int needcheck_tmp = Util.getIntValue(rs.getString("needcheck"), 0);
						int creater_tmp = Util.getIntValue(rs.getString("creater"), 0);
						int optstatus_tmp = Util.getIntValue(rs.getString("optstatus"), 0);
						if(liableperson_tmp != user.getUID()){
							viewtype_tmp = checkorviewtype_tmp;
							if(checkor_tmp==0 || needcheck_tmp==0 || checkor_tmp!=user.getUID()){
								viewtype_tmp = createrviewtype_tmp;
								if(creater_tmp != user.getUID()){
									viewtype_tmp = 0;
								}
							}
						}
						String iconStr = SptmForWorktask.getWorktaskIcon(viewtype_tmp, optstatus_tmp);
						String WorktaskContent=hpu.getLimitStr(eid,fieldId,taskcontent,user,hpid,subCompanyId);
						out.println(hpu.getLinkStr("/worktask/request/ViewWorktask.jsp?operatorid="+optid,WorktaskContent,linkmode)+iconStr);
					%>
				</td>
			 <%}%>  

			 <%if("taskprincipal".equals(columnName)){%>
				<td width="60">
				<%
					out.println(hpu.getLinkStr("/hrm/resource/HrmResource.jsp?id="+principalid,ResourceComInfo.getLastname(principalid),linkmode));
				%>
				</td>				
			  <%}%>  
				
			 <%if("begindate".equals(columnName)){%>
				<td width="76"><%=planstartdate%></td>
			  <%}%>  
				
				
			   <%if("begintime".equals(columnName)){%>
				<td width="62"><%=planstarttime%></td>
			  <%}%>

			   <%if("enddate".equals(columnName)){%>
				<td width="76">
					<%=planenddate%>
			   </td>
			  <%}%>

			   <%if("endtime".equals(columnName)){%>
				<td  width="62">
					<%=planendtime%>
				</td>
			  <%}%>

			   <%if("WorktaskStatus".equals(columnName)){%>
				<td width="40"><%=SptmForWorktask.getStatusName(optstatus,""+user.getLanguage())%></td>
			  <%}%>


			<%}%>
		</TR>
		<%
		rowcount++;
		if(perpage!=1&&rowcount<perpage){
		%>		
		 <TR class='sparator' style="height:1px" height=1px><td colspan=<%=size+1%> style='padding:0px'></td></TR>
		 <%}%>
		<%}%>
		 </TABLE>
    </TD>
    <TD width="1px"></TD>
</TR>
</TABLE>


