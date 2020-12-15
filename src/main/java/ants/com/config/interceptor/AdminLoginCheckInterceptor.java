package ants.com.config.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AdminLoginCheckInterceptor extends HandlerInterceptorAdapter {
	// Controller 진입 전에 수행하는 메서드
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		
		// 정적 자원 요청인 경우 Interceptor 예외 처리한다.
		String requestUrl = request.getRequestURL().toString(); 
		if(requestUrl.contains("/resources")){ 
		      return true;
		}
		
		if(session.getAttribute("SADMIN") == null) {
			// 로그인 페이지로 이동한다. 
			response.sendRedirect("/admin/adloginView");
			return false;
		}
		//  true인 경우 다음 interceptor를 호출하고 없으면 controller를 호출한다. 
		// false인 경우 : 요청 처리를 멈춘다.
		return true;
	}
	
	// Controller 진입 후에 수행하는 메서드
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
	}
	
	// Controller와 View의 표현까지 끝난 후에 실행되는 메서드..
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		super.afterCompletion(request, response, handler, ex);
	}
	
}
