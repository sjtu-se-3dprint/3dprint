package ajaxservice;

import java.io.IOException;
import java.util.ArrayList;

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

/**
 * ɾ��ģ�͡�
 */
public class DeleteModelsAjax extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException{
		
		// ����û��Ƿ��Ѿ���¼
		User user = GetLoginUserService.service(req);
		if(user == null){
			return;
		}

		String modelIDs = req.getParameter("modelIDs");
		if(Util.isEmpty(modelIDs)){
			return;
		}
		modelIDs = new String(modelIDs.getBytes("ISO-8859-1"), "UTF-8");
		
		String[] idStrs = modelIDs.split(";");
		ArrayList<Integer> ids = new ArrayList<Integer>();
		for(int i=0; i<idStrs.length; i++){
			ids.add(Integer.parseInt(idStrs[i]));
		}
		
		Integer successCount = 0;
		System.out.println(ids);
		if("manager".equals(user.getAuthority())){ // ����Աɾ��ģ�ͣ������ơ�
			for(Integer id: ids){
				Model model = ModelService.getModelService().searchModelByID(id);
				boolean success = ModelService.getModelService().updateModelStatus(id, "deleted");
				if(success){
					successCount += 1;
					MailService.getMailService().addMail(user.getId(), model.getUser().getId(), "系统提示", "你所上传的模型【" + model.getName() + "】已被管理员删除。");
				}
			}
		}else{ // �û�ɾ��ģ�ͣ�ֻ��ɾ���Լ��ϴ���ģ�͡�
			for(Integer id: ids){
				Model model = ModelService.getModelService().searchModelByID(id);
				System.out.println(model.getName());
				if(model == null || model.getUser().getId() != user.getId()){
					continue;
				}
				successCount += ModelService.getModelService().updateModelStatus(id, "deleted")?1:0;
			}
		}

		resp.getWriter().print(wrapJSON(successCount));
	}
	
	private String wrapJSON(int successCount){
		return "{" + Util.quotation("successCount") + ":" + successCount + "}";
	}
}
