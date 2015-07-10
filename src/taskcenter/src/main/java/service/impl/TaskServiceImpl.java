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
				item.put("process_status", "processing");
				Map executor = taskMapper.getExecutorByTaskId(item);
				if(executor != null){
					item.put("executor", executor);
				}
			}
		}else if(taskList != null && "已完成".equals(param.get("task_status"))){
			for(Map item : taskList){
				item.put("process_status", "finished");
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
			throw new Exception("找不到该任务或该执行人");
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

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public Boolean cancelTask(Map param) throws Exception {

		Map task = taskMapper.getTaskById(param);
		if(task == null || !"正在进行中".equals(task.get("task_status"))){
			throw new Exception("找不到该任务或该任务不处于状态“正在进行中”");
		}
		
		Map executor = new HashMap();
		executor.put("task_id", task.get("task_id"));
		executor.put("process_status", "processing");
		executor = taskMapper.getExecutorByTaskId(executor);
		if(executor == null){
			throw new Exception("找不到该任务的原执行者");
		}
		
		Map processStatus = new HashMap();
		processStatus.put("process_id", executor.get("process_id"));
		processStatus.put("process_status_new", "cancelled");
		processStatus.put("process_status_old", "processing");
		if(1 != taskMapper.updateProcessStatus(processStatus)){
			throw new Exception("撤销任务失败");
		}
		
		Map taskStatus = new HashMap();
		taskStatus.put("task_id", task.get("task_id"));
		taskStatus.put("task_status_old", "正在进行中");
		taskStatus.put("task_status_new", "未处理");
		if(1 != taskMapper.updateTaskStatus(taskStatus)){
			throw new Exception("撤销任务失败");
		}
		
		System.out.println(task);
		return true;
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public Boolean delayTask(Map param) throws Exception {
		
		Map task = taskMapper.getTaskById(param);
		if(task == null || !"正在进行中".equals(task.get("task_status"))){
			throw new Exception("找不到该任务或该任务不处于状态“正在进行中”");
		}
		
		Map executor = new HashMap();
		executor.put("task_id", task.get("task_id"));
		executor.put("process_status", "processing");
		executor = taskMapper.getExecutorByTaskId(executor);
		if(executor == null){
			throw new Exception("找不到该任务的原执行者");
		}
		
		Map processDuration = new HashMap();
		processDuration.put("process_id", executor.get("process_id"));
		processDuration.put("process_duration", Integer.parseInt("" + executor.get("process_duration")) + Integer.parseInt("" + param.get("delay_days")));
		if(1 != taskMapper.updateProcessDuration(processDuration)){
			throw new Exception("申请延期失败");
		}
		
		return true;
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public Boolean endTask(Map param) throws Exception {
		
		Map task = taskMapper.getTaskById(param);
		if(task == null || !"正在进行中".equals(task.get("task_status"))){
			throw new Exception("找不到该任务或该任务不处于状态“正在进行中”");
		}
		
		Map executor = new HashMap();
		executor.put("task_id", task.get("task_id"));
		executor.put("process_status", "processing");
		executor = taskMapper.getExecutorByTaskId(executor);
		if(executor == null){
			throw new Exception("找不到该任务的原执行者");
		}
		
		Map processStatus = new HashMap();
		processStatus.put("process_id", executor.get("process_id"));
		processStatus.put("process_status_new", "finished");
		processStatus.put("process_status_old", "processing");
		if(1 != taskMapper.updateProcessStatus(processStatus)){
			throw new Exception("提交失败");
		}
		
		Map taskStatus = new HashMap();
		taskStatus.put("task_id", task.get("task_id"));
		taskStatus.put("task_status_old", "正在进行中");
		taskStatus.put("task_status_new", "已完成");
		if(1 != taskMapper.updateTaskStatus(taskStatus)){
			throw new Exception("提交失败");
		}
		
		return true;
	}

}
