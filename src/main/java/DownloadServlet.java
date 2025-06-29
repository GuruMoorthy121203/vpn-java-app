import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/DownloadServlet")
public class DownloadServlet extends HttpServlet {
	
    private static final String AES_KEY = "MySecretAESKey12"; // Same 16-char key used during upload

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	// Inside doGet:
    	HttpSession session = request.getSession(false);
    	if (session == null || session.getAttribute("username") == null) {
    	    response.sendRedirect("login.jsp"); // redirect to login page
    	    return;
    	}

    	String username = (String) session.getAttribute("username");

        int fileId = Integer.parseInt(request.getParameter("id"));

        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(
                    "jdbc:postgresql://localhost:5432/vpn_project_db",
                    "postgres", "postgres");

            PreparedStatement stmt = conn.prepareStatement("SELECT filename, file_data FROM uploaded_files WHERE id = ?");
            stmt.setInt(1, fileId);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String fileName = rs.getString("filename");
                byte[] fileData = rs.getBytes("file_data");

                // 🔓 Decrypt file before sending
                byte[] decryptedFile = AESUtil.decrypt(fileData, AES_KEY);
                // Log the download
                String role = (String) session.getAttribute("role");

                PreparedStatement logStmt = conn.prepareStatement(
                    "INSERT INTO download_logs (file_id, downloaded_by, username, role, filename) VALUES (?, ?, ?, ?, ?)");
                logStmt.setInt(1, fileId);
                logStmt.setString(2, username); // downloaded_by (optional field if same as username)
                logStmt.setString(3, username); // username
                logStmt.setString(4, role);     // role
                logStmt.setString(5, fileName); // filename

                logStmt.executeUpdate();
                logStmt.close();

                // Force file download
                response.setContentType("application/octet-stream");
                response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
                response.setContentLength(decryptedFile.length);

                try (OutputStream os = response.getOutputStream()) {
                    os.write(decryptedFile);
                    os.flush();
                }
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
