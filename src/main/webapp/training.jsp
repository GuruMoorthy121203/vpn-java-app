<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.*, javax.servlet.*"%>
<%
// Safely check role from existing session
if (session.getAttribute("role") == null || !"training".equals(session.getAttribute("role"))) {
	response.sendRedirect("login.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Training Dashboard</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	rel="stylesheet">
<style>
body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	min-height: 100vh;
	padding: 20px 0;
}

.container {
	max-width: 800px;
}

.back-button-container {
	margin-bottom: 30px;
}

.back-btn {
	background: linear-gradient(135deg, #4CAF50, #45a049);
	color: white;
	padding: 12px 24px;
	border: none;
	border-radius: 50px;
	cursor: pointer;
	font-weight: 600;
	text-decoration: none;
	display: inline-flex;
	align-items: center;
	gap: 8px;
	transition: all 0.3s ease;
	box-shadow: 0 4px 15px rgba(76, 175, 80, 0.3);
}

.back-btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 6px 20px rgba(76, 175, 80, 0.4);
	color: white;
}

.main-card {
	background: rgba(255, 255, 255, 0.95);
	backdrop-filter: blur(10px);
	border: 1px solid rgba(255, 255, 255, 0.2);
	border-radius: 20px;
	padding: 40px;
	box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
	transition: transform 0.3s ease;
}

.main-card:hover {
	transform: translateY(-5px);
}

.dashboard-title {
	color: #2c3e50;
	font-weight: 700;
	margin-bottom: 30px;
	position: relative;
	text-align: center;
}

.dashboard-title::after {
	content: '';
	position: absolute;
	bottom: -10px;
	left: 50%;
	transform: translateX(-50%);
	width: 80px;
	height: 4px;
	background: linear-gradient(135deg, #667eea, #764ba2);
	border-radius: 2px;
}

.dashboard-title i {
	color: #667eea;
	margin-right: 10px;
}

.action-buttons {
	display: grid;
	gap: 20px;
	margin-bottom: 30px;
}

.action-btn {
	padding: 18px 30px;
	border: none;
	border-radius: 15px;
	font-weight: 600;
	font-size: 16px;
	text-decoration: none;
	transition: all 0.3s ease;
	position: relative;
	overflow: hidden;
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 10px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.action-btn::before {
	content: '';
	position: absolute;
	top: 0;
	left: -100%;
	width: 100%;
	height: 100%;
	background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
	transition: left 0.5s ease;
}

.action-btn:hover::before {
	left: 100%;
}

.action-btn:hover {
	transform: translateY(-3px);
	box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
}

.btn-add {
	background: linear-gradient(135deg, #007bff, #0056b3);
	color: white;
}

.btn-add:hover {
	color: white;
	box-shadow: 0 8px 25px rgba(0, 123, 255, 0.3);
}

.btn-view {
	background: linear-gradient(135deg, #28a745, #1e7e34);
	color: white;
}

.btn-view:hover {
	color: white;
	box-shadow: 0 8px 25px rgba(40, 167, 69, 0.3);
}

.welcome-message {
	background: linear-gradient(135deg, #f8f9fa, #e9ecef);
	padding: 25px;
	border-radius: 15px;
	margin-bottom: 30px;
	border-left: 5px solid #667eea;
	color: #495057;
	font-size: 16px;
	line-height: 1.6;
}

.welcome-message i {
	color: #667eea;
	margin-right: 10px;
}

.logout-section {
	text-align: center;
	padding-top: 20px;
	border-top: 1px solid rgba(0, 0, 0, 0.1);
}

.logout-btn {
	background: linear-gradient(135deg, #dc3545, #c82333);
	color: white;
	padding: 12px 30px;
	border: none;
	border-radius: 50px;
	cursor: pointer;
	font-weight: 600;
	transition: all 0.3s ease;
	box-shadow: 0 4px 15px rgba(220, 53, 69, 0.3);
}

.logout-btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 6px 20px rgba(220, 53, 69, 0.4);
}

.feature-icons {
	font-size: 1.2em;
}

@media (max-width: 768px) {
	.container {
		padding: 0 15px;
	}
	
	.main-card {
		padding: 25px;
	}
	
	.action-btn {
		padding: 15px 20px;
		font-size: 14px;
	}
}

/* Animated background elements */
.bg-decoration {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	pointer-events: none;
	z-index: -1;
}

.bg-decoration::before {
	content: '';
	position: absolute;
	top: 20%;
	right: 10%;
	width: 200px;
	height: 200px;
	background: radial-gradient(circle, rgba(255, 255, 255, 0.1), transparent);
	border-radius: 50%;
	animation: float 6s ease-in-out infinite;
}

.bg-decoration::after {
	content: '';
	position: absolute;
	bottom: 20%;
	left: 10%;
	width: 150px;
	height: 150px;
	background: radial-gradient(circle, rgba(255, 255, 255, 0.1), transparent);
	border-radius: 50%;
	animation: float 8s ease-in-out infinite reverse;
}

@keyframes float {
	0%, 100% { transform: translateY(0px); }
	50% { transform: translateY(-20px); }
}
</style>
</head>

<body>
	<div class="bg-decoration"></div>
	
	<div class="container">
		<div class="back-button-container">
			<form action="dashboard.jsp" method="get">
				<button type="submit" class="back-btn">
					<i class="fas fa-arrow-left"></i> Back to Dashboard
				</button>
			</form>
		</div>

		<div class="main-card">
			<h2 class="dashboard-title">
				<i class="fas fa-graduation-cap"></i>Training Dashboard
			</h2>
			
			<div class="action-buttons">
				<a href="AddTraining.jsp" class="action-btn btn-add">
					<i class="fas fa-plus-circle feature-icons"></i>
					Add Training/Test
				</a>
				<a href="ViewTraining.jsp" class="action-btn btn-view">
					<i class="fas fa-eye feature-icons"></i>
					View All Sessions
				</a>
			</div>
			
			<div class="welcome-message">
				<i class="fas fa-info-circle"></i>
				<strong>Welcome Training Team!</strong> 
			</div>
			
			<div class="logout-section">
				<form action="logout" method="post">
					<input type="submit" class="logout-btn" value="🔓 Logout" />
				</form>
			</div>
		</div>
	</div>
</body>
</html>