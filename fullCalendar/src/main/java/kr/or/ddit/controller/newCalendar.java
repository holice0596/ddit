package kr.or.ddit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class newCalendar {
	
	@RequestMapping(value = "/calendar")
	public String calendar(){
		return "New";
	}
}
