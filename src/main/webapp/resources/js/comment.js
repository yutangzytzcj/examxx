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
		this.clearComment();
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
					
					var html = comment.generatComment(message.object.comments);
					comment.appendHtml(html,message.object.size);
				} else {
					util.error("读取失败请稍后尝试:" + message.result);
				}
			},
			error : function(jqXHR, textStatus) {
				util.error("读取失败请稍后尝试");
			}
		});
	},
	
	appendHtml : function appendHtml(html,size){
		$(".comment-list").html(html);
		$(".comment-total-num").text(size);
	},
	
	clearComment : function clearComment(){
		$(".comment-list").empty();
	},

	generatComment : function generatComment(commentList){
		if(commentList.length == 0)return "";
		var html = "";
		
		for(var i = 0 ; i < commentList.length; i++){
			html = html + "<li class=\"comment-list-item\">";
			html = html + "<div class=\"comment-user-container\">";
			html = html + "<div><img src=\"resources/images/photo.jpg\" class=\"comment-user-img\"></div>";
			html = html + "<div class=\"comment-user-info\"><div>" + commentList[i].username + "</div>";
			html = html + "<div class=\"comment-date\">	" + commentList[i].createTime + "</div>";
			html = html + 	"</div>";
			html = html + "</div>";
			html = html + "<p class=\"comment-user-text\">" + commentList[i].contentMsg + "</p>";
			html = html + "</li>";
		}
		
		
		return html;
	}
};





