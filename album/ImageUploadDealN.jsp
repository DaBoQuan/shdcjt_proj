<%@ page language='java' %>
<%@ page import='java.io.*,java.util.*,javax.servlet.*,javax.servlet.http.*,javax.servlet.http.HttpServletRequest'%>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="weaver.album.PhotoSequence,weaver.image.Thumbnail,weaver.general.*" %>
<%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="p" class="weaver.album.PhotoComInfo" scope="page" />

<%
int userId = user.getUID();
int pId = 0;
String uploadImgIDs = "";
int uploadImgSizeSum = 0;

String picturePath = "";
rs.executeSql("SELECT picturePath FROM systemset");
if(rs.next()){
	picturePath = Util.null2String(rs.getString("picturePath"));
}

String physicalPath = request.getRealPath("UploadFolder");
String physicalPathThumbnail = physicalPath;//����ͼ�����/Album/UploadFolder/thumbnail��
if(!("".equals(picturePath))){//���������·����ͼƬ�����ָ��Ŀ¼��
	physicalPath = picturePath;
}

File saveDir = new File(physicalPath);
if(!(saveDir.exists())){
	saveDir.mkdir();
}

/*
//������־�ļ�
File LogFile = new File (physicalPath + "/UploadLogFileLog.txt");
LogFile.createNewFile();
FileWriter LogFileWrite = new FileWriter(LogFile);
LogFileWrite.write("Upload Begin...");
*/

//��ʼ�����ϴ�����
DiskFileUpload fu = new DiskFileUpload();

//1G
//�������пͻ���POST��������������С
//���ֵ������̫С����������ϴ����ļ�������׳��ϴ��쳣�Ĵ���
fu.setSizeMax(1000000000);
//�ڴ滺������С0.5M
fu.setSizeThreshold(500000);
//��ʱ�ļ�����·��
fu.setRepositoryPath(physicalPath);

//��ʼ��������
List listFileItems = fu.parseRequest(request);
//�������ֵ����map�У��Ӷ���߶�ȡfield��Ч��
Hashtable fieldItems = new Hashtable();

ArrayList imgArray = new ArrayList();

for(int i=0;i<listFileItems.size();i++){
	FileItem sourceFile = (FileItem)(listFileItems.get(i));
	if(!sourceFile.isFormField()){
		pId = PhotoSequence.getInstance().get();

		String fileName = new File(sourceFile.getName()).getName();

		if(fileName.lastIndexOf("\\")!=-1){
			fileName = fileName.substring(fileName.lastIndexOf("\\")+1, fileName.length());
		}
		
		if(Util.isExcuteFile(fileName)) continue;

		String newFileName = String.valueOf(pId);

		File file = new File(physicalPath + File.separator + newFileName);
		sourceFile.write(file);

		String filesize = Util.round(String.valueOf(file.length()/1000), 1);
		if(filesize.equals("0")) filesize="1";
		uploadImgSizeSum += Util.getIntValue(filesize);

		//����ͼ
		String[] param = {physicalPath+File.separator+newFileName, physicalPathThumbnail+File.separator+"thumbnail"+File.separator+newFileName, "96", "200", "100"};
		Thumbnail.create(param);

		String[] paramImg = {""+pId, fileName, filesize, newFileName, TimeUtil.getCurrentTimeString()};
		imgArray.add(paramImg);
	}else{
		//����ֵ���ŵ�map��
		fieldItems.put(sourceFile.getFieldName(), sourceFile);
	}
}

if(uploadImgIDs.endsWith(",")){
	uploadImgIDs = uploadImgIDs.substring(0, uploadImgIDs.length()-1);
}


//=========================================================================================================
FileItem Field1FileItem = (FileItem)fieldItems.get("parentId");
String parentId = Field1FileItem.getString();
String ancestorId = p.getAncestorId(parentId);

String sql = "";
int size = imgArray.size();
for(int i=0;i<size;i++){
	String[] _imgArray = (String[])imgArray.get(i);
	sql = "INSERT INTO AlbumPhotos (id, parentId, isFolder, subFolderCount, photoName, photoSize, photoPath, photoDescription, thumbnailPath, userid, postdate, subcompanyId) VALUES ("+_imgArray[0]+", "+parentId+", '0', 0, '"+_imgArray[1]+"', "+_imgArray[2]+", '"+physicalPath+File.separator+_imgArray[3]+"', '', '"+File.separator+"album"+File.separator+"UploadFolder"+File.separator+"thumbnail"+File.separator+_imgArray[3]+"', "+userId+", '"+_imgArray[4]+"', "+ancestorId+")";
	rs.executeSql(sql);

	p.addPhotoInfoCache(_imgArray[0]);
}

//sqlserverʹ�ô�����
if(rs.getDBType().equals("oracle")){
	p.updateCountAndSize(ancestorId, parentId);
}

p.updatePhotoInfoCache(parentId);
%>