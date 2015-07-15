package service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import mapper.ModelMapper;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import service.ModelService;
import service.UserService;

@Service("modelServiceImpl")
public class ModelServiceImpl implements ModelService {

	// 模型文件上传的临时文件夹，用户选择模型文件后，立即上传到此文件夹
	private static String MODEL_TEMP_PATH = "/upload-files/temp/model/";

	// 模型文件上传的swap文件夹，这是org.apache.commons.fileupload要求设置的，为了减少内存的使用
	private static String MODEL_SWAP_PATH = "/upload-swap-files/";

	// 模型文件上传的正式文件夹
	private static String MODEL_FILE_PATH = "/upload-files/model/";

	@Resource(name = "userServiceImpl")
	UserService userService;

	@Resource(name = "modelMapper")
	ModelMapper modelMapper;

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
				if (sizeInBytes > 1024 * 1024 * 101) { // 限制大小
					throw new Exception("不支持上传100MB以上的模型文件");
				}

				// 写入到临时文件夹里面去
				File uploadedFile = new File(folder + "/" + curr);
				item.write(uploadedFile);
			}
		}
		return curr + "";
	}

	public List totalModelType(Map param) {
		List modelTypeList = modelMapper.getTotalModelType(param);
		return modelTypeList;
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public Boolean uploadModel(Map param) throws Exception {

		Map me = userService.myInfo(null);

		if (me == null) {
			throw new Exception("请登录后再上传模型");
		}

		// 
		List<String> model_images = (List) param.get("model_images");
		int image_index = model_images.size();
		String image_name = "";
		for (int i = 0; i < image_index; image_name += i++ + ";") {
		}
		param.put("image_name", image_name);
		param.put("image_index", image_index);
		param.put("user_id", me.get("user_id"));

		if (1 != modelMapper.insertModel(param) || null == param.get("model_id")) {
			throw new Exception("上传模型失败");
		}

		String folder = param.get("real_path") + MODEL_FILE_PATH + "/"
				+ param.get("model_id");
		util.Util.createFolder(folder);

		// 解码，写入文件系统
		Base64 decoder = new Base64();
		String flag = "base64,";
		int index = 0;
		for (String base64Image : model_images) {
			int location = base64Image.indexOf(flag);
			if (location < 0) {
				continue;
			}
			base64Image = base64Image.substring(location + flag.length());
			byte[] bytes = decoder.decode(base64Image);
			FileOutputStream os = new FileOutputStream(folder + "/"
					+ index++ + ".jpg");
			os.write(bytes);
			os.close();
		}

		return true;
	}

}
