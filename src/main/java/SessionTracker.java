import javax.servlet.annotation.WebListener;
import javax.servlet.http.*;
import java.sql.*;

@WebListener
public class SessionTracker implements HttpSessionListener {

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        HttpSession session = se.getSession();
        String username = (String) session.getAttribute("username");

        if (username != null) {
            try {
                Class.forName("org.postgresql.Driver");
                Connection conn = DriverManager.getConnection(
                        "jdbc:postgresql://localhost:5432/vpn_project_db", "postgres", "postgres");

                String sql = "UPDATE login_logs SET logout_time = current_timestamp " +
                             "WHERE username = ? AND logout_time IS NULL " +
                             "ORDER BY login_time DESC LIMIT 1";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, username);
                stmt.executeUpdate();

                stmt.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
