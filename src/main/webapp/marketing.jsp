<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.*, javax.servlet.*"%>

<%
String role = (String) session.getAttribute("role");
if (role == null || !"marketing".equals(role)) {
	response.sendRedirect("login.jsp");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Marketing Dashboard</title>
<meta charset="UTF-8">
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
	padding: 20px;
}

.container {
	max-width: 900px;
	margin: auto;
}

.back-button-container {
	margin-bottom: 20px;
}

.back-btn {
	background: linear-gradient(45deg, #28a745, #20c997);
	color: white;
	padding: 12px 24px;
	border: none;
	border-radius: 50px;
	cursor: pointer;
	font-size: 16px;
	font-weight: 500;
	text-decoration: none;
	display: inline-flex;
	align-items: center;
	gap: 8px;
	transition: all 0.3s ease;
	box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
}

.back-btn:hover {
	background: linear-gradient(45deg, #218838, #1ea06d);
	transform: translateY(-2px);
	box-shadow: 0 6px 20px rgba(40, 167, 69, 0.4);
	color: white;
	text-decoration: none;
}

.main-card {
	background: rgba(255, 255, 255, 0.95);
	backdrop-filter: blur(20px);
	border: 1px solid rgba(255, 255, 255, 0.2);
	border-radius: 20px;
	padding: 40px;
	box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
	animation: slideUp 0.6s ease-out;
}

@keyframes slideUp {
	from {
		opacity: 0;
		transform: translateY(30px);
	}
	to {
		opacity: 1;
		transform: translateY(0);
	}
}

.welcome-title {
	background: linear-gradient(45deg, #667eea, #764ba2);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	background-clip: text;
	font-weight: 700;
	font-size: 2.5rem;
	margin-bottom: 20px;
}

.subtitle {
	color: #6c757d;
	font-size: 1.1rem;
	margin-bottom: 30px;
	line-height: 1.6;
}

.dashboard-title {
	color: #495057;
	font-weight: 600;
	margin-bottom: 30px;
	position: relative;
	padding-bottom: 10px;
}

.dashboard-title::after {
	content: '';
	position: absolute;
	bottom: 0;
	left: 50%;
	transform: translateX(-50%);
	width: 60px;
	height: 3px;
	background: linear-gradient(45deg, #667eea, #764ba2);
	border-radius: 2px;
}

.action-buttons {
	display: flex;
	justify-content: center;
	gap: 20px;
	margin-bottom: 40px;
	flex-wrap: wrap;
}

.action-btn {
	padding: 15px 30px;
	border: none;
	border-radius: 50px;
	font-size: 16px;
	font-weight: 600;
	text-decoration: none;
	display: inline-flex;
	align-items: center;
	gap: 10px;
	transition: all 0.3s ease;
	min-width: 180px;
	justify-content: center;
	position: relative;
	overflow: hidden;
}

.action-btn::before {
	content: '';
	position: absolute;
	top: 0;
	left: -100%;
	width: 100%;
	height: 100%;
	background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
	transition: left 0.5s;
}

.action-btn:hover::before {
	left: 100%;
}

.btn-add-lead {
	background: linear-gradient(45deg, #28a745, #20c997);
	color: white;
	box-shadow: 0 8px 25px rgba(40, 167, 69, 0.3);
}

.btn-add-lead:hover {
	background: linear-gradient(45deg, #218838, #1ea06d);
	transform: translateY(-3px);
	box-shadow: 0 12px 35px rgba(40, 167, 69, 0.4);
	color: white;
}

.btn-view-leads {
	background: linear-gradient(45deg, #007bff, #6f42c1);
	color: white;
	box-shadow: 0 8px 25px rgba(0, 123, 255, 0.3);
}

.btn-view-leads:hover {
	background: linear-gradient(45deg, #0056b3, #5a2d91);
	transform: translateY(-3px);
	box-shadow: 0 12px 35px rgba(0, 123, 255, 0.4);
	color: white;
}

.logout-container {
	text-align: center;
	margin-top: 20px;
}

.logout-btn {
	background: linear-gradient(45deg, #dc3545, #e74c3c);
	color: white;
	padding: 12px 30px;
	border: none;
	border-radius: 50px;
	font-size: 16px;
	font-weight: 500;
	cursor: pointer;
	transition: all 0.3s ease;
	box-shadow: 0 6px 20px rgba(220, 53, 69, 0.3);
}

.logout-btn:hover {
	background: linear-gradient(45deg, #c82333, #dc2626);
	transform: translateY(-2px);
	box-shadow: 0 8px 25px rgba(220, 53, 69, 0.4);
}

.icon {
	font-size: 1.2rem;
}

/* Responsive design */
@media (max-width: 768px) {
	.main-card {
		padding: 25px;
		margin: 10px;
	}
	
	.welcome-title {
		font-size: 2rem;
	}
	
	.action-buttons {
		flex-direction: column;
		align-items: center;
	}
	
	.action-btn {
		width: 100%;
		max-width: 280px;
	}
}

@media (max-width: 576px) {
	.welcome-title {
		font-size: 1.8rem;
	}
	
	.subtitle {
		font-size: 1rem;
	}
}
</style>
</head>

<body>
	<div class="container">
		<div class="back-button-container">
			<form action="dashboard.jsp" method="get" style="margin: 0;">
				<button type="submit" class="back-btn">
					<i class="fas fa-arrow-left icon"></i>
					Back to Dashboard
				</button>
			</form>
		</div>

		<div class="main-card">
			<h2 class="text-center welcome-title">
				<i class="fas fa-chart-line me-3"></i>
				Welcome Marketing Team!
			</h2>
			<p class="text-center subtitle">
				Here you can share promotional messages securely using the VPN system.
				Manage your leads and campaigns with enterprise-grade security.
			</p>

			<h3 class="text-center dashboard-title">Marketing Dashboard</h3>
			
			<div class="action-buttons">
				<a href="AddLead.jsp" class="action-btn btn-add-lead">
					<i class="fas fa-user-plus icon"></i>
					Add New Lead
				</a>
				<a href="ViewLeads.jsp" class="action-btn btn-view-leads">
					<i class="fas fa-users icon"></i>
					View All Leads
				</a>
			</div>

			<div class="logout-container">
				<form action="logout" method="post">
					<button type="submit" class="logout-btn">
						<i class="fas fa-sign-out-alt me-2"></i>
						Logout
					</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>