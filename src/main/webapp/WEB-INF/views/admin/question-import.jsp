<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%-- <%@taglib uri="spring.tld" prefix="spring"%> --%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
  	<head>
   		<base href="<%=basePath%>">
   	 	<meta charset="utf-8"><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title>试题管理</title>
		<meta name="keywords" content="">
		<link rel="shortcut icon" href="<%=basePath%>resources/images/favicon.ico" />
		<link href="resources/bootstrap/css/bootstrap-huan.css" rel="stylesheet">
		<link href="resources/font-awesome/css/font-awesome.min.css" rel="stylesheet">
		<link href="resources/css/style.css" rel="stylesheet">
		<link href="resources/css/slider.css" rel="stylesheet">
		<link href="resources/css/question-add.css" rel="stylesheet">
		<link href="resources/chart/morris.css" rel="stylesheet">
	</head>
	<body>
		<header>
			<div class="container">
				<div class="row">
					<div class="col-xs-5">
						<div class="logo">
							<h1><a href="#">网站管理系统</a></h1>
							<div class="hmeta">
								专注互联网在线考试解决方案
							</div>
						</div>
					</div>
					<div class="col-xs-7" id="login-info">
						<c:choose>
							<c:when test="${not empty sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}">
								<div id="login-info-user">
									
									<a href="user-detail/${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}" id="system-info-account" target="_blank">${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}</a>
									<span>|</span>
									<a href="j_spring_security_logout"><i class="fa fa-sign-out"></i> 退出</a>
								</div>
							</c:when>
							<c:otherwise>
								<a class="btn btn-primary" href="user-register">用户注册</a>
								<a class="btn btn-success" href="user-login-page">登录</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</header>
		<!-- Navigation bar starts -->

		<div class="navbar bs-docs-nav" role="banner">
			<div class="container">
				<nav class="collapse navbar-collapse bs-navbar-collapse" role="navigation">
					<ul class="nav navbar-nav">
						<li>
							<a href="#"><i class="fa fa-home"></i>网站首页</a>
						</li>
						<li class="active">
							<a href="admin/question-list"><i class="fa fa-edit"></i>试题管理</a>
						</li>

						<li>
							<a href="admin/exampaper-list"><i class="fa fa-file-text-o"></i>试卷管理</a>
						</li>
						<li>
							<a href="admin/user-list"><i class="fa fa-user"></i>会员管理</a>
						</li>
						<li>
							<a href="admin/field-list"><i class="fa fa-cloud"></i>题库管理</a>
						</li>
						<li>
							<a href="admin/sys-backup"><i class="fa fa-cogs"></i>网站设置</a>
						</li>
					</ul>
				</nav>
			</div>
		</div>

		<!-- Navigation bar ends -->

		<!-- Slider starts -->

		<div>
			<!-- Slider (Flex Slider) -->

			<div class="container" style="min-height:500px;">

				<div class="row">
					<div class="col-xs-3">
						<ul class="nav default-sidenav">
							<li>
								<a href="admin/question-list"> <i class="fa fa-list-ul"></i> 试题管理 </a>

							</li>
							<li >
								<a href="admin/question-add"> <i class="fa fa-pencil-square-o"></i> 添加试题 </a>

							</li>
							<li class="active">
								<a> <i class="fa fa-cloud-upload"></i> 导入试题 </a>

							</li>

						</ul>

					</div>
					<div class="col-xs-9">
						<div class="page-header">
							<h1><i class="fa fa-cloud-upload"></i> 导入试题 </h1>
						</div>
						<div class="page-content row">
							<form id="from-question-import" action="teacher/upload-question">
							<div class="form-line upload-question-group">
								<span class="form-label">选择题库：</span>
								<select class="df-input-narrow">
									<option value="-1">-- 请选择 --</option>
									
											<option value="1">营销类 题库</option>
									
								</select>
								<span class="form-message"></span>
							</div>
							<div class="form-line template-download">
								<span class="form-label">下载模板：</span>
								<a href="resources/template/question.xls" style="color:rgb(22,22,22);text-decoration: underline;">点击下载</a>
							</div>
							<div class="form-line upload-question-file">
								<span class="form-label">上传文件：</span>
								<div id="div-file-list">
								</div>
								<div id="uploadify" class="uploadify" style="height: 25px;"><object id="SWFUpload_0" type="application/x-shockwave-flash" data="resources/js/uploadify/uploadify.swf?preventswfcaching=1401981635735" width="100%" height="25" class="swfupload" style="position: absolute; z-index: 1;"><param name="wmode" value="transparent"><param name="movie" value="resources/js/uploadify/uploadify.swf?preventswfcaching=1401981635735"><param name="quality" value="high"><param name="menu" value="false"><param name="allowScriptAccess" value="always"><param name="flashvars" value="movieName=SWFUpload_0&amp;uploadURL=%2Fextr-0.0.1-SNAPSHOT%2Fteacher%2Fupload-uploadify&amp;useQueryString=false&amp;requeueOnError=false&amp;httpSuccess=&amp;assumeSuccessTimeout=30&amp;params=sessionHash%3Da0486b50f6e9fbfe47ccc6988f27b49ee1792915%26amp%3Bpath%3D&amp;filePostName=Filedata&amp;fileTypes=*.*&amp;fileTypesDescription=All%20Files&amp;fileSizeLimit=2048&amp;fileUploadLimit=0&amp;fileQueueLimit=999&amp;debugEnabled=false&amp;buttonImageURL=%2Fextr-0.0.1-SNAPSHOT%2Fteacher%2F&amp;buttonWidth=100%25&amp;buttonHeight=25&amp;buttonText=&amp;buttonTextTopPadding=0&amp;buttonTextLeftPadding=0&amp;buttonTextStyle=color%3A%20%23000000%3B%20font-size%3A%2016pt%3B&amp;buttonAction=-110&amp;buttonDisabled=false&amp;buttonCursor=-2"></object><div id="uploadify-button" class="uploadify-button " style="height: 25px; line-height: 25px;"><span class="uploadify-button-text">点击上传</span></div></div><div id="uploadify-queue" class="uploadify-queue"></div>
								<span class="form-message"></span>
							</div>
							
							<div class="form-line">
								<input value="提交" type="submit" class="df-submit">
							</div>
						</form>

						</div>
					</div>
				</div>
			</div>
		</div>

		<footer>
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div class="copy">
							<p>
								Exam++ Copyright © <a href="http://www.examxx.net/" target="_blank">Exam++</a> - <a href="." target="_blank">主页</a> | <a href="http://www.examxx.net/" target="_blank">关于我们</a> | <a href="http://www.examxx.net/" target="_blank">FAQ</a> | <a href="http://www.examxx.net/" target="_blank">联系我们</a>
							</p>
						</div>
					</div>
				</div>

			</div>

		</footer>

		<!-- Slider Ends -->

		<!-- Javascript files -->
		<!-- jQuery -->
		<script type="text/javascript" src="resources/js/jquery/jquery-1.9.0.min.js"></script>
		<!-- Bootstrap JS -->
		<script type="text/javascript" src="resources/bootstrap/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="resources/chart/raphael-min.js"></script>
		<script type="text/javascript" src="resources/chart/morris.js"></script>
		<script type="text/javascript" src="resources/js/exam-finished.js"></script>
	</body>
</html>