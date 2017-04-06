package weaver.hrm.report.schedulediff;

import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

import weaver.conn.RecordSet;
import weaver.general.BaseBean;
import weaver.general.Util;
import weaver.general.TimeUtil;
import weaver.hrm.company.DepartmentComInfo;
import weaver.hrm.User;
import weaver.hrm.report.schedulediff.HrmScheduleDiffUtil;
import weaver.hrm.report.schedulediff.HrmScheduleDiffDetBeLateManager;
import weaver.hrm.report.schedulediff.HrmScheduleDiffDetLeaveEarlyManager;
import weaver.hrm.report.schedulediff.HrmScheduleDiffDetAbsentFromWorkManager;
import weaver.hrm.report.schedulediff.HrmScheduleDiffDetNoSignManager;

public class HrmScheduleDiffManagerNew  extends BaseBean {
	private User user;//��ǰ�û�����
	public HrmScheduleDiffManagerNew() {
		user=null;
	}
	
	   /**
	    * ��������ǰ�����û�
	    * @param user ��ǰ�����û�  @see User
	    */ 
	public void setUser(User user) {
		this.user = user;
	}
	
	/**
	 *  ����ϼƵĹ�������
	 * 
	 * @param fromDate  ��ʼ����
	 * @param toDate    ��������          
	 * @return int �ϼƵĹ�������
	 */		
	public int getTotalWorkingDays(String fromDate,String toDate){
		int totalWorkingDays=0;

		//��ȫ���
		if(fromDate==null||fromDate.trim().equals("")
		 ||toDate==null||toDate.trim().equals("")	
		 ||fromDate.compareTo(toDate)>0){
			return totalWorkingDays;
		}		
		
		String currentDate="";
		String nextDate="";
	    boolean hasReachToDate=false;
	    boolean isWorkday=true;
	    HrmScheduleDiffUtil hrmScheduleDiffUtil=new HrmScheduleDiffUtil();
	    hrmScheduleDiffUtil.setUser(this.user);
	    
		for(currentDate=fromDate;!hasReachToDate;){
			
	        if(currentDate.equals(toDate)){
	        	hasReachToDate=true;
			}
	        
	        isWorkday=hrmScheduleDiffUtil.getIsWorkday(currentDate);
	        
	        if(!isWorkday){
				//��ȡ��һ����
				nextDate=TimeUtil.dateAdd(currentDate,1);
				currentDate=nextDate;
				continue;
	        }
	        
			//��ȡ��һ����
	        
			nextDate=TimeUtil.dateAdd(currentDate,1);
			currentDate=nextDate;
			totalWorkingDays++;
	        
		}		
		return totalWorkingDays;
	}
	/**
	 *  ��ÿ����б�
	 *  
	 * @param fromDate ��ʼ����
	 * @param toDate ��������
	 * @param subCompanyId  �ֲ�id
	 * @param departmentId  ����id
	 * @param resourceId  ������Դid
	 * 
	 * @return List   �����б�
	 */ 	
	public List getScheduleList(String fromDate,String toDate,int subCompanyId,int departmentId,int resourceId){
		
		List scheduleList=new ArrayList();
		Map scheduleMap=null;
		Map resourceIdIndexMapping=new HashMap();

		RecordSet rs=new RecordSet();		
		
		StringBuffer sb=new StringBuffer();
		sb.append("select id,lastName,departmentId from HrmResource where status in(0,1,2,3) ");
		
		if("oracle".equals(rs.getDBType())){
			sb.append(" and loginid is not null ");
		}else{
			sb.append(" and loginid is not null and loginid<>'' ");
		}
		
		if(subCompanyId>0){
			sb.append(" and  subCompanyId1=").append(subCompanyId);
		}

		if(departmentId>0){
			sb.append(" and  departmentId=").append(departmentId);
		}
		
		if(resourceId>0){
			sb.append(" and  id=").append(resourceId);
		}
		
		sb.append("  order by subCompanyId1 asc,departmentId asc,id asc ");
		
		try{
			
			DepartmentComInfo departmentComInfo=new DepartmentComInfo();
			
			int tempDepartmentId=0;
			String tempDepartmentName="";
			int tempResourceId=0;
			String tempResourceName="";
			
			int index=0;

			rs.executeSql(sb.toString());
			while(rs.next()){
				tempDepartmentId=rs.getInt("departmentId");
				tempDepartmentName=departmentComInfo.getDepartmentname(""+tempDepartmentId);
				tempResourceId=rs.getInt("id");
				tempResourceName=Util.null2String(rs.getString("lastName"));
				
				scheduleMap=new HashMap();
				scheduleMap.put("departmentName",tempDepartmentName);
				scheduleMap.put("resourceName",tempResourceName);	
				
				resourceIdIndexMapping.put(String.valueOf(tempResourceId),String.valueOf(index));
				scheduleList.add(scheduleMap);
				index++;
			}
			
			//���³ٵ���A��B��������
			updateDataOfBeLate(scheduleList,resourceIdIndexMapping,fromDate,toDate,subCompanyId,departmentId,resourceId);
			
			//�������ˣ�A��B��������
			updateDataOfLeaveEarly(scheduleList,resourceIdIndexMapping,fromDate,toDate,subCompanyId,departmentId,resourceId);			
			
			//���¿���������
			updateDataOfAbsentFromWork(scheduleList,resourceIdIndexMapping,fromDate,toDate,subCompanyId,departmentId,resourceId);
			
			//����©ǩ������
			updateDataOfNoSign(scheduleList,resourceIdIndexMapping,fromDate,toDate,subCompanyId,departmentId,resourceId);
			
			//������٣����١��¼١������ٱ𡢱�ע��������
			updateDataOfLeave(scheduleList,resourceIdIndexMapping,fromDate,toDate,subCompanyId,departmentId,resourceId);
			
			//���³��������
			updateDataOfEvection(scheduleList,resourceIdIndexMapping,fromDate,toDate,subCompanyId,departmentId,resourceId);
			
			//���¹���������
			//updateDataOfOut();
			
			return scheduleList;			
		}catch(Exception ex){
			return scheduleList;			
		}finally{
			
		}
	}
	
