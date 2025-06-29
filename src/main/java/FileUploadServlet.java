import java.io.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.sql.*;

@MultipartConfig(maxFileSize = 16177215) // 15MB max file size
@WebServlet("/upload")
public class FileUploadServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:postgresql://localhost:5432/vpn_project_db";
    private static final String DB_USER = "postgres";
    private static final String DB_PASSWORD = "postgres";
    private static final String AES_KEY = "MySecretAESKey12"; // 16 chars

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            Part filePart = request.getPart("file");
            String fileName = filePart.getSubmittedFileName();

            InputStream fileContent = filePart.getInputStream();
            byte[] fileBytes = fileContent.readAllBytes();

            // Encrypt the file
            byte[] encryptedFile = AESUtil.encrypt(fileBytes, AES_KEY);

            // Store in PostgreSQL
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            String sql = "INSERT INTO uploaded_files (filename, file_data, uploaded_by) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, fileName);
            stmt.setBytes(2, encryptedFile);
            stmt.setString(3, "admin"); // You can replace this with session user
            stmt.executeUpdate();

            stmt.close();
            conn.close();

            response.getWriter().println("File uploaded and encrypted successfully.");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Upload failed: " + e.getMessage());
        }
    }
}
