<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!DOCTYPE html>
<html lang="zh-CN">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<body>
	<jsp:include page="header.jsp" flush="true"></jsp:include>
	<script src="<%=request.getContextPath()%>/js/common/modelCenter.js"></script>
	<div class="container">
		<div class="row">
			<div class="col-md-9">
				<div class="carousel slide" data-ride="carousel"
					id="carousel_shop_center">
					<ol class="carousel-indicators">
						<li data-target="#carousel_shop_center" data-slide-to="0"
							class="active"></li>
						<li data-target="#carousel_shop_center" data-slide-to="1"></li>
						<li data-target="#carousel_shop_center" data-slide-to="2"></li>
					</ol>
					<div class="carousel-inner" role="listbox">
						<div class="item active">
							<img src="../Image/slider-bg-1.png" alt="...">
							<div class="carousel-caption">...</div>
						</div>
						<div class="item">
							<img src="../Image/slider-bg-1.png" alt="...">
							<div class="carousel-caption">...</div>
						</div>
						<div class="item">
							<img src="../Image/slider-bg-1.png" alt="...">
							<div class="carousel-caption">...</div>
						</div>
					</div>
					<a class="left carousel-control" href="#carousel_shop_center"
						role="button" data-slide="prev"> <span class="icon-prev"
						aria-hidden="true"></span> <span class="sr-only">Previous</span>
					</a> <a class="right carousel-control" href="#carousel_shop_center"
						role="button" data-slide="next"> <span class="icon-next"
						aria-hidden="true"></span> <span class="sr-only">Next</span>
					</a>
				</div>
				<br />
				<div class="row">
					<div class="col-md-4">
						<div class="thumbnail">
							<img src="http://placehold.it/320x150" alt="">
							<div class="caption">
								<h4 class="pull-right">$24.99</h4>
								<h4>
									<a href="#">First Product</a>
								</h4>
								<p>
									See more snippets like this online store item at <a
										target="_blank" href="http://www.bootsnipp.com">Bootsnipp
										- http://bootsnipp.com</a>.
								</p>
							</div>
							<div class="ratings">
								<p class="pull-right">15 reviews</p>
								<p>
									<span class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span>
								</p>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="thumbnail">
							<img src="http://placehold.it/320x150" alt="">
							<div class="caption">
								<h4 class="pull-right">$24.99</h4>
								<h4>
									<a href="#">First Product</a>
								</h4>
								<p>
									See more snippets like this online store item at <a
										target="_blank" href="http://www.bootsnipp.com">Bootsnipp
										- http://bootsnipp.com</a>.
								</p>
							</div>
							<div class="ratings">
								<p class="pull-right">15 reviews</p>
								<p>
									<span class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span>
								</p>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="thumbnail">
							<img src="http://placehold.it/320x150" alt="">
							<div class="caption">
								<h4 class="pull-right">$24.99</h4>
								<h4>
									<a href="#">First Product</a>
								</h4>
								<p>
									See more snippets like this online store item at <a
										target="_blank" href="http://www.bootsnipp.com">Bootsnipp
										- http://bootsnipp.com</a>.
								</p>
							</div>
							<div class="ratings">
								<p class="pull-right">15 reviews</p>
								<p>
									<span class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span>
								</p>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="thumbnail">
							<img src="http://placehold.it/320x150" alt="">
							<div class="caption">
								<h4 class="pull-right">$24.99</h4>
								<h4>
									<a href="#">First Product</a>
								</h4>
								<p>
									See more snippets like this online store item at <a
										target="_blank" href="http://www.bootsnipp.com">Bootsnipp
										- http://bootsnipp.com</a>.
								</p>
							</div>
							<div class="ratings">
								<p class="pull-right">15 reviews</p>
								<p>
									<span class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span>
								</p>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="thumbnail">
							<img src="http://placehold.it/320x150" alt="">
							<div class="caption">
								<h4 class="pull-right">$24.99</h4>
								<h4>
									<a href="#">First Product</a>
								</h4>
								<p>
									See more snippets like this online store item at <a
										target="_blank" href="http://www.bootsnipp.com">Bootsnipp
										- http://bootsnipp.com</a>.
								</p>
							</div>
							<div class="ratings">
								<p class="pull-right">15 reviews</p>
								<p>
									<span class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span>
								</p>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="thumbnail">
							<img src="http://placehold.it/320x150" alt="">
							<div class="caption">
								<h4 class="pull-right">$24.99</h4>
								<h4>
									<a href="#">First Product</a>
								</h4>
								<p>
									See more snippets like this online store item at <a
										target="_blank" href="http://www.bootsnipp.com">Bootsnipp
										- http://bootsnipp.com</a>.
								</p>
							</div>
							<div class="ratings">
								<p class="pull-right">15 reviews</p>
								<p>
									<span class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span> <span
										class="glyphicon glyphicon-star"></span>
								</p>
							</div>
						</div>
					</div>
				</div>
				<!--/row-->
				<br />
				<nav>
					<ul class="pagination">
						<li><a href="#">前继5页</a></li>
						<li><a href="#" aria-label="Previous"> <span
								aria-hidden="true">&laquo;</span>
						</a></li>
						<li><a href="#">1</a></li>
						<li><a href="#">2</a></li>
						<li><a href="#">3</a></li>
						<li><a href="#">4</a></li>
						<li><a href="#">5</a></li>
						<li><a href="#" aria-label="Next"> <span
								aria-hidden="true">&raquo;</span>
						</a></li>
						<li><a href="#">后续5页</a></li>
					</ul>
				</nav>
			</div>
			<!--/.col-md-9-->

			<div class="col-md-3" id="sidebar" role="navigation">
				<div class="list-group">
					<a href="#" class="list-group-item active">全部</a> <a href="#"
						class="list-group-item">艺术</a> <a href="#" class="list-group-item">时尚</a>
					<a href="#" class="list-group-item">玩具</a> <a href="#"
						class="list-group-item">饰品</a> <a href="#" class="list-group-item">首饰</a>
					<a href="#" class="list-group-item">家居</a> <a href="#"
						class="list-group-item">零件</a>
				</div>
				<br />
				<form class="form-inline">
					<div class="form-group">
						<label for="sortType">排序类型：</label> <select class="form-control"
							id="sortType">
							<option>评分</option>
							<option>最近</option>
							<option>大小</option>
						</select>
					</div>
					<button type="button" class="btn btn-default">
						<span class="glyphicon glyphicon-arrow-up" aria-hidden="true"></span>
					</button>
					<button type="button" class="btn btn-default">
						<span class="glyphicon glyphicon-arrow-down" aria-hidden="true"></span>
					</button>
				</form>
				<br />
				<div class="input-group">
					<input type="text" class="form-control" placeholder="关键字搜索...">
					<span class="input-group-btn">
						<button class="btn btn-default" type="button">搜索</button>
					</span>
				</div>
			</div>
		</div>
	</div>
</body>
</html>