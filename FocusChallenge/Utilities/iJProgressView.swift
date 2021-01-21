//
//  iJProgressView.swift
//  FocusChallenge
//
//  Created by Carlos Rosales on 1/19/21.
//

import UIKit
public class IJProgressView {
    
    var containerView = UIView()
    var progressView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    public class var shared: IJProgressView {
        struct Static {
            static let instance: IJProgressView = IJProgressView()
        }
        return Static.instance
    }
    
    public func showProgressView(view: UIView) {
        containerView.frame = view.frame
        containerView.center = view.center
        containerView.backgroundColor = UIColor(white: 0xffffff, alpha: 0.3)
        
        progressView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        progressView.center = view.center
        progressView.backgroundColor = .clear
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: containerView.frame.width, height: containerView.frame.height)
        activityIndicator.style = .gray
        activityIndicator.center = CGPoint(x: progressView.bounds.width / 2,y :progressView.bounds.height / 2)
        
        progressView.addSubview(activityIndicator)
        containerView.addSubview(progressView)
        view.addSubview(containerView)
        
        activityIndicator.startAnimating()
    }
    
    public func hideProgressView() {
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
}

