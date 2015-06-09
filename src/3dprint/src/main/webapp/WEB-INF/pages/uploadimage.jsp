<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<html>
<body>
	<jsp:include page="common/header.jsp" flush="true"></jsp:include>
	<script src="<%=request.getContextPath()%>/js/jquery.form.min.js"></script>
	<div class="container">
		<div class="row">
			<form id="myForm" method="POST"
				action="<%=request.getContextPath()%>/common/upload"
				enctype="multipart/form-data">
				File: <input type="file" name="file" id="file" /> <br />
				Destination: <input type="text" value="/tmp" name="destination" />
				<br /> <input type="submit" value="Upload" name="upload" id="upload" />
			</form>
			<div id="progress">123</div>
		</div>
	</div>
	<script>
		$(function() {
			$('form').ajaxForm(
					{
						url: '<%=request.getContextPath()%>/common/upload2',
						beforeSend : function() {
							alert('before send')
						},
						uploadProgress : function(event, position, total,
								percentComplete) {
							console.log('');
							console.log('uploadProgress');
							console.log('position:' + position);
							console.log('total:' + total);
							console.log('percentComplete:' + percentComplete);
							$('#progress').html(percentComplete+'%');
						},
						success : function(res) {
							alert('success');
							console.log(res);
						},
						complete : function(xhr) {
							alert('complete');
							console.log(xhr);
						}
					});
			// 			alert('Finish');
			// 			$('testForm').ajaxForm(function(){
			// 				alert("Thank you for your comment");
			// 			});
		});
	</script>
</body>
</html>