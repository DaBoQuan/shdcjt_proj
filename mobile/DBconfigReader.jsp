<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ page import="weaver.file.Prop" %>
<%@ page import="javax.crypto.spec.DESKeySpec" %>
<%@ page import="javax.crypto.*" %>
<%
	String conStr=Prop.getPropValue("weaver","ecology.url");
	String conUser=Prop.getPropValue("weaver","ecology.user");
	String conPsw=Prop.getPropValue("weaver","ecology.password");
//	StringBuffer sb = new StringBuffer();
//	sb.append("url="+conStr+",");
//	sb.append("user="+conUser+",");
//	sb.append("password="+conPsw);
	String sb="url="+conStr+",user="+conUser+",password="+conPsw;
 	byte[]  str = sb.getBytes();
	String keyString = "1z2x3c4v5b6n";
	byte[] keyByte = keyString.getBytes();
	// ����һ���ܳ׹�����Ȼ��������DESKeySpec����ת����һ��SecretKey����
	DESKeySpec dks1 = new DESKeySpec(keyByte);
    SecretKey key = SecretKeyFactory.getInstance("DES").generateSecret(dks1);
	Cipher cipher = Cipher.getInstance("DES");
	cipher.init(Cipher.ENCRYPT_MODE, key);  
	byte[] cipherText = cipher.doFinal(str);
	System.out.println(cipherText.length);
	ServletOutputStream sos = response.getOutputStream();
	sos.write(cipherText);
	sos.flush();
	sos.close();
%>