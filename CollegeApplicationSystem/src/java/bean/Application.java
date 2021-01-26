/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

import java.sql.Timestamp;
import java.util.Date;

/**
 *
 * @author user
 */
public class Application {

    /**
     * @return the roomtype
     */
    public String getRoomtype() {
        return roomtype;
    }

    /**
     * @param roomtype the roomtype to set
     */
    public void setRoomtype(String roomtype) {
        this.roomtype = roomtype;
    }

    /**
     * @return the studentname
     */
    public String getStudentname() {
        return studentname;
    }

    /**
     * @param studentname the studentname to set
     */
    public void setStudentname(String studentname) {
        this.studentname = studentname;
    }

    /**
     * @return the collegename
     */
    public String getCollegename() {
        return collegename;
    }

    /**
     * @param collegename the collegename to set
     */
    public void setCollegename(String collegename) {
        this.collegename = collegename;
    }

    /**
     * @return the roomname
     */
    public String getRoomname() {
        return roomname;
    }

    /**
     * @param roomname the roomname to set
     */
    public void setRoomname(String roomname) {
        this.roomname = roomname;
    }
    private int applicationID;
    private Date applicationDate;
    private Date processedDate;
    private String applicationDateString;
    private int studentID;
    private int roomID;
    private String status;
    private String studentname;
    private String collegename;
    private String roomname;
    private String roomtype;

    /**
     * @return the applicationID
     */
    public int getApplicationID() {
        return applicationID;
    }

    /**
     * @param applicationID the applicationID to set
     */
    public void setApplicationID(int applicationID) {
        this.applicationID = applicationID;
    }

    /**
     * @return the applicationDate
     */
    public Date getApplicationDate() {
        return applicationDate;
    }

    /**
     * @param applicationDate the applicationDate to set
     */
    public void setApplicationDate(Date applicationDate) {
        this.applicationDate = applicationDate;
    }

    /**
     * @return the processedDate
     */
    public Date getProcessedDate() {
        return processedDate;
    }

    /**
     * @param processedDate the processedDate to set
     */
    public void setProcessedDate(Date processedDate) {
        this.processedDate = processedDate;
    }

    /**
     * @return the studentID
     */
    public int getStudentID() {
        return studentID;
    }

    /**
     * @param studentID the studentID to set
     */
    public void setStudentID(int studentID) {
        this.studentID = studentID;
    }

    /**
     * @return the roomID
     */
    public int getRoomID() {
        return roomID;
    }

    /**
     * @param roomID the roomID to set
     */
    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    /**
     * @return the status
     */
    public String getStatus() {
        return status;
    }

    /**
     * @param status the status to set
     */
    public void setStatus(String status) {
        this.status = status;
    }
    

}
