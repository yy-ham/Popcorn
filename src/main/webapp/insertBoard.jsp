<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#return_boardList").click(function(){
			if(confirm("돌아가시겠습니까?")){
				$(location).attr("href","listBoard.do");
			}
		})
		
		
		$("#boardcontent").keyup(function(e){	//엔터 누를시에 댓글등록
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
						insertBoard();
					}else{
						alert("200자 이내로 입력하세요")
					}
				}
			}
		})
		
		var insertBoard = function(){
			$.ajax({
				url:"InsertBoard",
				data:$("#myform").serialize(),
				success:function(re){
					if(re>0){
						alert("게시글 등록 성공");
						$(location).attr("href","listBoard.do");
					}
				}
			});
		}
		
		$("#submit").click(function(e){
			insertBoard();
			e.preventDefault();
		})
	});
	
</script>
</head>
<body>
	<form id="myform">
		<input type="hidden" name="boardno" value="${boardno }">
		<span style="font-size:1.5em"><b>게시글 제목 : </b></span><input type="text" name="boardtitle" placeholder="30자 이내로 입력하세요" maxlength="30" size="50px">
		<h2>작성자 : ${nickname} </h2>
		<input type="hidden" name="userno" value="${userno }">
		<h2>내용 : </h2>
		<textarea rows="10" cols="80" maxlength="200" id="boardcontent" name="boardcontent" placeholder="200자 이내로 입력하세요"></textarea><br>
		<div>0/200자</div>
		<input type="submit" value="게시글 등록" name="submit" id="submit">
	</form>
		<button id="return_boardList">돌아가기</button>
</body>
</html>