/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studentsmanage.services;

import java.util.ArrayList;
import java.util.List;
import lk.studentsmanage.models.StudentModel;
import lk.studentsmanage.models.UserModel;
import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Path;

/**
 *
 * @author User
 */
public interface StudentAPI {
    
    @GET("student/get/{admissionNum}")
    Call<StudentModel> getStudentDetails(@Path("admissionNum") String admissionNum);
    
    @GET("student/getallcount")
    Call<Long> getStudentCount();
    
    

    
}
