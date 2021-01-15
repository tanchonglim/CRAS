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
    
    //college table
    PreparedStatement psSelectAllCollege = null;
    
    //insert college
    PreparedStatement psInsertCollege = null;
    
    //update college
    PreparedStatement psUpdateCollege = null;
    
    //college room
    PreparedStatement psSelectRoomByID = null;
    
    //insert room
    PreparedStatement psInsertRoom = null;
    
    //update room
    PreparedStatement psUpdateRoom = null;
    
    //delete college
    PreparedStatement psDeleteCollege = null;
    
    //delete room
    PreparedStatement psDeleteRoom = null;
    
    PreparedStatement psInsertApplication = null;
    
    PreparedStatement psUpdateRoomOccupied = null;
    
    PreparedStatement psUpdateStudentApplication = null;
    
    PreparedStatement psSelectApplication = null;
    
    //admin select all application
    PreparedStatement psSelectAllApplication = null;
    
    //admin update application approval
    PreparedStatement psUpdateApprovalApplication = null;

    PreparedStatement psSelectCollegeByID = null;
    
    PreparedStatement psSelectRoomByRoomID = null;
    
    PreparedStatement getpsSelectAllApplicationStud = null;
    
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
    
    public void prepareSQLStatemenSelectAllCollege(){
        
        try {
            //create SQL statement
            String sqlSelectAllCollege = "SELECT * FROM college";
            
            //prepare statement
            psSelectAllCollege  = con.prepareStatement(sqlSelectAllCollege);            
        }
        catch (SQLException ex) {
            ex.printStackTrace ();
        }
    }
    
    public PreparedStatement getpsSelectAllCollege(){
        return psSelectAllCollege;
    }
    
    public void prepareSQLStatemenSelectRoomByID(){
        
        try {
            //create SQL statement
            String sqlSelectAllCollege = "SELECT * FROM room WHERE collegeID = ?;";
            
            //prepare statement
            psSelectRoomByID  = con.prepareStatement(sqlSelectAllCollege);            
        }
        catch (SQLException ex) {
            ex.printStackTrace ();
        }
    }
    
    public PreparedStatement getpsSelectRoomByID(){
        return psSelectRoomByID;
    }
    
    public void prepareSQLStatementUpdateCollege(){
        
        try {
            //create SQL statement
            String sqlUpdateCollege = "UPDATE college SET collegeName = ?, address = ? WHERE collegeID = ?;";
            
            //prepare statement
            psUpdateCollege = con.prepareStatement(sqlUpdateCollege);            
        }
        catch (SQLException ex) {
            ex.printStackTrace ();
        }
    }
    
    public PreparedStatement getpsUpdateCollege(){
        return psUpdateCollege;
    }
    
    public void prepareSQLStatementUpdateRoom(){
        
        try {
            //create SQL statement
            String sqlUpdateRoom = "UPDATE room SET roomName = ?, roomType = ?, capacity = ?, occupied = ? WHERE roomID = ?;";
            
            //prepare statement
            psUpdateRoom = con.prepareStatement(sqlUpdateRoom);            
        }
        catch (SQLException ex) {
            ex.printStackTrace ();
        }
    }
    
    public PreparedStatement getpsUpdateRoom(){
        return psUpdateRoom;
    }
    
    public void prepareSQLStatementInsertCollege(){
        
        try {
           
            //create SQL statement
            String sqlInsertCollege = "INSERT INTO college(collegeName, address, addedDate)" +
                                   " VALUES(?, ?, NOW())"; 
            
            //prepare statement
            psInsertCollege = con.prepareStatement(sqlInsertCollege);            
        }
        catch (SQLException ex) {
            ex.printStackTrace ();
        }
    }

    public PreparedStatement getPsInsertCollege(){
        return psInsertCollege;
    }
    
    public void prepareSQLStatementInsertRoom(){
        
        try {
           
            //create SQL statement
            String sqlInsertRoom = "INSERT INTO room(roomName, collegeID, addedDate, roomType, capacity, occupied)" +
                                   " VALUES(?, ?, NOW(), ?, ?, ?)"; 
            
            //prepare statement
            psInsertRoom = con.prepareStatement(sqlInsertRoom);            
        }
        catch (SQLException ex) {
            ex.printStackTrace ();
        }
    }

    public PreparedStatement getPsInsertRoom(){
        return psInsertRoom;
    }
    
    public void prepareSQLStatementDeleteCollege(){
        
        try {
            //create SQL statement
            String sqlDeleteCollege = "DELETE FROM college WHERE collegeID = ?;";
            
            //prepare statement
            psDeleteCollege = con.prepareStatement(sqlDeleteCollege);            
        }
        catch (SQLException ex) {
            ex.printStackTrace ();
        }
    }
    
    public PreparedStatement getpsDeleteCollege(){
        return psDeleteCollege;
    }
    
    public void prepareSQLStatementDeleteRoom(){
        
        try {
            //create SQL statement
            String sqlDeleteRoom = "DELETE FROM room WHERE roomID = ?;";
            
            //prepare statement
            psDeleteRoom = con.prepareStatement(sqlDeleteRoom);            
        }
        catch (SQLException ex) {
            ex.printStackTrace ();
        }
    }
    
    public PreparedStatement getpsDeleteRoom(){
        return psDeleteRoom;
    }
    
    public void prepareSQLStatementInsertApplication(){
        
        try {
           
            //create SQL statement
            String sqlInsertApplication = "INSERT INTO application(studentID, roomID, status, applicationDate)" +
                                   " VALUES(?, ?, ?, NOW())"; 
            
            //prepare statement
            psInsertApplication = con.prepareStatement(sqlInsertApplication);            
        }
        catch (SQLException ex) {
            ex.printStackTrace ();
        }
    }

    public PreparedStatement getPsInsertApplication(){
        return psInsertApplication;
    }
    
    public void prepareSQLStatementUpdateRoomOccupied(){
        
        try {
            //create SQL statement
            String sqlUpdateRoomOccupied = "UPDATE room SET occupied = ? WHERE roomID = ?;";
            
            //prepare statement
            psUpdateRoomOccupied = con.prepareStatement(sqlUpdateRoomOccupied);            
        }
        catch (SQLException ex) {
            ex.printStackTrace ();
        }
    }
    
    public PreparedStatement getpsUpdateRoomOccupied(){
        return psUpdateRoomOccupied;
    }
    
    public void prepareSQLStatementUpdateStudentApplication(){
        
        try {
            //create SQL statement
            String sqlUpdateStudentApplication = "UPDATE student SET application = ? WHERE studentID = ?;";
            
            //prepare statement
            psUpdateStudentApplication = con.prepareStatement(sqlUpdateStudentApplication);            
        }
        catch (SQLException ex) {
            ex.printStackTrace ();
        }
    }
    
    public PreparedStatement getpsUpdateStudentApplication(){
        return psUpdateStudentApplication;
    }
    
    public void prepareSQLStatemenSelectApplication(){
        
        try {
            //create SQL statement
            String sqlSelectApplication = "SELECT * FROM application where studentID = ?;";
            
            //prepare statement
            psSelectApplication  = con.prepareStatement(sqlSelectApplication);            
        }
        catch (SQLException ex) {
            ex.printStackTrace ();
        }
    }
    
    public PreparedStatement getpsSelectApplication(){
        return psSelectApplication;
    }
    
    public void prepareSQLStatementSelectAllApplication(){
        
        try {
            //create SQL statement
            String sqlSelectAllApplication = "SELECT * FROM application";
            
            //prepare statement
            psSelectAllApplication  = con.prepareStatement(sqlSelectAllApplication);            
        }
        catch (SQLException ex) {
            ex.printStackTrace ();
        }
    }
    
    public PreparedStatement getPsSelectAllApplication(){
        return psSelectAllApplication;
    }
    
    public void prepareSQLStatementUpdateApprovalApplication(){
        
        try {
            //create SQL statement
            String sqlUpdateApprovalApplication = "UPDATE application SET status = ?, processedDate = NOW() WHERE applicationID = ?;";
            
            //prepare statement
            psUpdateApprovalApplication = con.prepareStatement(sqlUpdateApprovalApplication);            
        }
        catch (SQLException ex) {
            ex.printStackTrace ();
        }
    }
    
    public PreparedStatement getpsUpdateApprovalApplication(){
        return psUpdateApprovalApplication;
    }
    
    public void prepareSQLStatemenSelectCollegeByID(){
        
        try {
            //create SQL statement
            String sqlSelectCollegeByID = "SELECT * FROM college WHERE collegeID = ?;";
            
            //prepare statement
            psSelectCollegeByID  = con.prepareStatement(sqlSelectCollegeByID);            
        }
        catch (SQLException ex) {
            ex.printStackTrace ();
        }
    }
    
    public PreparedStatement getpsSelectCollegeByID(){
        return psSelectCollegeByID;
    }
    
    public void prepareSQLStatemenSelectRoomByRoomID(){
        
        try {
            //create SQL statement
            String sqlSelectRoomByRoomID = "SELECT * FROM room WHERE roomID = ?;";
            
            //prepare statement
            psSelectRoomByRoomID  = con.prepareStatement(sqlSelectRoomByRoomID);            
        }
        catch (SQLException ex) {
            ex.printStackTrace ();
        }
    }
    
    public PreparedStatement getpsSelectRoomByRoomID(){
        return psSelectRoomByRoomID;
    }
    
    public void prepareSQLStatemenSelectAllApplicationStud(){
        
        try {
            //create SQL statement
            String sqlSelectAllApplicationStud = "SELECT * FROM application INNER JOIN room ON application.roomID = room.roomId INNER JOIN college on room.collegeID = college.collegeID WHERE studentID = ?;";
            
            //prepare statement
            getpsSelectAllApplicationStud  = con.prepareStatement(sqlSelectAllApplicationStud);            
        }
        catch (SQLException ex) {
            ex.printStackTrace ();
        }
    }
    
    public PreparedStatement getpsSelectAllApplicationStud(){
        return getpsSelectAllApplicationStud;
    }
    

}