	/**
	 *  ���³ٵ���A��B��������
	 *  
	 * @param scheduleList �����б�
	 * @param resourceIdIndexMapping  ������Դ��������Ӧ��
	 * @param fromDate ��ʼ����
	 * @param toDate ��������
	 * @param subCompanyId  �ֲ�id
	 * @param departmentId  ����id
	 * @param resourceId  ������Դid
	 * 
	 */ 	
	private void updateDataOfBeLate(List scheduleList,Map resourceIdIndexMapping,String fromDate,String toDate,int subCompanyId,int departmentId,int resourceId){
		
		//��óٵ��б�
		HrmScheduleDiffDetBeLateManager beLateManager=new HrmScheduleDiffDetBeLateManager();
		beLateManager.setUser(this.user);
		beLateManager.setSortForResult(false);
		List beLateList=beLateManager.getScheduleList(fromDate,toDate,subCompanyId,departmentId,resourceId);
		Map beLateMap=null;
		
		String tempResourceId="";
		String tempSignTime="";
		int index=-1;
		
		Map scheduleMap=null;
		String beLateA="";
		String beLateB="";
		
		for(int i=0;i<beLateList.size();i++){
			beLateMap=(Map)beLateList.get(i);
			tempResourceId=Util.null2String((String)beLateMap.get("resourceId"));
			tempSignTime=Util.null2String((String)beLateMap.get("signTime"));
			
			index=Util.getIntValue((String)resourceIdIndexMapping.get(tempResourceId),-1);
			if(index>=0){
				scheduleMap=(Map)scheduleList.get(index);
				//�ٵ���A��09����ǰ�ٵ���B��09���ٵ�(����09��)��
//				if(tempSignTime.compareTo(criticalOfAandBForAM)<0){
//					beLateA=(String)scheduleMap.get("beLateA");
//					beLateA=String.valueOf(Util.getIntValue(beLateA,0)+1);
//					scheduleMap.put("beLateA",beLateA);
//				}else{
//				}
				beLateB=(String)scheduleMap.get("beLateB");
				beLateB=String.valueOf(Util.getIntValue(beLateB,0)+1);
				scheduleMap.put("beLateB",beLateB);					
			}
		}
	}
	
