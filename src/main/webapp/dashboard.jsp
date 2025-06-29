<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<%
// Check if user is logged in
String userRole = (String) session.getAttribute("role");
String username = (String) session.getAttribute("username");
if (userRole == null || username == null) {
	response.sendRedirect("login.jsp");
	return;
}

// VPN session simulation
String vpnSessionId = (String) session.getAttribute("vpnSessionId");
if (vpnSessionId == null) {
	vpnSessionId = UUID.randomUUID().toString();
	session.setAttribute("vpnSessionId", vpnSessionId);
}
%>

<!DOCTYPE html>
<html>
<head>
<title>VPN Office Dashboard</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	rel="stylesheet">
<style>
:root {
	--primary-color: #2563eb;
	--secondary-color: #1e40af;
	--success-color: #10b981;
	--danger-color: #ef4444;
	--warning-color: #f59e0b;
	--info-color: #06b6d4;
	--dark-color: #1f2937;
	--light-gray: #f8fafc;
	--border-color: #e2e8f0;
	--shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
	--shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
	--shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
	--shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
}

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Inter', 'Segoe UI', system-ui, -apple-system, sans-serif;
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	min-height: 100vh;
	padding: 20px;
	line-height: 1.6;
}

.container {
	max-width: 1200px;
	margin: auto;
}

/* Header Styles */
.header {
	background: linear-gradient(135deg, #ffffff 0%, #f8fafc 100%);
	padding: 30px;
	border-radius: 20px;
	margin-bottom: 25px;
	box-shadow: var(--shadow-xl);
	border: 1px solid rgba(255, 255, 255, 0.2);
	backdrop-filter: blur(10px);
	position: relative;
	overflow: hidden;
}

.header::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	height: 4px;
	background: linear-gradient(90deg, var(--primary-color), var(--info-color), var(--success-color));
	border-radius: 20px 20px 0 0;
}

.header h2 {
	color: var(--dark-color);
	font-weight: 700;
	font-size: 2rem;
	margin-bottom: 8px;
	display: flex;
	align-items: center;
	gap: 12px;
}

.header h2 i {
	color: var(--primary-color);
	font-size: 1.8rem;
}

.header .text-success {
	font-weight: 600;
	color: var(--success-color) !important;
	font-size: 1.1rem;
	display: flex;
	align-items: center;
	gap: 8px;
}

.header .text-success::before {
	content: '';
	width: 8px;
	height: 8px;
	background: var(--success-color);
	border-radius: 50%;
	animation: pulse 2s infinite;
}

@keyframes pulse {
	0%, 100% { opacity: 1; }
	50% { opacity: 0.5; }
}

