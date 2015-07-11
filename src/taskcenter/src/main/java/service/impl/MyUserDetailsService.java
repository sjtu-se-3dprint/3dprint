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
		param.put("user_account", username);
		Map user = userMapper.findUserByAccount(param);
		if (user == null) {
			throw new UsernameNotFoundException("User not found");
		}

		Set<GrantedAuthority> setAuths = new HashSet<GrantedAuthority>();
		setAuths.add(new SimpleGrantedAuthority("ROLE_USER"));
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>(
				setAuths);

		return new User(username, (String)user.get("user_password"), true, true, true, true, authorities);

	}

}