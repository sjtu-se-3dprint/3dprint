package database;

import java.io.InputStream;
import java.util.List;

import entity.Model;


public interface ModelServiceInterface {

	// 查询模型
	public Model searchModelByID(int id);
	public List<Model> searchModelsByUserStatus(int userID, String status);
	public List<Model> searchModelsSort(String style, String status, String candown, String sort);
	
	// 创建模型
	public Model createModel(int userID, String name);
	 
	// 更新模型文本信息、文件、图片
	public Boolean updateModelInformation(int id, String name, float length, float width,
			float height, String style, String description);
	public Boolean updateModelFile(int id, byte[] file);
	
	public Boolean createModelImage(int id, byte[] image);
	public Boolean deleteModelImage(int id, int number);
	
	// 修改模型状态
	public Boolean updateModelStatus(int id, String status);
	
	// 获取模型图片
	public InputStream readModelImage(int id, int number);
	
	public InputStream readModelFile(int id);
}
