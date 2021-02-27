/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package student;

import bean.Application;
import bean.College;
import bean.Room;
import bean.Student;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import jdbc.JDBCUtility;

/**
 *
 * @author USER
 */
@WebServlet(name = "StudentViewApplicationServlet", urlPatterns = {"/StudentViewApplicationServlet"})
public class StudentViewApplicationServlet extends HttpServlet {
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
        jdbcUtility.prepareSQLStatemenSelectAllApplicationStud();
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
        
        ArrayList<College> collegeList = new ArrayList<College>();
        ArrayList<Room> roomList = new ArrayList<Room>();
        ArrayList<Application> applicationList = new ArrayList<Application>();
        
        HttpSession session = request.getSession();
        if(session.getAttribute("user") == null||session.getAttribute("student") == null){
            response.sendRedirect(request.getContextPath() + "/notAuthorized.jsp");
            return;
        }
        Student stud = new Student();
        stud  = (Student)session.getAttribute("student");
        int studentID = stud.getStudentID();
        
        try {
            PreparedStatement ps = jdbcUtility.getpsSelectAllApplicationStud();
            ps.setInt(1, studentID);
          
            ResultSet rs = ps.executeQuery();
          
           while(rs.next()){
               College college = new College();
               Room room = new Room();
               Application application = new Application();
               

               college.setCollegeName(rs.getString(15));
               room.setRoomName(rs.getString(8));
               room.setRoomType(rs.getString(11));
               
               application.setApplicationDate(rs.getTimestamp(2));
               application.setProcessedDate(rs.getTimestamp(3));
               application.setStatus(rs.getString(6));

               collegeList.add(college);
               roomList.add(room);
               applicationList.add(application);
           }                          
               
           request.setAttribute("college",collegeList);
           request.setAttribute("room",roomList);
           request.setAttribute("application",applicationList);
           
           RequestDispatcher rd = request.getRequestDispatcher("/studentViewApplication.jsp");
           rd.forward(request, response); 
           response.sendRedirect(request.getContextPath() + "/studentViewApplication.jsp");
           
             response.sendRedirect(request.getContextPath() + "/studentHome.jsp?message=Fail to view");
        } catch (SQLException ex) {
            //failed
            while (ex != null) {
                System.out.println ("SQLState: " + ex.getSQLState ());
                System.out.println ("Message:  " + ex.getMessage ());
		System.out.println ("Vendor:   " + ex.getErrorCode ());
                ex = ex.getNextException ();
		System.out.println ("");
            }
            response.sendRedirect(request.getContextPath() + "/studentHome.jsp?message=Failed");
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
