import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
  
    let encryptionChannel = FlutterMethodChannel(name: "enc/dec", binaryMessenger: controller.binaryMessenger)
    encryptionChannel.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
      // Note: this method is invoked on the UI thread.
        if(call.method == "encrypt"){
            guard let args = call.arguments as? [String : Any] else {return}
            let data = args["data"] as! String
            let key = args["key"] as! String

            //  START: Encrypting params
            let useAES: AESCrypt = AESCrypt()
            let eencrypt = useAES.encrypt(key, message: data)!
            self?.encrypt(result: result, encrypted: eencrypt)
            //  END: Encrypting params
            return
        }else if(call.method == "decrypt"){
            guard let args = call.arguments as? [String : Any] else {return}
            let data = args["data"] as! String
            let key = args["key"] as! String

            //  START: Decrypting params
            let useAES: AESCrypt = AESCrypt()
            let decryptedString = useAES.decrypt(key, message: data)!
            self?.decrypt(result: result, decrypted: decryptedString)
            //  END: Decrypting params
            return
        }else if(call.method == "sha1"){
            guard let args = call.arguments as? [String : Any] else {return}
            let data = args["data"] as! String
            self?.sha1(result: result, stringData: data)
            return
        }else{
            result(FlutterMethodNotImplemented)
            return
        }
    })


    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
      
    private func encrypt(result: FlutterResult, encrypted: String) {
        result(encrypted)
    }
    
    private func decrypt(result: FlutterResult, decrypted: String) {
        result(decrypted)
    }

    // HASH A STRING TO SHA1
    func sha1(result: FlutterResult, stringData: String) {
        let data = stringData.data(using: String.Encoding.utf8)!
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA1($0, CC_LONG(data.count), &digest)
        }
        let hexBytes = digest.map { String(format: "%02hhx", $0) }

        result(hexBytes.joined())
    }
}

import Foundation
import CryptoSwift

var keyValue :String!

class CryptoHelper{
    private static let iv = "RF22SW76BV83EDH8RF22SW76BV83EDH8123456789";
    // ENC
    public static func encrypt(dataFromFlutter :String, keyFromFlutter :String) -> String? {
        do{
            let encrypted: Array<UInt8> = try AES(key: keyFromFlutter, iv: iv, padding: .pkcs5).encrypt(Array(dataFromFlutter.utf8))
            return encrypted.toBase64()
        }catch{
            return "DATA ERROR"
        }
    }
    
    // DEC
    public static func decrypt(dataFromFlutter :String, keyFromFlutter :String) -> String? {
        do{
            let data = Data(base64Encoded: dataFromFlutter)
            let decrypted = try AES(key: keyFromFlutter, iv: iv, padding: .pkcs5).decrypt(data!.bytes)
            return String(data: Data(decrypted), encoding: .utf8)
        }catch{
            return "DATA ERROR"
        }
    }
}