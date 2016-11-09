//
//  ViewController.swift
//  WebApp
//
//  Created by Hans Ravnaas on 11/7/16.
//  Copyright © 2016 Hans Ravnaas. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var addressBar: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    //@IBOutlet var webView: UIView!
    @IBOutlet weak var webView: UIWebView!
    
    @IBAction func onNavigation(_ sender: UIBarButtonItem)
    {
        switch sender.tag {
        case 10:
            if self.webView.canGoBack
            {
                self.webView.goBack()
            }
            
        case 20:
            if self.webView.canGoForward
            {
                self.webView.goForward()
            }
        default:
            print("Incorrect tag - '\(sender.tag)'")        }
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.loadUrl(inputUrl: "http://www.codingdojo.com")
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadUrl(inputUrl:String) -> Void
    {
        let urlWithScheme: String!
        if inputUrl.hasPrefix("http://") || inputUrl.hasPrefix("https://")
        {
            urlWithScheme = inputUrl
        }
        else
        {
            urlWithScheme = "http://\(inputUrl)"
        }
        
        let urlRequest = URLRequest(url: URL(string: urlWithScheme)!)
        self.webView.loadRequest(urlRequest)
    }
}

extension ViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        self.loadUrl(inputUrl: textField.text!)
        return resignFirstResponder()
    }
}

extension ViewController: UIWebViewDelegate
{
    func webViewDidStartLoad(_ webView: UIWebView)
    {
        self.activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
      self.activityIndicator.stopAnimating()
    }
}

