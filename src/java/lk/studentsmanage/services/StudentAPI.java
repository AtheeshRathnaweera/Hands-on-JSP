/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studentsmanage.services;

import java.util.ArrayList;
import lk.studentsmanage.models.StudentModel;
import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Path;

/**
 *
 * @author User
 */
public interface StudentAPI {
    
    @GET("getStudent/{admissionNum}")
    Call<StudentModel> getStudentDetails(@Path("admissionNum") String admissionNum);
    
    @GET("users/studentUsersCount")
    Call<ArrayList<Long>> getStudentUsersCount();

    
}
