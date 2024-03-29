/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studentsmanage.models;


/**
 *
 * @author User
 */
public class StudentModel {
    private Long admissionNumber;
    private String firstName;
    private String lastName;
    private String bday;
    private String address;
    private String enrolledDate;
    private ClassModel currentClass;

    public StudentModel() {
    }

    public StudentModel(Long admissionNumber, String firstName, String lastName, String bday, String address, String enrolledDate, ClassModel currentClass) {
        this.admissionNumber = admissionNumber;
        this.firstName = firstName;
        this.lastName = lastName;
        this.bday = bday;
        this.address = address;
        this.enrolledDate = enrolledDate;
        this.currentClass = currentClass;
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

    public String getBday() {
        return bday;
    }

    public void setBday(String bday) {
        this.bday = bday;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEnrolledDate() {
        return enrolledDate;
    }

    public void setEnrolledDate(String enrolledDate) {
        this.enrolledDate = enrolledDate;
    }

    public ClassModel getCurrentClass() {
        return currentClass;
    }

    public void setCurrentClass(ClassModel currentClass) {
        this.currentClass= currentClass;
    }

    @Override
    public String toString() {
        return "StudentModel{" + "admissionNumber=" + admissionNumber + ", firstName=" + firstName + ", lastName=" + lastName + ", bday=" + bday + ", address=" + address + ", enrolledDate=" + enrolledDate + ", currentClass=" + currentClass + '}';
    }


    
    
}

