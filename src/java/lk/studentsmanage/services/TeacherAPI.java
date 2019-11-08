/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studentsmanage.services;


import lk.studentsmanage.models.TeacherModel;
import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Path;

/**
 *
 * @author User
 */
public interface TeacherAPI {
    
    @GET("getTeacher/{teacherNic}")
    Call<TeacherModel> getTeacherDetails(@Path("teacherNic") String teacherNic);
    
}
