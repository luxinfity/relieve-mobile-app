import UIKit
import Flutter
import GoogleMaps
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    
    GMSServices.provideAPIKey("IOS_API_KEY")
    
    // Use Firebase library to configure APIs
    let filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist")!
    let options = FirebaseOptions(contentsOfFile: filePath)
    FirebaseApp.configure(options: options!)

    GeneratedPluginRegistrant.register(with: self)
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
