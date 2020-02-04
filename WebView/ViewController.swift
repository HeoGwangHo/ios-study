//
//  ViewController.swift
//  6.Web
//
//  Created by macbook on 25/01/2020.
//  Copyright © 2020 Gwang-Ho Heo. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet var txtUrl: UITextField!
    @IBOutlet var myWebView: WKWebView!
    @IBOutlet var myActivityIndicator: UIActivityIndicatorView!
    
    //url의 인수를 통해 웹 페이지의 주소를 전달받아 웹 페이지를 보여 줌
    func loadWebPage(_ url: String) {
        let myUrl = URL(string: url)
        let myRequest = URLRequest(url: myUrl!)
        myWebView.load(myRequest)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myWebView.navigationDelegate = self
        loadWebPage("https://github.com/HeoGwangHo") // 앱 실행 시 초기 홈페이지를 불러옴
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        myActivityIndicator.startAnimating()
        myActivityIndicator.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        myActivityIndicator.stopAnimating()
        myActivityIndicator.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        myActivityIndicator.stopAnimating()
        myActivityIndicator.isHidden = true
    }
    
    // "http://"문자열이 없을 경우 자동으로 삽입
    func chekUrl(_ url: String) -> String {
        var strUrl = url
        let flag = strUrl.hasPrefix("http://")
        if !flag {
            strUrl = "http://" + strUrl
        }
        return strUrl
    }

    // 텍스트 필드에 적힌 주소로 웹 뷰 로딩
    @IBAction func btnGotoUrl(_ sender: UIButton) {
        let myUrl = chekUrl(txtUrl.text!)
        txtUrl.text = ""
        loadWebPage(myUrl)
    }
    
    //[Site1] 버튼 클릭 시 설정해논 주소로 이동
    @IBAction func btnGoSite1(_ sender: UIButton) {
        loadWebPage("https://github.com/HeoGwangHo")
    }
    
    @IBAction func btnGoSite2(_ sender: UIButton) {
        loadWebPage("https://github.com/HeoGwangHo/ios-study")
    }
    
    @IBAction func btnLoadHtmlString(_ sender: UIButton) {
        let htmlString = "<h1> HTML String </h1><p> String 변수를 이용한 웹 페이지 </p> <p><a href=\"https://github.com/HeoGwangHo\">HeoGwangHo 깃허브</a>로 이동</p>"
        myWebView.loadHTMLString(htmlString, baseURL: nil)
    }
    
    @IBAction func btnLoadHtmlFile(_ sender: UIButton) {
        let filePath = Bundle.main.path(forResource: "htmlView", ofType: "html")
        let myUrl = URL(fileURLWithPath: filePath!)
        let myRequest = URLRequest(url: myUrl)
        myWebView.load(myRequest)
    }
    
    @IBAction func btnStop(_ sender: UIBarButtonItem) {
        myWebView.stopLoading() //웹 페이지의 로딩을 중지
    }
    
    @IBAction func btnReload(_ sender: UIBarButtonItem) {
        myWebView.reload() // 웹 페이지를 재로딩
    }
    
    @IBAction func btnGoBack(_ sender: UIBarButtonItem) {
        myWebView.goBack() //이전 웹 페이지로 이동
    }
    
    @IBAction func btnGoForward(_ sender: UIBarButtonItem) {
        myWebView.goForward() // 다음 웹 페이지로 이동
    }
    
}

