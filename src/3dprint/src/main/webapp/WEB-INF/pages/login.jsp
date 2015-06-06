<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<html>
<body>
	<h1 id="banner">Login to 3DPrint Web Site</h1>
	<a href="common/index">访问首页</a>
	<br>
	<br>
	<form name="f" action="<c:url value='../j_spring_security_check'/>"
		method="POST">
		<table>
			<tr>
				<td>Username:</td>
				<td><input type='text' name='j_username' /></td>
			</tr>
			<tr>
				<td>Password:</td>
				<td><input type='password' name='j_password'></td>
			</tr>
			<tr>
				<td colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td colspan='2'><input name="submit" type="submit">&nbsp;<input
					name="reset" type="reset"></td>
			</tr>
		</table>
	</form>
</body>
</html>