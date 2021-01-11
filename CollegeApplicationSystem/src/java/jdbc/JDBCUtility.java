/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package jdbc;

import java.sql.*;

/**
 *
 * @author User
 */
public class JDBCUtility {
    
    Connection con;
    String driver;
    String url;
    String userName;
    String password;
    
    //user table
    PreparedStatement psSelectUserByEmailORUsername = null;
    
    //student table
    PreparedStatement psSelecttStudentByID = null;
    
    //user-student table
    PreparedStatement psInsertUserStudent = null;
    
    //update student profile
    PreparedStatement psUpdateStudentProfile = null;
    
    //check student password
    PreparedStatement psCheckPassword = null;
    
    //update student password
    PreparedStatement psUpdateStudentPassword = null;
    
      //use this constructor if using ConnectionPool
    public JDBCUtility()
    {
    }

    //use this constructor if not using ConnectionPool
    //ConnectionPool is used for multi user!
    public JDBCUtility(String driver,
                       String url,
                       String userName,
                       String password)
    {
        this.driver = driver;
        this.url = url;
        this.userName = userName;
        this.password = password;
    }

    public  void jdbcConnect()
    {
        try
	{
            Class.forName (driver);
            con = DriverManager.getConnection(url, userName, password);

            DatabaseMetaData dma = con.getMetaData ();
            System.out.println("\nConnected to " + dma.getURL());
            System.out.println("Driver       " + dma.getDriverName());
            System.out.println("Version      " + dma.getDriverVersion());
            System.out.println("");
	}
	catch (SQLException ex)
	{
            while (ex != null)
            {
		System.out.println ("SQLState: " +
                                    ex.getSQLState ());
                System.out.println ("Message:  " +
                                    ex.getMessage ());
		System.out.println ("Vendor:   " +
                                    ex.getErrorCode ());
                ex = ex.getNextException ();
		System.out.println ("");
            }

            System.out.println("Connection to the database error");
	}
	catch (java.lang.Exception ex)
	{
            ex.printStackTrace ();
	}
    }

    public Connection jdbcGetConnection()
    {
	return con;
    }

    public void jdbcConClose()
    {
	try
	{
            con.close();
	}
	catch (Exception ex)
	{
	}
    }
    
    //user    
    public void prepareSQLStatementSelectUserByEmailORUsername(){
        
        try {
           
            //create SQL statement
            String sqlSelectUserByEmailORUsername = "SELECT * FROM user WHERE username = ? OR email = ?" ;            
            
            //prepare statement
            psSelectUserByEmailORUsername = con.prepareStatement(sqlSelectUserByEmailORUsername);            
        }
        catch (SQLException ex) {
            ex.printStackTrace ();
        }
    }
    
    public PreparedStatement getPsSelectStudentByEmailORUsername(){
        return psSelectUserByEmailORUsername;
    }
    
    //student
    
     public void prepareSQLStatementSelectStudentByID(){
        
        try {
           
            //create SQL statement
            String sqlSelectStudentByID = "SELECT * FROM student JOIN user ON student.studentID = user.studentID WHERE student.studentID = ? " ;            
            
            //prepare statement
            psSelecttStudentByID = con.prepareStatement(sqlSelectStudentByID);            
        }
        catch (SQLException ex) {
            ex.printStackTrace ();
        }
    }
    
    public PreparedStatement getPsSelectStudentbyID(){
        return psSelecttStudentByID;
    }
    
 
    
    //user-student
    
       public void prepareSQLStatementInsertUserStudent(){
        
        try {
            //create SQL statement
            String sqlInsertUserStudent = "INSERT INTO student(name, matricNo) values(?, ?); "
                    + "SET @id = LAST_INSERT_ID(); "
                    + "INSERT INTO user(username, email, password, salt, userType, studentID, addedDate) " 
                    + "values(?, ?, ?, ?, ?, @id, NOW());";
            
            //prepare statement
            psInsertUserStudent = con.prepareStatement(sqlInsertUserStudent);            
        }
        catch (SQLException ex) {
            ex.printStackTrace ();
        }
    }
    
    public PreparedStatement getPsInsertUserStudent(){
        return psInsertUserStudent;
    }
    
    //update student profile
    
    public void prepareSQLStatementUpdateStudentProfile(){
        
        try {
            //create SQL statement
            String sqlUpdateStudentProfile = "UPDATE student SET name = ?, matricNo = ? WHERE studentID = ?;"
                    + "UPDATE user SET email = ? WHERE studentID = ?;";
            
            //prepare statement
            psUpdateStudentProfile = con.prepareStatement(sqlUpdateStudentProfile);            
        }
        catch (SQLException ex) {
            ex.printStackTrace ();
        }
    }
    
    public PreparedStatement getpsUpdateStudentProfile(){
        return psUpdateStudentProfile;
    }
    
     //update student profile
    
    public void prepareSQLStatemenCheckPassword(){
        
        try {
            //create SQL statement
            String sqlCheckPassword = "SELECT password, salt FROM user WHERE studentID = ?;";
            
            //prepare statement
            psCheckPassword  = con.prepareStatement(sqlCheckPassword);            
        }
        catch (SQLException ex) {
            ex.printStackTrace ();
        }
    }
    
    public PreparedStatement getpsCheckPassword(){
        return psCheckPassword;
    }
    
    public void prepareSQLStatemenUpdateStudentPassword(){
        
        try {
            //create SQL statement
            String sqlUpdatePassword = "UPDATE user SET password = ? WHERE studentID = ?;";
            
            //prepare statement
            psUpdateStudentPassword  = con.prepareStatement(sqlUpdatePassword);            
        }
        catch (SQLException ex) {
            ex.printStackTrace ();
        }
    }
    
    public PreparedStatement getpsUpdateStudentPassword(){
        return psUpdateStudentPassword;
    }
    
    
}
