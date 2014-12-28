package com.extr.controller;

import java.util.List;



import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.extr.controller.domain.ExamFinishParam;
import com.extr.controller.domain.Message;
import com.extr.domain.question.Comment;
import com.extr.service.CommentService;
import com.extr.util.Page;

@Controller
public class CommentController {

	@Autowired
	private CommentService commentService;

	@RequestMapping(value = "student/comment-list/{questionId}/{index}", method = RequestMethod.GET)
	public @ResponseBody
	Message getQuestionComments(@PathVariable("questionId") int questionId,
			@PathVariable("index") int index) {
		Message msg = new Message();
		msg.setMessageInfo("not-has-next");
		Page<Comment> page = new Page<Comment>();
		page.setPageNo(1);
		page.setPageSize(10 * index);
		try{
			List<Comment> commentList = commentService.getCommentByQuestionId(questionId, page);
			if(page.getTotalRecord() > page.getPageSize())
				msg.setMessageInfo("has-next");
			msg.setObject(commentList);
			msg.setGeneratedId(page.getTotalRecord());
		}catch(Exception e){
			msg.setResult(e.getClass().getName());
		}
		
		return msg;
	}
	
	@RequestMapping(value = "student/submit-comment", method = RequestMethod.POST)
	public @ResponseBody
	Message submitComment(@RequestBody Comment comment, HttpServletRequest request) {
		
		
		return new Message();
		
	}
}
