import Flutter
import UIKit

public class SwiftFlutterThailandProvincesPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_thailand_provinces", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterThailandProvincesPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
