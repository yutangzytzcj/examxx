package com.extr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.extr.domain.question.Comment;
import com.extr.persistence.CommentMapper;
import com.extr.util.Page;

@Service("commentService")
public class CommentServiceImpl implements CommentService {

	@Autowired
	private CommentMapper commentMapper;
	@Override
	public List<Comment> getCommentByQuestionId(int questionId,Page<Comment> page) {
		// TODO Auto-generated method stub
		return commentMapper.getCommentByQuestionId(questionId,page);
	}

}
