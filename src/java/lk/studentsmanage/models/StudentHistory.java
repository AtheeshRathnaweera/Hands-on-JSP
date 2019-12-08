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
public class StudentHistory {
    
    private Integer id;
    private Long admissionNumber;
    private int year;
    private ClassModel classId;
    private String subjects;
    private String firstTermResults;
    private String secondTermResults;
    private String thirdTermResults;

    public StudentHistory() {
    }

    public StudentHistory(Integer id, Long admissionNumber, int year, ClassModel classId, String subjects, String firstTermResults, String secondTermResults, String thirdTermResults) {
        this.id = id;
        this.admissionNumber = admissionNumber;
        this.year = year;
        this.classId = classId;
        this.subjects = subjects;
        this.firstTermResults = firstTermResults;
        this.secondTermResults = secondTermResults;
        this.thirdTermResults = thirdTermResults;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Long getAdmissionNumber() {
        return admissionNumber;
    }

    public void setAdmissionNumber(Long admissionNumber) {
        this.admissionNumber = admissionNumber;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public ClassModel getClassId() {
        return classId;
    }

    public void setClassId(ClassModel classId) {
        this.classId = classId;
    }

    public String getFirstTermResults() {
        return firstTermResults;
    }

    public void setFirstTermResults(String firstTermResults) {
        this.firstTermResults = firstTermResults;
    }

    public String getSecondTermResults() {
        return secondTermResults;
    }

    public void setSecondTermResults(String secondTermResults) {
        this.secondTermResults = secondTermResults;
    }

    public String getThirdTermResults() {
        return thirdTermResults;
    }

    public void setThirdTermResults(String thirdTermResults) {
        this.thirdTermResults = thirdTermResults;
    }

    public String getSubjects() {
        return subjects;
    }

    public void setSubjects(String subjects) {
        this.subjects = subjects;
    }

    @Override
    public String toString() {
        return "StudentHistory{" + "id=" + id + ", admissionNumber=" + admissionNumber + ", year=" + year + ", classId=" + classId + ", subjects=" + subjects + ", firstTermResults=" + firstTermResults + ", secondTermResults=" + secondTermResults + ", thirdTermResults=" + thirdTermResults + '}';
    }
    
}
