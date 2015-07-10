package mapper;

import java.util.List;
import java.util.Map;

public interface TaskMapper {

	public List getTaskList(Map param);
	
	public Map getExecutorByTaskId(Map param);
	
	public List getUserList();
	
	public Map getTaskById(Map param);
	
	public Map getUserById(Map param);
	
	public Integer updateTaskStatus(Map param);
	
	public Integer insertProcess(Map param);
	
	public Integer insertTask(Map param);
}
