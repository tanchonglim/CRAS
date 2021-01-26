/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package student;

import bean.Student;
import bean.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.RandomStringUtils;
import jdbc.JDBCUtility;

/**
 *
 * @author Wen Jie
 */
@WebServlet(name = "StudentUpdateProfileServlet", urlPatterns = {"/StudentUpdateProfileServlet"})
public class StudentUpdateProfileServlet extends HttpServlet {

    private JDBCUtility jdbcUtility;
    private Connection con;
    
    @Override
    public void init() throws ServletException
    {
        String driver = "com.mysql.jdbc.Driver";

        String dbName = "college_application";
        String url = "jdbc:mysql://localhost/" + dbName + "?allowMultiQueries=true";
        String userName = "root";
        String password = "";

        jdbcUtility = new JDBCUtility(driver,
                                      url,
                                      userName,
                                      password);

        jdbcUtility.jdbcConnect();
        con = jdbcUtility.jdbcGetConnection();
        jdbcUtility.prepareSQLStatementUpdateStudentProfile();
        jdbcUtility.prepareSQLStatementSelectStudentByID();
    }     
    
    public void destroy() {   
        jdbcUtility.jdbcConClose();
    } 
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
       //get data from form
        String name = request.getParameter("name");
        String matricNo = request.getParameter("matricNo");
        String email = request.getParameter("email");
        int studentID = Integer.parseInt(request.getParameter("studentID"));
        
        //insert into database
        try {
            PreparedStatement ps = jdbcUtility.getpsUpdateStudentProfile();
            ps.setString(1, name);
            ps.setString(2, matricNo);
            ps.setInt(3, studentID);
            ps.setString(4, email);
            ps.setInt(5, studentID);
          
           int updateStatus = ps.executeUpdate();
          
           if(updateStatus == 1){
               HttpSession session = request.getSession();
        
                //get user profile bean from session
                User user = (User)session.getAttribute("user");
                user.setEmail(email);
                session.setAttribute("user", user);
                
                Student student = (Student)session.getAttribute("student");
                student.setName(name);
                student.setMatricNo(matricNo);
                session.setAttribute("student", student);
                
                response.sendRedirect(request.getContextPath() + "/studentProfile.jsp?success=Update success");
           }
            
           else
             response.sendRedirect(request.getContextPath() + "/studentEditProfile.jsp?message=Update failed");
        } catch (SQLException ex) {
            //failed
            while (ex != null) {
                System.out.println ("SQLState: " + ex.getSQLState ());
                System.out.println ("Message:  " + ex.getMessage ());
		System.out.println ("Vendor:   " + ex.getErrorCode ());
                ex = ex.getNextException ();
		System.out.println ("");
            }
            response.sendRedirect(request.getContextPath() + "/studentEditProfile.jsp?message=Update failed");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
