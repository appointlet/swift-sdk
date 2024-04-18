import UIKit
import WebKit
import AppointletSwiftSDK  // Make sure this import matches the actual module name of your SDK

class ViewController: UIViewController, AppointletSchedulerViewManagerDelegate {

    var appointletSchedulerViewManager: AppointletSchedulerViewManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Initialize your SDK manager here
        appointletSchedulerViewManager = AppointletSchedulerViewManager(pageId: "yourPageId", meetingTypeId: "yourMeetingTypeId")
        appointletSchedulerViewManager.setDelegate(self)
        
        // Assuming your AppointletSchedulerViewManager adds the WKWebView to its parent view
        if let webView = appointletSchedulerViewManager.webView {
            webView.frame = self.view.bounds
            view.addSubview(webView)
        }
    }

    // Delegate methods
    func appointletSchedulerViewManagerDidReceiveLoadedEvent() {
        print("Web view loaded!")
    }

    func appointletSchedulerViewManagerDidReceiveCompletedEvent() {
        print("Booking created!")
    }
}
