/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package admin;

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
import jdbc.JDBCUtility;

/**
 *
 * @author 
 */
@WebServlet(name = "AdminUpdateApprovalApplicationServlet", urlPatterns = {"/AdminUpdateApprovalApplicationServlet"})
public class AdminUpdateApprovalApplicationServlet extends HttpServlet {

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
        jdbcUtility.prepareSQLStatementUpdateApprovalApplication();
        jdbcUtility.prepareSQLStatementUpdateStudentApplication();
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
        if(session.getAttribute("user") == null||!((User) session.getAttribute("user")).getUserType().equals("admin")){
            response.sendRedirect(request.getContextPath() + "/notAuthorized.jsp");
            return;
        }
       //get data from form in adminViewApplication.jsp
        String status = request.getParameter("status");
        int applicationID = Integer.parseInt(request.getParameter("applicationID"));        
        int studentID = Integer.parseInt(request.getParameter("studentID"));
        
        //update application in database
        try {
            PreparedStatement ps = jdbcUtility.getpsUpdateApprovalApplication();
            ps.setString(1, status);
            ps.setInt(2, applicationID);

          
           int updateApprovalApplicationStatus = ps.executeUpdate();
          
           if(updateApprovalApplicationStatus == 1){
               
               if(status.equals("unapproved")){
                    ps = jdbcUtility.getpsUpdateStudentApplication();
                    ps.setInt(1,0);
                    ps.setInt(2,studentID);
                    ps.setInt(3, applicationID);
                    
                    //set student application = 0 in student table
                    int updateStudentApplicationStatus = ps.executeUpdate(); 
                    
                    if(updateStudentApplicationStatus == 1) {
                        response.sendRedirect(request.getContextPath() + "/AdminSelectAllApplicationServlet?success=Student application unapproved.");                       
                    }
                    else {
                        response.sendRedirect(request.getContextPath() + "/AdminSelectAllApplicationServlet?message=Update failed");
                    }
               }
               else{
                    response.sendRedirect(request.getContextPath() + "/AdminSelectAllApplicationServlet?success=Student application approved.");  
               }
           }
            
           else
             response.sendRedirect(request.getContextPath() + "/AdminSelectAllApplicationServlet?message=Update failed");
        } catch (SQLException ex) {
            //failed
            while (ex != null) {
                System.out.println ("SQLState: " + ex.getSQLState ());
                System.out.println ("Message:  " + ex.getMessage ());
		System.out.println ("Vendor:   " + ex.getErrorCode ());
                ex = ex.getNextException ();
		System.out.println ("");
            }
            response.sendRedirect(request.getContextPath() + "/AdminSelectAllApplicationServlet?message=Update failed");
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
