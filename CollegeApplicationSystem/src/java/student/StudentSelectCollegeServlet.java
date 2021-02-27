/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package student;

import bean.Student;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import jdbc.JDBCUtility;
import bean.College;
import java.util.ArrayList;


/**
 *
 * @author USER
 */
@WebServlet(name = "StudentSelectCollegeServlet", urlPatterns = {"/StudentSelectCollegeServlet"})
public class StudentSelectCollegeServlet extends HttpServlet {

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
        jdbcUtility.prepareSQLStatemenSelectAllCollege();
        jdbcUtility.prepareSQLStatemenSelectAllRoom();
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
        ArrayList<College> collegeList = new ArrayList<College>();
        int totalAvailable = 0;       
        
        try {
            PreparedStatement ps = jdbcUtility.getpsSelectAllCollege();
          
            ResultSet rs = ps.executeQuery();
          
           while(rs.next()){        
               College college = new College();
               college.setCollegeID(rs.getInt(1));
               college.setCollegeName(rs.getString(2));
               collegeList.add(college);
           }
           
            for(int i=0; i <collegeList.size();i++){
                ps = jdbcUtility.getpsSelectAllRoom();
                rs = ps.executeQuery(); 
                totalAvailable = 0;
                while(rs.next()){
                   if(rs.getInt(3) == collegeList.get(i).getCollegeID()){
                       totalAvailable += (rs.getInt(6)-rs.getInt(7));
                   }
               }         
               collegeList.get(i).setTotalAvailable(totalAvailable);
           }
                      
           request.setAttribute("data",collegeList);
           
           RequestDispatcher rd = request.getRequestDispatcher("/studentSelectCollege.jsp");
           rd.forward(request, response); 
           
           response.sendRedirect(request.getContextPath() + "/studentSelectCollege.jsp");
        } catch (SQLException ex) {
            //failed
            while (ex != null) {
                System.out.println ("SQLState: " + ex.getSQLState ());
                System.out.println ("Message:  " + ex.getMessage ());
		System.out.println ("Vendor:   " + ex.getErrorCode ());
                ex = ex.getNextException ();
		System.out.println ("");
            }
            response.sendRedirect(request.getContextPath() + "/studentHome.jsp?message=Faileddd");
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
