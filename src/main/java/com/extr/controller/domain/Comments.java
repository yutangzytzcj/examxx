package com.extr.controller.domain;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;

import com.extr.domain.question.Comment;

@XmlRootElement(name = "Comments")
public class Comments{
	
	@XmlElementWrapper(name="c")
	@XmlElement(name = "comment")
	private ArrayList<Comment> comments = null;
	@XmlElement(name = "size")
	private int size;
	public int getSize() {
		return size;
	}

	public void setSize(int size) {
		this.size = size;
	}

	public ArrayList<Comment> getComments() {
		return comments;
	}

	public void setComments(ArrayList<Comment> comments) {
		this.comments = comments;
	}
	
}