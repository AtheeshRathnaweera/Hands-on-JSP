/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studentsmanage.services;


import lk.studentsmanage.models.UserModel;
import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.POST;

public interface LoginAPI {

    @POST("login")
    Call<UserModel> login(@Body UserModel uLog);

    @POST("signin/student")
    Call<UserModel> signInStudent(@Body UserModel uSign);
    
    @POST("signin/teacher")
    Call<UserModel> signInTeacher(@Body UserModel tSign);
    
    @POST("signin/operator")
    Call<UserModel> signInOperator(@Body UserModel pSign);

}
