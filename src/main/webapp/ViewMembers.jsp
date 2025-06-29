<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    if (session == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>View Members</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 40px 0;
            display: flex; /* Use flexbox to organize content */
            flex-direction: column; /* Stack items vertically */
            align-items: center; /* Center content horizontally */
        }

        .container {
            max-width: 1100px;
            width: 100%; /* Ensure container takes full width up to max-width */
            margin-top: 20px; /* Add some margin from the top, below the back link */
        }

        .main-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            width: 100%; /* Ensure the card takes full width of its container */
        }

        .header-section {
            background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
            color: white;
            padding: 30px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .header-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="20" cy="20" r="2" fill="rgba(255,255,255,0.1)"/><circle cx="80" cy="80" r="2" fill="rgba(255,255,255,0.1)"/><circle cx="40" cy="60" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="90" cy="30" r="1.5" fill="rgba(255,255,255,0.1)"/><circle cx="10" cy="70" r="1" fill="rgba(255,255,255,0.1)"/></svg>');
            animation: float 20s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-10px) rotate(5deg); }
        }

        .header-section h2 {
            margin: 0;
            font-size: 2.5rem;
            font-weight: 700;
            position: relative;
            z-index: 2;
        }

        .header-subtitle {
            margin-top: 10px;
            opacity: 0.9;
            font-size: 1.1rem;
            position: relative;
            z-index: 2;
        }

        .table-container {
            padding: 40px;
            background: #f8f9fa;
        }

        .table {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            border: none;
        }

        .table thead {
            background: linear-gradient(135deg, #343a40 0%, #495057 100%);
        }

        .table thead th {
            border: none;
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 20px 15px;
            font-size: 0.85rem;
        }

        .table tbody tr {
            transition: all 0.3s ease;
            border: none;
        }

        .table tbody tr:hover {
            background: linear-gradient(135deg, #e3f2fd 0%, #f3e5f5 100%);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
        }

        .table tbody td {
            border: none;
            padding: 18px 15px;
            vertical-align: middle;
            border-bottom: 1px solid #f1f3f4;
        }

        .table tbody tr:last-child td {
            border-bottom: none;
        }

        .btn-custom {
            border-radius: 25px;
            padding: 8px 20px;
            font-weight: 600;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
            border: none;
            position: relative;
            overflow: hidden;
        }

        .btn-custom::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .btn-custom:hover::before {
            left: 100%;
        }

        .btn-danger-custom {
            background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(231, 76, 60, 0.3);
        }

        .btn-danger-custom:hover {
            background: linear-gradient(135deg, #c0392b 0%, #a93226 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(231, 76, 60, 0.4);
            color: white;
        }

        .btn-primary-custom {
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
        }

        .btn-primary-custom:hover {
            background: linear-gradient(135deg, #2980b9 0%, #1f618d 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(52, 152, 219, 0.4);
            color: white;
        }

        .member-id {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 8px 12px;
            border-radius: 20px;
            font-weight: 600;
            display: inline-block;
            min-width: 40px;
            text-align: center;
        }

        .member-name {
            font-weight: 600;
            color: #2c3e50;
        }

        .member-email {
            color: #7f8c8d;
            font-style: italic;
        }

        .error-message {
            background: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
            color: white;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            font-weight: 600;
        }

        .stats-bar {
            background: #f8f9fa;
            padding: 20px;
            border-bottom: 1px solid #e9ecef;
        }

        .stat-item {
            text-align: center;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: #3498db;
        }

        .stat-label {
            color: #6c757d;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
            justify-content: center;
        }

        /* --- CSS for the Back to Module button --- */
        .back-link-container {
            width: 100%; /* Take full width */
            max-width: 1100px; /* Match container max-width */
            margin-bottom: 20px; /* Space between button and main card */
            padding-left: 20px; /* Align with container's padding or content */
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            padding: 10px 20px;
            background: rgba(255, 255, 255, 0.2); /* Slightly transparent white */
            color: white;
            text-decoration: none;
            border-radius: 30px;
            font-weight: 600;
            transition: all 0.3s ease;
            backdrop-filter: blur(5px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .back-link:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.2);
            color: white; /* Ensure text remains white on hover */
        }

        .back-link .fas {
            margin-right: 8px;
        }
        /* --- End of CSS for the Back to Module button --- */

        @media (max-width: 768px) {
            .header-section h2 {
                font-size: 2rem;
            }
            
            .table-container {
                padding: 20px;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .btn-custom {
                padding: 6px 16px;
                font-size: 0.8rem;
            }

            .back-link-container {
                padding-left: 15px; /* Adjust padding for smaller screens */
            }
        }

        .fade-in {
            animation: fadeIn 0.8s ease-in-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
<div class="back-link-container">
    <a href="admin.jsp" class="back-link">
        <i class="fas fa-arrow-left me-2"></i>Back to Module
    </a>
</div>

<div class="container fade-in">
    <div class="main-card">
        <div class="header-section">
            <h2><i class="fas fa-users me-3"></i>Members Management</h2>
            <p class="header-subtitle">Manage and monitor all registered members</p>
        </div>

        <div class="table-container">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th><i class="fas fa-hashtag me-2"></i>ID</th>
                            <th><i class="fas fa-user me-2"></i>Name</th>
                            <th><i class="fas fa-envelope me-2"></i>Email</th>
                            <th colspan="2" class="text-center"><i class="fas fa-cogs me-2"></i>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                        try {
                            Class.forName("org.postgresql.Driver");
                            Connection conn = DriverManager.getConnection(
                                "jdbc:postgresql://localhost:5432/vpn_project_db", "postgres", "postgres");

                            Statement stmt = conn.createStatement();
                            ResultSet rs = stmt.executeQuery("SELECT * FROM members");

                            while(rs.next()) {
                                int id = rs.getInt("id");
                    %>
                        <tr>
                            <td>
                                <span class="member-id"><%= id %></span>
                            </td>
                            <td>
                                <span class="member-name"><%= rs.getString("name") %></span>
                            </td>
                            <td>
                                <span class="member-email"><%= rs.getString("email") %></span>
                            </td>
                            <td class="text-center">
                                <div class="action-buttons">
                                    <a href="DeleteMemberServlet?id=<%= id %>" 
                                       class="btn btn-custom btn-danger-custom"
                                       onclick="return confirm('Are you sure you want to delete this member?')">
                                        <i class="fas fa-trash-alt me-1"></i>Delete
                                    </a>
                                </div>
                            </td>
                            <td class="text-center">
                                <div class="action-buttons">
                                    <a href="EditMember.jsp?id=<%= id %>" 
                                       class="btn btn-custom btn-primary-custom">
                                        <i class="fas fa-edit me-1"></i>Edit
                                    </a>
                                </div>
                            </td>
                        </tr>
                    <%
                            }
                            conn.close();
                        } catch(Exception e) {
                    %>
                        <tr>
                            <td colspan="5">
                                <div class="error-message">
                                    <i class="fas fa-exclamation-triangle me-2"></i>
                                    Error loading members: <%= e.getMessage() %>
                                </div>
                            </td>
                        </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>