	/**
	 *  �������ˣ�A��B��������
	 *  
	 * @param scheduleList �����б�
	 * @param resourceIdIndexMapping  ������Դ��������Ӧ��
	 * @param fromDate ��ʼ����
	 * @param toDate ��������
	 * @param subCompanyId  �ֲ�id
	 * @param departmentId  ����id
	 * @param resourceId  ������Դid
	 * 
	 */ 	
	private void updateDataOfLeaveEarly(List scheduleList,Map resourceIdIndexMapping,String fromDate,String toDate,int subCompanyId,int departmentId,int resourceId){
		
		//��������б�
		HrmScheduleDiffDetLeaveEarlyManager leaveEarlyManager=new HrmScheduleDiffDetLeaveEarlyManager();
		leaveEarlyManager.setUser(this.user);
		leaveEarlyManager.setSortForResult(false);
		List leaveEarlyList=leaveEarlyManager.getScheduleList(fromDate,toDate,subCompanyId,departmentId,resourceId);
		Map leaveEarlyMap=null;
		
		String tempResourceId="";
		String tempSignTime="";
		int index=-1;
		
		Map scheduleMap=null;
		String leaveEarlyA="";
		String leaveEarlyB="";
		
		for(int i=0;i<leaveEarlyList.size();i++){
			leaveEarlyMap=(Map)leaveEarlyList.get(i);
			tempResourceId=Util.null2String((String)leaveEarlyMap.get("resourceId"));
			tempSignTime=Util.null2String((String)leaveEarlyMap.get("signTime"));
			
			index=Util.getIntValue((String)resourceIdIndexMapping.get(tempResourceId),-1);
			if(index>=0){
				scheduleMap=(Map)scheduleList.get(index);
				//���ˣ�A��17���Ժ����ˣ�B��17��ǰ���ˣ�����17�㣩��
//				if(tempSignTime.compareTo(criticalOfAandBForPM)>0){
//					leaveEarlyA=(String)scheduleMap.get("leaveEarlyA");
//					leaveEarlyA=String.valueOf(Util.getIntValue(leaveEarlyA,0)+1);
//					scheduleMap.put("leaveEarlyA",leaveEarlyA);
//				}else{
//				}
				leaveEarlyB=(String)scheduleMap.get("leaveEarlyB");
				leaveEarlyB=String.valueOf(Util.getIntValue(leaveEarlyB,0)+1);
				scheduleMap.put("leaveEarlyB",leaveEarlyB);					
			}
		}
	}
	
