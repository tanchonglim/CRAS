/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package shared;

import bean.Student;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.text.SimpleDateFormat;  
import jdbc.JDBCUtility;
import bean.*;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.DigestUtils;

/**
 *
 * @author Tan Chong Lim
 */
@WebServlet(name = "StudentLoginServlet", urlPatterns = {"/StudentLoginServlet"})
public class LoginServlet extends HttpServlet {

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
        jdbcUtility.prepareSQLStatementSelectUserByEmailORUsername();
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
        
        String login = request.getParameter("login");
        String password = request.getParameter("password");
        
         try {
            PreparedStatement ps = jdbcUtility.getPsSelectStudentByEmailORUsername();

            ps.setString(1, login);
            ps.setString(2, login);

            ResultSet selectResult = ps.executeQuery();
          
           if(selectResult.next()){
               
                int userID = Integer.parseInt(selectResult.getString("userID"));
                String username = selectResult.getString("username");
                String email = selectResult.getString("email");
                java.sql.Date addedDate = selectResult.getDate("addedDate");
                int studentID = Integer.parseInt(selectResult.getString("studentID"));
                String userType = selectResult.getString("userType");
                String salt = selectResult.getString("salt");
                String hashedPassword = selectResult.getString("password");
               
               if(hashedPassword.equals(DigestUtils.sha512Hex(password + salt))){
                   //valid credential
                   //set session
                   User user = new User();
                   user.setUserID(userID);
                   user.setUsername(username);
                   user.setEmail(email);
                   user.setUserType(userType);
                   user.setStudentID(studentID);
                   //user.setAddedDate(new SimpleDateFormat("YYYY-MM-DD HH:MM:SS").parse(addedDate));
                   Date sqlDate = new Date(addedDate.getTime());
                   user.setAddedDate(sqlDate);
                  
                   
                   HttpSession session = request.getSession();
                   session.setAttribute("user", user); 
                   
                   if(user.getUserType().equals("student")){
                       PreparedStatement ps2 = jdbcUtility.getPsSelectStudentbyID();
                       ps2.setString(1, String.valueOf(user.getStudentID()));
                       
                       ResultSet selectResult2 = ps2.executeQuery();
                       Student student = null;
                       
                       if(selectResult2.next()){
                           String name = selectResult2.getString("name");
                           String matricNo = selectResult2.getString("matricNo");
                           String imagepath = selectResult2.getString("imagepath");
                           
                           student = new Student();
                           student.setName(name);
                           student.setMatricNo(matricNo);
                           student.setStudentID(studentID);
                           student.setImagePath(imagepath);
                       }
                       
                       session.setAttribute("student", student);
                   }
                   
                   if(user.getUserType().equals("student")){
                        //redirect to StudentHome
                        response.sendRedirect(request.getContextPath() + "/studentHome.jsp");                      
                   } else {
                       response.sendRedirect(request.getContextPath() + "/adminHome.jsp");
                   }
                   

               } else {
                   //invalid credential
                    response.sendRedirect(request.getContextPath() + "/login.jsp?message=invalid credential");
               }
           }
          
           else
             response.sendRedirect(request.getContextPath() + "/login.jsp?message=invalid credential");
        } catch (SQLException ex) {
            //failed
            while (ex != null) {
                System.out.println ("SQLState: " + ex.getSQLState ());
                System.out.println ("Message:  " + ex.getMessage ());
		System.out.println ("Vendor:   " + ex.getErrorCode ());
                ex = ex.getNextException ();
		System.out.println ("");
            }
            response.sendRedirect(request.getContextPath() + "/login.jsp?message=failed");
        } catch (Exception e){
            //failed
            System.out.println(e);
            response.sendRedirect(request.getContextPath() + "/login.jsp?message=failed");
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
