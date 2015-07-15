package service.impl;

import java.io.File;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.stereotype.Service;

import service.ModelService;
import service.UserService;

@Service("modelServiceImpl")
public class ModelServiceImpl implements ModelService {
	
	private static String MODEL_TEMP_PATH = "/upload-files/temp/model/"; 
	private static String MODEL_SWAP_PATH = "/upload-swap-files/";

	@Resource(name = "userServiceImpl")
	UserService userService;

	public String uploadTempModel(HttpServletRequest request) throws Exception {

		Map me = userService.myInfo(null);

		if (me == null) {
			throw new Exception("请登录后再上传模型");
		}
		
		// 项目部署的物理位置
		String realPath = request.getSession().getServletContext()
				.getRealPath("/");

		// 设置临时文件夹，内存不够时可能会用到
		String tempRepository = realPath + MODEL_SWAP_PATH;
		util.Util.createFolder(tempRepository);
		DiskFileItemFactory factory = new DiskFileItemFactory();
		File repository = new File(tempRepository);
		factory.setRepository(repository);

		// 解析请求，生成内存文件
		ServletFileUpload upload = new ServletFileUpload(factory);
		List<FileItem> items = upload.parseRequest(request);
		Iterator<FileItem> iter = items.iterator();

		// 保存到用户的临时上传文件中去
		String folder = realPath + MODEL_TEMP_PATH + me.get("user_id"); 
		util.Util.createFolder(folder);
		long curr = System.currentTimeMillis();
		if (iter.hasNext()) { // 只取第一个文件
			FileItem item = iter.next();
			if (item.isFormField()) { // 如果不是文件，则失败
				throw new Exception("上传失败");
			} else { // 是文件
				long sizeInBytes = item.getSize();
				if(sizeInBytes > 1024*1024*101){ // 限制大小
					throw new Exception("不支持上传100MB以上的模型文件");
				}
				
				// 写入到临时文件夹里面去
				File uploadedFile = new File(folder + "/" + curr);
				item.write(uploadedFile);
			}
		}
		return curr + "";
	}

}
