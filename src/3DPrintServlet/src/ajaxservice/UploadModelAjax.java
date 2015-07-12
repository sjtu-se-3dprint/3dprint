package ajaxservice;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.ModelService;
import entity.Model;
import entity.User;
import service.GetLoginUserService;
import util.Util;
import sun.misc.BASE64Decoder;  

/**
 * 上传模型。
 *
 */
public class UploadModelAjax extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException{
		
		User user = GetLoginUserService.service(req);
		if(user == null){
			return;
		}
		
		String modelfile = req.getParameter("modelfile");
		String modelname = req.getParameter("modelname");
		String length = req.getParameter("length");
		String width = req.getParameter("width");
		String height = req.getParameter("height");
		String imagefiles = req.getParameter("imagefiles");
		String style = req.getParameter("style");
		String description = req.getParameter("description");
		
		if(Util.isEmpty(modelfile) || Util.isEmpty(modelname) || Util.isEmpty(length)
				|| Util.isEmpty(width) || Util.isEmpty(height) || Util.isEmpty(imagefiles)
				|| Util.isEmpty(style) || Util.isEmpty(description)){
			return;
		}

		// 检查规格是否正确
		float lengthValue = 0;
		float widthValue = 0;
		float heightValue = 0;
		try{
			lengthValue = Float.parseFloat(length);
			widthValue = Float.parseFloat(width);
			heightValue = Float.parseFloat(height);
			if(lengthValue < 0 || widthValue < 0 || heightValue < 0){
				return;
			}
		}catch(Exception e){
			return;
		}
		
		// 检查图片格式是否正确，并且去除base64头部
		String images[] = imagefiles.split("\r\n");
		if(images.length < 1){
			return;
		}
		for(int i=0; i<images.length; i++){
			if(images[i].indexOf("data:image") != 0){
				return;
			}
			int base64Index = images[i].indexOf("base64,");
			if(base64Index < 0){
				return;
			}
			images[i] = images[i].substring(base64Index + "base64,".length());
		}
		
		// 去除头部
		int base64Index = modelfile.indexOf("base64,");
		modelfile = modelfile.substring(base64Index + "base64,".length());
		
		// 创建模型
		Model model = ModelService.getModelService().createModel(user.getId(), modelname);
		if(model == null){
			resp.getWriter().print(wrapJSON(false));
			return;
		}
		
		// 更新模型文本信息
		ModelService.getModelService().updateModelInformation(model.getId(), modelname, lengthValue, widthValue, heightValue, style, description);
		
		// 更新模型文件
		BASE64Decoder decoder = new BASE64Decoder();
		byte[] decodedBytes = decoder.decodeBuffer(modelfile);
		Boolean modelFileSuccess = ModelService.getModelService().updateModelFile(model.getId(), decodedBytes);
		System.out.println("model file create: " + modelFileSuccess);
		
		// 更新模型图片
		for(int i=0; i<images.length; i++){
			Boolean imageSuccess = ModelService.getModelService().createModelImage(model.getId(), decoder.decodeBuffer(images[i]));
			System.out.println("image " + (i+1) + " create: " + imageSuccess);
		}
		
		resp.getWriter().print(wrapJSON(true));
	}
	
	private String wrapJSON(boolean success){
		return "{" + Util.quotation("success") + ":" + success + "}";
	}

}
