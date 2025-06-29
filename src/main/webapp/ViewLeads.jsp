<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Leads - VPN Office</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #f4f6f8 0%, #e8ecf0 100%);
            min-height: 100vh;
            padding: 20px 0;
        }

        .container {
            max-width: 1200px;
        }

        .main-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            border: none;
            overflow: hidden;
        }

        .card-header {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            color: white;
            padding: 25px;
            border: none;
        }

        .card-header h2 {
            margin: 0;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .card-body {
            padding: 30px;
        }

        .table-container {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-top: 20px;
        }

        .table {
            margin: 0;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .table thead th {
            background: linear-gradient(135deg, #343a40 0%, #495057 100%);
            color: white;
            border: none;
            padding: 15px 12px;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
        }

        .table tbody tr {
            transition: all 0.3s ease;
            border-bottom: 1px solid #e9ecef;
        }

        .table tbody tr:hover {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            transform: translateY(-1px);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .table tbody td {
            padding: 15px 12px;
            vertical-align: middle;
            border: none;
        }

        .table tbody tr:last-child td {
            border-bottom: none;
        }

        .btn-delete {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            border: none;
            border-radius: 6px;
            padding: 8px 16px;
            font-size: 0.85rem;
            font-weight: 500;
            transition: all 0.3s ease;
            box-shadow: 0 2px 6px rgba(220, 53, 69, 0.3);
        }

        .btn-delete:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(220, 53, 69, 0.4);
            background: linear-gradient(135deg, #c82333 0%, #a71e2a 100%);
        }

        .stats-row {
            margin-bottom: 25px;
        }

        .stat-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            border-left: 4px solid #007bff;
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-3px);
        }

        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            color: #007bff;
            margin: 0;
        }

        .stat-label {
            color: #6c757d;
            font-size: 0.9rem;
            margin: 0;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .error-message {
            background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
            color: #721c24;
            padding: 20px;
            border-radius: 8px;
            border-left: 4px solid #dc3545;
            margin: 20px 0;
        }

        .no-data {
            text-align: center;
            padding: 40px;
            color: #6c757d;
        }

        .back-btn {
            background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
            border: none;
            border-radius: 6px;
            padding: 10px 20px;
            color: white;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            margin-bottom: 20px;
        }

        .back-btn:hover {
            background: linear-gradient(135deg, #5a6268 0%, #495057 100%);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(108, 117, 125, 0.3);
        }

        @media (max-width: 768px) {
            .container {
                padding: 10px;
            }
            
            .card-header {
                padding: 20px 15px;
            }
            
            .card-body {
                padding: 20px 15px;
            }
            
            .table-container {
                padding: 15px;
                margin-top: 15px;
            }
            
            .table {
                font-size: 0.9rem;
            }
            
            .table thead th,
            .table tbody td {
                padding: 10px 8px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="dashboard.jsp" class="back-btn">
            <i class="fas fa-arrow-left"></i>
            Back to Dashboard
        </a>
        
        <div class="card main-card">
            <div class="card-header">
                <h2>
                    <i class="fas fa-users"></i>
                    Marketing Leads Management
                </h2>
            </div>
            <div class="card-body">
                <div class="row stats-row">
                    <div class="col-md-6">
                        <div class="stat-card">
                            <%
                                int totalLeads = 0;
                                try {
                                    Class.forName("org.postgresql.Driver");
                                    Connection countConn = DriverManager.getConnection(
                                        "jdbc:postgresql://localhost:5432/vpn_project_db", "postgres", "postgres");
                                    Statement countStmt = countConn.createStatement();
                                    ResultSet countRs = countStmt.executeQuery("SELECT COUNT(*) as total FROM leads");
                                    if(countRs.next()) {
                                        totalLeads = countRs.getInt("total");
                                    }
                                    countConn.close();
                                } catch(Exception e) {
                                    // Handle silently for display
                                }
                            %>
                            <p class="stat-number"><%= totalLeads %></p>
                            <p class="stat-label">Total Leads</p>
                        </div>
                    </div>
                    
                </div>

                <div class="table-container">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th><i class="fas fa-hashtag"></i> ID</th>
                                    <th><i class="fas fa-user"></i> Name</th>
                                    <th><i class="fas fa-envelope"></i> Email</th>
                                    <th><i class="fas fa-building"></i> Company</th>
                                    <th><i class="fas fa-cogs"></i> Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    boolean hasData = false;
                                    try {
                                        Class.forName("org.postgresql.Driver");
                                        Connection conn = DriverManager.getConnection(
                                            "jdbc:postgresql://localhost:5432/vpn_project_db", "postgres", "postgres");

                                        Statement stmt = conn.createStatement();
                                        ResultSet rs = stmt.executeQuery("SELECT * FROM leads ORDER BY id DESC");

                                        while(rs.next()) {
                                            hasData = true;
                                            int id = rs.getInt("id");
                                %>
                                <tr>
                                    <td><strong><%= id %></strong></td>
                                    <td><%= rs.getString("name") %></td>
                                    <td><%= rs.getString("email") %></td>
                                    <td><%= rs.getString("company") %></td>
                                    <td>
                                        <a href="DeleteLeadServlet?id=<%= id %>" 
                                           class="btn btn-delete btn-sm" 
                                           onclick="return confirm('Are you sure you want to delete this lead?')"
                                           title="Delete Lead">
                                            <i class="fas fa-trash-alt"></i> Delete
                                        </a>
                                    </td>
                                </tr>
                                <%
                                        }
                                        
                                        if(!hasData) {
                                %>
                                <tr>
                                    <td colspan="5" class="no-data">
                                        <i class="fas fa-inbox fa-3x mb-3" style="color: #dee2e6;"></i>
                                        <br>
                                        No leads found in the database.
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
                                            <i class="fas fa-exclamation-triangle"></i>
                                            <strong>Database Error:</strong> <%= e.getMessage() %>
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
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>