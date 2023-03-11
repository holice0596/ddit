package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.jsonFormatVisitors.JsonFormatTypes;

import lombok.Data;

@Data
public class FullCalendarVO {
	private int calNo;
	private String title;
	private String startDate;
	private String endDate;
	
	private List<FullCalendarVO> list;
}
