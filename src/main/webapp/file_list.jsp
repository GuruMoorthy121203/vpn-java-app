<%@ page import="java.sql.*, java.util.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%
    String userRole = (session != null) ? (String) session.getAttribute("role") : null;

    if (userRole == null || 
        (!userRole.equals("admin") && !userRole.equals("marketing") && !userRole.equals("training"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<html>
<head>
<title>Uploaded Files</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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

.page-header {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-radius: 15px;
    padding: 30px;
    margin-bottom: 30px;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
    border: 1px solid rgba(255, 255, 255, 0.2);
}

.page-title {
    color: #2c3e50;
    font-weight: 700;
    font-size: 2.5rem;
    margin: 0;
    display: flex;
    align-items: center;
    gap: 15px;
}

.back-button {
    display: inline-flex;
    align-items: center;
    gap: 10px;
    padding: 12px 24px;
    background: linear-gradient(45deg, #007BFF, #0056b3);
    color: white;
    text-decoration: none;
    border-radius: 50px;
    font-weight: 600;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(0, 123, 255, 0.3);
}

.back-button:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(0, 123, 255, 0.4);
    color: white;
    text-decoration: none;
}

.files-container {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-radius: 15px;
    padding: 30px;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
    border: 1px solid rgba(255, 255, 255, 0.2);
}

.files-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    background: white;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
}

.files-table th {
    background: linear-gradient(45deg, #667eea, #764ba2);
    color: white;
    padding: 18px 15px;
    text-align: left;
    font-weight: 600;
    font-size: 0.95rem;
    letter-spacing: 0.5px;
    border: none;
}

.files-table td {
    padding: 15px;
    border-bottom: 1px solid #eef2f7;
    color: #2c3e50;
    vertical-align: middle;
}

.files-table tr:hover {
    background: linear-gradient(90deg, rgba(102, 126, 234, 0.05), rgba(118, 75, 162, 0.05));
    transform: scale(1.01);
    transition: all 0.2s ease;
}

.files-table tr:last-child td {
    border-bottom: none;
}

.download-btn {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 8px 16px;
    background: linear-gradient(45deg, #28a745, #20c997);
    color: white;
    text-decoration: none;
    border-radius: 25px;
    font-size: 0.9rem;
    font-weight: 500;
    transition: all 0.3s ease;
    box-shadow: 0 2px 10px rgba(40, 167, 69, 0.3);
}

.download-btn:hover {
    transform: translateY(-1px);
    box-shadow: 0 4px 15px rgba(40, 167, 69, 0.4);
    color: white;
    text-decoration: none;
}

.file-id {
    background: linear-gradient(45deg, #6c757d, #495057);
    color: white;
    padding: 5px 10px;
    border-radius: 15px;
    font-size: 0.8rem;
    font-weight: 600;
    display: inline-block;
    min-width: 35px;
    text-align: center;
}

.filename {
    font-weight: 600;
    color: #495057;
    display: flex;
    align-items: center;
    gap: 10px;
}

.file-icon {
    color: #667eea;
    font-size: 1.2rem;
}

.uploaded-by {
    display: flex;
    align-items: center;
    gap: 8px;
    color: #6c757d;
}

.user-icon {
    color: #764ba2;
}

.upload-date {
    color: #6c757d;
    font-size: 0.9rem;
}

.no-files {
    text-align: center;
    padding: 40px;
    color: #6c757d;
    font-style: italic;
}

.error-message {
    background: linear-gradient(45deg, #dc3545, #c82333);
    color: white;
    padding: 15px 20px;
    border-radius: 10px;
    margin: 20px 0;
    display: flex;
    align-items: center;
    gap: 10px;
}

@media (max-width: 768px) {
    .page-title {
        font-size: 2rem;
    }
    
    .files-table {
        font-size: 0.9rem;
    }
    
    .files-table th,
    .files-table td {
        padding: 12px 8px;
    }
}
</style>
</head>
<body>
    <div class="container">
        <div class="page-header">
            <a href="dashboard.jsp" class="back-button">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
            <h1 class="page-title mt-3">
                <i class="fas fa-folder-open"></i>
                Available Files
            </h1>
        </div>

        <div class="files-container">
            <table class="files-table">
                <thead>
                    <tr>
                        <th><i class="fas fa-hashtag me-2"></i>ID</th>
                        <th><i class="fas fa-file me-2"></i>Filename</th>
                        <th><i class="fas fa-user me-2"></i>Uploaded By</th>
                        <th><i class="fas fa-calendar me-2"></i>Date</th>
                        <th><i class="fas fa-download me-2"></i>Download</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;
                    boolean hasFiles = false;

                    try {
                        Class.forName("org.postgresql.Driver");
                        conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/vpn_project_db", "postgres", "postgres");

                        stmt = conn.prepareStatement("SELECT * FROM uploaded_files ORDER BY upload_time DESC");
                        rs = stmt.executeQuery();

                        while (rs.next()) {
                            hasFiles = true;
                    %>
                    <tr>
                        <td>
                            <span class="file-id"><%=rs.getInt("id")%></span>
                        </td>
                        <td>
                            <div class="filename">
                                <i class="fas fa-file-alt file-icon"></i>
                                <%=rs.getString("filename")%>
                            </div>
                        </td>
                        <td>
                            <div class="uploaded-by">
                                <i class="fas fa-user-circle user-icon"></i>
                                <%=rs.getString("uploaded_by")%>
                            </div>
                        </td>
                        <td class="upload-date"><%=rs.getTimestamp("upload_time")%></td>
                        <td>
                            <a href="DownloadServlet?id=<%=rs.getInt("id")%>" class="download-btn">
                                <i class="fas fa-download"></i>
                                Download
                            </a>
                        </td>
                    </tr>
                    <%
                        }
                        
                        if (!hasFiles) {
                    %>
                    <tr>
                        <td colspan="5" class="no-files">
                            <i class="fas fa-folder-open fa-2x mb-3 d-block"></i>
                            No files uploaded yet
                        </td>
                    </tr>
                    <%
                        }
                        
                    } catch (Exception e) {
                    %>
                    <tr>
                        <td colspan="5">
                            <div class="error-message">
                                <i class="fas fa-exclamation-triangle"></i>
                                Error: <%=e.getMessage()%>
                            </div>
                        </td>
                    </tr>
                    <%
                    } finally {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>