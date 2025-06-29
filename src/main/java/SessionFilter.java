import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;

@WebFilter(urlPatterns = {"/admin.jsp", "/marketing.jsp", "/training.jsp"})
public class SessionFilter implements Filter {

    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization (optional)
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("username") == null) {
            // User not logged in — redirect to login page
            res.sendRedirect("login.jsp?error=session");
        } else {
            // User logged in — allow access
            chain.doFilter(request, response);
        }
    }

    public void destroy() {
        // Cleanup (optional)
    }
}
