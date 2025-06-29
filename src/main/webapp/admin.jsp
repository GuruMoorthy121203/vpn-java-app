<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.*, javax.servlet.*"%>

<%
if (session == null || !"admin".equals(session.getAttribute("role"))) {
	response.sendRedirect("login.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Admin Dashboard</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	rel="stylesheet">
<style>
/* Custom CSS Variables */
:root {
    --primary-color: #2c3e50;
    --secondary-color: #3498db;
    --success-color: #27ae60;
    --danger-color: #e74c3c;
    --warning-color: #f39c12;
    --light-bg: #ecf0f1;
    --card-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    --hover-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
    --gradient-primary: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    --gradient-secondary: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
}

/* Body and Background */
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: var(--gradient-primary);
    min-height: 100vh;
    padding: 20px 0;
}

/* Container Styling */
.container {
    max-width: 800px;
}

/* Back Button Styling */
.back-button-container {
    margin-bottom: 30px;
}

.back-btn {
    background: linear-gradient(45deg, var(--success-color), #2ecc71);
    color: white;
    padding: 12px 25px;
    border: none;
    border-radius: 50px;
    cursor: pointer;
    font-weight: 600;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 10px;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(46, 204, 113, 0.3);
}

.back-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(46, 204, 113, 0.4);
    color: white;
}

/* Main Card Styling */
.main-card {
    background: white;
    border-radius: 20px;
    box-shadow: var(--card-shadow);
    border: none;
    overflow: hidden;
    position: relative;
}

.main-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 5px;
    background: var(--gradient-secondary);
}

/* Header Styling */
.admin-header {
    background: linear-gradient(135deg, var(--primary-color), #34495e);
    color: white;
    padding: 30px;
    margin: -1.5rem -1.5rem 2rem -1.5rem;
    text-align: center;
}

.admin-header h2 {
    margin: 0;
    font-size: 2.5rem;
    font-weight: 700;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
}

.admin-header p {
    margin: 15px 0 0 0;
    opacity: 0.9;
    font-size: 1.1rem;
}

/* Action Buttons Container */
.action-buttons {
    padding: 0 20px;
}

/* Enhanced Button Styling */
.action-btn {
    padding: 18px 30px;
    border-radius: 15px;
    font-weight: 600;
    font-size: 1.1rem;
    text-transform: uppercase;
    letter-spacing: 1px;
    border: none;
    position: relative;
    overflow: hidden;
    transition: all 0.3s ease;
    text-decoration: none;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 12px;
}

.btn-add-member {
    background: linear-gradient(45deg, var(--secondary-color), #5dade2);
    color: white;
    box-shadow: 0 8px 25px rgba(61, 173, 226, 0.3);
}

.btn-add-member:hover {
    transform: translateY(-3px);
    box-shadow: 0 12px 35px rgba(61, 173, 226, 0.4);
    color: white;
}

.btn-view-members {
    background: linear-gradient(45deg, var(--success-color), #58d68d);
    color: white;
    box-shadow: 0 8px 25px rgba(39, 174, 96, 0.3);
}

.btn-view-members:hover {
    transform: translateY(-3px);
    box-shadow: 0 12px 35px rgba(39, 174, 96, 0.4);
    color: white;
}

/* Logout Button */
.logout-section {
    margin-top: 40px;
    padding: 30px;
    background: linear-gradient(135deg, #f8f9fa, #e9ecef);
    border-radius: 15px;
}

.btn-logout {
    background: linear-gradient(45deg, var(--danger-color), #ec7063);
    color: white;
    padding: 15px 40px;
    border: none;
    border-radius: 50px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 1px;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 6px 20px rgba(231, 76, 60, 0.3);
}

.btn-logout:hover {
    transform: translateY(-2px);
    box-shadow: 0 10px 30px rgba(231, 76, 60, 0.4);
}

/* Icon Styling */
.btn-icon {
    font-size: 1.2rem;
}

/* Responsive Design */
@media (max-width: 768px) {
    .container {
        padding: 0 15px;
    }
    
    .admin-header h2 {
        font-size: 2rem;
    }
    
    .action-btn {
        padding: 15px 25px;
        font-size: 1rem;
    }
    
    .back-btn {
        padding: 10px 20px;
    }
}

/* Animation Keyframes */
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

.main-card {
    animation: fadeInUp 0.6s ease-out;
}

/* Hover Effects for Interactive Elements */
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
</style>
</head>

<body>
    <div class="container">
        <!-- Back Button -->
        <div class="back-button-container">
            <form action="dashboard.jsp" method="get" style="margin: 0;">
                <button type="submit" class="back-btn">
                    <i class="fas fa-arrow-left"></i>
                    Back to Dashboard
                </button>
            </form>
        </div>

        <!-- Main Admin Card -->
        <div class="card main-card p-4 shadow">
            <!-- Header Section -->
            <div class="admin-header">
                <h2>
                    <i class="fas fa-user-shield"></i>
                    Admin Dashboard
                </h2>
                <p>Welcome Admin! Here you can manage users, monitor connections, and update system settings.</p>
            </div>

            <!-- Action Buttons -->
            <div class="action-buttons">
                <div class="d-grid gap-4 mb-4">
                    <a href="AddMember.jsp" class="btn action-btn btn-add-member">
                        <i class="fas fa-user-plus btn-icon"></i>
                        Add New Member
                    </a>
                    
                    <a href="ViewMembers.jsp" class="btn action-btn btn-view-members">
                        <i class="fas fa-users btn-icon"></i>
                        View All Members
                    </a>
                </div>
            </div>

            <!-- Logout Section -->
            <div class="logout-section text-center">
                <form action="logout" method="post" style="margin: 0;">
                    <button type="submit" class="btn-logout">
                        <i class="fas fa-sign-out-alt"></i>
                        Secure Logout
                    </button>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>