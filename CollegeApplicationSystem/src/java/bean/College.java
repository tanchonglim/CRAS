/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

import java.util.Date;

/**
 *
 * @author Ong Shi Bing
 */
public class College {

    /**
     * @return the collegeID
     */
    public int getCollegeID() {
        return collegeID;
    }

    /**
     * @param collegeID the collegeID to set
     */
    public void setCollegeID(int collegeID) {
        this.collegeID = collegeID;
    }

    /**
     * @return the collegeName
     */
    public String getCollegeName() {
        return collegeName;
    }

    /**
     * @param collegeName the collegeName to set
     */
    public void setCollegeName(String collegeName) {
        this.collegeName = collegeName;
    }

    /**
     * @return the address
     */
    public String getAddress() {
        return address;
    }

    /**
     * @param address the address to set
     */
    public void setAddress(String address) {
        this.address = address;
    }

    /**
     * @return the addedDate
     */
    public Date getAddedDate() {
        return addedDate;
    }

    /**
     * @param addedDate the addedDate to set
     */
    public void setAddedDate(Date addedDate) {
        this.addedDate = addedDate;
    }
    
    /**
     * @return the totalAvailable
     */
    public int getTotalAvailable() {
        return totalAvailable;
    }

    /**
     * @param totalAvailable the totalAvailable to set
     */
    public void setTotalAvailable(int totalAvailable) {
        this.totalAvailable = totalAvailable;
    }
    
    private int collegeID;
    private String collegeName;
    private String address;
    private Date addedDate;
    private int totalAvailable;
}
