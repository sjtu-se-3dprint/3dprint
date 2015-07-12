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
 * ÏÂÔØÄ£ÐÍ¡£
 */
public class DownloadModelAjax extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException{
		
		String modelID = req.getParameter("modelID");
		if(Util.isEmpty(modelID)){
			return;
		}
		
		resp.setContentType("application/stl");
		resp.addHeader("Content-Disposition", "attachment; filename=modelfile_" + modelID + ".stl;");
		InputStream reader = ModelService.getModelService().readModelFile(Integer.parseInt(modelID));
		
		if(reader != null){
			byte[] bytes = new byte[1024];
			int count = 0;
			while((count = reader.read(bytes)) != -1){
				resp.getOutputStream().write(bytes, 0, count);
			}
		}
	}
}