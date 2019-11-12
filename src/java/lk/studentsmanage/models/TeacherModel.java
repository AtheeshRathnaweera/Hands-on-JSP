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
public class TeacherModel {
    
    
    private String nic;
    private String firstName;
    private String lastName;
    private String address;
    private Long telephoneNumber;
    private String status;
    private String gender;
    private Integer currentClassId;

    public TeacherModel() {
    }

    public TeacherModel(String nic, String firstName, String lastName, String address, Long telephoneNumber, String status, String gender, Integer currentClassId) {
        this.nic = nic;
        this.firstName = firstName;
        this.lastName = lastName;
        this.address = address;
        this.telephoneNumber = telephoneNumber;
        this.status = status;
        this.gender = gender;
        this.currentClassId = currentClassId;
    }

  

  
    public String getNic() {
        return nic;
    }

    public void setNic(String nic) {
        this.nic = nic;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Long getTelephoneNumber() {
        return telephoneNumber;
    }

    public void setTelephoneNumber(Long telephoneNumber) {
        this.telephoneNumber = telephoneNumber;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getCurrentClassId() {
        return currentClassId;
    }

    public void setCurrentClassId(Integer currentClassId) {
        this.currentClassId = currentClassId;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    @Override
    public String toString() {
        return "TeacherModel{" + "nic=" + nic + ", firstName=" + firstName + ", lastName=" + lastName + ", address=" + address + ", telephoneNumber=" + telephoneNumber + ", status=" + status + ", gender=" + gender + ", currentClassId=" + currentClassId + '}';
    }

    

    
    
    
}
