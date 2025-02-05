//
//  ViewController.swift
//  VerovioExample
//
//  Created by Thomas Ramson on 10.12.19.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var nextpage: UIButton!
    @IBOutlet weak var prevpage: UIButton!
    
    @IBOutlet weak var Left: UISwipeGestureRecognizer!
    @IBOutlet weak var Right: UISwipeGestureRecognizer!
    
    var index:Int = Int(1)
    var meiURL = Bundle.main.url(forResource: "Chopin_Etude_Op.10_No.9", withExtension: "mei")!
    //var pc = VerovioWrapper().getPageCount(meiURL)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let svg = VerovioWrapper().renderPage(url: meiURL, size: view.bounds.size, page: 1);
        webView.loadHTMLString(svg, baseURL: nil);
        
        let mySwipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeLeft(_:)))
        let mySwipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeRight(_:)))
        
        self.webView.addGestureRecognizer(mySwipeLeft)
        self.webView.addGestureRecognizer(mySwipeRight)
        
        //self.webView.addGestureRecognizer(UISwipeGestureRecognizer(target: self, action: #selector(self.swipeLeft(_:))))
        //self.webView.addGestureRecognizer(UISwipeGestureRecognizer(target: self, action: #selector(self.swipeRight(_:))))
        
        self.webView.isUserInteractionEnabled = true
        self.webView.allowsBackForwardNavigationGestures = true
    }
    
    @IBAction func bwd(_ sender: UIButton) {
        if index > 1{
            let svg = VerovioWrapper().renderPage(url: meiURL, size: view.bounds.size, page: Int32(index-1));
            let mySwipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeLeft(_:)))
            webView.addGestureRecognizer(mySwipeLeft)
            webView.loadHTMLString(svg, baseURL: nil);
            index-=1;
        }
    }
    
    @IBAction func fwd(_ sender: UIButton) {
        let pc = VerovioWrapper().getPageCount(meiURL)
        
        if index < pc{
            let svg = VerovioWrapper().renderPage(url: meiURL, size: view.bounds.size, page: Int32(index+1));
            let mySwipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeRight(_:)))
            webView.addGestureRecognizer(mySwipeRight)
            webView.loadHTMLString(svg, baseURL: nil);
            index+=1;
        }
    }
    @IBAction func swipeLeft(_ sender: Any) {
        print("left")
    }
    
    @IBAction func swipeRight(_ sender: Any) {
        print("right")
    }
}
