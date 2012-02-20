<%@ taglib tagdir="/WEB-INF/tags/templates" prefix="t" %>

<t:index redirect_session="true">
	<div class="left">
		<img src="img/index/banner.png"/>
	</div>
	
	<div class="main-links right">
		<a href="${pageContext.request.contextPath}/public/student_application/new_form.jsp" class="right clear">
			Apply Online!
		</a>
		<a href="#" class="right clear">Academics</a>
		<a href="#" class="right clear">Admission</a>
		<a href="#" class="right clear">News</a>
	</div>
	
	<div class="clear clearfix">
		<div class="box left">
			<h2>Vision</h2>
			<p>
				be the preeminent educational institution in the Philippines focused on academic excellence by empowering learners to become independent, 
				highly productive and globally competitive individuals in the industrial community
			</p>
		</div>
		<div class="box left">
			<h2>Mission</h2>
			<p>
				continually creates alternative methodologies to formal education with the objective of preparing students 
				for the world of work through strong linkages and collaboration between academe and industry to support local and global manpower needs
			</p>
		</div>
		<div class="box left">
			<h2>Goal</h2>
			<p>
				an innovative teaching-learning system which will demonstrate a delivery mechanism compliant with the values, 
				legacy, and advocacy of our institution
			</p>
		</div>
		
	</div>
</t:index>
