package service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import mapper.UserMapper;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

@Repository
@Service("myUserDetailsService")
public class MyUserDetailsService implements UserDetailsService {

	@Resource(name = "userMapper")
	UserMapper userMapper;

	public UserDetails loadUserByUsername(final String username)
			throws UsernameNotFoundException {

		// 查找用户、用户对应的角色
		Map param = new HashMap();
		param.put("name", username);
		param.put("status", "normal");
		Map user = userMapper.findUserByName(param);
		if (user == null) {
			throw new UsernameNotFoundException("User not found");
		}
		user.put("authentication_status", "normal");
		List<Map> roles = userMapper.findUserRolesByUserId(user);

		// 赋予用户对应的角色
		Set<GrantedAuthority> setAuths = new HashSet<GrantedAuthority>();
		for (Map roleMap : roles) {
			setAuths.add(new SimpleGrantedAuthority((String) roleMap
					.get("user_role_name")));
		}
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>(
				setAuths);

		return new User(username, (String) user.get("password"), true, true,
				true, true, authorities);

	}

}