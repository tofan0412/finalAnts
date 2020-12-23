package ants.com.common.web;

import java.nio.charset.StandardCharsets;
import java.util.Base64;

import javax.crypto.Mac;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import javax.json.Json;
import javax.json.JsonObject;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.http.StreamingHttpOutputMessage.Body;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/bot")
@Controller
public class ChatBotController {
		
		
	@RequestMapping("/chatbot")
	public String chatbot() {
//		byte[] secretKeyBytes = SecretKey.getBytes(StandardCharsets.UTF_8);
//		SecretKeySpec secretKeySpec = new SecretKeySpec(secretKeyBytes, "HmacSHA256");
//		Mac mac = Mac.getInstance("HmacSHA256");
//		mac.init(secretKeySpec);
//		byte[] signature = mac.doFinal(Body.getBytes(StandardCharsets.UTF_8));
//		String signatureHeader = Base64.getEncoder().encodeToString(signature);
//		
		return "tiles/bot/chatbot";
	}
		
}
