/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lk.studentsmanage.services;

import java.util.ArrayList;
import java.util.List;
import lk.studentsmanage.models.ClassModel;
import lk.studentsmanage.models.StudentModel;
import lk.studentsmanage.models.TeacherModel;
import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.GET;
import retrofit2.http.POST;
import retrofit2.http.Path;

/**
 *
 * @author User
 */
public interface ClassAPI {
    
    @GET("class/allCount")
    Call<Long> getAllCount();
    
    @GET("class/getClassAmount/{grade}")
    Call<Long> getClassAmountOfAGrade(@Path("grade") int grade);
    
    @GET("class/getInfo/{classId}")
    Call<ClassModel> getClassInfo(@Path("classId") int classId);
    
    @GET("class/getStudentsCount/{classId}}")
    Call<Long> getStudentAmountOfAClass(@Path("classId") int classId);

    @GET("class/getClasses/{grade}")
    Call<List<ClassModel>> getAllClassesByGrade(@Path("grade") int grade);

    @GET("class/getStudents/{classId}")
    Call<List<StudentModel>> getAllStudentsByClass(@Path("classId") int classId);

    @GET("class/getTeacher/{classId}")
    Call<List<TeacherModel>> getClassTeacher(@Path("classId") int classId);

    @POST("class/add")
    Call<ClassModel> saveAClass(@Body ClassModel classdto);

    @POST("addStudent")
    Call<Boolean> AddAStudent(@Body StudentModel ssdto);

}
