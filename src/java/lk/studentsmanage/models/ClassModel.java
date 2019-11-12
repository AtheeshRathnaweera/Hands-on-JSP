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
public class ClassModel {
    
    Integer id;
    Integer grade;
    String name;

    public ClassModel() {
    }

    public ClassModel(Integer id, Integer grade, String name) {
        this.id = id;
        this.grade = grade;
        this.name = name;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getGrade() {
        return grade;
    }

    public void setGrade(Integer grade) {
        this.grade = grade;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "ClassModel{" + "id=" + id + ", grade=" + grade + ", name=" + name + '}';
    }
    
    
    
}
