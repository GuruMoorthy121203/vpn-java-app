import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AddTrainingServlet")
public class AddTrainingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String topic = request.getParameter("topic");
        String trainer = request.getParameter("trainer");
        String date = request.getParameter("date");

        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:postgresql://localhost:5432/vpn_project_db", "postgres", "postgres");

            String sql = "INSERT INTO trainings (topic, trainer, date) VALUES (?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, topic);
            ps.setString(2, trainer);
            ps.setDate(3, Date.valueOf(date)); // Converts String to SQL Date
            ps.executeUpdate();

            conn.close();
            response.sendRedirect("training.jsp");
        } catch(Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
