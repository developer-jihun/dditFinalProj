<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<style>
h6 {
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 500;
	font-size: 14px;
	margin-left: 50px;
}

textarea:focus {
    outline: none;
}

</style>
<!-- Head Image 시작 -->
<div class="boardHeadImage">
	<div class="wrapper">
		<div class="slide">
			<img src="/resources/images/layout/ddit/pdoctorIntro.png" />
		</div>
	</div>
</div>
<!-- Head Image 끝 -->
<!-- main section 시작 -->
<section class="container">
	<!-- 이용안내 nav 시작 -->
	<div class="row" style="margin-left: 7%; margin-top: 50px; width: 85%; height: 100px; border-top: 1px solid gray; border-bottom: 1px solid gray;">
		<div class="col-12">
			<h4 style="margin-left: 50px; margin-top: 20px; font-family: 'Noto Sans KR', sans-serif; font-weight: 700;">의료진 소개</h4>
		</div>
		<div class="col-6">
			<h6 style="opacity: 0.5;">home > 병원 소개 > 의료진 소개</h6>
		</div>
	</div>
	<!-- 이용안내 nav 끝 -->
	
	
	  <div class="table-responsive">
      <div class="table-wrapper" style="margin-left:7%; width:85%;">
         <div class="card" style="border:none;">
		    <div class="card-body" style="margin-left:20%;">
			   <div class="row">
				 <div class="col-sm-12">
					<c:forEach items="${doctorList}" var="list">
			    		<div class="col-md-12 bg-register-image" style="margin-top: 2%;text-align: center;">
			    		<div class="row">
						<table>
							<tr>
								<td>
									<c:choose>
									<c:when test="${list.thumbnail==null}">
										<img src="/resources/images/employee/s_cb8450a3-35e9-44e1-9598-730c60f5cb54_user.png" style="height:350px; width:300px; margin-bottom:4%;" >										
									</c:when>
									<c:otherwise>
										<img src="${list.thumbnail}" style="height:350px; width:300px; margin-bottom:4%;" >								
									</c:otherwise>
									</c:choose>
			                 	</td>
				            	 <td>
				            	 	<input type="text" value="${list.empNm}(${list.introNmEn}) 원장"
				            	 	style="border: none;  text-align:left; outline: none;font-size: 25px;width:370px;" readonly />
				            	 	<br/>
				            	 	<input type="text" value="${list.introSpecialty}"
				            	 	style="border: none; width:370px;  text-align:left; outline: none;font-size: 25px; font-family: 'Nanum Gothic', sans-serif;" readonly />
				            	 	<br/>
				            	 	<br/>
				            	 	<input type="text" value="약력"
				            	 	style="border: none; width:370px;  text-align:left; outline: none;font-size: 25px; font-family: 'Nanum Gothic', sans-serif;" readonly />
				            	 	<input type="text" value="―"
				            	 	style="border: none; width:370px;  text-align:left; outline: none;font-size: 25px; font-family: 'Nanum Gothic', sans-serif;" readonly />
				            	 	<textarea name="introEducation" id="introEducation" style="resize: none;font-size: 18px;height: 175px;width: 370px; border: none; background-color:white; text-align: left; font-family: 'Nanum Gothic', sans-serif;" readonly><c:out value="${list.introEducation}" /></textarea>
				            	 </td>
			            	 		<br/>
			            	 		<br/>
			            	 		<br/>
							</tr>
		         		</table>
		         		</div>
						</div>
		            </c:forEach>
		    	 </div>
		    </div>
	     </div>
	     </div>
                
           
      </div>
   </div>
</section>
	
	

<!-- main section 끝 -->
