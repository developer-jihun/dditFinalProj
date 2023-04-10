package com.web.ddentist.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

public class PatientAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {

		String rememberId = request.getParameter("rememberId");
		if(rememberId != null && rememberId.equals("Y")) {
			Cookie cookie = new Cookie("rememberId", AesEncryptionUtil.encrypt(request.getParameter("ptId")));
			cookie.setMaxAge(604800);
			cookie.setPath("/ddit");
			response.addCookie(cookie);
		} else {
			Cookie[] cookies = request.getCookies();
			if(cookies != null) {
				for(Cookie cookie : cookies) {
					if(cookie.getName().equals("rememberId")) {
						cookie.setMaxAge(0);
						cookie.setPath("/ddit");
						response.addCookie(cookie);
					}
				}
			}
		}

		response.sendRedirect("/ddit");
	}
}
