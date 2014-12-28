package com.extr.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.extr.controller.domain.AnswerSheetItem;
import com.extr.controller.domain.Message;
import com.extr.controller.domain.QuestionQueryResult;
import com.extr.domain.exam.PracticePaper;
import com.extr.domain.question.Comment;
import com.extr.security.UserInfo;
import com.extr.service.CommentService;
import com.extr.util.Page;
import com.extr.util.QuestionAdapter;
import com.extr.util.xml.Object2Xml;

@Controller
public class CommentController {

	@Autowired
	private CommentService commentService;

	@RequestMapping(value = "comment-list-{questionId}-{index}", method = RequestMethod.GET)
	public @ResponseBody
	Message getQuestionComments(@PathVariable("questionId") int questionId,
			@PathVariable("index") int index) {
		Message msg = new Message();
		Page<Comment> page = new Page<Comment>();
		page.setPageNo(1);
		page.setPageSize(10 * index);
		try{
			List<Comment> commentList = commentService.getCommentByQuestionId(questionId, page);
			msg.setObject(commentList);
		}catch(Exception e){
			msg.setResult(e.getClass().getName());
		}
		
		return msg;
	}
}
