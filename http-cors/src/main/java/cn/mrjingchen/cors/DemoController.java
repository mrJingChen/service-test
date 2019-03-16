package cn.mrjingchen.cors;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * <p>Description: 测试页</p>
 * 不能设置"/"请求路径，会拦截到static下静态资源
 * @author charles·chen
 * @version v0.1
 */
@Controller
public class DemoController {

	@GetMapping("demo")
	public String demo(HttpServletRequest request, Map<String, Object> map) {
		StringBuffer url = request.getRequestURL();
		String protocolIp = url.substring(0, url.indexOf(request.getRequestURI()));
		map.put("protocolIp", protocolIp + request.getContextPath());
		return "index";
	}
	
}
