<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page contentType="text/csv" %>
<%
    String fromDate = request.getParameter("fromDate");
    String toDate = request.getParameter("toDate");

    response.setHeader("Content-Disposition", "attachment; filename=login_logs.csv");

    String dbURL = "jdbc:postgresql://localhost:5432/vpn_project_db";
    String dbUser = "postgres";
    String dbPass = "postgres";

    String filterClause = "";
    if (fromDate != null && toDate != null && !fromDate.isEmpty() && !toDate.isEmpty()) {
        filterClause = " WHERE login_time BETWEEN '" + fromDate + " 00:00:00' AND '" + toDate + " 23:59:59'";
    }

    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM login_logs" + filterClause);

        out.println("ID,Username,Status,Login Time,Logout Time");
        while (rs.next()) {
        	Timestamp logoutTime = rs.getTimestamp("logout_time");
        	out.println(
        	    rs.getInt("id") + "," +
        	    rs.getString("username") + "," +
        	    rs.getString("status") + "," +
        	    rs.getTimestamp("login_time") + "," +
        	    (logoutTime != null ? logoutTime : "")
        	);

        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
