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
import javax.servlet.http.HttpSession;
import jdbc.JDBCUtility;
import bean.Student;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.RandomStringUtils;

/**
 *
 * @author USER
 */
@WebServlet(name = "StudentApplyCollegeRoomServlet", urlPatterns = {"/StudentApplyCollegeRoomServlet"})
public class StudentApplyCollegeRoomServlet extends HttpServlet {
    
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
        jdbcUtility.prepareSQLStatementInsertApplication();
        jdbcUtility.prepareSQLStatementUpdateRoomOccupied();
        jdbcUtility.prepareSQLStatementUpdateStudentApplicationStatus();
    }     
    
    public void destroy() {   
        jdbcUtility.jdbcConClose();
    } 
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();        
        
        Student stud = new Student();
        stud  = (Student)session.getAttribute("student");
        int studentID = stud.getStudentID();
        int roomID = Integer.parseInt(request.getParameter("rid"));
        int occupied = Integer.parseInt(request.getParameter("occupied")) + 1;
        
       // PreparedStatement ps = jdbcUtility.getpsSelectAllRoom();
        
        
        try {
            PreparedStatement ps = jdbcUtility.getPsInsertApplication();
            ps.setInt(1, studentID);
            ps.setInt(2, roomID);
            ps.setString(3, "pending");     
            
           int insertStatus = ps.executeUpdate();
          
           if(insertStatus == 1){
               ps = jdbcUtility.getpsUpdateRoomOccupied();
               ps.setInt(1, occupied);
               ps.setInt(2, roomID);
               ps.executeUpdate();
               
               ps = jdbcUtility.getpsUpdateStudentApplicationStatus();
               ps.setInt(1,1);
               ps.setInt(2,studentID);
               ps.executeUpdate();               
               
               stud.setApplication(1);
               session.setAttribute("student", stud);
               
               response.sendRedirect(request.getContextPath() + "/studentHome.jsp?success=Apply success!");
           }
           else
             response.sendRedirect(request.getContextPath() + "/studentHome.jsp?message=Failed1");
        } catch (SQLException ex) {
            //failed
            while (ex != null) {
                System.out.println ("SQLState: " + ex.getSQLState ());
                System.out.println ("Message:  " + ex.getMessage ());
		System.out.println ("Vendor:   " + ex.getErrorCode ());
                ex = ex.getNextException ();
		System.out.println ("");
            }
            response.sendRedirect(request.getContextPath() + "/studentHome.jsp?message=Failed2");
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
