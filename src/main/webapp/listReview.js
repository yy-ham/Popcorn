$(function () {
	var listBook = function () {
		$.ajax({
			url: "",
			success: function (arr) {
				$("#list").empty();
				$.each(arr, function () {
					var li = $("<li></li>").html(this.bookname);
					$(li).addClass("book");
					$(li).attr({
						bookid: this.bookid, 
						bookname: this.bookname, 
						publisher: this.publisher, 
						price: this.price
					});
					$("#list").append(li);
				});
			}
		});
	}
	
	
	
	$("#my_form").submit(function (e) {
		var data = $(this).serializeArray();
		e.preventDefault();
		$.ajax({
			url: "InsertBook",
			data: data,
			success: function (r) {
				listBook();
			}
		});
	});
	
	listBook();
	
	$("#btnNew").click(function () {
		$.ajax({
			url: "NextBookid",
			success: function (bookid) {
				$("#bookid").val(bookid);
			}
		});			
	});
	
	$("#btnUpdate").click(function () {
		var data = $("#my_form").serializeArray();
		$.ajax({
			url: "UpdateBook",
			data: data,
			success: function (r) {
				listBook();
			}
		});
	});
	
	$("#btnDelete").click(function () {
		if(confirm("정말로 삭제하시겠습니까?")){
			var data = $("#my_form").serializeArray();
			$.ajax({
				url: "DeleteBook",
				data: data,
				success: function () {
					listBook();
				}
			});
			
		}
	});
	
	$(document).on("click", ".book", function () {
		$("#bookid").val($(this).attr("bookid"));
		$("#bookname").val($(this).attr("bookname"));
		$("#publisher").val($(this).attr("publisher"));
		$("#price").val($(this).attr("price"));
		//input 태그의 값을 설정하거나 읽어올 때 val()
		//td, div, span 등에 글자 설정하거나 읽어올 때 html()
		//제이쿼리에 있는 함수 사용할 땐 this -> $(this), attr은 제이쿼리 함수
		$(".book").removeClass("active");
		$(this).addClass("active");
	});
	
	$(document).on("mouseover", ".book", function () {
		$(this).addClass("high_light");
	});
	$(document).on("mouseleave", ".book", function () {
		$(this).removeClass("high_light");
	});
	
	
	
});
