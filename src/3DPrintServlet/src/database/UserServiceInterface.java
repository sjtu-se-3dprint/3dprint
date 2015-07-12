package database;

import java.io.InputStream;
import java.util.List;

import entity.User;

public interface UserServiceInterface {

	// 查找用户。
	public User searchUserByID(int id);
	public User searchUserByName(String name);
	public List<User> searchUsersByAuthorityStatus(String authority, String status);
	
	// 创建普通用户、管理员
	public User createUser(String name, String password);
	public User createManager(String name, String password);
	
	// 更新用户信息、头像、密码
	public Boolean updateUserInformation(int id, String email, String telephone, String qq);
	public Boolean updateUserImage(int id, byte[] image);
	public Boolean updateUserPassword(int id, String oldpassword, String newpassword);
	
	// 修改用户状态
	public Boolean updateUserStatus(int id, String status);
	
	// 获取用户头像
	public InputStream readUserImage(int id);
	
}
