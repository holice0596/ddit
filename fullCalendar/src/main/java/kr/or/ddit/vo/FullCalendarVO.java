package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.jsonFormatVisitors.JsonFormatTypes;

import lombok.Data;

@Data
public class FullCalendarVO {
	private int calNo;						// 일정번호
	private String title;					// 제목
	private String content;					// 내용
	private String startDate;				// 시작일
	private String endDate;					// 종료일
	private int afNo;						// 파일번호
	
	private List<FullCalendarVO> list;		// 일정목록
	
	// ATTFILE(테이블)
	private String afdate;					// 파일생성일(파일등록일)
	
	// FILEDTL(테이블) : 파일 여러개 등록하려면 필요
	private int fdtlNo;						// 파일상세번호
	private String fdtlName;				// 파일이름
	private String fdtlSave;				// 저장이름
	
}
