/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package admin;

import bean.Application;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jdbc.JDBCUtility;

/**
 *
 * @author Wen Jie
 */
@WebServlet(name = "AdminViewApplicationHistoryServlet", urlPatterns = {"/AdminViewApplicationHistoryServlet"})
public class AdminViewApplicationHistoryServlet extends HttpServlet {

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
        jdbcUtility.prepareSQLStatementSelectAllApplicationHistory();
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
       try {
            PreparedStatement ps = jdbcUtility.getPsSelectAllApplicationHistory();
            ResultSet rs = ps.executeQuery();

            
            ArrayList applicationList = new ArrayList();
            Application application; 

            while(rs.next()) {
                PrintWriter out = response.getWriter();
                
                int applicationID = rs.getInt("applicationID");
                Date applicationDate = rs.getDate("applicationDate");
                Date processedDate = rs.getDate("processedDate");
                Timestamp applicationDateTime = rs.getTimestamp("applicationDate");
                Timestamp processedDateTime = rs.getTimestamp("processedDate");
                int studentID = rs.getInt("studentID");
                int roomID = rs.getInt("roomID");
                String status = rs.getString("status");

                SimpleDateFormat ft = new SimpleDateFormat ("yyyy.MM.dd HH:mm:ss");
                
         
                application = new Application();
                application.setApplicationID(applicationID);
                application.setApplicationDate(applicationDateTime);
                application.setProcessedDate(processedDateTime);
                application.setStudentID(studentID);
                application.setRoomID(roomID);
                application.setStatus(status);
                
                applicationList.add(application);
            }
            
            request.setAttribute("applicationList", applicationList);
            request.getRequestDispatcher("adminViewApplicationHistory.jsp").forward(request, response);
         
           /*if(insertStatus == 1)
            response.sendRedirect(request.getContextPath() + "/adminViewRoom.jsp?cid="+cID);
           else
             response.sendRedirect(request.getContextPath() + "/adminHome.jsp");*/
        } catch (SQLException ex) {
            //failed
            while (ex != null) {
                System.out.println ("SQLState: " + ex.getSQLState ());
                System.out.println ("Message:  " + ex.getMessage ());
		System.out.println ("Vendor:   " + ex.getErrorCode ());
                ex = ex.getNextException ();
		System.out.println ("");
            }
            response.sendRedirect(request.getContextPath() + "/adminHome.jsp");
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