	/**
	 *  ���¿���������
	 *  
	 * @param scheduleList �����б�
	 * @param resourceIdIndexMapping  ������Դ��������Ӧ�� 
	 * @param fromDate ��ʼ����
	 * @param toDate ��������
	 * @param subCompanyId  �ֲ�id
	 * @param departmentId  ����id
	 * @param resourceId  ������Դid
	 * 
	 */ 	
	private void updateDataOfAbsentFromWork(List scheduleList,Map resourceIdIndexMapping,String fromDate,String toDate,int subCompanyId,int departmentId,int resourceId){
		
		//��ÿ����б�
		HrmScheduleDiffDetAbsentFromWorkManager absentFromWorkManager=new HrmScheduleDiffDetAbsentFromWorkManager();
		absentFromWorkManager.setUser(this.user);
		absentFromWorkManager.setSortForResult(false);
		List absentFromWorkList=absentFromWorkManager.getScheduleList(fromDate,toDate,subCompanyId,departmentId,resourceId);
		Map absentFromWorkMap=null;
		
		String tempResourceId="";
		int index=-1;
		
		Map scheduleMap=null;
		String absentFromWork="";
		
		for(int i=0;i<absentFromWorkList.size();i++){
			absentFromWorkMap=(Map)absentFromWorkList.get(i);
			tempResourceId=Util.null2String((String)absentFromWorkMap.get("resourceId"));
			
			index=Util.getIntValue((String)resourceIdIndexMapping.get(tempResourceId),-1);
			if(index>=0){
				scheduleMap=(Map)scheduleList.get(index);
				absentFromWork=(String)scheduleMap.get("absentFromWork");
				absentFromWork=String.valueOf(Util.getIntValue(absentFromWork,0)+1);
				scheduleMap.put("absentFromWork",absentFromWork);
			}
		}
	}
	
	/**
	 *  ����©ǩ������
	 *  
	 * @param scheduleList �����б�
	 * @param resourceIdIndexMapping  ������Դ��������Ӧ��
	 * @param fromDate ��ʼ����
	 * @param toDate ��������
	 * @param subCompanyId  �ֲ�id
	 * @param departmentId  ����id
	 * @param resourceId  ������Դid
	 * 
	 */ 	
	private void updateDataOfNoSign(List scheduleList,Map resourceIdIndexMapping,String fromDate,String toDate,int subCompanyId,int departmentId,int resourceId){
		
		//���©ǩ�б�
		HrmScheduleDiffDetNoSignManager noSignManager=new HrmScheduleDiffDetNoSignManager();
		noSignManager.setUser(this.user);
		noSignManager.setSortForResult(false);
		List noSignList=noSignManager.getScheduleList(fromDate,toDate,subCompanyId,departmentId,resourceId);
		Map noSignMap=null;
		
		String tempResourceId="";
		int index=-1;
		
		Map scheduleMap=null;
		String noSign="";
		
		for(int i=0;i<noSignList.size();i++){
			noSignMap=(Map)noSignList.get(i);
			tempResourceId=Util.null2String((String)noSignMap.get("resourceId"));
			
			index=Util.getIntValue((String)resourceIdIndexMapping.get(tempResourceId),-1);
			if(index>=0){
				scheduleMap=(Map)scheduleList.get(index);
				noSign=(String)scheduleMap.get("noSign");
				noSign=String.valueOf(Util.getIntValue(noSign,0)+1);
				scheduleMap.put("noSign",noSign);
			}
		}
	}
	
