<%@ page import="java.sql.*"%>
<%@ page session="true"%>
<%
String userRole = (String) session.getAttribute("role");
String username = (String) session.getAttribute("username");
if (!"admin".equals(userRole)) {
	response.sendRedirect("dashboard.jsp");
	return;
}

Connection conn = null;
PreparedStatement stmt = null;
ResultSet rs = null;

try {
	Class.forName("org.postgresql.Driver");
	conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/vpn_project_db", "postgres", "postgres");
	stmt = conn.prepareStatement("SELECT * FROM download_logs WHERE username IS NOT NULL AND role IS NOT NULL AND filename IS NOT NULL ORDER BY download_time DESC");
	rs = stmt.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
<title>Download Logs</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<a href="dashboard.jsp"
	style="display: inline-block; margin-top: 20px; padding: 10px 20px; background-color: #007BFF; color: white; text-decoration: none; border-radius: 5px;">
	<i class="fas fa-arrow-left"></i> Back to Dashboard
</a>


<h2>Available Files</h2>
<body class="p-4">
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f4f7fa;
        color: #333;
        line-height: 1.6;
    }

    .container {
        max-width: 1200px;
        margin: 30px auto;
        padding: 20px;
        background-color: #ffffff;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
    }

    h2 {
        color: #2c3e50;
        margin-bottom: 25px;
        border-bottom: 2px solid #e0e0e0;
        padding-bottom: 15px;
        display: flex;
        align-items: center;
        font-size: 1.9rem;
    }

    h2 .fas {
        margin-right: 12px;
        color: #007BFF; /* Bootstrap primary blue */
    }

    .table {
        width: 100%;
        margin-top: 20px;
        border-collapse: separate;
        border-spacing: 0;
        border-radius: 8px;
        overflow: hidden; /* Ensures rounded corners apply to the table */
    }

    .table thead th {
        background-color: #007BFF; /* Darker blue for header */
        color: white;
        padding: 15px 20px;
        text-align: left;
        font-weight: bold;
        font-size: 0.95rem;
    }

    .table tbody tr {
        background-color: #ffffff;
        transition: background-color 0.3s ease;
    }

    .table tbody tr:nth-child(even) {
        background-color: #f8fafd; /* Light shade for even rows */
    }

    .table tbody tr:hover {
        background-color: #e2f0ff; /* Lighter blue on hover */
    }

    .table tbody td {
        padding: 12px 20px;
        border-bottom: 1px solid #eee;
        color: #555;
        font-size: 0.9rem;
    }

    .table tbody tr:last-child td {
        border-bottom: none; /* No border for the last row */
    }

    /* Style for the back to dashboard button */
    a[href="dashboard.jsp"] {
        display: inline-flex; /* Use flexbox for alignment of icon and text */
        align-items: center;
        margin: 25px 0 35px 0; /* Adjusted margin */
        padding: 12px 25px;
        background-color: #007BFF;
        color: white;
        text-decoration: none;
        border-radius: 30px; /* More rounded pill shape */
        font-weight: 600;
        transition: background-color 0.3s ease, transform 0.2s ease;
        box-shadow: 0 4px 10px rgba(0, 123, 255, 0.2);
    }

    a[href="dashboard.jsp"] .fas {
        margin-right: 8px;
    }

    a[href="dashboard.jsp"]:hover {
        background-color: #0056b3; /* Darker blue on hover */
        transform: translateY(-2px); /* Slight lift effect */
        box-shadow: 0 6px 15px rgba(0, 123, 255, 0.3);
    }

    /* Responsive adjustments */
    @media (max-width: 768px) {
        .table thead {
            display: none; /* Hide table header on small screens */
        }

        .table, .table tbody, .table tr, .table td {
            display: block;
            width: 100%;
        }

        .table tr {
            margin-bottom: 15px;
            border: 1px solid #eee;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        .table td {
            text-align: right;
            padding-left: 50%;
            position: relative;
            border: none;
            padding-top: 10px;
            padding-bottom: 10px;
        }

        .table td::before {
            content: attr(data-label);
            position: absolute;
            left: 15px;
            width: calc(50% - 30px);
            text-align: left;
            font-weight: bold;
            color: #333;
        }
    }
</style>

<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
	<h2>
		<i class="fas fa-download text-primary"></i> Download Logs
	</h2>
	<table class="table table-bordered table-striped">
		<thead class="table-dark">
			<tr>
				<th>#</th>
				<th>Username</th>
				<th>Role</th>
				<th>Filename</th>
				<th>Download Time</th>
			</tr>
		</thead>
		<tbody>
			<%
			int count = 1;
			while (rs.next()) {
			%>
			<tr>
				<td><%=count++%></td>
				<td><%=rs.getString("username")%></td>
				<td><%=rs.getString("role")%></td>
				<td><%=rs.getString("filename")%></td>
				<td><%=rs.getTimestamp("download_time")%></td>
			</tr>
			<%
			}
			%>
		</tbody>
	</table>
</body>
</html>

<%
rs.close();
stmt.close();
conn.close();
} catch (Exception e) {
e.printStackTrace();
}
%>
