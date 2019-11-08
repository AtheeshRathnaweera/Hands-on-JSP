/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studentsmanage.models;

import java.util.Date;

/**
 *
 * @author User
 */
public class StudentModel {
    private Long admissionNumber;
    private String firstName;
    private String lastName;
    private Date bday;
    private String address;
    private Date enrolledDate;

    public StudentModel() {
    }

    public StudentModel(Long admissionNumber, String firstName, String lastName, Date bday, String address, Date enrolledDate) {
        this.admissionNumber = admissionNumber;
        this.firstName = firstName;
        this.lastName = lastName;
        this.bday = bday;
        this.address = address;
        this.enrolledDate = enrolledDate;
    }

    public Long getAdmissionNumber() {
        return admissionNumber;
    }

    public void setAdmissionNumber(Long admissionNumber) {
        this.admissionNumber = admissionNumber;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public Date getBday() {
        return bday;
    }

    public void setBday(Date bday) {
        this.bday = bday;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getEnrolledDate() {
        return enrolledDate;
    }

    public void setEnrolledDate(Date enrolledDate) {
        this.enrolledDate = enrolledDate;
    }

    @Override
    public String toString() {
        return "Student{" + "admissionNumber=" + admissionNumber + ", firstName=" + firstName + ", lastName=" + lastName + ", bday=" + bday + ", address=" + address + ", enrolledDate=" + enrolledDate + '}';
    }
    
    
    
}

