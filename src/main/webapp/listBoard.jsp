<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	
	h1{
		text-align:center;
	}
	
	table{
		margin:10px auto;
	}
	
	#tbody td{
		text-align:center;
	}
	
	#controller{
		width:30%;
		margin:0px auto;
		text-align:center;
	}
	
	#footer{
		width:50%;
		margin:0px auto;
		text-align:center;
	}
	
	/*상단바*/
	* {
		margin: 0;
		padding: 0
	}
	
	/*전체*/
	body{
		background: rgb(243, 243, 243);
	}
	
	/*태그 선택자 설정*/
	p{
		margin-bottom: 5px;
		margin-left: 10px;
	}
	
	li{
		list-style: none;
		float: left;
	}
	
	button{
		cursor: pointer;
	}
	
	a{
		text-decoration: none;
		color: black;
	}
	
	hr{
		margin: 20px 0;
	}
	
	header{
		/*margin: 0 auto;*/
		width: 1300px;
		
	}
	.navigation_menu{
		margin: 20px 0;
	}
	
	/*상단 우측 아이콘 정렬*/
	#empty{
		margin-left: 570px;
	}
	
	/*메인로고*/
	#mainlogo_li{
		margin-left: 30px;
	}
	
	.menu_icon {
		margin: 32px 10px 0 10px; /*위 오 아 왼*/
		background: none;
		font-size: 20px;
		font-weight: bold;
		padding: 5px;
		cursor: pointer;
		font-family: '나눔스퀘어라운드';
		/*border: 2px solid #BF9B7A;*/
		/*border-radius: 5px;*/
		border: none;
		color: #0D0D0D;
	}
	
	#header_container{
		position: fixed;
		width: 1300px;
		margin: 0 auto;
		/*margin-left: 150px;*/
		/*border: 5px solid red;*/
		display: block;
		left: 0; top: 0; right: 0;
	}
	
	#board_container{
		margin: 0 auto;
		margin-top: 200px;
		width: 960px;
		border: 2px solid #BF9B7A;
		padding: 30px;
		border-radius: 5px;
		display: block;
	}
	
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		
		var userno=$("#hidden_userno").val();
		//var userno=1;
		$("#insertBoard").attr("href","insertBoard.do?userno="+userno);
		
		$(".boardtitle").click(function(e){
			var boardno=$(this).parent().prev().html();
			sessionStorage.setItem("boardno",boardno);
			console.log(sessionStorage.getItem("boardno"));
			e.preventDefault();
			$(location).attr("href","detailBoard.do?boardno="+boardno);
		})
		
		$(document).on("click",".boardtitle_future",function(){
			var boardno=$(this).parent().prev().html();
			sessionStorage.setItem("boardno",boardno);
			$(location).attr("href","detailBoard.do?boardno="+boardno);
		})
		
	var search_list = function(){	
			$.ajax({
				url:"SearchMovie",
				data:$("#footer").serializeArray(),
				success:function(list){
					
					$("#tbody").empty();
					$("#controller").empty();
						if(list.cnt==0){
							alert("검색 결과가 없습니다.");
						}else{
							var category=sessionStorage.getItem("category");
							var searchBoard=sessionStorage.getItem("searchBoard");
							
							for(var i=0;i<list.length-1;i++){
								var tr=$("<tr></tr>");
								var td1=$("<td></td>").html(list[i].boardno);
								var td2=$("<td></td>");
								var a=$("<a></a>").attr("href","#").addClass("boardtitle_future").html(list[i].boardtitle);
								td2.append(a);
								var td3=$("<td></td>").html(list[i].nickname);
								var td4=$("<td></td>").html(list[i].boarddate);
								var td5=$("<td></td>").html(list[i].boardview);
								tr.append(td1,td2,td3,td4,td5);
								$("#tbody").append(tr);
							}
							
							var pageno=list[list.length-1].pageno;
							var prev=list[list.length-1].prev;
							var next=list[list.length-1].next;
							var total_page=list[list.length-1].total_page;
							
							var prev_a=$("<a></a>").attr("href","listBoard.do?pageno="+prev+"&searchBoard="+searchBoard+"&category="+category).html("◀&nbsp");
							var span_a = $("<span></span>");
							for(var i=1;i<=total_page;i++){
								var pageno_a=$("<a></a>").attr("href","listBoard.do?pageno="+i+"&searchBoard="+searchBoard+"&category="+category).html(i);
								var blank = $("<span></span>").html("&nbsp&nbsp");
								$(span_a).append(pageno_a,blank);
							}
							var next_a=$("<a></a>").attr("href","listBoard.do?pageno="+next+"&searchBoard="+searchBoard+"&category="+category).html("▶");
							$("#controller").append(prev_a,span_a,next_a);
					}
					
				}
			});
		}
		
		$("#submit").click(function(e){
			sessionStorage.setItem("category",$("#category").val());
			sessionStorage.setItem("searchBoard",$("#searchBoard").val());
			search_list();
			e.preventDefault();
		})
		
	})
