package lk.studentsmanage.services;

import java.util.List;
import lk.studentsmanage.models.ClassModel;
import lk.studentsmanage.models.OperatorModel;
import lk.studentsmanage.models.UserModel;
import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.GET;
import retrofit2.http.PUT;
import retrofit2.http.Path;

public interface AdminAPI {
    
    @GET("operator/getallcount")
    Call<Long> getAllOperatorsCount();
    
    @GET("users/teacherUsersCount")
    Call<Long> getAllTeacherUsersCount();
    
    @GET("users/studentUsersCount")
    Call<Long> getAllStudentUsersCount();
    
    @GET("users/students")
    Call<List<UserModel>> getAllStudentUsers();
    
    @GET("users/teachers")
    Call<List<UserModel>> getAllTeacherUsers();
    
    @GET("operator/getall")
    Call<List<OperatorModel>> getAllOperators();
    
    @PUT("pwResetAdmin")
    Call<Boolean> resetAdminPassword(@Body UserModel adminNew);
    
    
}
