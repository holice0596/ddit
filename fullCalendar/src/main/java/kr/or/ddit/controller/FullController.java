package kr.or.ddit.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.ICalService;
import kr.or.ddit.vo.FullCalendarVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/ddit")
public class FullController {
	
	@Inject
	private ICalService service;
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String calendar() throws Exception{
		return "calendar";
	}
	
	@ResponseBody
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public JSONArray calendarList(Model model) throws Exception {
		List<FullCalendarVO> list = service.list();
		System.out.println(list);
		
		JSONObject jsonObj = new JSONObject();
		JSONArray jsonArr = new JSONArray();
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		for(int i=0; i < list.size(); i++) {
			map.put("no", list.get(i).getCalNo());
			map.put("title", list.get(i).getTitle());
			map.put("content", list.get(i).getContent());
			System.out.println("content["+i+"] : " + list.get(i).getContent());
			map.put("start", list.get(i).getStartDate());
			map.put("end", list.get(i).getEndDate());
			
			jsonObj = new JSONObject(map);
			jsonArr.add(jsonObj);
		}
		System.out.println("jsonArr : {}"+jsonArr); 
		return jsonArr;
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String calRegisterForm(FullCalendarVO calendar, Model model) {
		log.info("calRegisterForm");
		model.addAttribute("calendar", calendar);
		return "ddit/register";
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String register(@Validated FullCalendarVO calendar, BindingResult result, Model model) throws Exception {
		log.info("register()");
		log.info("title : " + calendar.getTitle());
		log.info("content : " + calendar.getContent());
		
		service.register(calendar);
		
		if(calendar.getCalNo() > 0) {
			return "redirect:/ddit/list";
		}
		model.addAttribute("msg","등록 성공");
		return "calendar";
	}
	
	@ResponseBody
	@RequestMapping(value = "/remove", method = RequestMethod.POST)
	public String remove(FullCalendarVO calendar, Model model) throws Exception {
		log.info("remove()");
		service.remove(calendar);
		model.addAttribute("msg", "삭제 완료");
//		return "{\"result\" : \"성공\"}";
		return "calendar";
	}
	
	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(FullCalendarVO calendar, Model model) throws Exception{
		log.info("update()");
		service.update(calendar);
		model.addAttribute("calNo", calendar.getCalNo());
		return "calendar";
	}
}
