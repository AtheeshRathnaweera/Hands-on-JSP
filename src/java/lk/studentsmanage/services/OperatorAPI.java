package lk.studentsmanage.services;

import lk.studentsmanage.models.OperatorModel;
import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.DELETE;
import retrofit2.http.POST;
import retrofit2.http.Path;

public interface OperatorAPI {
    
    @POST("operator/add")
    Call<OperatorModel> addNewOperator(@Body OperatorModel op);
    
    @DELETE("operator/remove/{nic}/{status}")
    Call<Boolean> updateStatus(@Path("nic")String nic,@Path("status")String status);
    
}
