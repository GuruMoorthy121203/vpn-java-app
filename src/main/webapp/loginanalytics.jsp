<%@ page import="java.sql.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%
    String userRole = (session != null) ? (String) session.getAttribute("role") : null;

    if (userRole == null || !userRole.equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<html>
<head>
<title>Login Analytics Dashboard</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    margin: 0;
    padding: 20px;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
}

.dashboard-header {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-radius: 15px;
    padding: 25px;
    margin-bottom: 25px;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
    border: 1px solid rgba(255, 255, 255, 0.2);
}

.dashboard-header h2 {
    color: #2c3e50;
    margin: 0;
    font-weight: 600;
    display: flex;
    align-items: center;
    gap: 12px;
}

.back-btn {
    background: linear-gradient(45deg, #4CAF50, #45a049);
    color: white;
    padding: 12px 24px;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-weight: 500;
    transition: all 0.3s ease;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    box-shadow: 0 4px 15px rgba(76, 175, 80, 0.3);
}

.back-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(76, 175, 80, 0.4);
    color: white;
    text-decoration: none;
}

.filter-section {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-radius: 15px;
    padding: 25px;
    margin-bottom: 25px;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
    border: 1px solid rgba(255, 255, 255, 0.2);
}

.filter-form {
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
    align-items: end;
}

.form-group {
    display: flex;
    flex-direction: column;
    gap: 5px;
}

.form-group label {
    font-weight: 600;
    color: #2c3e50;
    font-size: 0.9em;
}

.form-control {
    padding: 10px 15px;
    border: 2px solid #e0e6ed;
    border-radius: 8px;
    font-size: 0.95em;
    transition: all 0.3s ease;
    background: rgba(255, 255, 255, 0.9);
}

.form-control:focus {
    border-color: #667eea;
    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
    outline: none;
}

.btn-primary, .btn-secondary {
    padding: 10px 20px;
    border: none;
    border-radius: 8px;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.3s ease;
    display: inline-flex;
    align-items: center;
    gap: 8px;
}

.btn-primary {
    background: linear-gradient(45deg, #667eea, #764ba2);
    color: white;
    box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
}

.btn-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
}

.btn-secondary {
    background: linear-gradient(45deg, #6c757d, #5a6268);
    color: white;
    box-shadow: 0 4px 15px rgba(108, 117, 125, 0.3);
}

.btn-secondary:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(108, 117, 125, 0.4);
}

.stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
    margin-bottom: 30px;
}

.stat-card {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-radius: 15px;
    padding: 25px;
    text-align: center;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
    border: 1px solid rgba(255, 255, 255, 0.2);
    transition: all 0.3s ease;
}

.stat-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
}

.stat-card .stat-icon {
    font-size: 2.5em;
    margin-bottom: 15px;
    display: block;
}

