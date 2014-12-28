package com.extr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.extr.domain.question.Comment;
import com.extr.persistence.CommentMapper;
import com.extr.util.Page;

public class CommentServiceImpl implements CommentService {

	@Autowired
	private CommentMapper commentMapper;
	@Override
	public List<Comment> getCommentByQuestionId(int questionId,Page<Comment> page) {
		// TODO Auto-generated method stub
		return commentMapper.getCommentByQuestionId(questionId,page);
	}

}
