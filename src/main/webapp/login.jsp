<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VPN Login</title>
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
	display: flex;
	align-items: center;
	padding: 20px 0;
}

.login-container {
	max-width: 450px;
	margin: 0 auto;
}

.login-card {
	background: rgba(255, 255, 255, 0.95);
	backdrop-filter: blur(10px);
	border-radius: 20px;
	box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
	border: 1px solid rgba(255, 255, 255, 0.2);
	overflow: hidden;
	transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.login-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 25px 50px rgba(0, 0, 0, 0.2);
}

.card-header {
	background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
	color: white;
	text-align: center;
	padding: 30px 20px 20px;
	border: none;
}

.card-header h2 {
	margin: 0;
	font-weight: 600;
	font-size: 1.8rem;
	text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.vpn-icon {
	font-size: 3rem;
	margin-bottom: 15px;
	opacity: 0.9;
}

.card-body {
	padding: 40px 30px 30px;
}

.form-floating {
	margin-bottom: 20px;
}

.form-control {
	border: 2px solid #e1e5e9;
	border-radius: 12px;
	padding: 12px 16px;
	font-size: 16px;
	transition: all 0.3s ease;
	background: rgba(255, 255, 255, 0.8);
}

.form-control:focus {
	border-color: #4facfe;
	box-shadow: 0 0 0 0.2rem rgba(79, 172, 254, 0.25);
	background: white;
	transform: translateY(-2px);
}

.form-label {
	font-weight: 500;
	color: #495057;
	margin-bottom: 8px;
}

.btn-login {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	border: none;
	border-radius: 12px;
	padding: 14px;
	font-size: 16px;
	font-weight: 600;
	text-transform: uppercase;
	letter-spacing: 0.5px;
	transition: all 0.3s ease;
	box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
}

.btn-login:hover {
	background: linear-gradient(135deg, #5a67d8 0%, #6b46c1 100%);
	transform: translateY(-2px);
	box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
}

.btn-login:active {
	transform: translateY(0);
}

.alert {
	border-radius: 12px;
	border: none;
	font-weight: 500;
	margin-top: 20px;
	animation: slideIn 0.3s ease-out;
}

.alert-danger {
	background: linear-gradient(135deg, #ff6b6b 0%, #ee5a52 100%);
	color: white;
}

.alert-warning {
	background: linear-gradient(135deg, #feca57 0%, #ff9ff3 100%);
	color: white;
}

@keyframes slideIn {
	from {
		opacity: 0;
		transform: translateY(-10px);
	}
	to {
		opacity: 1;
		transform: translateY(0);
	}
}

.input-group {
	position: relative;
}

.input-icon {
	position: absolute;
	left: 15px;
	top: 50%;
	transform: translateY(-50%);
	color: #6c757d;
	z-index: 10;
	pointer-events: none;
}

.form-control.with-icon {
	padding-left: 45px;
}

.security-badge {
	background: rgba(40, 167, 69, 0.1);
	color: #28a745;
	padding: 8px 15px;
	border-radius: 20px;
	font-size: 0.85rem;
	font-weight: 500;
	text-align: center;
	margin-top: 20px;
	border: 1px solid rgba(40, 167, 69, 0.2);
}

.footer-text {
	text-align: center;
	margin-top: 25px;
	color: #6c757d;
	font-size: 0.9rem;
}

/* Responsive adjustments */
@media (max-width: 576px) {
	body {
		padding: 10px;
	}
	
	.login-container {
		max-width: 100%;
	}
	
	.card-body {
		padding: 30px 20px 20px;
	}
	
	.card-header {
		padding: 25px 15px 15px;
	}
	
	.vpn-icon {
		font-size: 2.5rem;
	}
}
</style>
</head>
<body>

	<div class="container">
		<div class="login-container">
			<div class="card login-card">
				<div class="card-header">
					<i class="fas fa-shield-alt vpn-icon"></i>
					<h2>VPN Access Portal</h2>
				</div>
				
				<div class="card-body">
					<form action="login" method="post">
						<div class="mb-3">
							<label for="username" class="form-label">
								<i class="fas fa-user me-2"></i>Username
							</label>
							<div class="input-group">
								<i class="fas fa-user input-icon"></i>
								<input type="text" name="username" id="username" 
									class="form-control with-icon" placeholder="Enter your username" required>
							</div>
						</div>

						<div class="mb-3">
							<label for="password" class="form-label">
								<i class="fas fa-lock me-2"></i>Password
							</label>
							<div class="input-group">
								<i class="fas fa-lock input-icon"></i>
								<input type="password" name="password" id="password"
									class="form-control with-icon" placeholder="Enter your password" required>
							</div>
						</div>

						<div class="d-grid">
							<button type="submit" class="btn btn-primary btn-login">
								<i class="fas fa-sign-in-alt me-2"></i>Secure Login
							</button>
						</div>
					</form>

					<%-- Optional error message display if redirected after failed login --%>
					<%
					String error = request.getParameter("error");
					if ("1".equals(error)) {
					%>
					<div class="alert alert-danger">
						<i class="fas fa-exclamation-triangle me-2"></i>
						Invalid username or password.
					</div>
					<%
					}
					%>
					<%
					if ("session".equals(request.getParameter("error"))) {
					%>
					<div class="alert alert-warning">
						<i class="fas fa-clock me-2"></i>
						Your session expired due to inactivity. Please log in again.
					</div>
					<%
					}
					%>

					<div class="security-badge">
						<i class="fas fa-lock me-2"></i>
						Secured with 256-bit encryption
					</div>
					
					<div class="footer-text">
						VPN Access Portal • Secure Connection
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>