package ajaxservice;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.MailService;
import database.ModelService;
import entity.Model;
import entity.User;
import service.GetLoginUserService;
import util.Util;
import sun.misc.BASE64Decoder;  

/**
 * �޸�ģ�͡�
 *
 */
public class ModifyModelAjax extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException{
		
		User user = GetLoginUserService.service(req);
		if(user == null){
			return;
		}
		
		String modelID = req.getParameter("modelID");
		String modelfile = req.getParameter("modelfile");
		String modelname = req.getParameter("modelname");
		String length = req.getParameter("length");
		String width = req.getParameter("width");
		String height = req.getParameter("height");
		String imagefiles = req.getParameter("imagefiles");
		String style = req.getParameter("style");
		String description = req.getParameter("description");
		String oldimagefiles = req.getParameter("oldimagefiles");
		
		if(Util.isEmpty(imagefiles) && Util.isEmpty(oldimagefiles)){
			return;
		}
		
		if(Util.isEmpty(modelID) || Util.isEmpty(modelname) || Util.isEmpty(length)
				|| Util.isEmpty(width) || Util.isEmpty(height)
				|| Util.isEmpty(style) || Util.isEmpty(description)){
			return;
		}
		
		int modelIDValue = -1;
		// ������Ƿ���ȷ
		float lengthValue = 0;
		float widthValue = 0;
		float heightValue = 0;
		try{
			modelIDValue = Integer.parseInt(modelID);
			lengthValue = Float.parseFloat(length);
			widthValue = Float.parseFloat(width);
			heightValue = Float.parseFloat(height);
			if(lengthValue < 0 || widthValue < 0 || heightValue < 0){
				return;
			}
		}catch(Exception e){
			return;
		}
		
		Model model = ModelService.getModelService().searchModelByID(modelIDValue);
		if(model == null || !"normal".equals(model.getStatus())){
			return;
		}
		if(!"manager".equals(user.getAuthority()) && user.getId() != model.getUser().getId()){
			return;
		}
		 
		// ����ģ���ı���Ϣ
		ModelService.getModelService().updateModelInformation(model.getId(), modelname, lengthValue, widthValue, heightValue, style, description);
		
		if(!Util.isEmpty(modelfile)){
			// ȥ��ͷ��
			int base64Index = modelfile.indexOf("base64,");
			modelfile = modelfile.substring(base64Index + "base64,".length());
			// ����ģ���ļ�
			BASE64Decoder decoder = new BASE64Decoder();
			byte[] decodedBytes = decoder.decodeBuffer(modelfile);
			Boolean modelFileSuccess = ModelService.getModelService().updateModelFile(model.getId(), decodedBytes);
			System.out.println(modelFileSuccess);
		}
		
		boolean removeImages[] = new boolean[model.getImageNumber()];
		for(int i=0; i<removeImages.length; i++){
			removeImages[i] = true;
		}
		if(!Util.isEmpty(oldimagefiles)){
			String[] oldimagestrs = oldimagefiles.split("\r\n");
			for(int i=0; i<oldimagestrs.length; i++){
				int indexValue = Integer.parseInt(oldimagestrs[i]);
				if(indexValue > 0 && indexValue <= removeImages.length){
					removeImages[indexValue-1] = false;
				} 
			}
		}
		for(int i=removeImages.length-1; i>=0; i--){
			System.out.println(i + ": " + removeImages[i]);
			if(removeImages[i]){
				Boolean success = ModelService.getModelService().deleteModelImage(model.getId(), i+1);
				System.out.println(success);
			}
		}
		
		if(!Util.isEmpty(imagefiles)){
			// ���ͼƬ��ʽ�Ƿ���ȷ������ȥ��base64ͷ��
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
			
			BASE64Decoder decoder = new BASE64Decoder();
			// ����ģ��ͼƬ
			for(int i=0; i<images.length; i++){
				Boolean imageSuccess = ModelService.getModelService().createModelImage(model.getId(), decoder.decodeBuffer(images[i]));
				System.out.println("image " + (i+1) + " create: " + imageSuccess);
			}
		}
		
		// 管理员修改了用户上传的模型，需要通知用户
		if("manager".equals(user.getAuthority()) && user.getId() != model.getUser().getId()){
			System.out.println("model changed");
			System.out.println("model name:" + model.getName());
			MailService.getMailService().addMail(user.getId(), model.getUser().getId(), "系统提示", "你所上传的模型【" + model.getName() + "】已被管理员修改。");
		}
		
		resp.getWriter().print(wrapJSON(true));
	}
	
	private String wrapJSON(boolean success){
		return "{" + Util.quotation("success") + ":" + success + "}";
	}

}
