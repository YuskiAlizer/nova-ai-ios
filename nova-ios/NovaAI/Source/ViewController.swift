import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    // URL de l'application Nova AI
    // IMPORTANT: Remplacez par votre URL d'hébergement permanent
    // avant de générer le fichier .ipa pour l'App Store ou TestFlight
    let appURL = URL(string: "https://www.perplexity.ai/computer/a/nova-ai-agent-intelligent-WM8eu0_MTdi60tyrIPAbQw")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        
        webView = WKWebView(frame: view.bounds, configuration: configuration)
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Fond violet pendant le chargement
        view.backgroundColor = UIColor(red: 124/255, green: 58/255, blue: 237/255, alpha: 1.0)
        
        // Charger l'app
        let request = URLRequest(url: appURL)
        webView.load(request)
    }
    
    // Garder l'app en mémoire (ne pas recharger à chaque fois)
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Injection du support offline basique
        let script = """
        window.addEventListener('load', function() {
            document.body.style.webkitTouchCallout = 'none';
        });
        """
        webView.evaluateJavaScript(script, completionHandler: nil)
    }
    
    // Gérer les liens externes
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated {
            if let url = navigationAction.request.url, url.host != appURL.host {
                UIApplication.shared.open(url)
                decisionHandler(.cancel)
                return
            }
        }
        decisionHandler(.allow)
    }
}