.header .btn-danger {
	background: linear-gradient(135deg, var(--danger-color), #dc2626);
	border: none;
	padding: 12px 24px;
	border-radius: 12px;
	font-weight: 600;
	transition: all 0.3s ease;
	box-shadow: var(--shadow-md);
}

.header .btn-danger:hover {
	transform: translateY(-2px);
	box-shadow: var(--shadow-lg);
	background: linear-gradient(135deg, #dc2626, #b91c1c);
}

/* User Info Styles */
.info {
	background: linear-gradient(135deg, #ffffff 0%, #f8fafc 100%);
	padding: 25px 30px;
	border-radius: 16px;
	margin-bottom: 25px;
	box-shadow: var(--shadow-lg);
	border: 1px solid var(--border-color);
	position: relative;
}

.info strong {
	font-size: 1.2rem;
	color: var(--dark-color);
	font-weight: 700;
}

.info .badge {
	font-size: 0.9rem;
	padding: 8px 16px;
	border-radius: 20px;
	font-weight: 600;
	letter-spacing: 0.5px;
	background: linear-gradient(135deg, var(--primary-color), var(--secondary-color)) !important;
}

.info small {
	color: #6b7280;
	font-weight: 500;
	background: #f1f5f9;
	padding: 6px 12px;
	border-radius: 8px;
	font-family: monospace;
}

/* Modules Container */
.modules {
	background: linear-gradient(135deg, #ffffff 0%, #f8fafc 100%);
	padding: 30px;
	border-radius: 20px;
	box-shadow: var(--shadow-xl);
	border: 1px solid var(--border-color);
}

.modules a {
	text-decoration: none;
	color: inherit;
	display: block;
	height: 100%;
}

/* Module Card Styles */
.module-card {
	background: linear-gradient(135deg, #ffffff 0%, #fafbfc 100%);
	border: 1px solid var(--border-color);
	border-radius: 16px;
	padding: 30px 20px;
	text-align: center;
	transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
	position: relative;
	overflow: hidden;
	height: 100%;
	min-height: 200px;
	display: flex;
	flex-direction: column;
	justify-content: center;
	box-shadow: var(--shadow-sm);
}

.module-card::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	height: 4px;
	background: linear-gradient(90deg, transparent, var(--primary-color), transparent);
	transform: translateX(-100%);
	transition: transform 0.6s ease;
}

.module-card:hover::before {
	transform: translateX(100%);
}

.module-card:hover {
	transform: translateY(-8px);
	box-shadow: var(--shadow-xl);
	border-color: var(--primary-color);
}

.module-card i {
	margin-bottom: 16px;
	transition: all 0.3s ease;
}

.module-card:hover i {
	transform: scale(1.1);
}

.module-card h5 {
	color: var(--dark-color);
	font-weight: 700;
	font-size: 1.3rem;
	margin-bottom: 12px;
	transition: color 0.3s ease;
}

.module-card:hover h5 {
	color: var(--primary-color);
}

.module-card p {
	color: #6b7280;
	font-size: 0.95rem;
	margin-bottom: 0;
	line-height: 1.5;
}

/* Icon Colors */
.text-info { color: var(--info-color) !important; }
.text-danger { color: var(--danger-color) !important; }
.text-warning { color: var(--warning-color) !important; }
.text-success { color: var(--success-color) !important; }
.text-primary { color: var(--primary-color) !important; }
.text-secondary { color: #6b7280 !important; }

/* Responsive Design */
@media (max-width: 768px) {
	body {
		padding: 10px;
	}
	
	.header {
		padding: 20px;
		text-align: center;
	}
	
	.header .d-flex {
		flex-direction: column;
		gap: 15px;
	}
	
	.header h2 {
		font-size: 1.5rem;
		justify-content: center;
	}
	
	.info {
		padding: 20px;
		text-align: center;
	}
	
	.info .d-flex {
		flex-direction: column;
		gap: 12px;
	}
	
	.modules {
		padding: 20px;
	}
	
	.module-card {
		padding: 25px 15px;
		min-height: 180px;
	}
}

@media (max-width: 576px) {
	.header h2 {
		font-size: 1.3rem;
	}
	
	.module-card {
		min-height: 160px;
	}
	
	.module-card h5 {
		font-size: 1.1rem;
	}
	
	.module-card p {
		font-size: 0.9rem;
	}
}

/* Loading Animation */
.module-card {
	opacity: 0;
	animation: fadeInUp 0.6s ease forwards;
}

.module-card:nth-child(1) { animation-delay: 0.1s; }
.module-card:nth-child(2) { animation-delay: 0.2s; }
.module-card:nth-child(3) { animation-delay: 0.3s; }
.module-card:nth-child(4) { animation-delay: 0.4s; }
.module-card:nth-child(5) { animation-delay: 0.5s; }
.module-card:nth-child(6) { animation-delay: 0.6s; }

@keyframes fadeInUp {
	from {
		opacity: 0;
		transform: translateY(30px);
	}
	to {
		opacity: 1;
		transform: translateY(0);
	}
}

/* Scrollbar Styling */
::-webkit-scrollbar {
	width: 8px;
}

::-webkit-scrollbar-track {
	background: #f1f5f9;
	border-radius: 10px;
}

::-webkit-scrollbar-thumb {
	background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
	border-radius: 10px;
}

::-webkit-scrollbar-thumb:hover {
	background: linear-gradient(135deg, var(--secondary-color), var(--primary-color));
}
</style>
</head>
<body>

	<div class="container">

		<!-- Header -->
		<div class="header d-flex justify-content-between align-items-center">
			<div>
				<h2>
					<i class="fas fa-shield-alt"></i> VPN Dashboard
				</h2>
				<p class="text-success mb-0">VPN Connected - Session Active</p>
			</div>
			<div>
				<form action="logout" method="post">
					<button type="submit" class="btn btn-danger">
						<i class="fas fa-sign-out-alt"></i> Logout
					</button>
				</form>
			</div>
		</div>

		<!-- User Info -->
		<div class="info d-flex justify-content-between align-items-center">
			<div>
				<strong>Welcome, <%=username%></strong> <span
					class="badge bg-primary ms-2"><%=userRole.toUpperCase()%></span>
			</div>
			<div>
				<small>Session ID: <%=vpnSessionId.substring(0, 8)%>...
				</small>
			</div>
		</div>

		<!-- Modules -->
		<div class="modules">
			<div class="row g-4">
				<%
				if ("admin".equals(userRole) || "training".equals(userRole) || "marketing".equals(userRole)) {
				%>
				<div class="col-md-4">
					<a href="file_list.jsp">
						<div class="module-card">
							<i class="fas fa-folder-open fa-2x mb-2 text-info"></i>
							<h5>Shared Files</h5>
							<p>Access uploaded files securely</p>
						</div>
					</a>
				</div>
				<%
				}
				%>

				<%
				if ("admin".equals(userRole)) {
				%>
				<div class="col-md-4">
					<a href="admin.jsp">
						<div class="module-card">
							<i class="fas fa-users-cog fa-2x mb-2 text-danger"></i>
							<h5>Admin Module</h5>
							<p>Manage users and system settings</p>
						</div>
					</a>
				</div>
				<%
				}
				%>

				<%
				if ("marketing".equals(userRole) || "admin".equals(userRole)) {
				%>
				<div class="col-md-4">
					<a href="marketing.jsp">
						<div class="module-card">
							<i class="fas fa-chart-line fa-2x mb-2 text-info"></i>
							<h5>Marketing Module</h5>
							<p>Manage leads securely</p>
						</div>
					</a>
				</div>
				<%
				}
				%>

				<%
				if ("training".equals(userRole) || "admin".equals(userRole)) {
				%>
				<div class="col-md-4">
					<a href="training.jsp">
						<div class="module-card">
							<i class="fas fa-graduation-cap fa-2x mb-2 text-warning"></i>
							<h5>Training Module</h5>
							<p>Access VPN training sessions</p>
						</div>
					</a>
				</div>
				<%
				}
				%>

				<%
				if ("admin".equals(userRole)) {
				%>
				<div class="col-md-4">
					<a href="upload.jsp">
						<div class="module-card">
							<i class="fas fa-upload fa-2x mb-2 text-success"></i>
							<h5>Secure Upload</h5>
							<p>Upload documents via encrypted VPN</p>
						</div>
					</a>
				</div>
				<%
				}
				%>
				<!-- Additional modules -->
				<%
				if ("admin".equals(userRole)) {
				%>
				<div class="col-md-4">
					<a href="login-logs.jsp">
						<div class="module-card">
							<i class="fas fa-list-alt fa-2x mb-2 text-secondary"></i>
							<h5>Login Logs</h5>
							<p>Track login activity and session history</p>
						</div>
					</a>
				</div>

				<div class="col-md-4">
					<a href="loginanalytics.jsp">
						<div class="module-card">
							<i class="fas fa-chart-pie fa-2x mb-2 text-primary"></i>
							<h5>VPN Analytics</h5>
							<p>Analyze VPN usage and reports</p>
						</div>
					</a>
				</div>
				<div class="col-md-4">
					<a href="download-logs.jsp">
						<div class="module-card">
							<i class="fas fa-download fa-2x mb-2 text-info"></i>
							<h5>Download Logs</h5>
							<p>Track who downloaded which file</p>
						</div>
					</a>
				</div>
				<%
				}
				%>

			</div>
		</div>

	</div>

</body>
</html>