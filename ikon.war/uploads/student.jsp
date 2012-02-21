<%@ page import="java.util.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="webutil.*" %>
<%@ page import="com.rameses.web.fileupload.*" %>
<%@ page import="com.rameses.web.support.*" %>
<%@ page import="com.rameses.service.*" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags/common/server" prefix="s" %>

<%!
class XlsDataHandler implements DataImportHandler
{
	private ServiceProxy service;
	
	XlsDataHandler(ServiceProxy service) {
		this.service = service;
	}

	public void onread(Map map, int index) {
		try {
			service.invoke("save", new Object[]{ map });
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	
}
%>

<%

if( request instanceof MultipartRequest ) {
	MultipartRequest mreq = (MultipartRequest) request;
	FileItem fitem = mreq.getFileParameter("file");
	
	LookupUtil lu = new LookupUtil(application);
	ServiceProxy sp = lu.lookupService("StudentService", request);
	
	try {
		DataImporter di = new ExcelDataImporter();
		di.importData(fitem.getInputStream(), new XlsDataHandler(sp));
	}
	catch(Exception e) {
	
	}
}

%>


<h3>Upload Students Excel File</h3>
<form method="post" enctype="multipart/form-data">
	<input type="file" name="file" />
	<br/>
	<button type="submit" name="upload">Upload</button>
</form>