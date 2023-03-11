package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.FullCalendarVO;

public interface ICalService {
	
	public List<FullCalendarVO> list();

	public void register(FullCalendarVO calendar)throws Exception;

	public void remove(FullCalendarVO calendar) throws Exception;
}
