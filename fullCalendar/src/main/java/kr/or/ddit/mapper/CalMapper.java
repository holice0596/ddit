package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.FullCalendarVO;

public interface CalMapper {

	public List<FullCalendarVO> list();
	public void register(FullCalendarVO calendar) throws Exception;
	public void delete(FullCalendarVO calendar)throws Exception;

}
