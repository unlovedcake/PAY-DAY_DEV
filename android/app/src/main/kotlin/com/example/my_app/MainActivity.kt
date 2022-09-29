package com.example.my_app

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import com.example.my_app.common.CommonFunction;

class MainActivity: FlutterActivity() {
    private val mthdChannel = "enc/dec"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, mthdChannel)
            .setMethodCallHandler { call, result ->
            if (call.method == "encrypt"){
                val data = call.argument<String>("data")
                val key = call.argument<String>("key")
                val encrypted = CommonFunction.encryptAES256CBC(key, data);
                result.success(encrypted)
            }else if (call.method == "decrypt") {
                val data = call.argument<String>("data")
                val key = call.argument<String>("key")
                val decrypted = CommonFunction.decryptAES256CBC(key, data);
                result.success(decrypted)
            }else if (call.method == "sha1"){
                val data = call.argument<String>("data")
                var sha1 = CommonFunction.getSha1Hex(data);
                result.success(sha1)
            }else{
                result.notImplemented()
            }
        }
    }
}
