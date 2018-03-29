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
    
    @IBOutlet weak var planeImg: DragPlane!
    
    var dynamicAnimator: UIDynamicAnimator!
    var gravityBehavior: UIGravityBehavior!
    
    var mainMenu: UIImageView!
    var endMenu: UIImageView!
    
    var gameInPlay: Bool!
    
    var level: Int!
    var aircraftType: Int!
    
    var backgroundArray: [UIImage] = [UIImage(named: "clouds01.png")!, UIImage(named: "clouds02.png")!, UIImage(named: "clouds03.png")!, UIImage(named: "clouds04.png")!, UIImage(named: "clouds05.png")!, UIImage(named: "clouds06.png")!, UIImage(named: "clouds07.png")!, UIImage(named: "clouds08.png")!, UIImage(named: "clouds09.png")!, UIImage(named: "clouds10.png")!, UIImage(named: "clouds11.png")!, UIImage(named: "clouds12.png")!, UIImage(named: "clouds13.png")!, UIImage(named: "clouds14.png")!, UIImage(named: "clouds15.png")!, UIImage(named: "clouds16.png")!, UIImage(named: "clouds17.png")!, UIImage(named: "clouds18.png")!, UIImage(named: "clouds19.png")!, UIImage(named: "clouds20.png")!, UIImage(named: "clouds21.png")!, UIImage(named: "clouds22.png")!, UIImage(named: "clouds23.png")!, UIImage(named: "clouds24.png")!, UIImage(named: "clouds25.png")!, UIImage(named: "clouds26.png")!, UIImage(named: "clouds27.png")!, UIImage(named: "clouds28.png")!, UIImage(named: "clouds29.png")!, UIImage(named: "clouds30.png")!, UIImage(named: "clouds31.png")!, UIImage(named: "clouds32.png")!, UIImage(named: "clouds33.png")!, UIImage(named: "clouds34.png")!, UIImage(named: "clouds35.png")!, UIImage(named: "clouds36.png")!, UIImage(named: "clouds37.png")!, UIImage(named: "clouds38.png")!, UIImage(named: "clouds39.png")!, UIImage(named: "clouds40.png")!, UIImage(named: "clouds41.png")!, UIImage(named: "clouds42.png")!, UIImage(named: "clouds43.png")!, UIImage(named: "clouds44.png")!, UIImage(named: "clouds45.png")!, UIImage(named: "clouds46.png")!, UIImage(named: "clouds47.png")!, UIImage(named: "clouds48.png")!, UIImage(named: "clouds49.png")!, UIImage(named: "clouds50.png")!, UIImage(named: "clouds51.png")!, UIImage(named: "clouds52.png")!, UIImage(named: "clouds53.png")!]
    
    var explosionArray: [UIImage] = [UIImage(named: "explosion1a.png")!, UIImage(named: "explosion1b.png")!, UIImage(named: "explosion1c.png")!, UIImage(named: "explosion1d.png")!, UIImage(named: "explosion1e.png")!, UIImage(named: "explosion1f.png")!, UIImage(named: "explosion1g.png")!, UIImage(named: "explosion1h.png")!, UIImage(named: "explosion1i.png")!, UIImage(named: "explosion1j.png")!, UIImage(named: "explosion1k.png")!, UIImage(named: "explosion1l.png")!, UIImage(named: "explosion1m.png")!, UIImage(named: "explosion1n.png")!]
    
    var missile1Array: [UIImage] = [UIImage(named: "missile1a.png")!, UIImage(named: "missile1b.png")!, UIImage(named: "missile1c.png")!]
    
    var missile2Array: [UIImage] = [UIImage(named: "missile2a.png")!, UIImage(named: "missile2b.png")!, UIImage(named: "missile2c.png")!]
    
    var warningArray: [UIImage] = [UIImage(named: "warning1.png")!, UIImage(named: "warning2.png")!]
    
    var FA28AArray: [UIImage] = [UIImage(named: "aircraftF-A-28Aa.png")!, UIImage(named: "aircraftF-A-28Ab.png")!]
    
    var MiG51Array: [UIImage] = [UIImage(named: "aircraftMiG-51a.png")!, UIImage(named: "aircraftMiG-51b.png")!]
    
    var SR91AArray: [UIImage] = [UIImage(named: "aircraftSR-91Aa.png")!, UIImage(named: "aircraftSR-91Ab.png")!]
    
    var SU37KArray: [UIImage] = [UIImage(named: "aircraftSU-37Ka.png")!, UIImage(named: "aircraftSU-37Kb.png")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayMenu() //To display the game menu.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadGame(plane: [UIImage]) {
        setAnimatedBackground(dur: 1)
        planeImg.image = UIImage.animatedImage(with: plane, duration: 0.25)
        
        self.dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        
        gameInPlay = true;
        
        fireMissiles(interval: 0.2)
    }
    
    func fireMissiles(interval: Double) {
        if(gameInPlay) {
            let when = DispatchTime.now() + interval
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.spawnRandomMissile()
                self.fireMissiles(interval: interval)
            }
        }
    }
    
    func startGameEngine() {
        
    }
    
    func spawnRandomMissile() {
        let screenSize = UIScreen.main.bounds
        let randomXSpawn = CGFloat(arc4random_uniform(UInt32(screenSize.width)))
        spawnMissileAt(xSpawn: randomXSpawn)
    }
    
    func spawnMissileAt(xSpawn: CGFloat) {
        let warningView = UIImageView(image: nil)
        
        warningView.image = UIImage.animatedImage(with: warningArray, duration: 0.25)
        warningView.frame = CGRect(x:xSpawn - (75/2), y: 0, width: 75, height: 75)
        self.view.addSubview(warningView)
        
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when) {
            warningView.isHidden = true //Remove Warning sign
            
            let missileView = UIImageView(image: nil)
            
            if(Int(arc4random_uniform(2)) == 0) { //Generate a random number, 0 or 1.
                missileView.image = UIImage.animatedImage(with: self.missile1Array, duration: 0.25)
            } else {
                missileView.image = UIImage.animatedImage(with: self.missile2Array, duration: 0.25)
            }
            
            missileView.frame = CGRect(x:xSpawn - (30/2), y: -100, width: 30, height: 90) //Spawn at y = -100 for the missile not to be visible.
            
            self.view.addSubview(missileView)
            
            self.gravityBehavior = UIGravityBehavior(items: [missileView])
            self.gravityBehavior.magnitude = 1 //TODO Change this depending on level as well as missile frequency!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            self.dynamicAnimator.addBehavior(self.gravityBehavior)
        }
    }
    
    func loadButtons() {
        //Create easy level
        //Create medium level
        //Create hard level
        //Create expert level
        
        //Create SR-91A button
        //Create F/A-28A button
        //Create Su-37K button
        //Create MiG-51 button
    }
    
    func setAnimatedBackground(dur: Double) {
        backgroundImg.image = UIImage.animatedImage(with: backgroundArray, duration: dur)
    }
    
    func displayMenu() {
        //On click, call hideMenu
        loadButtons()
        
        loadGame(plane: FA28AArray)
        hideMenu()
    }
    
    func hideMenu() {
        //view.isHidden = true; to make an app seem like it has more than one view
    }
}
