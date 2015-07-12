package ajaxservice;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import database.LessonService;
import database.UserService;
import entity.User;
import service.GetLoginUserService;
import util.Util;

public class AddLessonNewAjax extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException { 

		User user = GetLoginUserService.service(req);
		if (user == null || !"admin".equals(user.getAuthority())) { 
			return;
		}

		String jsonStr = convertStreamToString(req.getInputStream());
		JSONObject obj = JSONObject.fromObject(jsonStr);
		System.out.println("addlesson:" + obj);
//		boolean success = LessonService.getModelService().addLesson(obj, user.getId());
		Integer id = LessonService.getModelService().addLessonNew(obj, user.getId());
		resp.getWriter().print(wrapJSON(id));
	}

	private String wrapJSON(Integer id) {
		return "{" + Util.quotation("success") + ":" + (id!=null) + "," + Util.quotation("id") + ":" + id +  "}";
	}

	public static String convertStreamToString(InputStream is) {
		BufferedReader reader = new BufferedReader(new InputStreamReader(is));
		StringBuilder sb = new StringBuilder();

		String line = null;
		try {
			while ((line = reader.readLine()) != null) {
				sb.append(line + "\n");
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				is.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		return sb.toString();
	}
}
