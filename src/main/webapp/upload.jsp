<%
String userRole = (session != null) ? (String) session.getAttribute("role") : null;

if (userRole == null || !userRole.equals("admin")) {
	response.sendRedirect("login.jsp");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>File Upload</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	rel="stylesheet">
<style>
body {
	font-family: 'Segoe UI', sans-serif;
	background: #f4f6f8;
	padding: 20px;
	min-height: 100vh;
}

.container {
	max-width: 800px;
	margin: auto;
}

.upload-card {
	background: white;
	padding: 40px;
	border-radius: 15px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
	margin-top: 20px;
}

.back-btn {
	display: inline-flex;
	align-items: center;
	gap: 8px;
	padding: 12px 24px;
	background: linear-gradient(135deg, #007BFF, #0056b3);
	color: white;
	text-decoration: none;
	border-radius: 8px;
	font-weight: 500;
	transition: all 0.3s ease;
	box-shadow: 0 2px 10px rgba(0, 123, 255, 0.3);
}

.back-btn:hover {
	background: linear-gradient(135deg, #0056b3, #004085);
	transform: translateY(-2px);
	box-shadow: 0 4px 15px rgba(0, 123, 255, 0.4);
	color: white;
	text-decoration: none;
}

.upload-header {
	text-align: center;
	margin-bottom: 40px;
}

.upload-header h2 {
	color: #2c3e50;
	font-weight: 600;
	margin-bottom: 10px;
}

.upload-header .subtitle {
	color: #6c757d;
	font-size: 16px;
}

.upload-form {
	background: #f8f9fa;
	padding: 30px;
	border-radius: 12px;
	border: 2px dashed #dee2e6;
	transition: all 0.3s ease;
}

.upload-form:hover {
	border-color: #007BFF;
	background: #f0f8ff;
}

.file-input-wrapper {
	position: relative;
	margin-bottom: 30px;
}

.file-input {
	width: 100%;
	padding: 15px;
	border: 2px solid #e9ecef;
	border-radius: 8px;
	background: white;
	font-size: 16px;
	transition: all 0.3s ease;
}

.file-input:focus {
	outline: none;
	border-color: #007BFF;
	box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
}

.upload-btn {
	width: 100%;
	padding: 15px;
	background: linear-gradient(135deg, #28a745, #20c997);
	color: white;
	border: none;
	border-radius: 8px;
	font-size: 16px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.3s ease;
	box-shadow: 0 3px 15px rgba(40, 167, 69, 0.3);
}

.upload-btn:hover {
	background: linear-gradient(135deg, #20c997, #17a2b8);
	transform: translateY(-2px);
	box-shadow: 0 5px 20px rgba(40, 167, 69, 0.4);
}

.upload-btn:active {
	transform: translateY(0);
}

.security-info {
	background: linear-gradient(135deg, #e3f2fd, #f3e5f5);
	padding: 20px;
	border-radius: 10px;
	margin-top: 30px;
	border-left: 4px solid #2196f3;
}

.security-info h6 {
	color: #1565c0;
	font-weight: 600;
	margin-bottom: 10px;
}

.security-info ul {
	margin: 0;
	padding-left: 20px;
	color: #424242;
}

.security-info li {
	margin-bottom: 5px;
}

.icon-upload {
	font-size: 48px;
	color: #007BFF;
	margin-bottom: 20px;
}

@media (max-width: 768px) {
	.container {
		padding: 10px;
	}
	
	.upload-card {
		padding: 20px;
		margin-top: 10px;
	}
	
	.back-btn {
		padding: 10px 20px;
		font-size: 14px;
	}
}

/* Drag and drop styling */
.file-input-wrapper.dragover {
	background: #e3f2fd;
	border-color: #2196f3;
}

.upload-animation {
	animation: pulse 2s infinite;
}

@keyframes pulse {
	0% { transform: scale(1); }
	50% { transform: scale(1.05); }
	100% { transform: scale(1); }
}
</style>
</head>
<body>
	<div class="container">
		<a href="dashboard.jsp" class="back-btn">
			<i class="fas fa-arrow-left"></i> Back to Dashboard
		</a>

		<div class="upload-card">
			<div class="upload-header">
				<i class="fas fa-cloud-upload-alt icon-upload"></i>
				<h2>Upload Secure File</h2>
				<p class="subtitle">Upload files securely through encrypted VPN connection</p>
			</div>

			<form action="upload" method="post" enctype="multipart/form-data" class="upload-form">
				<div class="file-input-wrapper">
					<input type="file" name="file" class="file-input" required>
				</div>
				
				<button type="submit" class="upload-btn">
					<i class="fas fa-upload"></i> Upload File
				</button>
			</form>

			<div class="security-info">
				<h6><i class="fas fa-shield-alt"></i> Security Information</h6>
				<ul>
					<li>All files are encrypted during transmission</li>
					<li>Only authorized administrators can upload files</li>
					<li>Files are scanned for security threats</li>
					<li>Upload activity is logged and monitored</li>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>