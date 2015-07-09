package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BaseController {

	public Map initResult(boolean success, List value){
		Map result = new HashMap();
		result.put("success", success);
		result.put("value", value);
		return result;
	}
	
	public Map initResult(boolean success, Map value){
		Map result = new HashMap();
		result.put("success", success);
		result.put("value", value);
		return result;
	}
	
	public Map initResult(boolean success, boolean value){
		Map result = new HashMap();
		result.put("success", success);
		result.put("value", value);
		return result;
	}
	
	public Map initResult(boolean success, String value){
		Map result = new HashMap();
		result.put("success", success);
		result.put("value", value);
		return result;
	}
	
	public Map initResult(boolean success, String message, List value){
		Map result = initResult(success, value);
		result.put("message", message);
		return result;
	}
	
	public Map initResult(boolean success, String message, Map value){
		Map result = initResult(success, value);
		result.put("message", message);
		return result;
	}
	
	public Map initResult(boolean success, String message, boolean value){
		Map result = initResult(success, value);
		result.put("message", message);
		return result;
	}
	
	public Map initResult(boolean success, String message, String value){
		Map result = initResult(success, value);
		result.put("message", message);
		return result;
	}
}
