<p align="center">
  <img src="https://github.com/yy-ham/Popcorn/assets/118264054/b799b1d5-260d-41ce-b76a-e502daf27df8" width="350">
</p>
<br>

# 🍿 POPCORN
영화 정보를 소개하고, 영화 평가와 리뷰를 작성할 수 있는 웹 페이지
<br>
<br>

<h2>프로젝트 소개</h2>
<ul>
  <li>프로젝트명: POPCORN (팝콘)</li>
  <li>개발 기간: 2022.11.18 ~ 2022.11.24</li>
  <li>개발 인원: 5명</li>
  <li>개발 환경</li>
  <ul>
    <li>Back-end
      <ul>
        <li>Java 17</li>
        <li>JSP, Servlet</li>
        <li>DB: Oracle 21c</li>
      </ul>
    </li>
    <li>Front-end
      <ul>
        <li>JavaScript, JQuery</li>
        <li>View: HTML5, CSS3, Thymeleaf, JSTL</li>
      </ul>
    </li>
  </ul>
  <li>주요 기능</li>
    <ul>
      <li>영화 및 감독, 배우 정보 조회</li>
      <li>영화 평가 및 리뷰 작성</li>
      <li>계층형 게시판</li>
      <li>마이페이지 내가 평가 또는 리뷰한 영화 조회</li>
    </ul>
</ul>
<br>
<br>

<h2>서비스 흐름도</h2>
<p>
  <img src="https://github.com/yy-ham/Trip-Contest/assets/118264054/bffedade-5a45-447d-bbe4-3bab6d7bc943" width="500">
</p>
<br>
<br>

<h2>DB 설계</h2>
<p>
  <img src="https://github.com/yy-ham/Trip-Contest/assets/118264054/0e9ce8dd-b8b2-4c39-a53f-bdbc07d42063" width="800">
</p>
<br>
<br>

<h2>담당 기능</h2>
▶를 누르면 상세 내용을 볼 수 있습니다.
<br>
<br>
<details>
  <summary>영화 평가 CRUD 기능</summary>
  <br>
  <ul>
    <li>로그인 후 평가 기능 이용 가능</li>
    <li>좋음, 보통, 싫음 세 가지 상태 중 한 개만 선택 가능</li>
    <li>아이콘 선택된 상태</li>
    <ul>
      <li>해당 아이콘 다시 누르면 평가 취소</li>
      <li>다른 아이콘 누르면 기존 평가 삭제 후 새로운 평가 등록</li>
    </ul>
  </ul>
  <br>
  <p>
    <img src="https://github.com/yy-ham/Popcorn/assets/118264054/5bddc42d-6ad1-4053-bc87-644d402c5173">
  </p>
</details>
<details>
  <summary>리뷰 CRUD 기능</summary>
  <br>
  <ul>
    <li>로그인 후 리뷰 기능 이용 가능</li>
    <li>작성자, 리뷰 내용, 영화 평가 함께 조회 가능</li>
    <li>자신이 작성한 리뷰만 리뷰 수정 또는 삭제 가능</li>
  </ul>
  <br>
  <b>1. 영화 상세 페이지 리뷰</b><br>
  <br>
  <p>
    <img src="https://github.com/yy-ham/Popcorn/assets/118264054/ed18134a-490d-4873-8e20-d4650c9226c0">
  </p>
  <br>
  
  <b>2. 리뷰 상세 페이지</b><br>
  <p>
    <img src="https://github.com/yy-ham/Popcorn/assets/118264054/3d662a82-3512-4da9-a34b-1a5df34746b2">
  </p>
  <br>
  
  <b>3. 리뷰 더보기 페이지</b><br>
  <p>
    <img src="https://github.com/yy-ham/Popcorn/assets/118264054/3adf47f0-23f3-447e-99ce-bf58dc93ca32">
  </p>
</details>
<details>
  <summary>영화 및 배우, 감독 정보 조회 기능</summary>
  <br>
  <b>1. 영화 상세 페이지</b><br>
  <p>
    <img src="https://github.com/yy-ham/Popcorn/assets/118264054/b3132660-0665-419a-8f1c-8892c254b689">
  </p>
  <br>
  
  <b>2. 배우 상세 페이지</b><br>
  <p>
    <img src="https://github.com/yy-ham/Popcorn/assets/118264054/116903b8-f3f4-411d-978d-83bbf93ef76f">
  </p>
  <br>
  
  <b>3. 감독 상세 페이지</b><br>
  <p>
    <img src="https://github.com/yy-ham/Popcorn/assets/118264054/fb205263-51bf-4cfd-a903-951a8e084c45">
  </p>
  <br>
</details>
<details>
  <summary>영화 컬렉션 조회 및 메인 이미지 변경 기능</summary>
  <br>
  <ul>
    <li>최신영화, 좋아요 많이 받은 영화, 영화제 수상작 컬렉션 조회</li>
    <li>난수 이용하여 사이트 접속 할 때마다 메인 이미지 변경</li>
  </ul>
  <br>
  <p>
    ▼ 메인 페이지<br>
    <img src="https://github.com/yy-ham/Popcorn/assets/118264054/070fab4e-1099-4797-b7f0-7bbe2c002d21">
  </p>
</details>
<details>
  <summary>자동 검색어 완성 기능</summary>
  <br>
  <ul>
    <li>메인 페이지 검색 박스에 글자를 입력하면 검색 버튼을 누르지 않아도 해당 글자가 포함된 영화 제목 조회 가능</li>
    <li>영화 제목 클릭 시 해당 영화 상세 페이지로 이동</li>
  </ul>
</details>
<details>
  <summary>비밀번호 재설정 기능</summary>
  <br>
  <ul>
    <li>회원가입할 때의 이름과 이메일을 입력 후 회원임이 확인되면 비밀번호 재설정 가능</li>
    <li>보안 강화를 위해 비밀번호 찾기 대신 비밀번호 재설정 기능 구현</li>
  </ul>
</details>
