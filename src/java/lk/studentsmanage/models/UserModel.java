/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studentsmanage.models;

public class UserModel {

    private String userId;
    private String password;
    private String userRole;

    public UserModel() {
    }

    public UserModel(String userId, String password, String userRole) {
        this.userId = userId;
        this.password = password;
        this.userRole = userRole;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserRole() {
        return userRole;
    }

    public void setUserRole(String userRole) {
        this.userRole = userRole;
    }

    @Override
    public String toString() {
        return "UserModel{" + "userId=" + userId + ", password=" + password + ", userRole=" + userRole + '}';
    }

   
    

}

