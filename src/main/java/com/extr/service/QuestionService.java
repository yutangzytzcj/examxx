package com.extr.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.extr.controller.domain.QuestionFilter;
import com.extr.controller.domain.QuestionImproveResult;
import com.extr.controller.domain.QuestionQueryResult;
import com.extr.domain.question.Field;
import com.extr.domain.question.KnowledgePoint;
import com.extr.domain.question.Question;
import com.extr.domain.question.QuestionStruts;
import com.extr.domain.question.QuestionType;
import com.extr.domain.question.UserQuestionHistory;
import com.extr.util.Page;

/**
 * @author Ocelot
 * @date 2014年6月8日 下午5:52:44
 */
public interface QuestionService {

	/**
	 * 获取题目类型
	 * 
	 * @return
	 */
	List<Field> getAllField(Page<Field> page);

	List<KnowledgePoint> getKnowledgePointByFieldId(int FieldId);

	List<Question> getQuestionList(Page<Question> pageModel, QuestionFilter qf);

	List<QuestionType> getQuestionTypeList();

	Question getQuestionByQuestionId(int questionId);

	/**
	 * 获取题目的知识点，知识点名由专业名fieldname和知识点pointname名拼接
	 * 
	 * @param questionId
	 * @return
	 */
	List<KnowledgePoint> getQuestionKnowledgePointListByQuestionId(
			int questionId);

	/**
	 * 添加试题，同时添加试题知识点对应关系
	 * 
	 * @param question
	 */
	public void addQuestion(Question question);

	public void deleteQuestionByQuestionId(int questionId);

	public HashMap<Integer, HashMap<Integer, List<QuestionStruts>>> getQuestionStrutsMap(
			List<Integer> idList);

	public KnowledgePoint getKnowledgePointByName(String pointName,
			String fieldName);

	/**
	 * 添加学员练习试题的记录
	 * 
	 * @param userQuestionHistory
	 */
	public void addUserQuestionHistory(UserQuestionHistory userQuestionHistory)
			throws Exception;

	/**
	 * 获取学员练习试题的记录
	 * 
	 * @param userId
	 * @return
	 */
	public UserQuestionHistory getUserQuestionHistoryByUserId(int userId);

	/**
	 * 更新学员练习试题记录
	 * 
	 * @param userQuestionHistory
	 */
	public void updateUserQuestionHistory(
			UserQuestionHistory userQuestionHistory) throws Exception;

	public List<QuestionQueryResult> getQuestionAnalysisListByPointIdAndTypeId(
			int typeId, int pointId);

	/**
	 * 强化练习获取分类信息
	 * 
	 * @return
	 */
	public List<QuestionImproveResult> getQuestionImproveResultByQuestionPointIdList(
			List<Integer> questionPointIdList);
	
	public List<QuestionQueryResult> getQuestionQueryResultListByFieldIdList(
			List<Integer> fieldIdList,List<Integer> typeIdList,int limit);
	
	public void updateQuestionPoint(Question question);
	
	/**
	 * 添加题库
	 * @param field
	 */
	public void addField(Field field);
	
	/**
	 * 添加知识点
	 * @param point
	 */
	public void addKnowledgePoint(KnowledgePoint point);
	
	/**
	 * 删除题库
	 * @param idList
	 */
	public void deleteFieldByIdList(List<Integer> idList);
	
	/**
	 * 删除知识点
	 * @param idList
	 */
	public void deleteKnowledgePointByIdList( List<Integer> idList);
}