	/**
	 *  ������٣����١��¼١������ٱ𡢱�ע��������
	 * 
	 * @param scheduleList �����б�
	 * @param resourceIdIndexMapping  ������Դ��������Ӧ�� 
	 * @param fromDate ��ʼ����
	 * @param toDate ��������
	 * @param subCompanyId  �ֲ�id
	 * @param departmentId  ����id
	 * @param resourceId  ������Դid
	 * 
	 */ 	
	private void updateDataOfLeave(List scheduleList,Map resourceIdIndexMapping,String fromDate,String toDate,int subCompanyId,int departmentId,int resourceId){
		
		//�������б�
		List leaveList=new ArrayList();;
		Map leaveMap=null;
		HrmScheduleDiffUtil hrmScheduleDiffUtil=new HrmScheduleDiffUtil();
		hrmScheduleDiffUtil.setUser(user);		

		String tempResourceId="";
		String tempFromDate="";
		String tempFromTime="";
		String tempToDate="";
		String tempToTime="";		
		String tempLeaveDays="";
		String tempLeaveType="";
		String tempOtherLeaveType="";		
		
		StringBuffer sb=new StringBuffer();
		sb.append(" select c.id as resourceId,b.fromDate,b.fromTime,b.toDate,b.toTime,b.leaveDays,b.leaveType,b.otherLeaveType ")
		  .append("   from Workflow_Requestbase a,Bill_BoHaiLeave b,HrmResource c ")
		  .append("  where a.requestId=b.requestId ")
		  .append("    and b.resourceId=c.id ")
		  .append("    and a.currentNodeType='3' ")		  
		  .append("    and c.status in(0,1,2,3) ");
			
		if(!fromDate.equals("")){
			sb.append(" and  b.toDate>='").append(fromDate).append("'");
		}

		if(!toDate.equals("")){
			sb.append(" and  b.fromDate<='").append(toDate).append("'");
		}

		if(subCompanyId>0){
			sb.append(" and  c.subCompanyId1=").append(subCompanyId);
		}

		if(departmentId>0){
			sb.append(" and  c.departmentId=").append(departmentId);
		}
			
		if(resourceId>0){
			sb.append(" and  c.id=").append(resourceId);
		}
		
		RecordSet rs=new RecordSet();
		rs.executeSql(sb.toString());
		while(rs.next()){
			tempResourceId=Util.null2String(rs.getString("resourceId"));	
			tempFromDate=Util.null2String(rs.getString("fromDate"));	
			tempFromTime=Util.null2String(rs.getString("fromTime"));	
			tempToDate=Util.null2String(rs.getString("toDate"));				
			tempToTime=Util.null2String(rs.getString("toTime"));
			tempLeaveDays=Util.null2String(rs.getString("leaveDays"));			
			tempLeaveType=Util.null2String(rs.getString("leaveType"));					
			tempOtherLeaveType=Util.null2String(rs.getString("otherLeaveType"));					
			
			leaveMap=new HashMap();
			leaveMap.put("resourceId",tempResourceId);
			leaveMap.put("fromDate",tempFromDate);
			leaveMap.put("fromTime",tempFromTime);
			leaveMap.put("toDate",tempToDate);			
			leaveMap.put("toTime",tempToTime);	
			leaveMap.put("leaveDays",tempLeaveDays);			
			leaveMap.put("leaveType",tempLeaveType);	
			leaveMap.put("otherLeaveType",tempOtherLeaveType);						
			leaveList.add(leaveMap);						
		}			

		int index=-1;
		
		Map scheduleMap=null;
		String leave="";
		String remark="";
		String leaveTypeName="";
		String otherLeaveTypeName="";
		
		for(int i=0;i<leaveList.size();i++){
			leaveMap=(Map)leaveList.get(i);
			tempResourceId=Util.null2String((String)leaveMap.get("resourceId"));
			//tempLeaveDays=Util.null2String((String)leaveMap.get("leaveDays"));				
			tempLeaveType=Util.null2String((String)leaveMap.get("leaveType"));				
			tempOtherLeaveType=Util.null2String((String)leaveMap.get("otherLeaveType"));
			
			tempFromDate=Util.null2String((String)leaveMap.get("fromDate"));			
			tempFromTime=Util.null2String((String)leaveMap.get("fromTime"));
			tempToDate=Util.null2String((String)leaveMap.get("toDate"));
			tempToTime=Util.null2String((String)leaveMap.get("toTime"));
			
			if(tempFromDate.compareTo(fromDate)<0){
				tempFromDate=fromDate;
				tempFromTime="00:00";
			}
			
			if(tempToDate.compareTo(toDate)>0){
				tempToDate=toDate;
				tempToTime="23:59";
			}
			
			//tempLeaveDays=hrmScheduleDiffUtil.getTotalWorkingDays(tempFromDate,tempFromTime,tempToDate,tempToTime);
			tempLeaveDays=hrmScheduleDiffUtil.getTotalWorkingDays(tempFromDate,tempFromTime,tempToDate,tempToTime,subCompanyId);			
			
			index=Util.getIntValue((String)resourceIdIndexMapping.get(tempResourceId),-1);
			if(index>=0){
				scheduleMap=(Map)scheduleList.get(index);

				
				//����������Ϊ�¼�
				if(tempLeaveType.trim().equals("1")){
					
					leave=Util.null2String((String)scheduleMap.get("privateAffairLeave"));
					leave=String.valueOf(Util.getDoubleValue(leave,0)+Util.getDoubleValue(tempLeaveDays,0));					
					scheduleMap.put("privateAffairLeave",leave);
					
				//����������Ϊ����
				}else if(tempLeaveType.trim().equals("2")){

					leave=Util.null2String((String)scheduleMap.get("sickLeave"));
					leave=String.valueOf(Util.getDoubleValue(leave,0)+Util.getDoubleValue(tempLeaveDays,0));					
					scheduleMap.put("sickLeave",leave);					
					
				//����������Ϊ�����Ǵ�н��  B
				}else if(tempLeaveType.trim().equals("3")){
					
					leave=Util.null2String((String)scheduleMap.get("otherLeaveB"));
					leave=String.valueOf(Util.getDoubleValue(leave,0)+Util.getDoubleValue(tempLeaveDays,0));					
					scheduleMap.put("otherLeaveB",leave);

					leaveTypeName=hrmScheduleDiffUtil.getBillSelectName(180,"leaveType",Util.getIntValue(tempLeaveType,-1));
					otherLeaveTypeName=hrmScheduleDiffUtil.getBillSelectName(180,"otherLeaveType",Util.getIntValue(tempOtherLeaveType,-1));
					
					remark=Util.null2String((String)scheduleMap.get("remark"));	
					if(remark.trim().equals("")){
						remark+=leaveTypeName+"��"+otherLeaveTypeName+"��";
					}else{
						remark+="��"+leaveTypeName+"��"+otherLeaveTypeName+"��";
					}
					scheduleMap.put("remark",remark);
					
				//����������Ϊ������н��  A
				}else if(tempLeaveType.trim().equals("4")){	
					
					leave=Util.null2String((String)scheduleMap.get("otherLeaveA"));
					leave=String.valueOf(Util.getDoubleValue(leave,0)+Util.getDoubleValue(tempLeaveDays,0));					
					scheduleMap.put("otherLeaveA",leave);
					
					leaveTypeName=hrmScheduleDiffUtil.getBillSelectName(180,"leaveType",Util.getIntValue(tempLeaveType,-1));
					otherLeaveTypeName=hrmScheduleDiffUtil.getBillSelectName(180,"otherLeaveType",Util.getIntValue(tempOtherLeaveType,-1));
					
					remark=Util.null2String((String)scheduleMap.get("remark"));	
					if(remark.trim().equals("")){
						remark+=leaveTypeName+"��"+otherLeaveTypeName+"��";
					}else{
						remark+="��"+leaveTypeName+"��"+otherLeaveTypeName+"��";
					}
					scheduleMap.put("remark",remark);					
					
				}
				//leave=(String)scheduleMap.get("noSign");
				//leave=String.valueOf(Util.getDoubleValue(leave,0)+Util.getDoubleValue(tempLeaveDays,0));
				//scheduleMap.put("noSign",noSign);
				
			}
		}
	}
	
