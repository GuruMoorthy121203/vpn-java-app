<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
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
<title>Login Logs</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
</head>
<a href="dashboard.jsp"
	style="display: inline-block; margin-top: 20px; padding: 10px 20px; background-color: #007BFF; color: white; text-decoration: none; border-radius: 5px;">
	⬅ Back to Dashboard </a>


<body>
	<div class="container mt-5">
		<h2 class="mb-4 text-center">Login Logs</h2>
		<table class="table table-bordered table-hover">
			<thead class="table-dark">
				<tr>
					<th>ID</th>
					<th>Username</th>
					<th>Login Time</th>
					<th>IP Address</th>
					<th>Status</th>
					<th>Logout Time</th>
				</tr>
			</thead>
			<tbody>
				<%
				Connection conn = null;
				PreparedStatement stmt = null;
				ResultSet rs = null;

				try {
					Class.forName("org.postgresql.Driver");
					conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/vpn_project_db", "postgres", "postgres");

					String sql = "SELECT * FROM login_logs ORDER BY login_time DESC";
					stmt = conn.prepareStatement(sql);
					rs = stmt.executeQuery();

					while (rs.next()) {
						int id = rs.getInt("id");
						String username = rs.getString("username");
						Timestamp loginTime = rs.getTimestamp("login_time");
						String ip = rs.getString("ip_address");
						String status = rs.getString("status");
						Timestamp logoutTime = rs.getTimestamp("logout_time");
				%>
				<tr>
					<td><%=id%></td>
					<td><%=username%></td>
					<td><%=loginTime%></td>
					<td><%=ip%></td>
					<td
						class="<%=status.equals("SUCCESS") ? "text-success" : "text-danger"%>">
						<%=status%>
					</td>
					<td><%=logoutTime != null ? logoutTime : "—"%></td>
				</tr>
				<%
				}
				} catch (Exception e) {
				out.println("<tr><td colspan='5' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
				} finally {
				if (rs != null)
				try {
					rs.close();
				} catch (SQLException ignore) {
				}
				if (stmt != null)
				try {
					stmt.close();
				} catch (SQLException ignore) {
				}
				if (conn != null)
				try {
					conn.close();
				} catch (SQLException ignore) {
				}
				}
				%>
			</tbody>
		</table>
	</div>
</body>
</html>
