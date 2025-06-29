import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String username = null;

        if (session != null) {
            username = (String) session.getAttribute("username"); // get username before invalidating
        }

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            if (username != null) {
                Class.forName("org.postgresql.Driver");
                conn = DriverManager.getConnection(
                        "jdbc:postgresql://localhost:5432/vpn_project_db", "postgres", "postgres");

                String sql = "UPDATE login_logs SET logout_time = current_timestamp " +
                             "WHERE id = (" +
                             "   SELECT id FROM login_logs " +
                             "   WHERE username = ? AND logout_time IS NULL " +
                             "   ORDER BY login_time DESC LIMIT 1" +
                             ")";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, username);
                stmt.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (stmt != null) stmt.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }

        if (session != null) {
            session.invalidate();
        }

        response.sendRedirect("login.jsp");
    }
}
