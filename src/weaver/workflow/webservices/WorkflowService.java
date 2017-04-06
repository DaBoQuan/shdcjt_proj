package weaver.workflow.webservices;

public interface WorkflowService {
	
	/**
	 * ��ȡ���������б�
	 * 
	 * @param pageNo ��ǰҳ��
	 * @param pageSize ÿҳ��¼��
	 * @param recordCount ��¼����
	 * @param userid ��ǰ�û�
	 * @param conditions ��ѯ����
	 * @return WorkflowRequestInfo ����������Ϣ
	 */
	public WorkflowRequestInfo[] getToDoWorkflowRequestList(int pageNo,int pageSize,int recordCount,int userId, String[] conditions);
	
	/**
	 * ��ȡ������������
	 * 
	 * @param userid ��ǰ�û�
	 * @param conditions ��ѯ����
	 * @return int ������������
	 */
	public int getToDoWorkflowRequestCount(int userId, String[] conditions);

	/**
	 * ��ȡ���������б�
	 * 
	 * @param pageNo ��ǰҳ��
	 * @param pageSize ÿҳ��¼��
	 * @param recordCount ��¼����
	 * @param userid ��ǰ�û�
	 * @param conditions ��ѯ����
	 * @return WorkflowRequestInfo ����������Ϣ
	 */
	public WorkflowRequestInfo[] getCCWorkflowRequestList(int pageNo,int pageSize,int recordCount,int userId, String[] conditions);
	
	/**
	 * ��ȡ������������
	 * 
	 * @param userid ��ǰ�û�
	 * @param conditions ��ѯ����
	 * @return int ������������
	 */
	public int getCCWorkflowRequestCount(int userId, String[] conditions);
	
	/**
	 * ��ȡ�Ѱ������б�
	 * 
	 * @param pageNo ��ǰҳ��
	 * @param pageSize ÿҳ��¼��
	 * @param recordCount ��¼����
	 * @param userid ��ǰ�û�
	 * @param conditions ��ѯ����
	 * @return WorkflowRequestInfo �Ѱ�������Ϣ
	 */
	public WorkflowRequestInfo[] getHendledWorkflowRequestList(int pageNo,int pageSize,int recordCount,int userId, String[] conditions);
	
	/**
	 * ��ȡ�Ѱ���������
	 * 
	 * @param userid ��ǰ�û�
	 * @param conditions ��ѯ����
	 * @return int �Ѱ���������
	 */
	public int getHendledWorkflowRequestCount(int userId, String[] conditions);

	/**
	 * ��ȡ�鵵�����б�
	 * 
	 * @param pageNo ��ǰҳ��
	 * @param pageSize ÿҳ��¼��
	 * @param recordCount ��¼����
	 * @param userid ��ǰ�û�
	 * @param conditions ��ѯ����
	 * @return WorkflowRequestInfo �鵵������Ϣ
	 */
	public WorkflowRequestInfo[] getProcessedWorkflowRequestList(int pageNo,int pageSize,int recordCount,int userId, String[] conditions);

	/**
	 * ��ȡ�鵵��������
	 * 
	 * @param userid ��ǰ�û�
	 * @param conditions ��ѯ����
	 * @return int �鵵��������
	 */
	public int getProcessedWorkflowRequestCount(int userId, String[] conditions);

	/**
	 * ��ȡ�ҵ������б�
	 * 
	 * @param pageNo ��ǰҳ��
	 * @param pageSize ÿҳ��¼��
	 * @param recordCount ��¼����
	 * @param userid ��ǰ�û�
	 * @param conditions ��ѯ����
	 * @return WorkflowRequestInfo ����������Ϣ
	 */
	public WorkflowRequestInfo[] getMyWorkflowRequestList(int pageNo,int pageSize,int recordCount,int userId, String[] conditions);

	/**
	 * ��ȡ�ҵ���������
	 * 
	 * @param userid ��ǰ�û�
	 * @param conditions ��ѯ����
	 * @return int ������������
	 */
	public int getMyWorkflowRequestCount(int userId, String[] conditions);
	
	/**
	 * �������п�����������
	 * @param keyword ���̱���
	 * @param userid ��ǰ�û�
	 * @param conditions ��ѯ����
	 * @return int ���п�����������
	 */
	public int getAllWorkflowRequestCount(int userid, String[] conditions);
	
	/**
	 * �������п�������
	 * @param pageNo ��ǰҳ��
	 * @param pageSize ÿҳ��¼��
	 * @param recordCount ��¼����
	 * @param keyword ���̱���
	 * @param userid ��ǰ�û�
	 * @param conditions ��ѯ����
	 * @return WorkflowRequestInfo ���п���������Ϣ
	 */
	public WorkflowRequestInfo[] getAllWorkflowRequestList(int pageNo, int pageSize, int recordCount, int userid, String[] conditions);

	/**
	 * ȡ��������ϸ��Ϣ
	 * 
	 * @param requestid ��������ID
	 * @param userid ��ǰ�û�
	 * @return WorkflowRequestInfo ������Ϣ
	 */
	public WorkflowRequestInfo getWorkflowRequest(int requestid,int userId,int fromrequestid);
	
	/**
	 * ȡ��������ϸ��Ϣ
	 * 
	 * @param requestid ��������ID
	 * @param userid ��ǰ�û�
	 * @param pagesize ǩ�����������
	 * @return WorkflowRequestInfo ������Ϣ
	 */
	public WorkflowRequestInfo getWorkflowRequest4split(int requestid, int userid,int fromrequestid, int pagesize);
	
