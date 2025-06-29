import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    // Database connection method
    private Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("org.postgresql.Driver");
        return DriverManager.getConnection(
            "jdbc:postgresql://localhost:5432/vpn_project_db", 
            "postgres", 
            "postgres"
        );
    }

    // Hash password using SHA-256
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }

    // POST request handling
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Input validation
        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            response.sendRedirect("login.jsp?error=1"); // Missing fields
            return;
        }

        try (Connection conn = getConnection()) {
            String sql = "SELECT role, password_hash FROM users WHERE username = ? AND active = true";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String storedHash = rs.getString("password_hash");
                String inputHash = hashPassword(password);
//                System.out.println("Input password: " + password);
//                System.out.println("Hashed input: " + inputHash);
//                System.out.println("Stored hash: " + storedHash);


                if (storedHash.equals(inputHash)) {
                    // Set session
                    HttpSession session = request.getSession();
                    String role = rs.getString("role");
                    session.setAttribute("username", username);
                    session.setAttribute("role", role);
                    session.setMaxInactiveInterval(30 * 60); // 30 minutes

                    // Log login
                    logLoginAttempt(conn, username, true, request.getRemoteAddr());

                    // Redirect based on role
                    switch (role) {
                        case "admin":
                            response.sendRedirect("dashboard.jsp");
                            break;
                        case "marketing":
                            response.sendRedirect("dashboard.jsp");
                            break;
                        case "training":
                            response.sendRedirect("dashboard.jsp");
                            break;
                        default:
                            // Unknown role
                            response.sendRedirect("login.jsp?error=3");
                    }
                } else {
                    logLoginAttempt(conn, username, false, request.getRemoteAddr());
                    response.sendRedirect("login.jsp?error=1"); // Wrong password
                }
            } else {
                logLoginAttempt(conn, username, false, request.getRemoteAddr());
                response.sendRedirect("login.jsp?error=1"); // Username not found or inactive
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=2"); // DB error
        }
    }
    
    

    // Log login attempts to login_logs table
    private void logLoginAttempt(Connection conn, String username, boolean success, String ipAddress) {
        try {
            String sql = "INSERT INTO login_logs (username, login_time, ip_address, status) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setTimestamp(2, new Timestamp(System.currentTimeMillis())); // login_time
            ps.setString(3, ipAddress);
            ps.setString(4, success ? "SUCCESS" : "FAILURE"); // status
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(); // Optional: log this properly
        }
    }
}
