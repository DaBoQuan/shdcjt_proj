package weaver.hrm.webservices;

public interface HrmSyncService {
	
	/**
	 * �ýӿڷ���json�ַ������ݡ���ʽΪ��{��code��,�� description��}
	 * ���磺{��0��,���û�����֯����λͬ���ɹ���}
	 * {��1��,��**�û�ͬ��������֯����λͬ���ɹ���}
	 * @param ������appID   appIDΪӦ��ϵͳ���룬���Ͽ���˾ȷ���󣬸�֪Ӧ��ϵͳ�����̡�
	 * @return
	 * 
	 */
	public String userSync(String appID);
}
