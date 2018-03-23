//
//  ViewController.swift
//  Coursework Workspace
//
//  Created by Daniel García Molero on 09/03/2018.
//  Copyright © 2018 Daniel García Molero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backgroundImg: UIImageView!
    
    @IBOutlet weak var planeImg: UIImageView!
    
    var backgroundArray: [UIImage] = [UIImage(named: "road1.png")!,
                                UIImage(named: "road2.png")!,
                                UIImage(named: "road3.png")!,
                                UIImage(named: "road4.png")!,
                                UIImage(named: "road5.png")!,
                                UIImage(named: "road6.png")!,
                                UIImage(named: "road7.png")!,
                                UIImage(named: "road8.png")!,
                                UIImage(named: "road9.png")!,
                                UIImage(named: "road10.png")!,
                                UIImage(named: "road11.png")!,
                                UIImage(named: "road12.png")!,
                                UIImage(named: "road13.png")!,
                                UIImage(named: "road14.png")!,
                                UIImage(named: "road15.png")!,
                                UIImage(named: "road16.png")!,
                                UIImage(named: "road17.png")!,
                                UIImage(named: "road18.png")!,
                                UIImage(named: "road19.png")!,
                                UIImage(named: "road20.png")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayMenu() //To display the game menu.
        loadGraphics()
        startGame()
        displayMenu() //To display the game menu.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadGraphics(/*Plane image data should be here*/) {
        setAnimatedBackground(dur: 0.5)
        //planeImg.image.
    }
    
    func startGame() {
        
    }
    
    func setAnimatedBackground(dur: Double) {
        backgroundImg.image = UIImage.animatedImage(with: backgroundArray, duration: dur)
    }
    
    func displayMenu() {
        //On click, call hideMenu
    }
    
    func hideMenu() {
        //view.isHidden = true; to make an app seem like it has more than one view
    }
}