</script>
</head>
<body>
			<!-- header -->
		<div id="header_container">
			<header>
				<nav>
					<ul id="menu_list">
						<!-- 메인 로고 -->
						<li class="navigation_menu" id="mainlogo_li">
							<a href="mainPage.do">
								<img src="./images/mainlogo.png" width="300" id="mainlogo">
							</a>
						</li>
						<li id="empty">&nbsp;</li>
						<!-- 자유게시판 아이콘 -->
						<li class="navigation_menu">
							<a href="listBoard.do">
								<button class="menu_icon" id="board_icon">자유게시판</button>
							</a>
						</li>
						<!-- 회원가입 / 마이페이지 아이콘 -->
						<li class="navigation_menu">
							<c:if test="${userno != null }">
								<a href="myPage.do">
									<button class="menu_icon" id="mypage_icon">마이페이지</button>
								</a>
							</c:if>
							<c:if test="${userno == null }">
								<a href="#">
									<button class="menu_icon" id="join_icon">회원가입</button>
								</a>
							</c:if>
						</li>
						<!-- 로그인 / 로그아웃 아이콘 -->
						<li class="navigation_menu">
							<input type="hidden" value="${userno }" id="userno">
							<c:if test="${userno != null }">
								<a href="#">
									<button class="menu_icon" id="logout_icon">로그아웃</button>
								</a>
							</c:if>
							<c:if test="${userno == null }">
								<a href="#">
									<button class="menu_icon" id="login_icon">로그인</button>
								</a>
							</c:if>
						</li>
					</ul> <!-- end #menu_list -->
				</nav>
			</header>
		</div> <!-- end #header_container -->

	<div id="board_container">
		<input type="hidden" value="${userno }" id="hidden_userno">
		<h1><a href="listBoard.do">자유 게시판</a></h1>
		<a id="insertBoard">게시물 등록</a>
		<table border="1" width="60%">
			<thead>
				<tr>
					<th width="10%">글번호</th>
					<th width="30%">제목</th>
					<th width="10%">작성자</th>
					<th width="10%">날짜</th>
					<th width="10%">조회수</th>
				</tr>
			</thead>
			<tbody id="tbody">
				<c:forEach var="b" items="${list}">
					<tr>
						<td>${b.boardno }</td>
						<td><a href="#" class="boardtitle">${b.boardtitle }</a></td>
						<td>${b.nickname }</td>
						<td>${b.boarddate }</td>
						<td>${b.boardview }</td>
					</tr>	
				</c:forEach>
			</tbody>
		</table>
		<div id="controller">
		
		<a href="listBoard.do?pageno=${prev}&searchBoard=${searchBoard}&category=${category}">◀</a>&nbsp 

		<c:forEach var="b" begin="1" end="${total_page}">
			<span><a href="listBoard.do?pageno=${b}&searchBoard=${searchBoard}&category=${category}">${b}</a></span>&nbsp
		</c:forEach>
		
		<a href="listBoard.do?pageno=${next}&searchBoard=${searchBoard}&category=${category}">▶</a>
		
		</div>
		<hr>
		<form id="footer">
			<select name="category" id="category">
				<option>제목</option>
				<option>내용</option>
				<option>작성자</option>
			</select>
			<input type="text" size="20px" name="searchBoard" id="searchBoard">
			<input type="submit" value="검색" id="submit">
		</form>
	</div> <!-- end #board_container -->
	
</body>
</html>