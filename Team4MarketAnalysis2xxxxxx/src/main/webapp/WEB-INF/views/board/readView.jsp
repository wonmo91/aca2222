<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	 	<title>게시판</title>
	 	<script src="https://kit.fontawesome.com/e4a42c4ca5.js" crossorigin="anonymous"></script>
  	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
 
	</head>
	<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='readForm']");
			
			// 수정 
			$(".update_btn").on("click", function(){
				formObj.attr("action", "/board/updateView");
				formObj.attr("method", "get");
				formObj.submit();				
			})
			// 삭제
			$(".delete_btn").on("click", function(){
				
				var deleteYN = confirm("삭제하시겠습니가?");
				if(deleteYN == true){
					
				formObj.attr("action", "/board/delete");
				formObj.attr("method", "post");
				formObj.submit();
					
				}
			})
			// 취소
			$(".list_btn").on("click", function(){
				
				location.href = "/board/list";
			})
			
			// 목록
			$(".list_btn").on("click", function(){

				location.href = "/board/list?page=${scri.page}"
								+"&perPageNum=${scri.perPageNum}"
								+"&searchType=${scri.searchType}&keyword=${scri.keyword}";
			})
			
			//댓글작성
			$(".replyWriteBtn").on("click", function(){
				  var formObj = $("form[name='replyForm']");
				  formObj.attr("action", "/board/replyWrite");
				  formObj.submit();
			});
			//댓글 수정 View
			$(".replyUpdateBtn").on("click", function(){
				location.href = "/board/replyUpdateView?bno=${read.bno}"
								+ "&page=${scri.page}"
								+ "&perPageNum=${scri.perPageNum}"
								+ "&searchType=${scri.searchType}"
								+ "&keyword=${scri.keyword}"
								+ "&rno="+$(this).attr("data-rno");
			});
			//댓글 삭제 View
			$(".replyDeleteBtn").on("click", function(){
				location.href = "/board/replyDeleteView?bno=${read.bno}"
					+ "&page=${scri.page}"
					+ "&perPageNum=${scri.perPageNum}"
					+ "&searchType=${scri.searchType}"
					+ "&keyword=${scri.keyword}"
					+ "&rno="+$(this).attr("data-rno");
			});
		})
	</script>
	