.stat-card.total .stat-icon { color: #3498db; }
.stat-card.success .stat-icon { color: #2ecc71; }
.stat-card.failed .stat-icon { color: #e74c3c; }

.stat-card .stat-number {
    font-size: 2.2em;
    font-weight: 700;
    color: #2c3e50;
    margin: 10px 0;
}

.stat-card .stat-label {
    color: #7f8c8d;
    font-weight: 500;
    text-transform: uppercase;
    font-size: 0.85em;
    letter-spacing: 1px;
}

.content-section {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-radius: 15px;
    padding: 25px;
    margin-bottom: 25px;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
    border: 1px solid rgba(255, 255, 255, 0.2);
}

.content-section h3 {
    color: #2c3e50;
    margin-bottom: 20px;
    font-weight: 600;
    display: flex;
    align-items: center;
    gap: 10px;
}

.table {
    background: white;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
    margin: 0;
}

.table thead th {
    background: linear-gradient(45deg, #667eea, #764ba2);
    color: white;
    font-weight: 600;
    text-transform: uppercase;
    font-size: 0.85em;
    letter-spacing: 0.5px;
    padding: 18px 15px;
    border: none;
}

.table tbody td {
    padding: 15px;
    border-color: #f8f9fa;
    color: #2c3e50;
    font-weight: 500;
}

.table tbody tr:hover {
    background-color: rgba(102, 126, 234, 0.05);
}

.chart-container {
    position: relative;
    height: 400px;
    margin: 20px 0;
    background: white;
    border-radius: 10px;
    padding: 20px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
}

.export-section {
    text-align: center;
    margin-top: 30px;
}

.export-link {
    display: inline-flex;
    align-items: center;
    gap: 10px;
    background: linear-gradient(45deg, #17a2b8, #138496);
    color: white;
    padding: 15px 30px;
    text-decoration: none;
    border-radius: 10px;
    font-weight: 600;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(23, 162, 184, 0.3);
}

.export-link:hover {
    color: white;
    text-decoration: none;
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(23, 162, 184, 0.4);
}

.error-message {
    background: linear-gradient(45deg, #e74c3c, #c0392b);
    color: white;
    padding: 15px 20px;
    border-radius: 10px;
    margin: 20px 0;
    box-shadow: 0 4px 15px rgba(231, 76, 60, 0.3);
}

@media (max-width: 768px) {
    .filter-form {
        flex-direction: column;
        align-items: stretch;
    }
    
    .stats-grid {
        grid-template-columns: 1fr;
    }
    
    body {
        padding: 10px;
    }
}
</style>
</head>
<body>
    <div class="container">
        <div class="dashboard-header">
            <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                <h2>
                    <i class="fas fa-chart-line"></i>
                    Login Analytics Dashboard
                </h2>
                <form action="dashboard.jsp" method="get" class="m-0">
                    <button type="submit" class="back-btn">
                        <i class="fas fa-arrow-left"></i>
                        Back to Dashboard
                    </button>
                </form>
            </div>
        </div>

        <div class="filter-section">
            <form method="get" class="filter-form">
                <div class="form-group">
                    <label for="fromDate">From Date:</label>
                    <input type="date" name="fromDate" id="fromDate" class="form-control"
                        value="<%=request.getParameter("fromDate") != null ? request.getParameter("fromDate") : ""%>">
                </div>
                <div class="form-group">
                    <label for="toDate">To Date:</label>
                    <input type="date" name="toDate" id="toDate" class="form-control"
                        value="<%=request.getParameter("toDate") != null ? request.getParameter("toDate") : ""%>">
                </div>
                <div class="form-group">
                    <button type="submit" class="btn-primary">
                        <i class="fas fa-filter"></i>
                        Apply Filter
                    </button>
                </div>
                <div class="form-group">
                    <button type="submit" name="all" value="1" class="btn-secondary">
                        <i class="fas fa-list"></i>
                        Show All
                    </button>
                </div>
            </form>
        </div>

        <%
        String dbURL = "jdbc:postgresql://localhost:5432/vpn_project_db";
        String dbUser = "postgres";
        String dbPass = "postgres";

        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        String all = request.getParameter("all");

        String filterClause = "";
        if ("1".equals(all)) {
            filterClause = "";
            fromDate = null;
            toDate = null;
        } else if (fromDate != null && toDate != null && !fromDate.isEmpty() && !toDate.isEmpty()) {
            filterClause = " WHERE login_time BETWEEN '" + fromDate + " 00:00:00' AND '" + toDate + " 23:59:59'";
        }

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        int totalLogins = 0, successLogins = 0, failedLogins = 0;
        StringBuilder labels = new StringBuilder();
        StringBuilder counts = new StringBuilder();
        %>

        <%
        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
            stmt = conn.createStatement();

            // Total logins
            rs = stmt.executeQuery("SELECT COUNT(*) FROM login_logs" + filterClause);
            if (rs.next())
                totalLogins = rs.getInt(1);

            rs = stmt.executeQuery("SELECT COUNT(*) FROM login_logs WHERE status = 'SUCCESS'" + (filterClause.isEmpty()
            ? ""
            : " AND login_time BETWEEN '" + fromDate + " 00:00:00' AND '" + toDate + " 23:59:59'"));
            if (rs.next())
                successLogins = rs.getInt(1);

            rs = stmt.executeQuery("SELECT COUNT(*) FROM login_logs WHERE status = 'FAILURE'" + (filterClause.isEmpty()
            ? ""
            : " AND login_time BETWEEN '" + fromDate + " 00:00:00' AND '" + toDate + " 23:59:59'"));
            if (rs.next())
                failedLogins = rs.getInt(1);

            rs = stmt.executeQuery("SELECT TO_CHAR(login_time, 'YYYY-MM-DD') AS day, COUNT(*) FROM login_logs" + filterClause
            + " GROUP BY day ORDER BY day");
            while (rs.next()) {
                labels.append("'").append(rs.getString(1)).append("',");
                counts.append(rs.getInt(2)).append(",");
            }
        %>

        <!-- Statistics Cards -->
        <div class="stats-grid">
            <div class="stat-card total">
                <i class="fas fa-chart-bar stat-icon"></i>
                <div class="stat-number"><%=totalLogins%></div>
                <div class="stat-label">Total Logins</div>
            </div>
            <div class="stat-card success">
                <i class="fas fa-check-circle stat-icon"></i>
                <div class="stat-number"><%=successLogins%></div>
                <div class="stat-label">Successful Logins</div>
            </div>
            <div class="stat-card failed">
                <i class="fas fa-times-circle stat-icon"></i>
                <div class="stat-number"><%=failedLogins%></div>
                <div class="stat-label">Failed Logins</div>
            </div>
        </div>

        <!-- Chart Section -->
        <div class="content-section">
            <h3>
                <i class="fas fa-chart-area"></i>
                Login Trends
            </h3>
            <div class="chart-container">
                <canvas id="loginChart"></canvas>
            </div>
        </div>

        <!-- Logins by User Table -->
        <div class="content-section">
            <h3>
                <i class="fas fa-users"></i>
                Logins by User
            </h3>
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Username</th>
                            <th>Total Logins</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        rs = stmt.executeQuery(
                                "SELECT username, COUNT(*) as total FROM login_logs" + filterClause + " GROUP BY username ORDER BY total DESC");
                        while (rs.next()) {
                        %>
                        <tr>
                            <td><%=rs.getString("username")%></td>
                            <td><%=rs.getInt("total")%></td>
                        </tr>
                        <%
                        }
                        %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Export Section -->
        <div class="export-section">
            <%
            String exportLink = "export_logs.jsp";
            if (fromDate != null && toDate != null && !fromDate.isEmpty() && !toDate.isEmpty()) {
                exportLink += "?fromDate=" + fromDate + "&toDate=" + toDate;
            }
            %>
            <a href="<%=exportLink%>" class="export-link">
                <i class="fas fa-download"></i>
                Download Filtered Logs (CSV)
            </a>
        </div>

        <script>
            const ctx = document.getElementById('loginChart').getContext('2d');
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: [
        <%=labels.length() > 0 ? labels.substring(0, labels.length() - 1) : ""%>
            ],
                    datasets: [{
                        label: 'Logins per Day',
                        data: [
        <%=counts.length() > 0 ? counts.substring(0, counts.length() - 1) : ""%>
            ],
                        backgroundColor: 'rgba(102, 126, 234, 0.8)',
                        borderColor: 'rgba(102, 126, 234, 1)',
                        borderWidth: 2,
                        borderRadius: 8,
                        borderSkipped: false,
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Login Count',
                                font: {
                                    size: 14,
                                    weight: 'bold'
                                }
                            },
                            grid: {
                                color: 'rgba(0,0,0,0.1)'
                            }
                        },
                        x: {
                            title: {
                                display: true,
                                text: 'Date',
                                font: {
                                    size: 14,
                                    weight: 'bold'
                                }
                            },
                            grid: {
                                display: false
                            }
                        }
                    }
                }
            });
        </script>

        <%
        } catch (Exception e) {
        %>
        <div class="error-message">
            <i class="fas fa-exclamation-triangle"></i>
            Error: <%=e.getMessage()%>
        </div>
        <%
        e.printStackTrace();
        } finally {
        try {
            if (rs != null)
                rs.close();
        } catch (Exception e) {
        }
        try {
            if (stmt != null)
                stmt.close();
        } catch (Exception e) {
        }
        try {
            if (conn != null)
                conn.close();
        } catch (Exception e) {
        }
        }
        %>
    </div>
</body>
</html>