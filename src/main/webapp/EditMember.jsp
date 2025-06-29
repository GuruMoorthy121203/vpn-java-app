<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Member - VPN Office</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px 0;
        }

        .container {
            max-width: 600px;
        }

        .main-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: transform 0.3s ease;
        }

        .main-card:hover {
            transform: translateY(-5px);
        }

        .card-header {
            background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
            color: white;
            padding: 25px;
            text-align: center;
            border: none;
        }

        .card-header h2 {
            margin: 0;
            font-weight: 600;
            font-size: 1.8rem;
        }

        .card-header .subtitle {
            opacity: 0.9;
            font-size: 0.95rem;
            margin-top: 5px;
        }

        .card-body {
            padding: 40px;
        }

        .form-floating {
            margin-bottom: 25px;
        }

        .form-floating > .form-control {
            border: 2px solid #e1e5e9;
            border-radius: 10px;
            height: 60px;
            font-size: 16px;
            transition: all 0.3s ease;
            background-color: #f8f9fa;
        }

        .form-floating > .form-control:focus {
            border-color: #4CAF50;
            box-shadow: 0 0 0 0.25rem rgba(76, 175, 80, 0.25);
            background-color: white;
        }

        .form-floating > label {
            color: #6c757d;
            font-weight: 500;
        }

        .btn-group-custom {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }

        .btn-primary-custom {
            background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
            border: none;
            border-radius: 10px;
            padding: 15px 30px;
            font-weight: 600;
            font-size: 16px;
            transition: all 0.3s ease;
            flex: 1;
        }

        .btn-primary-custom:hover {
            background: linear-gradient(135deg, #45a049 0%, #3d8b40 100%);
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(76, 175, 80, 0.3);
        }

        .btn-secondary-custom {
            background: #6c757d;
            border: none;
            border-radius: 10px;
            padding: 15px 30px;
            font-weight: 600;
            font-size: 16px;
            transition: all 0.3s ease;
            flex: 1;
            color: white;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn-secondary-custom:hover {
            background: #5a6268;
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(108, 117, 125, 0.3);
            color: white;
            text-decoration: none;
        }

        .alert-custom {
            border-radius: 10px;
            border: none;
            padding: 20px;
            margin-bottom: 25px;
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.2);
        }

        .form-icon {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
            z-index: 5;
            pointer-events: none;
        }

        .input-group-custom {
            position: relative;
        }

        .breadcrumb-custom {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            padding: 15px 20px;
            margin-bottom: 30px;
        }

        .breadcrumb-custom .breadcrumb {
            margin: 0;
            background: none;
        }

        .breadcrumb-custom .breadcrumb-item a {
            color: white;
            text-decoration: none;
        }

        .breadcrumb-custom .breadcrumb-item.active {
            color: rgba(255, 255, 255, 0.8);
        }

        @media (max-width: 768px) {
            .container {
                padding: 0 15px;
            }
            
            .card-body {
                padding: 25px;
            }
            
            .btn-group-custom {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    String name = "", email = "";

    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:postgresql://localhost:5432/vpn_project_db", "postgres", "postgres");

        PreparedStatement ps = conn.prepareStatement("SELECT * FROM members WHERE id = ?");
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if(rs.next()) {
            name = rs.getString("name");
            email = rs.getString("email");
        }
        conn.close();
    } catch(Exception e) {
        out.println("<div class='alert alert-danger alert-custom'><i class='fas fa-exclamation-triangle me-2'></i>Error: " + e.getMessage() + "</div>");
    }
%>

<div class="container">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="breadcrumb-custom">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="dashboard.jsp"><i class="fas fa-home me-1"></i>Dashboard</a></li>
            <li class="breadcrumb-item"><a href="ViewMembers.jsp">Members</a></li>
            <li class="breadcrumb-item active" aria-current="page">Edit Member</li>
        </ol>
    </nav>

    <div class="main-card">
        <div class="card-header">
            <h2><i class="fas fa-user-edit me-2"></i>Edit Member</h2>
            <div class="subtitle">Update member information securely</div>
        </div>
        
        <div class="card-body">
            <form action="UpdateMemberServlet" method="post">
                <input type="hidden" name="id" value="<%= id %>">

                <div class="input-group-custom">
                    <div class="form-floating">
                        <input type="text" name="name" id="name" value="<%= name %>" 
                               class="form-control" placeholder="Full Name" required>
                        <label for="name"><i class="fas fa-user me-2"></i>Full Name</label>
                    </div>
                    <i class="fas fa-user form-icon"></i>
                </div>

                <div class="input-group-custom">
                    <div class="form-floating">
                        <input type="email" name="email" id="email" value="<%= email %>" 
                               class="form-control" placeholder="Email Address" required>
                        <label for="email"><i class="fas fa-envelope me-2"></i>Email Address</label>
                    </div>
                    <i class="fas fa-envelope form-icon"></i>
                </div>

                <div class="btn-group-custom">
                    <button type="submit" class="btn btn-primary-custom">
                        <i class="fas fa-save me-2"></i>Update Member
                    </button>
                    <a href="ViewMembers.jsp" class="btn btn-secondary-custom">
                        <i class="fas fa-times me-2"></i>Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>