<body>
  <nav class="navbar navbar-expand-lg bg-light">
    <div class="container-fluid">
      <a class="navbar-brand" href="<c:url value='/'/>">
        <i class="fa-brands fa-freebsd"> market A</i>
      </a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0" >
          <li class="nav-item1">
            <a class="nav-link active1" aria-current="page1" href="https://map.kakao.com/">상권지도</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">커뮤니티</a>
            <ul class="dropdown-menu">
              <li><a class="dropdown-item" href="#">공지사항</a></li>
              <li><a class="dropdown-item" href="#">묻고 답하기</a></li>
              <li><a class="dropdown-item" href="<c:url value='/board/list'/>">자유 게시판</a></li>
            </ul>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">내 공간</a>
            <ul class="dropdown-menu">
              <li><a class="dropdown-item" href="#">내 정보</a></li>
              <li><hr class="dropdown-divider"></li>
              <li><a class="dropdown-item" href="#">내 기록</a></li>
              <li><a class="dropdown-item" href="#">북마크</a></li>
            </ul>
          </li>
          <li class="nav-item3">
            <a class="nav-link active3" aria-current="page3" href="<c:url value='/signUp/login'/>">로그인</a>
          </li>
          <li class="nav-item4">
            <a class="nav-link active4" aria-current="page4" href="<c:url value='/resources/registerForm.html'/>">회원가입</a>
          </li>
        </ul>
        <form class="d-flex" role="search">
          <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
          <button class="btn btn-secondary" type="submit">Search</button>
        </form>
      </div>
    </div>
  </nav>
  
	
		<div class="container">
			<header>
				<h1> 게시판</h1>
			</header>
			<hr />
			 
			<div>
				<%@include file="nav.jsp" %>
			</div>
			<hr />
			
			<section id="container">
				<form name="readForm" role="form" method="post">
  					<input type="hidden" id="bno" name="bno" value="${read.bno}" />
  					<input type="hidden" id="page" name="page" value="${scri.page}"> 
  					<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
  					<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
  					<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}"> 
				</form>
				
				<div class="shadow-sm p-3 mb-5 bg-body rounded">
					<div class="form-group ">
					<label for="title" class="col-sm-2 control-label">제목</label>
					<input type="text" id="title" name="title" class="form-control" value="${read.title}" readonly="readonly"/>
				</div>
				<br/>
				<div class="form-group">
					<label for="content" class="col-sm-2 control-label">내용</label>
					<textarea id="content" name="content" class="fulltext form-control" onkeydown="resize(this)" onkeyup="resize(this)" readonly="readonly" style="height: 330px;"><c:out value="${read.content}"/></textarea>
				</div>
				<br/>
				<div class="form-group">
					<div class="container text-center">
  					<div class="row">
    					<div class="col">
      					<label for="writer" class="col-sm-2 control-label">작성자</label>
      					<input type="text" id="writer" name="writer"  value="${read.writer}"  readonly="readonly"/>
    					</div>
    					<div class="col">
    						<label for="regdate" class="col-sm-2 control-label">작성날짜</label>
      					<fmt:formatDate value="${read.regdate}" pattern="yyyy-MM-dd" />
    					</div>
  					</div>
					</div>
				</div>
				
				<br/>
				<div class="container text-left">
  				<div class="row">
    				<div class="col">
      				<div class="d-grid gap-2 d-md-block">
								<button type="submit" class="list_btn btn btn-dark">목록</button>	
							</div>
    				</div>
    				<div class="col">
      				<div class="d-grid gap-2 d-md-flex justify-content-md-end">	
								<button type="submit" class="update_btn btn btn-secondary">수정</button>
								<button type="submit" class="delete_btn btn btn-danger">삭제</button>
							</div>
    				</div>
  				</div>
				</div>
				</div>
				
				
				<!-- 댓글 -->
				<div id="reply">
  					<ol class="replyList shadow-sm p-3 mb-5 bg-body rounded">
    					<c:forEach items="${replyList}" var="replyList">
      						<li>
        						<p>
        							<div class="container text-center">
  											<div class="row">
    											<div class="col">
      											작성자 : ${replyList.writer}
    											</div>
    											<div class="col">
     				 							
    											</div>
    											<div class="col">
      											작성 날짜 :  <fmt:formatDate value="${replyList.regdate}" pattern="yyyy-MM-dd" />
    											</div>
  											</div>
											</div>
        						</p>
        						<div class="form-control">
        							<p>${replyList.content}</p>
        						</div>
        						<br/>
        						<div class="d-grid gap-2 d-md-flex justify-content-md-end">
  										<button type="button" class="replyUpdateBtn btn btn-secondary" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;" data-rno="${replyList.rno}">수정</button>
  										<button type="button" class="replyDeleteBtn btn btn-danger" style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;" data-rno="${replyList.rno}">삭제</button>
										</div>
      						</li>
    					</c:forEach>   
  					</ol>
				</div>
				
				<form name="replyForm" method="post" class="form-horizontal">
  					<input type="hidden" id="bno" name="bno" value="${read.bno}" />
  					<input type="hidden" id="page" name="page" value="${scri.page}"> 
  					<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}"> 
  					<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}"> 
  					<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}"> 

  					<div class="form-group">
    					<label for="writer" class="col-sm-2 control-label">댓글 작성자</label>
    					<div class="col-sm-10">
    						<input type="text" id="writer" name="writer" class="form-control"/>
    					</div>
    				</div>
    				<div class="form-group">
    					<label for="content" class="col-sm-2 control-label">댓글 내용</label>
    					<div>
    						<input type="text" id="content" name="content" class="form-control"/>
    					</div>
  					</div>
  					<br/>
  					<div class="form-group">
  						<div class="col-sm-offset-2 col-sm-10">
  							<button type="button" class="replyWriteBtn btn btn-success">작성</button>
  						</div>
  					</div>
				  </form>
			  </section>
			<hr />
		</div>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
		
	</body>
</html>