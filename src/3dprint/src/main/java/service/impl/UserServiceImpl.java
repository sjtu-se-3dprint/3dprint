package service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import mapper.UserMapper;

import org.apache.commons.codec.binary.Base64;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
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

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public Boolean removePlainUser(Map param) throws Exception {

		param.put("status", "normal");
		Map user = userMapper.findUserById(param);

		if (user == null) {
			throw new Exception("删除失败，未找到该用户。");
		}

		user.put("authentication_status", "normal");
		List<Map> roles = userMapper.findUserRolesByUserId(user);
		for (Map role : roles) {
			if (role != null && !"ROLE_USER".equals(role.get("user_role_name"))) {
				throw new Exception("删除失败，你没有权限删除该用户。");
			}
		}

		Integer row = userMapper.removeUserById(user);
		if (row == null || row != 1) {
			throw new Exception("删除失败，系统错误，请重试。");
		}

		return true;
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public Boolean resumePlainUser(Map param) throws Exception {

		param.put("status", "deleted");
		Map user = userMapper.findUserById(param);

		if (user == null) {
			throw new Exception("恢复失败，未找到被删除的该用户。");
		}

		user.put("authentication_status", "normal");
		List<Map> roles = userMapper.findUserRolesByUserId(user);
		for (Map role : roles) {
			if (role != null && !"ROLE_USER".equals(role.get("user_role_name"))) {
				throw new Exception("恢复失败，你没有权限恢复该用户。");
			}
		}

		Integer row = userMapper.resumeUserById(user);
		if (row == null || row != 1) {
			throw new Exception("恢复失败，系统错误，请重试。");
		}

		if (param.get("rollback") != null && (Boolean) param.get("rollback")) {
			throw new Exception("抛出异常，事务回滚。");
		}

		return true;
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public Boolean addPlainUser(Map param) throws Exception {

		Map user = userMapper.findUserByName(param);
		if (user != null) {
			throw new Exception("添加用户失败，该用户名已被占用。");
		}

		Integer row = userMapper.addPlainUser(param);
		if (row == null || row != 1 || param.get("user_id") == null) {
			throw new Exception("添加用户失败，该用户名已被占用。");
		}

		param.put("user_role_name", "ROLE_USER");
		row = userMapper.addRoleForUser(param);

		if (row == null || row != 1) {
			throw new Exception("创建用户角色时发生错误。");
		}

		return true;
	}

	public Boolean isUsernameValid(Map param) {
		Map user = userMapper.findUserByName(param);
		return user == null;
	}

	public Map myInfo(Map param) {

		UserDetails userDetails = (UserDetails) SecurityContextHolder
				.getContext().getAuthentication().getPrincipal();

		if (userDetails == null || userDetails.getUsername() == null) {
			return null;
		}

		param = new HashMap();
		param.put("name", userDetails.getUsername());
		param.put("status", "normal");

		Map user = userMapper.findUserByName(param);
		user.remove("password");
		user.remove("status");

		return user;
	}

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public Boolean modifyInfo(Map param) throws Exception {
		Map user = myInfo(null);
		if (user == null) {
			throw new Exception("你还没有登录。");
		}

		param.put("user_id", user.get("user_id"));
		Integer rows = userMapper.modifyUserInfo(param);
		if (rows == null || rows != 1) {
			throw new Exception("修改资料失败！");
		}

		return true;
	}

	public Boolean modifyUserhead(Map param) throws Exception {

		Map user = myInfo(null);
		if (user == null) {
			throw new Exception("你还没有登录。");
		}

		// 获取3中格式的头像（base64的字符串）
		String largeImg = (String) param.get("largeImg");
		String midImg = (String) param.get("midImg");
		String smallImg = (String) param.get("smallImg");

		if (largeImg == null || midImg == null || smallImg == null) {
			throw new Exception("头像格式不对！");
		}

		String pngHeader = "data:image/png;base64,";
		if (largeImg.indexOf(pngHeader) != 0 || midImg.indexOf(pngHeader) != 0
				|| smallImg.indexOf(pngHeader) != 0) {
			throw new Exception("头像格式不对！");
		}

		// 去掉base64字符串中的header
		largeImg = largeImg.substring(pngHeader.length());
		midImg = midImg.substring(pngHeader.length());
		smallImg = smallImg.substring(pngHeader.length());
		
		// 进行解码
		Base64 decoder = new Base64();
		byte[] largeBytes = decoder.decode(largeImg);
		byte[] midBytes = decoder.decode(midImg);
		byte[] smallBytes = decoder.decode(smallImg);

		// 获取工程目录，然后创建好图片保存地址的文件夹
		String realPath = (String) param.get("realPath");
		String imagePath = realPath + "\\image";
		File file = new File(imagePath);
		if(!file.isDirectory()){
			file.mkdir();
		}
		String userheadPath = imagePath + "\\userhead";
		file = new File(userheadPath);
		if(!file.isDirectory()){
			file.mkdir();
		}
		String userPath = userheadPath + "\\" + user.get("user_id");
		file = new File(userPath);
		if(!file.isDirectory()){
			file.mkdir();
		}
		
		// 把图片写入文件系统
		FileOutputStream largeFos = new FileOutputStream(userPath + "\\large.png");
		FileOutputStream midFos = new FileOutputStream(userPath + "\\mid.png");
		FileOutputStream smallFos = new FileOutputStream(userPath + "\\small.png");
		largeFos.write(largeBytes);
		midFos.write(midBytes);
		smallFos.write(smallBytes);
		largeFos.close();
		midFos.close();
		smallFos.close();
		
		return true;
	}

}
