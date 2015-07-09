package service.impl;

import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

@Repository
@Service("myUserDetailsService")
public class MyUserDetailsService implements UserDetailsService {

	public UserDetails loadUserByUsername(final String username)
			throws UsernameNotFoundException {


		return new User(username, "pass", true, true,
				true, true, null);

	}

}