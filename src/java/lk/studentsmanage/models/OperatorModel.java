/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studentsmanage.models;

public class OperatorModel {

    private String nic;
    private String firstName;
    private String lastName;
    private String bday;
    private String address; 
    private String enrolledDate;
    private String status;

    public OperatorModel() {
    }

    public OperatorModel(String nic, String firstName, String lastName, String bday, String address, String enrolledDate, String status) {
        this.nic = nic;
        this.firstName = firstName;
        this.lastName = lastName;
        this.bday = bday;
        this.address = address;
        this.enrolledDate = enrolledDate;
        this.status = status;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "OperatorModel{" + "nic=" + nic + ", firstName=" + firstName + ", lastName=" + lastName + ", bday=" + bday + ", address=" + address + ", enrolledDate=" + enrolledDate + ", status=" + status + '}';
    }
    
    
    
}
