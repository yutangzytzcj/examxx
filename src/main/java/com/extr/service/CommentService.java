package com.extr.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.extr.domain.question.Comment;
import com.extr.util.Page;

@Service
public interface CommentService {

	public List<Comment> getCommentByQuestionId(int questionId,Page<Comment> page);
}
