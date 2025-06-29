<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Trainings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px 0;
            display: flex; /* Added for layout */
            flex-direction: column; /* Added for layout */
            align-items: center; /* Added for layout */
        }

        .container {
            max-width: 1200px;
            width: 100%; /* Ensure container takes full width up to max-width */
            margin-top: 20px; /* Space between button and main card */
        }

        .main-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            overflow: hidden;
            width: 100%; /* Ensure the card takes full width of its container */
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
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .card-header i {
            font-size: 2.5rem;
            margin-bottom: 10px;
            display: block;
            opacity: 0.9;
        }

        .card-body {
            padding: 30px;
        }

        .table-container {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            border: 1px solid #e9ecef;
        }

        .table {
            margin: 0;
            border-radius: 10px;
            overflow: hidden;
        }

        .table thead th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            font-weight: 600;
            padding: 15px;
            text-align: center;
            font-size: 0.95rem;
            letter-spacing: 0.5px;
        }

        .table tbody td {
            padding: 15px;
            vertical-align: middle;
            border-bottom: 1px solid #e9ecef;
            font-size: 0.9rem;
        }

        .table tbody tr {
            transition: all 0.3s ease;
        }

        .table tbody tr:hover {
            background: linear-gradient(135deg, #f8f9ff 0%, #e8f4f8 100%);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .table tbody tr:last-child td {
            border-bottom: none;
        }

        .btn-delete {
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%);
            border: none;
            padding: 8px 16px;
            border-radius: 25px;
            color: white;
            font-weight: 500;
            transition: all 0.3s ease;
            box-shadow: 0 3px 10px rgba(255, 107, 107, 0.3);
        }

        .btn-delete:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.4);
            background: linear-gradient(135deg, #ee5a24 0%, #ff6b6b 100%);
            color: white;
        }

        .btn-delete i {
            margin-right: 5px;
        }

        .error-row {
            background: linear-gradient(135deg, #ffecec 0%, #ffe0e0 100%);
            color: #dc3545;
            font-weight: 500;
        }

        .error-row td {
            text-align: center;
            padding: 20px;
            border: 1px solid #f8d7da;
        }

        .no-data {
            text-align: center;
            padding: 40px;
            color: #6c757d;
            font-style: italic;
        }

        .table-responsive {
            border-radius: 10px;
            box-shadow: none;
        }

        .badge-id {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            padding: 5px 10px;
            border-radius: 15px;
            font-weight: 500;
        }

        .topic-cell {
            font-weight: 600;
            color: #495057;
        }

        .trainer-cell {
            color: #6c757d;
            font-style: italic;
        }

        .date-cell {
            color: #28a745;
            font-weight: 500;
        }

        /* Loading animation */
        .loading {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid #f3f3f3;
            border-top: 3px solid #3498db;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* --- CSS for the Back to Module button --- */
        .back-link-container {
            width: 100%; /* Take full width */
            max-width: 1200px; /* Match container max-width */
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

        /* Responsive design */
        @media (max-width: 768px) {
            .card-header h2 {
                font-size: 1.5rem;
            }
            
            .card-header i {
                font-size: 2rem;
            }
            
            .table tbody td {
                padding: 10px 8px;
                font-size: 0.8rem;
            }
            
            .btn-delete {
                padding: 6px 12px;
                font-size: 0.8rem;
            }

            .back-link-container {
                padding-left: 15px; /* Adjust padding for smaller screens */
            }
        }

        /* Subtle animations */
        .main-card {
            animation: fadeInUp 0.8s ease-out;
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

        .table tbody tr {
            animation: fadeIn 0.5s ease-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
    </style>
</head>
<body>
    <div class="back-link-container">
        <a href="training.jsp" class="back-link">
            <i class="fas fa-arrow-left me-2"></i>Back to Module
        </a>
    </div>

    <div class="container mt-4">
        <div class="main-card">
            <div class="card-header">
                <i class="fas fa-graduation-cap"></i>
                <h2>Training & Test Sessions Management</h2>
            </div>
            <div class="card-body">
                <div class="table-container">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th><i class="fas fa-hashtag me-2"></i>ID</th>
                                    <th><i class="fas fa-book me-2"></i>Topic</th>
                                    <th><i class="fas fa-user-tie me-2"></i>Trainer</th>
                                    <th><i class="fas fa-calendar me-2"></i>Date</th>
                                    <th><i class="fas fa-cogs me-2"></i>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    try {
                                        Class.forName("org.postgresql.Driver");
                                        Connection conn = DriverManager.getConnection(
                                            "jdbc:postgresql://localhost:5432/vpn_project_db", "postgres", "postgres");

                                        Statement stmt = conn.createStatement();
                                        ResultSet rs = stmt.executeQuery("SELECT * FROM trainings");

                                        boolean hasData = false;
                                        while(rs.next()) {
                                            hasData = true;
                                            int id = rs.getInt("id");
                                %>
                                <tr>
                                    <td><span class="badge-id"><%= id %></span></td>
                                    <td class="topic-cell"><%= rs.getString("topic") %></td>
                                    <td class="trainer-cell"><%= rs.getString("trainer") %></td>
                                    <td class="date-cell"><%= rs.getDate("date") %></td>
                                    <td>
                                        <a href="DeleteTrainingServlet?id=<%= id %>" class="btn btn-delete btn-sm" onclick="return confirm('Are you sure you want to delete this training session?')">
                                            <i class="fas fa-trash-alt"></i>Delete
                                        </a>
                                    </td>
                                </tr>
                                <%
                                        }
                                        
                                        if (!hasData) {
                                %>
                                <tr>
                                    <td colspan="5" class="no-data">
                                        <i class="fas fa-info-circle me-2"></i>
                                        No training sessions found
                                    </td>
                                </tr>
                                <%
                                        }
                                        
                                        conn.close();
                                    } catch(Exception e) {
                                %>
                                <tr class="error-row">
                                    <td colspan="5">
                                        <i class="fas fa-exclamation-triangle me-2"></i>
                                        Error loading data: <%= e.getMessage() %>
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
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>