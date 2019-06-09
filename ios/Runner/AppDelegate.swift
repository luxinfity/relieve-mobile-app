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
    var filePath:String!
#if DEBUG
    print("[FIREBASE] Development mode.")
    filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist", inDirectory: "Debug")
#else
    print("[FIREBASE] Production mode.")
    filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist", inDirectory: "Release")
#endif

    let options = FirebaseOptions.init(contentsOfFile: filePath)!
    FirebaseApp.configure(options: options)

    GeneratedPluginRegistrant.register(with: self)
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
