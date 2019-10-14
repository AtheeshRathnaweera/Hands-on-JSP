/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Utils;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.util.concurrent.TimeUnit;
import okhttp3.OkHttpClient;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

/**
 *
 * @author User
 */
public class RetrofitClient {
     private static RetrofitClient retrofit_client;
    private Retrofit retrofit;
    
    private RetrofitClient(String url) {

        
        OkHttpClient c = new OkHttpClient.Builder().callTimeout(5,TimeUnit.SECONDS).build();
        Gson gson = new GsonBuilder()
                .setLenient()
                .create();
        retrofit = new Retrofit.Builder()
                .baseUrl(url)
                .client(c)
                .addConverterFactory(GsonConverterFactory.create(gson))
                .build();
    }

    public Retrofit getRetrofit() {
        return retrofit;
    }

    public static RetrofitClient getRetrofitClient(String url) {

        if (retrofit_client == null) {

            retrofit_client = new RetrofitClient(url);
        }
        return retrofit_client;
    }
}
