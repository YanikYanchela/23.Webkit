import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, UITableViewDataSource, UITableViewDelegate {
    
    let webView = WKWebView()
    let urlTextField = UITextField()
    let goButton = UIButton()
    let bookmarkButton = UIButton()
    let bookmarksTableView = UITableView()
    
    var bookmarks = ["https://www.google.com", "https://www.youtube.com", "https://www.apple.com"] // Пример закладок
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        setupUI()
    }
    
    func setupUI() {
        // Web view
        webView.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.height - 200)
        view.addSubview(webView)
        
        // URL text field
        urlTextField.frame = CGRect(x: 10, y: 50, width: view.frame.width - 120, height: 30)
        urlTextField.borderStyle = .roundedRect
        
        view.addSubview(urlTextField)
        
        // Go button
        goButton.frame = CGRect(x: view.frame.width - 100, y: 50, width: 80, height: 30)
        goButton.setTitle("Go", for: .normal)
        goButton.addTarget(self, action: #selector(goButtonTapped), for: .touchUpInside)
        goButton.backgroundColor = .blue
        goButton.layer.cornerRadius = 10
        view.addSubview(goButton)
        
        // Bookmark button
        bookmarkButton.frame = CGRect(x: view.frame.width - 90, y: view.frame.height - 50, width: 80, height: 40)
        bookmarkButton.setTitle("Add Bookmark", for: .normal)
        bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
        bookmarkButton.backgroundColor = .gray
        view.addSubview(bookmarkButton)
        
        // Bookmarks table view
        bookmarksTableView.frame = CGRect(x: 0, y: view.frame.height - 200, width: view.frame.width, height: 150)
        bookmarksTableView.dataSource = self
        bookmarksTableView.delegate = self
        view.addSubview(bookmarksTableView)
    }
    
    @objc func goButtonTapped() {
        if let urlString = urlTextField.text, let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
            webView.reload()
        }
    }
    
    @objc func bookmarkButtonTapped() {
        if let urlString = urlTextField.text {
            bookmarks.append(urlString)
            bookmarksTableView.reloadData()
        }
    }
    
    // MARK: - WKNavigationDelegate
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("Failed navigation with error: \(error.localizedDescription)")
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = bookmarks[indexPath.row]
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urlString = bookmarks[indexPath.row]
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
