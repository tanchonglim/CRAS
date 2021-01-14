package bean;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author User
 */
public class Student {

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
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * @return the matricNo
     */
    public String getMatricNo() {
        return matricNo;
    }

    /**
     * @param matricNo the matricNo to set
     */
    public void setMatricNo(String matricNo) {
        this.matricNo = matricNo;
    }

    /**
     * @return the imagePath
     */
    public String getImagePath() {
        return imagePath;
    }

    /**
     * @param imagePath the imagePath to set
     */
    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
    
    /**
     * @return the imagePath
     */
    public int getApplication() {
        return application;
    }

    /**
     * @param imagePath the imagePath to set
     */
    public void setApplication(int application) {
        this.application = application;
    }
    
    private int studentID;
    private String name;
    private String matricNo;
    private String imagePath;
    private int application;
    
    
}
