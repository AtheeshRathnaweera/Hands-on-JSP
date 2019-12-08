/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studentsmanage.services;


import java.util.List;
import lk.studentsmanage.models.StudentHistory;
import lk.studentsmanage.models.StudentModel;
import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.GET;
import retrofit2.http.PUT;
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
    
    @GET("student/getall")
    Call<List<StudentModel>> getAllStudents();
    
    @GET("student/getStudentHistory/{admissionNum}")
    Call<List<StudentHistory>> getStudentHistory(@Path("admissionNum") String admissionNum);
    
    @PUT("student/updateResults")
    Call<StudentHistory> saveTermTestResults(@Body StudentHistory historyObj);
    
    

    
}
