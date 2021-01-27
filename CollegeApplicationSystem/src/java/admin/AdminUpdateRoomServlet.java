/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package admin;

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

/**
 *
 * @author Ong Shi Bing
 */
@WebServlet(name = "AdminUpdateRoomServlet", urlPatterns = {"/AdminUpdateRoomServlet"})
public class AdminUpdateRoomServlet extends HttpServlet {

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
        jdbcUtility.prepareSQLStatementUpdateRoom();
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
        String rName = request.getParameter("roomName");
        String rType = request.getParameter("roomType");
        int capacity = Integer.parseInt(request.getParameter("capacity"));
        int occupied = Integer.parseInt(request.getParameter("occupied"));
        int rID = Integer.parseInt(request.getParameter("roomID"));
        int cID = Integer.parseInt(request.getParameter("collegeID"));
        
        //insert into database
        try {
            PreparedStatement ps = jdbcUtility.getpsUpdateRoom();
            ps.setString(1, rName);
            ps.setString(2, rType);
            ps.setInt(3, capacity);
            ps.setInt(4, occupied);
            ps.setInt(5, rID);
          
           int updateStatus = ps.executeUpdate();
           
           if(updateStatus == 1){
               response.sendRedirect(request.getContextPath() + "/AdminSelectRoomByIDServlet?cid=" + cID + "&success=Update room success.");
           }
            
           else
             response.sendRedirect(request.getContextPath() + "/AdminSelectRoomByIDServlet?cid=" + cID + "&success=Update room fail.");
        } catch (SQLException ex) {
            //failed
            while (ex != null) {
                System.out.println ("SQLState: " + ex.getSQLState ());
                System.out.println ("Message:  " + ex.getMessage ());
		System.out.println ("Vendor:   " + ex.getErrorCode ());
                ex = ex.getNextException ();
		System.out.println ("");
            }
            response.sendRedirect(request.getContextPath() + "/AdminSelectRoomByIDServlet?cid=" + cID + "&success=Update room fail.");
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
