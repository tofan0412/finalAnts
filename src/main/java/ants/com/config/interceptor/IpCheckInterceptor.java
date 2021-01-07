package ants.com.config.interceptor;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import ants.com.admin.model.IpVo;
import ants.com.admin.service.AdminService;

public class IpCheckInterceptor extends HandlerInterceptorAdapter {
	
	@Resource(name="adminService")
	AdminService adminService;
	
	// Controller 진입 전에 수행하는 메서드
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, 
			Object handler) throws Exception {
		
		// 정적 자원 요청인 경우 Interceptor 예외 처리한다.
		String requestUrl = request.getRequestURL().toString(); 
		if(requestUrl.contains("/resources")){ 
		      return true;
		}
		
		String ip = request.getHeader("X-FORWARDED-FOR");
		if (ip == null) ip = request.getRemoteAddr();
		
		String[] clientIpArr = ip.split("\\.");
		
		List<IpVo> ipList = adminService.getIpListcheck();
		
		int equalsCnt = 0;
		int factor = 0;
		for (int i = 0 ; i < ipList.size(); i++) {
			
			if(factor == 1) {
				break;	// 일치하는 IP를 찾았으므로, 더이상 찾을 필요가 없다.
			}
			
			String[] serverIpArr = ipList.get(i).getIpAddr().split("\\.");	// 반드시 4개이다.
			equalsCnt = 0;
			
			for (int j = 0 ; j < 4 ; j++) {
				if (clientIpArr[j].equals(serverIpArr[j]) || serverIpArr[j].equals("*")) {
					equalsCnt++;
					if (equalsCnt == 4) {
						factor = 1;
						break;
					}
				}
			}
		}
		
		if (factor == 1) {
		}
		
		if(factor != 1) {	// IP가 서버에 등록되지 않았다는 뜻이다. 
			response.sendRedirect("/member/blockView");
			return false;
		}
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
