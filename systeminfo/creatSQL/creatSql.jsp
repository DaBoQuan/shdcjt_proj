<%@ page import="java.io.*" %>
<%@ page import = " weaver.general.Util" %>
<%@ page language = "java"  import="weaver.systeminfo.*"%>



<jsp:useBean id="GenerateSql" class="GenerateSql" scope="page" />
<%

String TB_name = request.getParameter("TB_name"); 

String  isAutoAdd = request.getParameter("isAutoAdd");
TB_name = TB_name.trim();
isAutoAdd = isAutoAdd.trim();
int isAutoAdd1 = Util.getIntValue(isAutoAdd) ;
 
String  allBackSqlSentence = GenerateSql.getSqlString( TB_name,isAutoAdd1);
out.print(allBackSqlSentence);

String name = TB_name +"_SqlText";

File f = new File(name);
PrintWriter outtext = new PrintWriter(new FileWriter(f));
outtext.print(allBackSqlSentence +"\n");
outtext.close();
%>

<script language = "JavaScript">
alert ("���ɵ�SQL����ѷ���Resion�µ�<%=name%>�ļ���") ;
</script>