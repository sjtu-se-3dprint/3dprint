package service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mapper.TaskMapper;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import service.TaskService;

@Service("taskServiceImpl")
public class TaskServiceImpl implements TaskService{

	@Resource(name = "taskMapper")
	TaskMapper taskMapper;
	
	public List getTaskList(Map param) {
		List<Map> taskList = taskMapper.getTaskList(param); 
		if(taskList != null && "正在进行中".equals(param.get("task_status"))){
			for(Map item : taskList){
				Map executor = taskMapper.getExecutorByTaskId(item);
				if(executor != null){
					item.put("executor", executor);
				}
			}
		}
		return taskList;
	}

	public List getUserList(Map param) {
		return taskMapper.getUserList();
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public Boolean pickTask(Map param) throws Exception {
		Map task = taskMapper.getTaskById(param);
		Map user = new HashMap();
		user.put("user_id", param.get("executor_id"));
		user = taskMapper.getUserById(user);
		if(task == null || user == null){
			return false;
		}
		System.out.println(task);
		System.out.println(user);
		
		if(!"未处理".equals(task.get("task_status"))){
			throw new Exception("该任务已在处理中");
		}
		
		Map taskStatusMap = new HashMap();
		taskStatusMap.put("task_id", task.get("task_id"));
		taskStatusMap.put("task_status_old", task.get("task_status"));
		taskStatusMap.put("task_status_new", "正在进行中");
		if(1 != taskMapper.updateTaskStatus(taskStatusMap)){
			throw new Exception("领取任务失败");
		}
		
		Map processMap = new HashMap();
		processMap.put("task_id", task.get("task_id"));
		processMap.put("user_id", user.get("user_id"));
		processMap.put("process_duration", param.get("process_duration"));
		if(1 != taskMapper.insertProcess(processMap)){
			throw new Exception("领取任务失败");
		}
		
		return true;
	}

	public Boolean publishTask(Map param) throws Exception {

		if(1 != taskMapper.insertTask(param)){
			throw new Exception("发布任务失败");
		}
		return true;
	}

}