	public WorkflowRequestLog[] getWorkflowRequestLogs(String workflowId, String requestId, int userid, int pagesize, int endId) throws Exception;
	/**
	 * �����ύ
	 * 
	 * @param WorkflowRequestInfo ������Ϣ
	 * @param requestid ��������ID
	 * @param userid ��ǰ�û�
	 * @param type �ύ����
	 * @param remark ǩ�����
	 * @return String �ύ���
	 */
	public String submitWorkflowRequest(WorkflowRequestInfo wri,int requestid,int userId,String type,String remark);
	
	/**
	 * ����ת��
	 * 
	 * @param requestid ��������ID
	 * @param recipients ת����
	 * @param userid ��ǰ�û�
	 * @param remark ǩ�����
	 * @param clientip �û�IP
	 * @return String ת�����
	 */
	public String forwardWorkflowRequest(int requestid,String recipients,String remark,int userId,String clientip);
	
	/**
	 * ȡ�ÿɴ����Ĺ������б�
	 * 
	 * @param pageNo ��ǰҳ��
	 * @param pageSize ÿҳ��¼��
	 * @param recordCount ��¼����
	 * @param userid ��ǰ�û�
	 * @param workflowType ����������
	 * @return WorkflowBaseInfo �������б�
	 */
	public WorkflowBaseInfo[] getCreateWorkflowList(int pageNo,int pageSize,int recordCount,int userId, int workflowType, String[] conditions);
	
	/**
	 * ȡ�ÿɴ����Ĺ���������
	 * 
	 * @param userid ��ǰ�û�
	 * @param workflowType ����������
	 * @param conditions ��ѯ����
	 * @return int ����������
	 */
	public int getCreateWorkflowCount(int userId, int workflowType, String[] conditions);

	/**
	 * ȡ�ÿɴ����Ĺ����������б�
	 * 
	 * @param pageNo ��ǰҳ��
	 * @param pageSize ÿҳ��¼��
	 * @param recordCount ��¼����
	 * @param userid ��ǰ�û�
	 * @param conditions ��ѯ����
	 * @return WorkflowBaseInfo �����������б�
	 */
	public WorkflowBaseInfo[] getCreateWorkflowTypeList(int pageNo,int pageSize,int recordCount,int userId, String[] conditions);
	
	/**
	 * ȡ�ÿɴ����Ĺ�������������
	 * 
	 * @param userid ��ǰ�û�
	 * @param conditions ��ѯ����
	 * @return int ��������������
	 */
	public int getCreateWorkflowTypeCount(int userId, String[] conditions);

	/**
	 * ȡ�ô������̵������Ϣ
	 * 
	 * @param workflowId ������ID
	 * @param userid ��ǰ�û�
	 * @return WorkflowRequestInfo ������Ϣ
	 */
	public WorkflowRequestInfo getCreateWorkflowRequestInfo(int workflowId,int userId);
	
	/**
	 * ִ�д�������
	 * 
	 * @param WorkflowRequestInfo ������Ϣ
	 * @param userid ��ǰ�û�
	 * @return String ���ؽ��
	 */
	public String doCreateWorkflowRequest(WorkflowRequestInfo wri,int userId);
	
	/**
	 * ������뵥���⴦��
	 * ������ʼ���ڡ���ʼʱ�䡢�������ڡ�����ʱ�����������
	 * @param fromDate
	 * @param fromTime
	 * @param toDate
	 * @param toTime
	 * @param resourceId
	 * @return String �������
	 */
	public String getLeaveDays(String fromDate,String fromTime,String toDate,String toTime,String resourceId);
	
	/**
	 * ȡ������new���
	 * @param requestids
	 * @param resourceid
	 * @return
	 */
	public String[] getWorkflowNewFlag(String[] requestids, String resourceid);

	/**
	 * ɾ������
	 * @param requestid ����id
	 * @param userId �û�id
	 * @return ɾ���Ƿ�ɹ� true�ɹ���falseʧ��
	 */
	public boolean deleteRequest(int requestid,int userId);
	
	/**
	 * д�����̲鿴��־
	 * @param requestid
	 * @param userid
	 */
	public void writeWorkflowReadFlag(String requestid, String userid);
	
	/**
	 * ��ǩ�������Ϣ���µ����̵�����ǩ�������Ϣ��
	 * @param requestid
	 * @param userid
	 */
	public void updateWorkflowLog(String requestid, String log);
	
	/**
	 * ���Ͽ�����Ա�����š��ֲ�����λ��������Ϣͬ����oa��
	 * @param requestid
	 * @param userid
	 */
	public void updateOaHrpkcode(String oaHrmId, String nkHrmId);
	/**
	 * ���Ͽ�����Ա�����š��ֲ�����λ��������Ϣͬ����oa��
	 * @param requestid
	 * @param userid
	 */
	public void updateOaDeptpkcode(String oaDeptId, String nkDeptId);
	/**
	 * ���Ͽ�����Ա�����š��ֲ�����λ��������Ϣͬ����oa��
	 * @param requestid
	 * @param userid
	 */
	public void updateOaSubCompkcode(String oaSubComId, String nkSubComId);
	/**
	 * ���Ͽ�����Ա�����š��ֲ�����λ��������Ϣͬ����oa��
	 * @param requestid
	 * @param userid
	 */
	public void updateOaJobTitlepkcode(String oaJobTitleId, String nkJobTitleId);
}
