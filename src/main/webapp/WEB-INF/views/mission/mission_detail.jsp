<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.Date"%>
<%@ include file="/WEB-INF/views/include/header.jsp"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="/js/mission/mission_detail.js"></script>
<link rel="stylesheet" href="/css/mission/mission_detail.css" />

</head>
<body>

	<!-- 그룹미션 참가하기 -->
	<div id="modal" class="modal-overlay">
		<div class="modal-window">
			<div class="close-area" id="modalclose">X</div>
			<h2 id="modalh2"></h2>
			<div id="registerbtn"></div>
			<div id="register_contents"></div>
			<form name="form1" method="post"
				action="${pageContext.request.contextPath}/register">
				<input type="hidden" name="m_code" value="${group.m_code }">
				<input type="hidden" name="p_friends" value=1>
				
				<div>
				<br>
					<input type='submit' id='participation' class="register" value='참가하기'>
				</div>
			</form>
		</div>
	</div>

	<!-- 상시미션 참가하기&인증하기 -->
	<div id="modal2" class="modal-overlay2">
		<div class="modal-window2">
			<div class="close-area2" id="modalclose2">X</div>
			<h2 id="modalh22"></h2>
			<div id="register_contents2"></div>
			<form name="form2" method="post"
				action="${pageContext.request.contextPath}/register_complete"
				enctype="multipart/form-data">
				<input type="hidden" name="m_code" value="${group.m_code }">
				<input name="p_photo" type="hidden" id="p_photo"> <input
					name="id" type="hidden" id="id" value="${sessionScope.session_id}">
				<input type="hidden" name="p_complete" value=1> <input
					type="hidden" name="m_point" value="${group.m_point}"> <input
					type="hidden" name="m_carbon" value="${group.m_carbon}"> <input
					name="image" id="input-image" type="file" accept="image/*">
					<br>
				<input type='submit' id='register_complete' class="register" value='참가하기'>
			</form>
		</div>
	</div>

	<!-- 미션 상세 정보 -->
	<div style="text-align: center; margin-top: 50px; margin-bottom: 50px;">
	<div style="display: grid; 
grid-template-columns: 40% auto; width:70%; margin-left: auto; 
margin-right: auto; 
margin-bottom: 20px;background-color: white; padding-top:10px;padding-bottom:5px; padding-left:10px; padding-right:20px; ">
		<div>
		<img width=500px height=500px
					src="<%=request.getContextPath()%>/img/${group.m_photo}">
					</div>
					<div style="text-align:left; margin-left:100px;">
					<div style=" margin-left:40px;padding-top:30px; ">
			<jsp:useBean id="toDate" class="java.util.Date" />
			<fmt:parseDate var="regDate" value="${group.m_date }"
				pattern="yyyy-MM-dd" />
			<span style="font-weight:500; font-size:18px;">미션일 
			<fmt:formatDate value="${regDate}" pattern="yyyy-MM-dd" /> 
			</span>
			<fmt:parseNumber value="${toDate.time / (1000*60*60*24)}"
				integerOnly="true" var="toDate2" scope="request"></fmt:parseNumber>
			<fmt:parseNumber value="${regDate.time / (1000*60*60*24)}"
				integerOnly="true" var="regDate2" scope="request"></fmt:parseNumber>

				<c:if test="${group.m_type == 'group'}">
				<li>지구용사들과 함께하는 단체 미션입니다. 미션 전날까지 신청을 완료해주세요!</li>							
				</c:if>
				<c:if test="${group.m_type == 'solo'}">
				<li>지금 바로 신청가능한 상시 미션입니다.</li>
				</c:if>
				<hr>
				</div>
				<ul>
				<li><h2>${group.m_name }</h2></li>
				<li> ${group.m_inform }</li>
				<li>장소 : ${group.m_location }</li>
				<li>포인트 획득 : ${group.m_point }p</li>
				<li>탄소 배출 감소량 : ${group.m_carbon }g</li>
				<c:if test="${(regDate2 - toDate2) > 0 }">
					<c:if test="${group.m_type == 'solo'}">
					<br>
						<li><input type="button" value="상시미션신청하기" class="register" id="solodetail"
							onclick="solodetail(${group.m_code})"></li>
					</c:if>
					<c:if test="${group.m_type == 'group'}">
						<c:if test="${group.m_personnel <= 0 }">
							<li style="color: green">정원이 다 찼습니다. 다른 참여자가 취소시 신청 수 있습니다.
							</li>
						</c:if>
						<c:if test="${group.m_personnel > 0}">
							<li>남은 모집 인원 : ${group.m_personnel }명</li>
							<br>
							<li><input type="button" value="신청하기" class="register" id="groupdetail"
								onclick="groupdetail(${group.m_code})"></li>
						</c:if>
					</c:if>
				</c:if>
				<c:if test="${regDate2 <= toDate2 }">
					<li style="color: blue"><strong>이미 마감된 미션입니다. 다음 모집 때
							함께해요!</strong></li>
				</c:if>

			</ul>
		</div>
		</div>
	</div>

	<!-- 리뷰 목록 -->
	<div class="review_box">

			<c:forEach items="${review }" var="row">
		<div class="review_list">
				<div style="padding-top:20px; padding-bottom:20px;">
					
					<img width=200px height=200px
						src="<%=request.getContextPath()%>/img/${row.p_photo}">
				</div>
				<div  style="padding-top:20px; padding-bottom:20px;">
		<c:if test="${row.p_review == null}">
					
 	<span style="font-size:20px; font-weight: 500;"><br>아직 리뷰를 작성하지 않았습니다.</span><br>
					</c:if>
					<c:if test="${row.p_review != null}">

						<c:if test="${row.p_star == 1 }">
							<img width=35px height=22px
								src="<%=request.getContextPath()%>/img/star1.png">
							<br>
						</c:if>
						<c:if test="${row.p_star == 2 }">
							<img width=150px height=25px
								src="<%=request.getContextPath()%>/img/star2.png">
							<br>
						</c:if>
						<c:if test="${row.p_star == 3 }">
							<img width=150px height=25px
								src="<%=request.getContextPath()%>/img/star3.png">
							<br>
						</c:if>
						<c:if test="${row.p_star == 4 }">
							<img width=150px height=25px
								src="<%=request.getContextPath()%>/img/star4.png">
							<br>
						</c:if>
						<c:if test="${row.p_star == 5 }">
							<img width=150px height=25px
								src="<%=request.getContextPath()%>/img/star5.png">
							<br>
						</c:if>
					
 	<span style="font-size:18px; font-weight: 400;">${row.p_review }</span><br>

					</c:if>
				</div>
				<div  style="padding-top:70px;">
				<span
						style="border-radius: 3px; display: inline-block; padding: auto; width: 25px; height: 25px; background-color:#F7e600;; color: black; font-size: 20px; font-weight: large;">${row.grade }</span>
					<span style="font-size: 20px; font-weight: 600"> ${row.id } </span><br>
					<br><input type=button value=신고하기 class="redcard">
				</div>
		</div>
			</c:forEach>
	</div>
	<c:forEach items="${map.list }" var="star">
		<div>별점 : ${star.p_star}</div>
	</c:forEach>
	별점 준 사람 수 : ${map.count }
</body>
</html>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>