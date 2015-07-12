package ajaxservice;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.InputStream;

import util.Util;
import database.LessonService;
import database.UserService;

public class LessonImageAjax extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException{
		
		String detailID = req.getParameter("detailID");
		if(Util.isEmpty(detailID)){
			return;
		}
		
		InputStream reader = LessonService.getModelService().readImage(Integer.parseInt(detailID));
		
		if(reader != null){
			byte[] bytes = new byte[1024];
			int count = 0;
			while((count = reader.read(bytes)) != -1){
				resp.getOutputStream().write(bytes, 0, count);
			}
		}
	}
}