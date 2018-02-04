//
//  ViewController.swift
//  ComplexViewsTest
//
//  Created by Austin Quach on 2/4/18.
//  Copyright © 2018 Austin Quach. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate var firstViewController : FirstViewController!
    fileprivate var secondViewController : SecondViewController!
    fileprivate var selfView : ViewController!
    @IBOutlet weak var mainLabel: UILabel!
    
    fileprivate func selfBuilder() {
        if selfView == nil {
            selfView =
                storyboard?
                    .instantiateViewController(withIdentifier: "selfView")
                as! ViewController
        }
    }
    fileprivate func firstBuilder() {
        if firstViewController == nil {
            firstViewController =
                storyboard?
                    .instantiateViewController(withIdentifier: "First")
                as! FirstViewController
        }
    }
    fileprivate func secondBuilder() {
        if secondViewController == nil {
            secondViewController =
                storyboard?
                    .instantiateViewController(withIdentifier: "Second")
                as! SecondViewController
        }
    }
    
    @IBAction func switchViews(_ sender: UIBarButtonItem) {
        secondBuilder()
        firstBuilder()
        selfBuilder()
        
        UIView.beginAnimations("View Flip", context: nil)
        UIView.setAnimationDuration(0.4)
        UIView.setAnimationCurve(.easeInOut)
        
        if firstViewController != nil &&
            firstViewController?.view.superview != nil {
            UIView.setAnimationTransition(.flipFromRight, for: view, cache: true)
            secondViewController.view.frame = view.frame
            //switchViewController(firstViewController, to: secondViewController)
            mainLabel.text = "Text Changed"
        }
        else {
            UIView.setAnimationTransition(.flipFromLeft, for: view, cache: true)
            firstViewController.view.frame = view.frame
            //switchViewController(secondViewController, to: firstViewController)
            mainLabel.text = "Text Changed"
        }
        UIView.commitAnimations()

    }
    
    fileprivate func switchViewController(_ from: UIViewController?, to: UIViewController?) {
        if from != nil {
            from!.willMove(toParentViewController: nil)
            from!.view.removeFromSuperview()
            from!.removeFromParentViewController()
        }
        
        if to != nil {
            self.addChildViewController(to!)
            self.view.insertSubview(to!.view, at: 0)
            to!.didMove(toParentViewController: self)
        }
    }

}

