package com.extr.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.extr.controller.domain.QuestionFilter;
import com.extr.controller.domain.QuestionImproveResult;
import com.extr.controller.domain.QuestionQueryResult;
import com.extr.domain.question.Field;
import com.extr.domain.question.KnowledgePoint;
import com.extr.domain.question.Question;
import com.extr.domain.question.QuestionStruts;
import com.extr.domain.question.QuestionType;
import com.extr.domain.question.UserQuestionHistory;
import com.extr.persistence.QuestionMapper;
import com.extr.util.Page;
import com.extr.util.xml.Object2Xml;

/**
 * @author Ocelot
 * @date 2014年6月8日 下午8:21:13
 */
@Service("questionService")
public class QuestionServiceImpl implements QuestionService {
	
	@Autowired
	private QuestionMapper questionMapper;

	@Override
	public List<Field> getAllField(Page<Field> page) {
		return questionMapper.getAllField(page);
	}

	@Override
	public List<KnowledgePoint> getKnowledgePointByFieldId(int FieldId) {
		return questionMapper.getKnowledgePointByFieldId(FieldId);
	}

	@Override
	public List<Question> getQuestionList(Page<Question> pageModel, QuestionFilter qf) {
		return questionMapper.getQuestionList(qf,pageModel);
	}
	@Override
	public List<QuestionType> getQuestionTypeList() {
		return questionMapper.getQuestionTypeList();
	}

	@Override
	public Question getQuestionByQuestionId(int questionId) {
		// TODO Auto-generated method stub
		return questionMapper.getQuestionByQuestionId(questionId);
	}

	@Override
	public List<KnowledgePoint> getQuestionKnowledgePointListByQuestionId(int questionId) {
		// TODO Auto-generated method stub
		return questionMapper.getQuestionKnowledgePointListByQuestionId(questionId);
	}

	@Override
	@Transactional
	public void addQuestion(Question question) {
		// TODO Auto-generated method stub
		try{
			questionMapper.insertQuestion(question);
			for(Integer i : question.getPointList()){
				questionMapper.addQuestionKnowledgePoint(question.getId(), i);
			}
		}catch(Exception e){
			throw new RuntimeException(e.getMessage());
		}
	}

	@Override
	@Transactional
	public void deleteQuestionByQuestionId(int questionId){
		// TODO Auto-generated method stub
		try {
			questionMapper.deleteQuestionPointByQuestionId(questionId);
			questionMapper.deleteQuestionByQuestionId(questionId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new RuntimeException(e.getMessage());
		}
	}

	@Override
	public HashMap<Integer, HashMap<Integer, List<QuestionStruts>>> getQuestionStrutsMap(List<Integer> idList) {
		// TODO Auto-generated method stub
		HashMap<Integer, HashMap<Integer, List<QuestionStruts>>> hm = new HashMap<Integer, HashMap<Integer, List<QuestionStruts>>>();
		List<QuestionStruts> questionList = questionMapper.getQuestionListByPointId(idList);
		for(QuestionStruts q : questionList){
			HashMap<Integer, List<QuestionStruts>> hashmap = new HashMap<Integer, List<QuestionStruts>>();
			List<QuestionStruts> ql = new ArrayList<QuestionStruts>();
			if(hm.containsKey(q.getPointId()))
				hashmap = hm.get(q.getPointId());
			if(hashmap.containsKey(q.getQuestionTypeId()))
				ql = hashmap.get(q.getQuestionTypeId());
			ql.add(q);
			hashmap.put(q.getQuestionTypeId(), ql);
			hm.put(q.getPointId(), hashmap);
		}
		return hm;
	}

	@Override
	public KnowledgePoint getKnowledgePointByName(String pointName,
			String fieldName) {
		// TODO Auto-generated method stub
		return questionMapper.getKnowledgePointByName(pointName, fieldName);
	}

	@Override
	public void addUserQuestionHistory(UserQuestionHistory userQuestionHistory) throws Exception {
		// TODO Auto-generated method stub
		if(userQuestionHistory.getHistory() == null)
			throw new Exception("不能插入空的历史记录");
		
		String histStr = Object2Xml.toXml(userQuestionHistory.getHistory());
		userQuestionHistory.setHistoryStr(histStr);
		questionMapper.addUserQuestionHistory(userQuestionHistory);
	}

	@Override
	public UserQuestionHistory getUserQuestionHistoryByUserId(int userId) {
		// TODO Auto-generated method stub
		UserQuestionHistory uh = questionMapper.getUserQuestionHistoryByUserId(userId);
		if(uh != null)
			uh.setHistory(Object2Xml.toBean(uh.getHistoryStr(), Map.class));
		return uh;
	}

	@Override
	public void updateUserQuestionHistory(
			UserQuestionHistory userQuestionHistory) throws Exception {
		// TODO Auto-generated method stub
		if(userQuestionHistory.getHistory() == null)
			throw new Exception("不能插入空的历史记录");
		
		String histStr = Object2Xml.toXml(userQuestionHistory.getHistory());
		userQuestionHistory.setHistoryStr(histStr);
		questionMapper.updateUserQuestionHistory(userQuestionHistory);
	}

	@Override
	public List<QuestionQueryResult> getQuestionAnalysisListByPointIdAndTypeId(
			int typeId, int pointId) {
		// TODO Auto-generated method stub
		return questionMapper.getQuestionAnalysisListByPointIdAndTypeId(typeId, pointId);
	}

	@Override
	public List<QuestionImproveResult> getQuestionImproveResultByQuestionPointIdList(List<Integer> questionPointIdList) {
		// TODO Auto-generated method stub
		return questionMapper.getQuestionImproveResultByQuestionPointIdList(questionPointIdList);
	}

	@Override
	public List<QuestionQueryResult> getQuestionQueryResultListByFieldIdList(
			List<Integer> fieldIdList,List<Integer> typeIdList,int limit) {
		// TODO Auto-generated method stub
		List<QuestionQueryResult> tmp = questionMapper.getQuestionAnalysisListByFieldIdList(fieldIdList,typeIdList);
		List<QuestionQueryResult> result = new ArrayList<QuestionQueryResult>();
		if(limit >= tmp.size())
			return tmp;
		Random random = new Random();
		Set<Integer> idSet = new HashSet<Integer>();
		while(idSet.size() < 20){
			idSet.add(random.nextInt(tmp.size()));
		}
		Iterator<Integer> it = idSet.iterator();
		while(it.hasNext()){
			result.add(tmp.get(it.next()));
		}
		return result;
	}

	@Transactional
	@Override
	public void updateQuestionPoint(Question question) {
		// TODO Auto-generated method stub
		try{
			questionMapper.deleteQuestionPointByQuestionId(question.getId());
			for(int id : question.getPointList()){
				questionMapper.addQuestionKnowledgePoint(question.getId(), id);
			}
		}catch(Exception e){
			e.printStackTrace();
			throw new RuntimeException(e.getClass().getName());
		}
		
		
	}

	@Override
	public void addField(Field field) {
		// TODO Auto-generated method stub
		questionMapper.addField(field);
	}
}
