package controller;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import service.TaskService;

@Controller
@RequestMapping("/task")
public class TaskController extends BaseController {

	@Resource(name = "taskServiceImpl")
	TaskService taskServiceImpl;

	@RequestMapping(value = "/listTask.ajax", method = RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public Map listTask(@RequestBody Map param) {                 
		try {
			return initResult(true, taskServiceImpl.getTaskList(param));
		} catch (Exception e) {
			e.printStackTrace();
			return initResult(false, e.getMessage(), "");
		}
	}
	
	@RequestMapping(value = "/listUser.ajax", method = RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public Map listUser(@RequestBody Map param) {                 
		try {
			return initResult(true, taskServiceImpl.getUserList(param));
		} catch (Exception e) {
			e.printStackTrace();
			return initResult(false, e.getMessage(), "");
		}
	}
	
	@RequestMapping(value = "/startTask.ajax", method = RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public Map startTask(@RequestBody Map param) {                 
		try {
			return initResult(true, taskServiceImpl.pickTask(param));
		} catch (Exception e) {
			e.printStackTrace();
			return initResult(false, e.getMessage(), "");
		}
	}
	
	@RequestMapping(value = "/publishTask.ajax", method = RequestMethod.POST, consumes = "application/json")
	@ResponseBody
	public Map publishTask(@RequestBody Map param) {                 
		try {
			return initResult(true, taskServiceImpl.publishTask(param));
		} catch (Exception e) {
			e.printStackTrace();
			return initResult(false, e.getMessage(), "");
		}
	}
}
