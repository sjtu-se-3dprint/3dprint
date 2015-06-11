package mapper;

import java.util.List;
import java.util.Map;

public interface UserMapper {

	/**
	 * 根据用户名查找用户
	 * @param map
	 * @return
	 */
	public Map findUserByName(Map map);
	
	/**
	 * 根据用户Id查找用户
	 * @param map
	 * @return
	 */
	public Map findUserById(Map map);
	
	/**
	 * 根据用户Id删除用户
	 * @param map
	 * @return
	 */
	public Integer removeUserById(Map map);
	
	/**
	 * 根据用户Id恢复用户
	 * @param map
	 * @return
	 */
	public Integer resumeUserById(Map map);
	
	/**
	 * 添加一个用户
	 * @param map
	 * @return
	 */
	public Integer addPlainUser(Map map);
	
	/**
	 * 根据用户Id查找其所有的权限
	 * @param map
	 * @return
	 */
	public List findUserRolesByUserId(Map map);
	
	/**
	 * 为用户添加角色
	 * @param map
	 * @return
	 */
	public Integer addRoleForUser(Map map);

	/**
	 * 查找用户权限只为User的用户
	 * @param param
	 * @return
	 */
	public List queryPlainUserList(Map param);
	
	/**
	 * 修改用户信息
	 * @param param
	 * @return
	 */
	public Integer modifyUserInfo(Map param);
	
	/**
	 * 修改用户密码
	 * @param param
	 * @return
	 */
	public Integer modifyPassword(Map param);
}
