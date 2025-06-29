<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    if (session == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Member</title>
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
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            border: none;
            overflow: hidden;
            position: relative;
        }

        .card-header {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            padding: 30px;
            text-align: center;
            border: none;
        }

        .card-header h2 {
            margin: 0;
            font-weight: 600;
            font-size: 2rem;
        }

        .card-header i {
            font-size: 3rem;
            margin-bottom: 15px;
            opacity: 0.9;
        }

        .card-body {
            padding: 40px;
        }

        .form-label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 8px;
            font-size: 0.95rem;
        }

        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 15px 20px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background-color: #f8f9fa;
        }

        .form-control:focus {
            border-color: #4facfe;
            box-shadow: 0 0 0 0.2rem rgba(79, 172, 254, 0.25);
            background-color: white;
            transform: translateY(-2px);
        }

        .input-group {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
            z-index: 10;
            font-size: 1.1rem;
        }

        .form-control.with-icon {
            padding-left: 50px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 12px;
            padding: 15px 40px;
            font-weight: 600;
            font-size: 1.1rem;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 25px rgba(102, 126, 234, 0.4);
            background: linear-gradient(135deg, #5a6fd8 0%, #6a4190 100%);
        }

        .btn-primary:active {
            transform: translateY(-1px);
        }

        .form-floating {
            margin-bottom: 25px;
        }

        .form-floating > .form-control {
            height: calc(3.5rem + 2px);
            line-height: 1.25;
        }

        .form-floating > label {
            opacity: 0.7;
            font-weight: 500;
        }

        .back-link {
            position: absolute;
            top: 20px;
            left: 20px;
            color: white;
            text-decoration: none;
            background: rgba(255, 255, 255, 0.2);
            padding: 10px 15px;
            border-radius: 25px;
            backdrop-filter: blur(10px);
            transition: all 0.3s ease;
        }

        .back-link:hover {
            background: rgba(255, 255, 255, 0.3);
            color: white;
            transform: translateX(-5px);
        }

        .decorative-elements {
            position: absolute;
            top: 0;
            right: 0;
            width: 200px;
            height: 200px;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
            border-radius: 50%;
            transform: translate(50%, -50%);
        }

        .decorative-elements::before {
            content: '';
            position: absolute;
            width: 100px;
            height: 100px;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.15) 0%, transparent 70%);
            border-radius: 50%;
            top: 120px;
            left: -50px;
        }

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

        @media (max-width: 768px) {
            .container {
                padding: 0 15px;
            }
            
            .card-body {
                padding: 30px 20px;
            }
            
            .card-header {
                padding: 25px 20px;
            }
            
            .card-header h2 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <a href="admin.jsp" class="back-link">
        <i class="fas fa-arrow-left me-2"></i>Back to Module
    </a>
    
    <div class="container mt-5">
        <div class="card main-card">
            <div class="card-header">
                <div class="decorative-elements"></div>
                <i class="fas fa-user-plus"></i>
                <h2>Add New Member</h2>
                <p class="mb-0 opacity-75">Add a new team member to the system</p>
            </div>
            <div class="card-body">
                <form action="AddMemberServlet" method="post">               
                    <div class="form-floating mb-4">
                        <input type="text" name="name" class="form-control" id="name" placeholder="Full Name" required />
                        <label for="name"><i class="fas fa-user me-2"></i>Full Name</label>
                    </div>
                    
                    <div class="form-floating mb-4">
                        <input type="email" name="email" class="form-control" id="email" placeholder="Email Address" required />
                        <label for="email"><i class="fas fa-envelope me-2"></i>Email Address</label>
                    </div>
                    
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-plus me-2"></i>Add Member
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>