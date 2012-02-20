<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.rameses.service.*" %>

<%   
	try {
		String userid = request.getParameter("id")+"";
		
		String resUrl = System.getProperty("ikon.temp.url");
		String target = resUrl + "/" + userid.hashCode() + "/thumbnail.jpg";
		File f = new File(new URL(target).toURI());

		//response.addHeader("Cache-Control", "max-age=86400");
		//response.addHeader("Cache-Control", "public");
		response.setContentType("image/jpg");
		
		Writer w = response.getWriter();
		InputStream is = null;
		
		try {
			if( f.exists() ) {
				is = new BufferedInputStream(new FileInputStream(f));
			}
			else {
				is = application.getResourceAsStream("img/profile/small.png");
				is = new BufferedInputStream(is);
			}
			int i = -1;
			while( (i=is.read()) != -1 ) w.write(i);
		}
		catch(Exception e) {}
		finally {
			if( is != null ) try{ is.close(); }catch(Exception ign){;}
		}
	}
	catch(Exception e) {
		e.printStackTrace();
		//out.write(e.getMessage());
	}	
%>