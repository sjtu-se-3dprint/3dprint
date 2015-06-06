package service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mapper.UserMapper;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import service.UserService;

@Service("userServiceImpl")
public class UserServiceImpl implements UserService {

	@Resource(name = "userMapper")
	UserMapper userMapper;
	
	public List queryPlainUserList(Map param) {
		param.put("authentication_status", "normal");
		param.put("user_role_status", "normal");
		List user = userMapper.queryPlainUserList(param);
		return user;
	}

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public Boolean removePlainUser(Map param) throws Exception {
		
		param.put("status", "normal");
		Map user = userMapper.findUserById(param);
		
		if(user == null){
			throw new Exception("删除失败，未找到该用户。");
		}
		
		user.put("authentication_status", "normal");
		List<Map> roles = userMapper.findUserRolesByUserId(user);
		for(Map role :roles){
			if(role != null && !"ROLE_USER".equals(role.get("user_role_name"))){
				throw new Exception("删除失败，你没有权限删除该用户。");
			}
		}
		
		Integer row = userMapper.removeUserById(user);
		if(row == null || row != 1){
			throw new Exception("删除失败，系统错误，请重试。");
		}
		
		return true;
	}

	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public Boolean resumePlainUser(Map param) throws Exception {

		param.put("status", "deleted");
		Map user = userMapper.findUserById(param);
		
		if(user == null){
			throw new Exception("恢复失败，未找到被删除的该用户。");
		}

		user.put("authentication_status", "normal");
		List<Map> roles = userMapper.findUserRolesByUserId(user);
		for(Map role :roles){
			if(role != null && !"ROLE_USER".equals(role.get("user_role_name"))){
				throw new Exception("恢复失败，你没有权限恢复该用户。");
			}
		}
		
		Integer row = userMapper.resumeUserById(user);
		if(row == null || row != 1){
			throw new Exception("恢复失败，系统错误，请重试。");
		}
		
		if(param.get("rollback") != null && (Boolean)param.get("rollback")){
			throw new Exception("抛出异常，事务回滚。");
		}
		
		return true;
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public Boolean addPlainUser(Map param) throws Exception {

		Map user = userMapper.findUserByName(param);
		if(user != null){
			throw new Exception("添加用户失败，该用户名已被占用。");
		}
		
		Integer row = userMapper.addPlainUser(param);
		if(row == null || row != 1 || param.get("user_id")==null){
			throw new Exception("添加用户失败，该用户名已被占用。");
		}
		
		param.put("user_role_name", "ROLE_USER");
		row = userMapper.addRoleForUser(param);
		
		if(row == null || row != 1){
			throw new Exception("创建用户角色时发生错误。");
		}
		
		return true;
	}

}
