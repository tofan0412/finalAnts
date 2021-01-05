package ants.com.member.model;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

public class MemberVoValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return MemberVo.class.isAssignableFrom(clazz);
	}
	
	@Override
	public void validate(Object target, Errors errors) {
		MemberVo memberVo = (MemberVo)target;
		
		// memId 값이 null 이거나 empty 문자열이면 안됨
		if(memberVo.getMemId() == null || memberVo.getMemId().equals("")){
			errors.rejectValue("memId", "required"); 	
		}
		
		if(memberVo.getMemName() == null || memberVo.getMemName().equals("")){
			errors.rejectValue("memName", "required"); 	
		}
			
		if(memberVo.getMemPass() == null || memberVo.getMemPass().equals("")){
			errors.rejectValue("memPass", "required");
		}
	}
	
}
