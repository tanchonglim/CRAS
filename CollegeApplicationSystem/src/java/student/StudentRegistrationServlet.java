/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package student;

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
import jdbc.JDBCUtility;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.RandomStringUtils;

/**
 *
 * @author Tan Chong Lim
 */
@WebServlet(name = "StudentRegistrationServlet", urlPatterns = {"/StudentRegistrationServlet"})
public class StudentRegistrationServlet extends HttpServlet {

    private JDBCUtility jdbcUtility;
    private Connection con;
    
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
        jdbcUtility.prepareSQLStatementInsertUserStudent();
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
        String name = request.getParameter("fullName");
        String matricNo = request.getParameter("matricNo");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
       
        String salt = RandomStringUtils.random(30, true, true); //generate salt
        String hashedPassword = DigestUtils.sha512Hex(password + salt); //generate hashed password
        String userType="student"; //only student can register
        
       
        //insert into database
        try {
            PreparedStatement ps = jdbcUtility.getPsInsertUserStudent();
            ps.setString(1, name);
            ps.setString(2, matricNo);
            ps.setString(3, username);
            ps.setString(4, email);
            ps.setString(5, hashedPassword);
            ps.setString(6, salt);
            ps.setString(7, userType);
            
            
           int insertStatus = ps.executeUpdate();
          
           if(insertStatus == 1)
            response.sendRedirect(request.getContextPath() + "/login.jsp?message=Register Success");
           else
             response.sendRedirect(request.getContextPath() + "/register.jsp?message=Failed");
        } catch (SQLException ex) {
            //failed
            response.sendRedirect(request.getContextPath() + "/register.jsp?message=Failed");
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
