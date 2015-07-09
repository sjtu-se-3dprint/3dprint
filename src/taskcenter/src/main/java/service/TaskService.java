package service;

import java.util.List;
import java.util.Map;

public interface TaskService {

	public List getTaskList(Map param);
	public List getUserList(Map param);
	public Boolean pickTask(Map param) throws Exception;
	public Boolean publishTask(Map param) throws Exception;
}
