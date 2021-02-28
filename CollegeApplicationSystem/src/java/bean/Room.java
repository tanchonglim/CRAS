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
public class Room {

    /**
     * @return the activated
     */
    public int getActivated() {
        return activated;
    }

    /**
     * @param activated the activated to set
     */
    public void setActivated(int activated) {
        this.activated = activated;
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
     * @return the roomName
     */
    public String getRoomName() {
        return roomName;
    }

    /**
     * @param roomName the roomName to set
     */
    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

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
     * @return the roomType
     */
    public String getRoomType() {
        return roomType;
    }

    /**
     * @param roomType the roomType to set
     */
    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    /**
     * @return the capacity
     */
    public int getCapacity() {
        return capacity;
    }

    /**
     * @param capacity the capacity to set
     */
    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    /**
     * @return the occupied
     */
    public int getOccupied() {
        return occupied;
    }

    /**
     * @param occupied the occupied to set
     */
    public void setOccupied(int occupied) {
        this.occupied = occupied;
    }
    private int roomID;
    private String roomName;
    private int collegeID;
    private Date addedDate;
    private String roomType;
    private int activated;
    private int capacity;
    private int occupied;
}
