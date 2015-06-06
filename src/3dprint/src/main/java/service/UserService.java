package service;

import java.util.List;
import java.util.Map;

public interface UserService {

	/**
	 * 查出权限只为User的用户
	 * @param param
	 * @return
	 */
	public List queryPlainUserList(Map param);
	
	/**
	 * 删除一个用户（根据Id）
	 * @param param
	 * @return
	 * @throws Exception 
	 */
	public Boolean removePlainUser(Map param) throws Exception;
	
	/**
	 * 恢复一个用户（根据Id）
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
}