	/**
	 *  ���³��������
	 *  
	 * @param scheduleList �����б�
	 * @param resourceIdIndexMapping  ������Դ��������Ӧ�� 
	 * @param fromDate ��ʼ����
	 * @param toDate ��������
	 * @param subCompanyId  �ֲ�id
	 * @param departmentId  ����id
	 * @param resourceId  ������Դid
	 * 
	 */ 	
	private void updateDataOfEvection(List scheduleList,Map resourceIdIndexMapping,String fromDate,String toDate,int subCompanyId,int departmentId,int resourceId){
		
		//�������б�
		List evectionList=new ArrayList();;
		Map evectionMap=null;
		HrmScheduleDiffUtil hrmScheduleDiffUtil=new HrmScheduleDiffUtil();
		hrmScheduleDiffUtil.setUser(user);

		String tempResourceId="";
		String tempFromDate="";
		String tempFromTime="";
		String tempToDate="";
		String tempToTime="";
		String tempEvectionDays="";
		
		
		StringBuffer sb=new StringBuffer();
		sb.append(" select c.id as resourceId,b.fromDate,b.fromTime,b.toDate,b.toTime ")
		  .append("   from Workflow_Requestbase a,Bill_BoHaiEvection b,HrmResource c ")
		  .append("  where a.requestId=b.requestId ")
		  .append("    and b.resourceId=c.id ")
		  .append("    and a.currentNodeType='3' ")		  
		  .append("    and c.status in(0,1,2,3) ");
			
		if(!fromDate.equals("")){
			sb.append(" and  b.toDate>='").append(fromDate).append("'");
		}

		if(!toDate.equals("")){
			sb.append(" and  b.fromDate<='").append(toDate).append("'");
		}

		if(subCompanyId>0){
			sb.append(" and  c.subCompanyId1=").append(subCompanyId);
		}

		if(departmentId>0){
			sb.append(" and  c.departmentId=").append(departmentId);
		}
			
		if(resourceId>0){
			sb.append(" and  c.id=").append(resourceId);
		}
		
		RecordSet rs=new RecordSet();
		rs.executeSql(sb.toString());
		while(rs.next()){
			tempResourceId=Util.null2String(rs.getString("resourceId"));
			tempFromDate=Util.null2String(rs.getString("fromDate"));
			tempFromTime=Util.null2String(rs.getString("fromTime"));
			tempToDate=Util.null2String(rs.getString("toDate"));					
			tempToTime=Util.null2String(rs.getString("toTime"));
											
			evectionMap=new HashMap();
			evectionMap.put("resourceId",tempResourceId);	
			evectionMap.put("fromDate",tempFromDate);	
			evectionMap.put("fromTime",tempFromTime);	
			evectionMap.put("toDate",tempToDate);
			evectionMap.put("toTime",tempToTime);			
			
			evectionList.add(evectionMap);						
		}			

		int index=-1;
		
		Map scheduleMap=null;
		String evection="";
		
		
		for(int i=0;i<evectionList.size();i++){
			evectionMap=(Map)evectionList.get(i);
			tempResourceId=Util.null2String((String)evectionMap.get("resourceId"));
			//tempEvectionDays=Util.null2String((String)evectionMap.get("evectionDays"));
			tempFromDate=Util.null2String((String)evectionMap.get("fromDate"));			
			tempFromTime=Util.null2String((String)evectionMap.get("fromTime"));
			tempToDate=Util.null2String((String)evectionMap.get("toDate"));
			tempToTime=Util.null2String((String)evectionMap.get("toTime"));
			
			if(tempFromDate.compareTo(fromDate)<0){
				tempFromDate=fromDate;
				tempFromTime="00:00";
			}
			
			if(tempToDate.compareTo(toDate)>0){
				tempToDate=toDate;
				tempToTime="23:59";
			}
			
			//tempEvectionDays=hrmScheduleDiffUtil.getTotalWorkingDays(tempFromDate,tempFromTime,tempToDate,tempToTime);
			tempEvectionDays=hrmScheduleDiffUtil.getTotalWorkingDays(tempFromDate,tempFromTime,tempToDate,tempToTime,subCompanyId);
			
			
			index=Util.getIntValue((String)resourceIdIndexMapping.get(tempResourceId),-1);
			if(index>=0){
				scheduleMap=(Map)scheduleList.get(index);
				
				evection=(String)scheduleMap.get("evection");
				//evection=String.valueOf(Util.getDoubleValue(evection,0)+Util.getDoubleValue(tempEvectionDays,0));
				evection=Util.getPointValue(Util.round(String.valueOf(Util.getDoubleValue(evection,0)+Util.getDoubleValue(tempEvectionDays,0)),2));
				scheduleMap.put("evection",evection);
				
			}
		}
	}	
}