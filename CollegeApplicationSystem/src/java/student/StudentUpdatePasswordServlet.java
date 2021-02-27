/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package student;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import jdbc.JDBCUtility;
import org.apache.commons.codec.digest.DigestUtils;

/**
 *
 * @author Wen Jie
 */
@WebServlet(name = "StudentUpdatePasswordServlet", urlPatterns = {"/StudentUpdatePasswordServlet"})
public class StudentUpdatePasswordServlet extends HttpServlet {
    
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
        jdbcUtility.prepareSQLStatemenCheckPassword();
        jdbcUtility.prepareSQLStatemenUpdateStudentPassword();
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
        
        HttpSession session = request.getSession();
        if(session.getAttribute("user") == null||session.getAttribute("student") == null){
            response.sendRedirect(request.getContextPath() + "/notAuthorized.jsp");
            return;
        }
        
       //get data from form
        String password = request.getParameter("password");
        String newPassword = request.getParameter("newPassword");
        int studentID = Integer.parseInt(request.getParameter("studentID"));
        
        //insert into database
        try {
            PreparedStatement ps = jdbcUtility.getpsCheckPassword();
            ps.setInt(1, studentID);
          
           ResultSet selectResult = ps.executeQuery();
          
           if(selectResult.next()){
                String salt = selectResult.getString("salt");
                String hashedPassword = selectResult.getString("password");
                
                if(hashedPassword.equals(DigestUtils.sha512Hex(password + salt))){
                    PreparedStatement ps1 = jdbcUtility.getpsUpdateStudentPassword();
                    String newHashedPassword = DigestUtils.sha512Hex(newPassword + salt);
                    ps1.setString(1, newHashedPassword);
                    ps1.setInt(2, studentID);
                    
                    int insertStatus = ps1.executeUpdate();
          
                    if(insertStatus == 1)
                     response.sendRedirect(request.getContextPath() + "/studentEditProfile.jsp?msg=Update Password Sucessfully");
                    else
                      response.sendRedirect(request.getContextPath() + "/register.jsp?message=Failed");
                }
                else
                    response.sendRedirect(request.getContextPath() + "/studentEditPassword.jsp?msg=Wrong Password");
           }            
        } catch (SQLException ex) {
            //failed
            while (ex != null) {
                System.out.println ("SQLState: " + ex.getSQLState ());
                System.out.println ("Message:  " + ex.getMessage ());
		System.out.println ("Vendor:   " + ex.getErrorCode ());
                ex = ex.getNextException ();
		System.out.println ("");
            }
            response.sendRedirect(request.getContextPath() + "/studentEditPassword.jsp");
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
