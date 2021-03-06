<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="Util" class="weaver.general.Util" scope="page" />
<%
    char flag = 2;
    String ProcPara = "";

    String method = Util.null2String(request.getParameter("method"));

    if(method.equals("add"))
    {
        String name=Util.convertInput2DB(Util.null2String(request.getParameter("name")));
        String desc=Util.convertInput2DB(Util.null2String(request.getParameter("desc")));

        ProcPara = "insert into DocSendDocKind(name,desc_n) values('"+name+"','"+desc+"')";
        RecordSet.executeSql(ProcPara);

        response.sendRedirect("docKind.jsp");
        return;
    }

    if(method.equals("edit"))
    {
        String id=Util.null2String(request.getParameter("id"));
        String name=Util.convertInput2DB(Util.null2String(request.getParameter("name")));
        String desc=Util.convertInput2DB(Util.null2String(request.getParameter("desc")));

        ProcPara = "update DocSendDocKind set ";
        ProcPara += "name='" + name + "', ";
        ProcPara += "desc_n='" + desc + "' ";
        ProcPara += " where id = " + id ;
        RecordSet.executeSql(ProcPara);

        response.sendRedirect("docKind.jsp");
        return;
    }

    String IDs[]=request.getParameterValues("IDs");
    if(method.equals("delete"))
    {
        if(IDs != null)
        {
            for(int i=0;i<IDs.length;i++)
            {
                ProcPara = "delete DocSendDocKind where id = " + IDs[i];
                RecordSet.executeSql(ProcPara);

            }
        }

        response.sendRedirect("docKind.jsp");
        return;
    }
%>
