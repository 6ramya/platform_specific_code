package com.example.platform_specific_code;
import androidx.annotation.NonNull;
import io.flutter.plugin.common.MethodChannel;
import android.os.Bundle;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL="flutter.native/helper";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    super.configureFlutterEngine(flutterEngine);
         new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler(
                 (call,result)->{
                     if(call.method.equals("helloFromNativeCode")){
                         String greetings=helloFromNativeCode();
                         result.success(greetings);
                     }
                 }
        );
    }

        private String helloFromNativeCode () {
            return "Hello From Native Android Code";
        }
    }
