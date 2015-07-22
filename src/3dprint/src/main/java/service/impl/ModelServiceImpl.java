package service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import mapper.ModelMapper;

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

	// 模型预览图片的文件夹
	private static String MODEL_IMAGE_PATH = "/image/model/";

	// 模型图片后缀
	private static String MODEL_IMAGE_SUFFIX = ".jpg";

	// 模型文件后缀
	private static String MODEL_FILE_SUFFIX = ".stl";

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

		// 插入到数据库
		List<String> model_images = (List) param.get("model_images");
		int image_index = model_images.size();
		String image_name = "";
		for (int i = 0; i < image_index; image_name += i++ + ";") {
		}
		param.put("image_name", image_name);
		param.put("image_index", image_index);
		param.put("user_id", me.get("user_id"));

		if (1 != modelMapper.insertModel(param)
				|| null == param.get("model_id")) {
			throw new Exception("上传模型失败");
		}

		// 获取存放模型图片的文件夹
		String realPath = (String) param.get("real_path");
		String imageFolder = realPath + MODEL_IMAGE_PATH + "/"
				+ param.get("model_id");
		util.Util.createFolder(imageFolder);

		// 解码图片，写入文件系统
		int index = 0;
		for (String base64Image : model_images) {
			util.Util.decodeBase64ImageAndSave(base64Image, imageFolder + "/"
					+ index++ + MODEL_IMAGE_SUFFIX);

		}

		// 把以前上传的模型文件从临时文件夹拷贝到正式文件夹下
		String tempFilePath = realPath + MODEL_TEMP_PATH + me.get("user_id")
				+ "/" + param.get("model_file_seq");
		String newFileFolder = realPath + MODEL_FILE_PATH
				+ param.get("model_id") + "/";
		String newFilePath = newFileFolder + param.get("model_id")
				+ MODEL_FILE_SUFFIX;
		util.Util.createFolder(newFileFolder);
		util.Util.copyFile(tempFilePath, newFilePath);

		return true;
	}

	public Map myModels(Map param) throws Exception {

		Map me = userService.myInfo(null);
		if (me == null) {
			throw new Exception("请先登录");
		}

		// 检查参数正确性
		int page = Integer.parseInt("" + param.get("page"));
		int amount = Integer.parseInt("" + param.get("amount"));
		if (page <= 0 || amount <= 0) {
			return null;
		}

		// 查出总共有多少个模型
		Map modelParam = new HashMap();
		modelParam.put("user_id", me.get("user_id"));
		modelParam.put("status", "normal");
		Integer total = modelMapper.countModelsByUserId(modelParam);
		if (total == null || total <= 0) {
			return null;
		}

		// 再次检查参数正确性
		if ((page - 1) * amount >= total) {
			return null;
		}

		modelParam.put("limit_from", (page - 1) * amount);
		modelParam.put("limit_to", amount);
		List models = modelMapper.findModelsByUserId(modelParam);
		generateImagesPathForModel(models);

		Map modelInfo = new HashMap();
		modelInfo.put("models", models);
		modelInfo.put("page", page);
		modelInfo.put("total", total);

		return modelInfo;
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public Boolean deleteMyModel(Map param) throws Exception {

		Map me = userService.myInfo(null);
		if (me == null) {
			throw new Exception("请先登录");
		}

		// 找出模型
		Map model = new HashMap();
		model.put("model_id", param.get("model_id"));
		model.put("status", "normal");
		model = modelMapper.findModelById(model);
		if (model == null) {
			throw new Exception("找不到该模型");
		}

		// 删除者不是上传者
		if (Integer.parseInt("" + model.get("user_id")) != Integer.parseInt(""
				+ me.get("user_id"))) {
			throw new Exception("你无权限删除此模型");
		}

		// 删除模型
		Map modelStatusMap = new HashMap();
		modelStatusMap.put("model_id", model.get("model_id"));
		modelStatusMap.put("old_status", model.get("status"));
		modelStatusMap.put("new_status", "deleted");
		if (1 != modelMapper.updateModelStatusById(modelStatusMap)) {
			throw new Exception("删除模型失败");
		}

		return true;
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public Boolean editModel(Map param) throws Exception {

		Map me = userService.myInfo(null);
		if (me == null) {
			throw new Exception("请先登录");
		}

		// 找出模型
		Map model = new HashMap();
		model.put("model_id", param.get("model_id"));
		model.put("status", "normal");
		model = modelMapper.findModelById(model);
		if (model == null) {
			throw new Exception("找不到该模型");
		}

		// 修改者不是上传者
		if (Integer.parseInt("" + model.get("user_id")) != Integer.parseInt(""
				+ me.get("user_id"))) {
			throw new Exception("你无权限修改此模型");
		}

		// 整理模型的图片变化信息
		int image_index = Integer.parseInt("" + model.get("image_index"));
		String image_name = "";
		List<Map> modelImages = (List) param.get("model_images");
		for (Map modelImage : modelImages) {
			if (modelImage == null) {
				continue;
			}
			if ("new".equals(modelImage.get("type"))) {
				image_name += image_index++ + ";";
			} else if ("origin".equals(modelImage.get("type"))) {
				image_name += modelImage.get("index") + ";";
			}
		}

		// 保存修改到数据库
		Map modelChanged = new HashMap();
		modelChanged.put("model_id", model.get("model_id"));
		modelChanged.put("model_description", param.get("model_description"));
		modelChanged.put("image_name", image_name);
		modelChanged.put("image_index", image_index);
		if (1 != modelMapper.updateModelById(modelChanged)) {
			throw new Exception("编辑模型失败");
		}

		// 获取存放模型图片的文件夹
		String realPath = (String) param.get("real_path");
		String imageFolder = realPath + MODEL_IMAGE_PATH + "/"
				+ param.get("model_id");
		util.Util.createFolder(imageFolder);

		// 保存新增的图片到文件系统
		image_index = Integer.parseInt("" + model.get("image_index"));
		for (Map modelImage : modelImages) {
			if (modelImage == null || !"new".equals(modelImage.get("type"))) {
				continue;
			}
			util.Util.decodeBase64ImageAndSave((String) modelImage.get("data"),
					imageFolder + "/" + image_index++ + MODEL_IMAGE_SUFFIX);
		}

		return true;
	}

	public Map findModelById(Map param) throws Exception {
		param.put("status", "normal");
		Map model = modelMapper.findModelById(param);
		generateImagesPathForModel(model);
		return model;
	}

	private void generateImagesPathForModel(List<Map> models) throws Exception {
		for (Map model : models) {
			generateImagesPathForModel(model);
		}
	}

	/**
	 * 为模型配好图片路径
	 * 
	 * @param model
	 * @throws Exception
	 */
	private void generateImagesPathForModel(Map model) throws Exception {
		if (model != null && model.get("image_name") != null) {
			String imageName = (String) model.get("image_name");
			String[] images = imageName.split(";");
			List<String> model_images = new ArrayList<String>();
			for (String image : images) {
				if ("".equals(image)) {
					continue;
				}
				model_images.add(MODEL_IMAGE_PATH + model.get("model_id") + "/"
						+ image + MODEL_IMAGE_SUFFIX);
			}
			model.put("model_images", model_images);
		}
	}

	public String countCollections(Map param)
	{
		Map result = modelMapper.countCollectionsByModelId(param);
		return result.get("collections").toString();
	}
}
