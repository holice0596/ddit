package kr.or.ddit.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.CalMapper;
import kr.or.ddit.vo.FullCalendarVO;

@Service
public class CalServiceImpl implements ICalService {

	@Inject
	private CalMapper mapper;
	
	@Override
	public List<FullCalendarVO> list() {

		return mapper.list();
	}

	@Override
	public void register(FullCalendarVO calendar) throws Exception {
		mapper.register(calendar);
	}

	@Override
	public void remove(FullCalendarVO calendar) throws Exception {
		mapper.delete(calendar);
	}

	@Override
	public void update(FullCalendarVO calendar) throws Exception {
		mapper.update(calendar);
	}

}
