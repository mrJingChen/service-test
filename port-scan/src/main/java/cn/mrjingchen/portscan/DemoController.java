package cn.mrjingchen.portscan;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * <p>Description: </p>
 * @author charles·chen
 * @version v0.1
 */
@RestController
@CrossOrigin(allowCredentials = "true", maxAge = 3600)
public class DemoController {
	
	/**
	 * {@link http://127.0.0.1:8080 }
	 * @version v0.1
	 * @param request
	 * @return
	 */
	@GetMapping
	public String demo(HttpServletRequest request){
		return String.format("%s:%s", request.getRemoteAddr(), request.getLocalPort());
	}
	
}
