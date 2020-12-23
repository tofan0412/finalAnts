<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

chatbot
APIGW Invoke URL - 	https://934b136eaf9d44b8b19dbf3855b804d6.apigw.ntruss.com/custom/v1/3717/7939af4c0f1ebe4049e933a07a667d0f58c0529cad7478808e6fabaec343492b
Secret Key - 		R1pPZ3dQaEJmbVFwZUx3eHZrTUlmUmV2S1NkUkRQWVM=

<h5>챗봇</h5>		
	
<script>
const HmacSHA256 = require('crypto-js/hmac-sha256');
const EncBase64 = require('crypto-js/enc-base64');
signatureHeader = HmacSHA256(requestBodyString, secretKey).toString(EncBase64);


$.ajax({ 
		method: "POST",
		url:"https://fhiqe86rd4.apigw.ntruss.com/send/localhost/",
		data:{ description : "ants" },
		headers:{ authorizerId : "" },
		success: function(data) {
			alert(data.description);
		}
	})
	
	
</script>

"version": "v2",
	"userId": "U47b00b58c90f8e47428af8b7bddcda3d",
	"userIp": "8.8.8.8",
	"timestamp": 12345678,
	"bubbles": [{
	"type": "text",
	"data" : { "description" : "postback text of welcome action" }}],
	"event": "open"