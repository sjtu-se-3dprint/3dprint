package service;

import java.util.List;
import java.util.Map;

public interface UserService {

	/**
	 * 查出自己的用户信息
	 * @param param
	 * @return
	 */
	public Map myInfo(Map param);
	

	/**
	 * 修改用户自己的信息
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Boolean modifyInfo(Map param) throws Exception;
	
	/**
	 * 查出权限只为User的用户
	 * @param param
	 * @return
	 */
	public List queryPlainUserList(Map param);
	
	/**
	 * 删除一个用户（user_id）
	 * @param param
	 * @return
	 * @throws Exception 
	 */
	public Boolean removePlainUser(Map param) throws Exception;
	
	/**
	 * 恢复一个用户（user_id）
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Boolean resumePlainUser(Map param) throws Exception;

	/**
	 * 增加一个用户（username、password）
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Boolean addPlainUser(Map param) throws Exception;
	
	/**
	 * 新用户名是否可用（username）
	 * @param param
	 * @return
	 */
	public Boolean isUsernameValid(Map param);
	
	/**
	 * 上传用户头像，储存到文件系统
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Boolean modifyUserhead(Map param) throws Exception;
}
