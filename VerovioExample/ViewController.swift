//
//  ViewController.swift
//  VerovioExample
//
//  Created by Thomas Ramson on 10.12.19.
//  Improved by Andreas Jacobs on 10.01.2025 (added buttons and swipe ability)
//

import UIKit
import WebKit
import SwiftUICore

class ViewController: UIViewController ,ObservableObject{
    
    //@EnvironmentObject var appDelegate: AppDelegate
    //@EnvironmentObject var sceneDelegate: SceneDelegate
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var nextpage: UIButton!
    @IBOutlet weak var prevpage: UIButton!
    
    @IBOutlet weak var Left: UISwipeGestureRecognizer!
    @IBOutlet weak var Right: UISwipeGestureRecognizer!
    
    var index:Int = Int(1)
    //var meiURL = Bundle.main.url(forResource: "ChopinEtude", withExtension: "mei")!
    //var pc = VerovioWrapper().getPageCount(meiURL)
    
    var docURL: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print("from viewcontroller.swift 1\n",urls[0])
        return urls[0]
    }()
    
    
    //func {print(self.appDelegate.myVar)}
    //let tesst = self().appDelegate
    //func print(_: appDelegate.myVar)
    
    //var meiURL = docURL.appendingPathComponent("ChopinEtude.mei")
    
    // added AJ
    private let swipeableview: UIView = {
        let view = UIView(frame: CGRect(origin: CGPoint(x: 0, y:0),size: CGSize(width: 800.0,height: 1200.0)))
        view.backgroundColor = .clear
        //@EnvironmentObject var sceneDelegate: SceneDelegate
        //print(sceneDelegate.myURL)
        //sceneDelegate.myURL = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // added AJ
        webView.addSubview(swipeableview)
        //webView.environmentObject(_:)
        
        //print(sceneDelegate.myURL as Any)
        
        
        let meiURL = docURL.appendingPathComponent("Kapsberger.mei")
        
        print("from viewController.swift 2\n",meiURL)
        
        //let test = appDelegate.self.myVar
        
        //print(test!)
        
        //let fileManager = FileManager.default
        
//        if let fileContent = fileManager.contents(atPath: meiURL.path) {
//            print(String(data: fileContent, encoding: .utf8)!)
//        }
        
        //let meiURL = Bundle.main.url(forResource: "ChopinEtude", withExtension: "mei")!
        
        let svg = VerovioWrapper().renderPage(url: meiURL, size: view.bounds.size, page: 1);
        webView.loadHTMLString(svg, baseURL: nil);
        
        //added AJ
        let mySwipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeLeft(_:)))
        let mySwipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeRight(_:)))
        
        mySwipeLeft.direction = .left
        mySwipeRight.direction = .right
        
        self.webView.addGestureRecognizer(mySwipeLeft)
        self.webView.addGestureRecognizer(mySwipeRight)
        
        self.webView.isUserInteractionEnabled = true
        //self.webView.allowsBackForwardNavigationGestures = true
    
    }
    
    @IBAction func bwd(_ sender: UIButton) {
        if index > 1{
            //let meiURL = Bundle.main.url(forResource: "ChopinEtude", withExtension: "mei")!
            let meiURL = docURL.appendingPathComponent("Kapsberger.mei")
            let svg = VerovioWrapper().renderPage(url: meiURL, size: view.bounds.size, page: Int32(index-1));
            webView.loadHTMLString(svg, baseURL: nil);
            index-=1;
            }
    }
    
    @IBAction func fwd(_ sender: UIButton) {
        //let meiURL = Bundle.main.url(forResource: "ChopinEtude", withExtension: "mei")!
        let meiURL = docURL.appendingPathComponent("Kapsberger.mei")
        let pc = VerovioWrapper().getPageCount(meiURL)
        
        print("pagecount",pc)
        
        if index < pc+1{
            let svg = VerovioWrapper().renderPage(url: meiURL, size: view.bounds.size, page: Int32(index+1));
            webView.loadHTMLString(svg, baseURL: nil);
            index+=1;
        }
    }
    // added AJ
    @IBAction func swipeRight(_ sender: Any) {
        print("left")
        if index > 1{
            //let meiURL = Bundle.main.url(forResource: "ChopinEtude", withExtension: "mei")!
            let meiURL = docURL.appendingPathComponent("Kapsberger.mei")
            let svg = VerovioWrapper().renderPage(url: meiURL, size: view.bounds.size, page: Int32(index-1));
            webView.loadHTMLString(svg, baseURL: nil);
            index-=1;
        }
    }
    // added AJ
    @IBAction func swipeLeft(_ sender: Any) {
        print("right")
        //let meiURL = Bundle.main.url(forResource: "ChopinEtude", withExtension: "mei")!
        let meiURL = docURL.appendingPathComponent("Kapsberger.mei")
        let pc = VerovioWrapper().getPageCount(meiURL)
        if index < pc+1{
            //let meiURL = docURL.appendingPathComponent("ChopinEtude.mei")
            let svg = VerovioWrapper().renderPage(url: meiURL, size: view.bounds.size, page: Int32(index+1));
            webView.loadHTMLString(svg, baseURL: nil);
            index+=1;
        }
    }
}
