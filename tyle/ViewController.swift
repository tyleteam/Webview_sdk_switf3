//
//  ViewController.swift
//  tyle
//
//  Created by tubloo on 2016. 12. 7..
//  Copyright © 2016년 tubloo. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKScriptMessageHandler {

    var webView: WKWebView!
    
    override func loadView() {
        super.loadView()
        
        let contentController = WKUserContentController();
        
        // html head에 삽입할 javascript method (고정)
        let script = "$('head').append('<script> window.tyleSDKCallback = { cb : function(data){webkit.messageHandlers.callbackHandler.postMessage(JSON.stringify(data)); } } </script>');"

        // webivew 에 스크립트 등록 하기 위한 객체
        let userScript = WKUserScript(
            source: script,
            injectionTime: WKUserScriptInjectionTime.atDocumentEnd,
            forMainFrameOnly: true
        )
        
        // webview controller에 스크립트 객체 추가
        contentController.addUserScript(userScript)
        contentController.add(
            self,
            name: "callbackHandler" // webivew에서 전달할때 webkit.messageHandlers.callbackHandler.postMessage 에서 `callbackHandler` 부분으로 식별한다.(원하는대로 바꾸면 된다.)
        )
        
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController

        // webivew 설정
        self.webView = WKWebView(
            frame: .zero,
            configuration: config
        )

        self.view = self.webView!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tyleUrl = "https://tyle.io"
        
        let url = URL(string:tyleUrl)
        let req = URLRequest(url:url!)
        // load webivew
        self.webView!.load(req)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        // message 파라미터로 결과값이 반환되어진다.
        if message.name == "callbackHandler" {
            print("\(message.body)")
        }
    }


}

