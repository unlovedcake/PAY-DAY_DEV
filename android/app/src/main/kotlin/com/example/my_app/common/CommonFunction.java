package com.example.my_app.common;

import com.scottyab.aescrypt.AESCrypt;

import java.security.GeneralSecurityException;
import java.security.MessageDigest;

public class CommonFunction {
    //SHA1 generator
    public static String getSha1Hex(String clearString) {
        try {
            MessageDigest messageDigest = MessageDigest.getInstance("SHA-1");
            messageDigest.update(clearString.getBytes());
            byte[] bytes = messageDigest.digest();
            StringBuilder buffer = new StringBuilder();
            for (byte b : bytes) {
                buffer.append(Integer.toString((b & 0xff) + 0x100, 16).substring(1));
            }
            return buffer.toString();
        } catch (Exception ignored) {
            ignored.printStackTrace();
            return null;
        }
    }

    //AES256 CBC
    public static String encryptAES256CBC(String key, String message) {
        String encryptedMsg = "";
        try {
            encryptedMsg = AESCrypt.encrypt(key, message);
        } catch (GeneralSecurityException e) {
            encryptedMsg = "error";
            e.printStackTrace();
        }

        return encryptedMsg;
    }

    //AES256 CBC
    public static String decryptAES256CBC(String key, String encryptedMsg) {
        String messageAfterDecrypt = "";
        try {
            messageAfterDecrypt = AESCrypt.decrypt(key, encryptedMsg);
        } catch (GeneralSecurityException e) {
            e.printStackTrace();
            messageAfterDecrypt = "error";
        }

        return messageAfterDecrypt;
    }
}
