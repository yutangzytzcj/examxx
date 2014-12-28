$(function() {
	comment.initial();
	comment.queryComment();
});

var comment = {
	initial : function initial() {
		this.bindSubmit();
	},
	bindSubmit : function bindSubmit() {
		$("form.comment-form").submit(function(){
			var content = $(".comment-form textarea").val();
			var thisquestion  = $(".question:visible");
			
			if(content==null||content==""){
				util.error("评论不能为空！");
				return false;
			}else if(content.length > 140){
				util.error("不能超过140个字！");
				return false;
			}
			
			var data = new Object();
			data.questionId =  $(thisquestion).find(".question-id").text();
			data.contentMsg = content;
			$.ajax({
				headers : {
					'Accept' : 'application/json',
					'Content-Type' : 'application/json'
				},
				async:false,
				type : "POST",
				url : "student/submit-comment",
				data : JSON.stringify(data),
				success : function(message, tst, jqXHR) {
					if (!util.checkSessionOut(jqXHR))
						return false;
					if (message.result == "success") {
						util.success("发表成功", function(){
							window.location.reload();
						});
					} else {
						util.error("操作失败请稍后尝试:" + message.result);
					}
				},
				error : function(jqXHR, textStatus) {
					util.error("操作失败请稍后尝试");
				}
			});
			
			return false;
		});
	},
	
	queryComment : function queryComment(){
		var thisquestion  = $(".question:visible");
		
		
		$.ajax({
			headers : {
				'Accept' : 'application/json',
				'Content-Type' : 'application/json'
			},
			async:true,
			type : "GET",
			url : "student/comment-list/" + $(thisquestion).find(".question-id").text() + "/0",
			success : function(message, tst, jqXHR) {
				if (!util.checkSessionOut(jqXHR))
					return false;
				if (message.result == "success") {
					
					util.success("读取评论列表成功");
					
				} else {
					util.error("读取失败请稍后尝试:" + message.result);
				}
			},
			error : function(jqXHR, textStatus) {
				util.error("读取失败请稍后尝试");
			}
		});
	}
};





