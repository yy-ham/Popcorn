<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#content{
		border: none;
		overflow-y:scroll;
		margin:0px auto;
	}
	
	.display_none{
		display:none;
	}
	
	#display_none{
		display:none;
	}

	.commentList_item{
		border-radius:15px;
		border: 3px solid orange;
		width : 40%;
		padding:10px; 
		margin:10px;	
	}
	
	.comment_change{
		float:right;
		maring:5px;
		display:none;
	}

	.btn_margin{
		margin:10px;
	}
	
	#boardtitle{
		display:inline-block;
	}
	
	/*중앙 정렬 레이아웃 초기화*/
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


/*상단바*/
/*중앙 정렬*/
header{
	/*margin: 0 auto;*/
	width: 1300px;
	background: rgb(243, 243, 243);
	
	
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
	background: rgb(243, 243, 243);
	z-index: 100;
	border-bottom:1px solid #D9CDBF;
}


/*body*/
#content{
	/*clear: both;*/
	margin: 0 auto;
	margin-top: 200px;
	width: 960px;
	border: 2px solid #BF9B7A;
	padding: 30px;
	border-radius: 5px;
	display: block;
	margin-bottom: 50px;
}

</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
		
	$(function(){
		
		
		var boardno =sessionStorage.getItem("boardno");
		console.log(boardno);
		//var userno=sessionStorage.getItem("userno");
		var userno = 1;
		
		$(document).on("click",".delete_btn",function(){		//삭제버튼 누르면 삭제
			var boardcommentno=$(this).attr("boardcommentno");
			console.log(boardcommentno);
			
			if(confirm("삭제하시겠습니까?")){
				$.ajax({
					url:"DeleteComment",
					data:{boardcommentno:boardcommentno},
					success:function(re){
						if(re>0){
							alert("댓글삭제 성공");
							btnMoreClick();
							listAll();
						}else{
							alert("댓글삭제 실패ㅠ");
						}
					}
				})
			}
			
		});
		
		$(document).on("click",".update_btn",function(){		//수정 버튼 누르면 수정
			$(".update_btn").css("display","none");
			
			var arr=$(this).parent().find("div");
			var txt=$(arr[0]).text();
			var txtarea=$("<textarea></textarea>").attr({"rows":"10","cols":"80"}).html(txt);
			var blank=$("<br>")
			var btn_update=$("<button></button>").html("수정하기").addClass("btn_margin");
			var btn_return=$("<button></button>").html("돌아가기").addClass("btn_margin");
			$(arr[0]).empty();
			$(arr[0]).append(txtarea,blank,btn_update,btn_return);
			var boardcommentno=$(this).attr("boardcommentno");
			
			$(btn_update).click(function(){
				var boardcommentcontent=$(txtarea).val().replaceAll("\n","<br>");
				$.ajax({
					url:"UpdateComment",
					data:{boardcommentno:boardcommentno,boardcommentcontent:boardcommentcontent},
					success:function(re){
						if(re>0){
							alert("수정성공!");
							listAll();
							btnMoreClick();
						}else{
							alert("수정실패ㅠ");
						}
					}
				});
			})
			
			$(btn_return).click(function(){
				listAll();
				btnMoreClick();
			})
			
		});
		
	
		var thisPage_userno=$("#boardChange").find("input").val();		//현페이지 작성자와 로그인한 작성자가 다를 경우 글 수정, 삭제 불가하게함
		if(userno!=thisPage_userno){
			$("#boardChange").css("display","none");
		}	
		
		var listAll = function(){					//모든 댓글 목록 가져오기
			$.ajax({
				url:"GetAllComments",
				data:{boardno:boardno},
				success:function(list){
					var no = list.length;
					$("#commentList").empty();
					$(".btnMore").html("더보기");
					$.each(list,function(index){
						
						var div=$("<div></div>").attr("class","commentList_item");
						
						var comment=$("<div></div>").html(this.boardcommentcontent);
						var hr=$("<hr>");
						var nickname=$("<span></span>").html("작성자 : "+this.nickname)
						var date =$("<span></span>").html("작성일 : "+this.boardcommentdate).css("margin-left","7em");
						var btn_delete=$("<button></button>").html("삭제").addClass("comment_change delete_btn")
										.attr("boardcommentno",this.boardcommentno);
						var blank = $("<span></span>").html("&nbsp &nbsp").addClass("comment_change");
						var btn_update=$("<button></button>").html("수정").addClass("comment_change update_btn")
										.attr("boardcommentno",this.boardcommentno);
						
						div.append(comment,hr,nickname,date,btn_delete,blank,btn_update);
						$("#commentList").append(div);
						
						if(userno==this.userno){					
							//기본적으로 comment_change class 적용 태그들은 보이지 않고
							//로그인 유저번호와 작성한 사람이 같은 경우에 수정,삭제 버튼을 보여준다.
							var showButton=$(div).find(".comment_change");
							$(showButton).css("display","inline-block");
						}	
						if(index>=2){$(div).addClass("display_none")}
						
						
					});
					btnMoreClick();
				}
			})
		}
		
		//실제로는 수정하기 버튼이 2개가 있는데 1번, 2번이라고 하자
		// 2번은 존재하지만 처음에는 안보이고
		// 1번은 처음에는 보이지만 버튼 클릭시에 textarea 작성가능하게 풀고 2번이 보이게 한다.
		var btn_group1=$("#boardChange").find("span")[0]			
		var btn_group2=$("#boardChange").find("span")[1]
		$(btn_group2).css("display","none");
		$("#boardtitle_input").css("display","none");
		
		var btn_update1=$("#boardChange").find("button")[0];
		var btn_delete=$("#boardChange").find("button")[1];
		var btn_update2=$("#boardChange").find("button")[2];
		var btn_return=$("#boardChange").find("button")[3];
		
		$(btn_update1).click(function(){
			$(btn_group1).css("display","none");
			$(btn_group2).css("display","inline");
			$("#boardtitle").css("display","none");
			$("#boardtitle_input").css("display","inline");
			$("#content").attr({"readonly":false,
								"disabled":false	
			});
		});
		
		$(btn_update2).click(function(){
			var boardtitle=$("#boardtitle_input").val()
			console.log(boardtitle);
			var boardcontent=$("#content").val();
			$.ajax({
				url:"UpdateBoard",
				data:{boardtitle:boardtitle,boardcontent:boardcontent,boardno:boardno},
				success:function(re){
					if(re>0){
						alert("수정 성공!");
					}else{
						alert("수정 실패!");
					}
					$(location).attr("href","detailBoard.do?boardno="+boardno);
					$("#boardtitle").html(boardtitle);
				}
			});
		});
				
		$(btn_delete).click(function(){
			if(confirm("게시물을 삭제하시겠습니까?")){
				$.ajax({
					url:"DeleteBoard",
					data:{boardno:boardno},
					success:function(re){
						if(re>0){
							alert("삭제성공");
							$(location).attr("href","listBoard.do");
						}else{
							$(location).attr("href","detailBoard.do?boardno="+boardno);
						}
					}
				})
			}
		})
		
		$(btn_return).click(function(){
			$(location).attr("href","detailBoard.do?boardno="+boardno);
		});
			
			
		var btnMoreClick = function(){				//스위치처럼 클릭할 때마다 보이고 닫히는 것이 번갈아 일어나게하는 함수
			$(".btnMore").click(function(){
				$(".display_none").toggle();
				var txt=$(".btnMore").html();
				if(txt=="더보기"){
					$(".btnMore").html("닫기");
				}else{
					$(".btnMore").html("더보기");
				}
			}).css("cursor","pointer");
		}
		
		listAll();
		
		$("#writeComment").click(function(){		//댓글 작성 버튼 누르면 댓글 작성란 펼쳐지기
			$("#display_none").toggle();			//댓글 작성란은 댓글목록과는 따로 작동해야해서 display:none에 대해서 id를 준것이다. 
		}).css("cursor","pointer");
		
		function insertComment(){					//ajax으로 db에 댓글 등록하는 함수
			var boardCommentContent=$("#boardCommentContent").val().replaceAll("\n","<br>");
			var boardno=$("#boardno").val();	
		
			$.ajax({
				url:"InsertComment",
				data:{boardCommentContent:boardCommentContent,boardno:boardno},
				success:function(re){
					$("#boardCommentContent").val("");
					if(re>0){
						alert("댓글등록 성공");
						listAll();
						btnMoreClick();
					}else{
						alert("댓글등록 실패");
					}
				}
			})
		}
	
		$("#btn_insertcomment").click(function(e){		//버튼 클릭시 댓글등록
			e.preventDefault();
			var txt=$(this).parent().find("textarea");
			var length=$(txt).length;
			var div=$(this).prev();						// 0/200 처럼 몇글자 적힌지 알려주는 태그
			if(length<=200){
				insertComment();
				$(div).empty();
				$(div).append("0/200자").css("color","black");
			}
		});
		
		$("#boardCommentContent").keyup(function(e){	//엔터 누를시에 댓글등록
			var length=$(this).val().length
			var div=$(this).nextAll()[1];				// 0/200 처럼 몇글자 적힌지 알려주는 태그
			$(div).empty();
			if(length<=200){
				$(div).append(length+"/200자").css("color","black");
			}else{
				$(div).append(length+"/200자").css("color","red");
			}
			if(e.keyCode==13){
				if(!e.shiftKey){
					if(length<=200){
						insertComment();
					}else{
						alert("200자 이내로 입력하세요")
					}
				}
			}
		})
		
		$("#returnList").click(function(e){				//'게시물 목록' 누르면 게시판으로 돌아가기
			$(location).attr("href","listBoard.do")
			e.preventDefault();
		});
		
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
								<a href="insertUserinfo.jsp">
									<button class="menu_icon" id="join_icon">회원가입</button>
								</a>
							</c:if>
						</li>
						<!-- 로그인 / 로그아웃 아이콘 -->
						<li class="navigation_menu">
							<input type="hidden" value="${userno }" id="userno">
							<c:if test="${userno != null }">
								<a href="logout.do">
									<button class="menu_icon" id="logout_icon">로그아웃</button>
								</a>
							</c:if>
							<c:if test="${userno == null }">
								<a href="login.jsp">
									<button class="menu_icon" id="login_icon">로그인</button>
								</a>
							</c:if>
						</li>
					</ul> <!-- end #menu_list -->
				</nav>
			</header>
		</div> <!-- end #header_container -->


	<div id="content">
	
	
	<!--<input type="hidden" value="${boardvo.boardno }" id="boardno">-->
	<h2>게시글 번호 : ${boardvo.boardno} </h2>
	<h3>게시글 제목 : <span id="boardtitle">${boardvo.boardtitle }</span>
	<input type="text" id="boardtitle_input" maxlength="30" value="${boardvo.boardtitle}" size="60px">
	
	</h3>
	<h3>작성자 : ${boardvo.nickname }</h3>
	<h3>내용 :</h3>
	<textarea rows="10" cols="100" readonly="readonly" id="content" disabled>${boardvo.boardcontent}</textarea>
	<div id="boardChange">
		<input type="hidden" value="${boardvo.userno }">
		<span>
			<button>게시글 수정</button>
			<button>삭제하기</button>
		</span>
		<span>
			<button>수정 완료</button>
			<button>돌아가기</button>
		</span>
	</div>
	<hr>
	
	<h3>댓글</h3>
	
	<div id="commentList">
		<div class="commentList_item">
			<div>(댓글)</div>
			<hr>
			<span>(아이디)</span>
			<span>(날짜)</span>
			<button class="comment_change" id="comment_update">수정</button>
			<span class="comment_change">&nbsp &nbsp</span>
			<button class="comment_change" id="comment_delete">삭제</button>
		</div>
	</div>
	
	<div class="btnMore"></div>
	<hr>
	
	<div id="writeComment">댓글 작성</div>
	<div id="display_none">
	<div id="insertComment">
		<input type="hidden" value="${boardvo.boardno}" id="boardno">
		<textarea placeholder="댓글을 입력하세요" maxlength="200" rows="5" cols="100" id="boardCommentContent"></textarea><br>
		<div>0/200자</div>
		<input id="btn_insertcomment" type="submit" value="등록">
	</div>	
	</div>
	<a href="#" id="returnList">게시물 목록</a>
	</div>
</body>
</html>