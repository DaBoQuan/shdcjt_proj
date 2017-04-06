<%@ page
	import="java.math.BigDecimal,java.util.Date,java.io.File,java.io.FilenameFilter,java.util.Arrays,weaver.general.Util,weaver.general.TimeUtil"%>
<%
/**
  * jQuery File Tree JSP Connector
  * Version 1.0
  * Copyright 2008 Joshua Gould
  * 21 April 2008
*/	
    String dir = request.getParameter("dir");
	//System.out.println("dir==="+dir);
    if (dir == null) {
    	return;
    }
	
	if (dir.charAt(dir.length()-1) == '\\') {
    	dir = dir.substring(0, dir.length()-1) + "/";
	} else if (dir.charAt(dir.length()-1) != '/') {
	    dir += "/";
	}
	String dirAbs="";
	dirAbs =application.getRealPath("/")+dir;

	dirAbs  = Util.StringReplace(dirAbs,"\\","/");
	String fileInfo ="[";
    if (new File(dirAbs).exists()) {
		String[] files = new File(dirAbs).list(new FilenameFilter() {
		    public boolean accept(File dirAbs, String name) {
				return name.charAt(0) != '.';
		    }
		});
		Arrays.sort(files, String.CASE_INSENSITIVE_ORDER);
		if(files.length>0){
			out.print("<ul class=\"jqueryFileTree\" style=\"display: none;\">");
			// All dirs
			for (int i=0; i<files.length;i++) {
				String file = files[i];
				File _file =  new File(dirAbs, file);
			    if (_file.isDirectory()) {
					out.print("<li class=\"directory collapsed\" ><a href=\"#\" rel=\"" + dir + file + "/\">"
						+ file + "</a></li>");
			    }else{
			    	fileInfo+="['"+file+"','"+new BigDecimal((_file.length()/1000)).setScale(0, BigDecimal.ROUND_HALF_UP)+"K','"+TimeUtil.getDateString(new Date(_file.lastModified()))+"'],";
			    }
			}
			// All files
			/*for (int i=0; i<files.length;i++) {
				String file = files[i];
				File _file =  new File(dirAbs, file);
			    if (!_file.isDirectory()) {
					int dotIndex = file.lastIndexOf('.');
					String ext = dotIndex > 0 ? file.substring(dotIndex + 1) : "";
					out.print("<li class=\"file ext_" + ext + "\"><a href=\"#\" rel=\"" + dir + file + "\">"
						+ file + "</a></li>");
			    	}
			}*/
			out.print("</ul>");
		}
		if(!fileInfo.equals("[")){
			fileInfo = fileInfo.substring(0,fileInfo.length()-1);
		}
		fileInfo +="]";
		out.println("$%^&"+fileInfo);
    }
%>