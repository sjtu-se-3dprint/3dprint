package ajaxservice;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.InputStream;

import util.Util;
import database.ModelService;

/**
 * 获取模型图片。
 */
public class ModelImageAjax extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException{
		
		String modelID = req.getParameter("modelID");
		String number = req.getParameter("number");
		if(Util.isEmpty(modelID) || Util.isEmpty(number)){
			return;
		}
		
		InputStream reader = ModelService.getModelService().readModelImage(Integer.parseInt(modelID), Integer.parseInt(number));
		
		if(reader != null){
			byte[] bytes = new byte[1024];
			int count = 0;
			while((count = reader.read(bytes)) != -1){
				resp.getOutputStream().write(bytes, 0, count);
			}
		}
	}
}