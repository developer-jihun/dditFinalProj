package com.web.ddentist.security;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.HandlerInterceptor;

public class AuthInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(auth.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_EMP"))) {
			request.getSession().invalidate();
			response.sendRedirect("/ddit");
			return false;
		}
		
		return true;
	}
	
}
