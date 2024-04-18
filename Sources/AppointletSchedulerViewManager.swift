import UIKit
import WebKit

public protocol AppointletSchedulerViewManagerDelegate: AnyObject {
    func appointletSchedulerViewManagerDidReceiveLoadedEvent()
    func appointletSchedulerViewManagerDidReceiveCompletedEvent()
}

public class AppointletSchedulerViewManager: NSObject, WKScriptMessageHandler {

    private var webView: WKWebView!
    private weak var delegate: AppointletSchedulerViewManagerDelegate?
    private var baseURL: String = "https://appt.link"
    
    public init(pageId: String, meetingTypeId: String? = nil) {
        super.init()
        let fullURL = constructURL(pageId: pageId, meetingTypeId: meetingTypeId)
        setupWebView(urlString: fullURL)
    }

    private func constructURL(pageId: String, meetingTypeId: String?) -> String {
        if let typeId = meetingTypeId {
            return "\(baseURL)/\(pageId)/\(typeId)"
        } else {
            return "\(baseURL)/\(pageId)"
        }
    }

    private func setupWebView(urlString: String) {
        let contentController = WKUserContentController()
        contentController.add(self, name: "appointletListener")

        let config = WKWebViewConfiguration()
        config.userContentController = contentController

        webView = WKWebView(frame: .zero, configuration: config)
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
    }

    public func loadWebView() {
        webView.isHidden = false
    }

    public func hideWebView() {
        webView.isHidden = true
    }

    public func setDelegate(_ delegate: AppointletSchedulerViewManagerDelegate) {
        self.delegate = delegate
    }

    // MARK: - WKScriptMessageHandler
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if let messageString = message.body as? String {
            handle(messageString)
        }
    }

    private func handle(_ messageString: String) {
        guard messageString.starts(with: "appointlet:") else { return }
        let jsonString = String(messageString.dropFirst("appointlet:".count))
        
        if let data = jsonString.data(using: .utf8),
           let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
           let type = jsonObject["type"] as? String {
            switch type {
            case "scheduler:loaded":
                delegate?.appointletSchedulerViewManagerDidReceiveLoadedEvent()
            case "booking:created":
                delegate?.appointletSchedulerViewManagerDidReceiveCompletedEvent()
            default:
                break
            }
        }
    }
}
