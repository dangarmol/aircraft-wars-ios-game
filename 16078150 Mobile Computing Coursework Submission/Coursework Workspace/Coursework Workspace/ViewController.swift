//
//  ViewController.swift
//  Coursework Workspace
//
//  Created by Daniel García Molero on 09/03/2018.
//  Copyright © 2018 Daniel García Molero. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var backgroundImg: UIImageView!
    
    @IBOutlet weak var planeImg: DragPlane!
    
    var gameTextFieldA: UITextField!
    var gameTextFieldB: UITextField!
    
    var screenTimer: UITextField!
    
    var endGameTextFieldA: UITextField!
    var endGameTextFieldB: UITextField!
    
    var hitAudioPlayer: AVAudioPlayer?
    var gameOverAudioPlayer: AVAudioPlayer?
    var staticAudioPlayer: AVAudioPlayer?
    
    var dynamicAnimator: UIDynamicAnimator!
    var gravityBehavior: UIGravityBehavior!
    var collisionBehavior: UICollisionBehavior!
    
    var mainMenuBackground: UIImageView!
    var endMenuTimeUpBackground: UIImageView!
    var endMenuGameOverBackground: UIImageView!
    var startButton: UIButton!
    var endGameButton: UIButton!
    var aircraftSelector: UISegmentedControl!
    var levelSelector: UISegmentedControl!
    
    let levels = ["Easy", "Medium", "Expert", "Ludicrous", "Onslaught!"]
    let planes = ["SR-91A", "F/A-28A", "Su-37K", "MiG-51"]
    let onslaughtLevels = ["Beginner", "Medium", "Hard", "Expert", "Ludicrous", "EXTREME!!!", "IMPOSSIBLE???"]
    
    var gameInPlay: Bool!
    var level: Int!
    var onslaught: Bool!
    var aircraftType: Int!
    var bonus: Int!
    var score: Int!
    var dodges: Int!
    var armor: Int!
    var time: Int!
    
    var backgroundArray: [UIImage] = [UIImage(named: "clouds01.png")!, UIImage(named: "clouds02.png")!, UIImage(named: "clouds03.png")!, UIImage(named: "clouds04.png")!, UIImage(named: "clouds05.png")!, UIImage(named: "clouds06.png")!, UIImage(named: "clouds07.png")!, UIImage(named: "clouds08.png")!, UIImage(named: "clouds09.png")!, UIImage(named: "clouds10.png")!, UIImage(named: "clouds11.png")!, UIImage(named: "clouds12.png")!, UIImage(named: "clouds13.png")!, UIImage(named: "clouds14.png")!, UIImage(named: "clouds15.png")!, UIImage(named: "clouds16.png")!, UIImage(named: "clouds17.png")!, UIImage(named: "clouds18.png")!, UIImage(named: "clouds19.png")!, UIImage(named: "clouds20.png")!, UIImage(named: "clouds21.png")!, UIImage(named: "clouds22.png")!, UIImage(named: "clouds23.png")!, UIImage(named: "clouds24.png")!, UIImage(named: "clouds25.png")!, UIImage(named: "clouds26.png")!, UIImage(named: "clouds27.png")!, UIImage(named: "clouds28.png")!, UIImage(named: "clouds29.png")!, UIImage(named: "clouds30.png")!, UIImage(named: "clouds31.png")!, UIImage(named: "clouds32.png")!, UIImage(named: "clouds33.png")!, UIImage(named: "clouds34.png")!, UIImage(named: "clouds35.png")!, UIImage(named: "clouds36.png")!, UIImage(named: "clouds37.png")!, UIImage(named: "clouds38.png")!, UIImage(named: "clouds39.png")!, UIImage(named: "clouds40.png")!, UIImage(named: "clouds41.png")!, UIImage(named: "clouds42.png")!, UIImage(named: "clouds43.png")!, UIImage(named: "clouds44.png")!, UIImage(named: "clouds45.png")!, UIImage(named: "clouds46.png")!, UIImage(named: "clouds47.png")!, UIImage(named: "clouds48.png")!, UIImage(named: "clouds49.png")!, UIImage(named: "clouds50.png")!, UIImage(named: "clouds51.png")!, UIImage(named: "clouds52.png")!, UIImage(named: "clouds53.png")!]
    
    var explosionArray: [UIImage] = [UIImage(named: "explosion1a.png")!, UIImage(named: "explosion1b.png")!, UIImage(named: "explosion1c.png")!, UIImage(named: "explosion1d.png")!, UIImage(named: "explosion1e.png")!, UIImage(named: "explosion1f.png")!, UIImage(named: "explosion1g.png")!, UIImage(named: "explosion1h.png")!, UIImage(named: "explosion1i.png")!, UIImage(named: "explosion1j.png")!, UIImage(named: "explosion1k.png")!, UIImage(named: "explosion1l.png")!, UIImage(named: "explosion1m.png")!, UIImage(named: "explosion1n.png")!]
    
    var missile1Array: [UIImage] = [UIImage(named: "missile1a.png")!, UIImage(named: "missile1b.png")!, UIImage(named: "missile1c.png")!]
    
    var missile2Array: [UIImage] = [UIImage(named: "missile2a.png")!, UIImage(named: "missile2b.png")!, UIImage(named: "missile2c.png")!]
    
    var warningArray: [UIImage] = [UIImage(named: "warning1.png")!, UIImage(named: "warning2.png")!]
    
    var SR91AArray: [UIImage] = [UIImage(named: "aircraftSR-91Aa.png")!, UIImage(named: "aircraftSR-91Ab.png")!]
    
    var FA28AArray: [UIImage] = [UIImage(named: "aircraftF-A-28Aa.png")!, UIImage(named: "aircraftF-A-28Ab.png")!]
    
    var Su37KArray: [UIImage] = [UIImage(named: "aircraftSU-37Ka.png")!, UIImage(named: "aircraftSU-37Kb.png")!]
    
    var MiG51Array: [UIImage] = [UIImage(named: "aircraftMiG-51a.png")!, UIImage(named: "aircraftMiG-51b.png")!]
    
    let screenSize = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDefaults()
        displayMenu() //To display the game menu.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDefaults() {
        self.aircraftType = 0
        self.level = 1
        self.gameInPlay = false
        self.score = 0
        self.onslaught = false
        self.bonus = 1
        self.dodges = 0
        self.armor = 1
        self.time = 20
        if(self.gameTextFieldA != nil && self.gameTextFieldB != nil) {
            self.gameTextFieldA.text = ""
            self.gameTextFieldB.text = ""
        }
    }
    
    func loadGame(plane: Int, level: Int) {
        setAnimatedBackground(dur: 1)
        var planeImage: [UIImage]
        switch plane {
        case 0:
            planeImage = self.SR91AArray
        case 1:
            planeImage = self.FA28AArray
        case 2:
            planeImage = self.Su37KArray
        case 3:
            planeImage = self.MiG51Array
            
        default:
            planeImage = self.SR91AArray
        }
        
        self.planeImg.isHidden = false
        
        if(gameTextFieldA == nil) {
            gameTextFieldA = UITextField()
            gameTextFieldA.frame = CGRect(x: 0, y: screenSize.height * 0.93, width: screenSize.width, height: 40)
            gameTextFieldA.isHidden = false
            gameTextFieldA.isUserInteractionEnabled = false
            gameTextFieldA.textAlignment = .center
            self.view.addSubview(gameTextFieldA)
        } else {
            self.gameTextFieldA.isHidden = false
        }
        
        if(gameTextFieldB == nil) {
            gameTextFieldB = UITextField()
            gameTextFieldB.frame = CGRect(x: 0, y: screenSize.height * 0.96, width: screenSize.width, height: 40)
            gameTextFieldB.isHidden = false
            gameTextFieldB.textAlignment = .center
            gameTextFieldB.isUserInteractionEnabled = false
            self.view.addSubview(gameTextFieldB)
        } else {
            self.gameTextFieldB.isHidden = false
        }
        
        if(self.onslaught) {
            gameTextFieldA.text = "Armor: " + String(self.armor!) + " | Score: " + String(self.score!) + " | Avoided: " + String(self.dodges!)
            gameTextFieldB.text = "Bonus: " + String(self.bonus!) + " | Level: " + self.onslaughtLevels[self.level!]
        } else {
            if(screenTimer == nil) {
                screenTimer = UITextField()
                screenTimer.isUserInteractionEnabled = false
                screenTimer.frame = CGRect(x: 0, y: screenSize.height * 0.95, width: screenSize.width, height: 40)
                self.screenTimer.isHidden = false
                screenTimer.textAlignment = .center
                self.view.addSubview(screenTimer)
            } else {
                self.screenTimer.isHidden = false
            }
        }
            
        planeImg.image = UIImage.animatedImage(with: planeImage, duration: 0.25)
        planeImg.center = CGPoint(x: (self.screenSize.width / 2), y: (self.screenSize.height * 0.85))
        
        self.dynamicAnimator = UIDynamicAnimator(referenceView: self.view) //Starts the dynamicAnimator used for missiles
        self.gravityBehavior = UIGravityBehavior()
        self.gravityBehavior.magnitude = 1
        
        playStaticSound()
    }
    
    func fireMissiles(interval: Double) {
        if(gameInPlay) {
            let when = DispatchTime.now() + interval
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.spawnRandomMissile()
                self.startLaunch(level: self.level!)
            }
        }
    }
    
    func startLaunch(level: Int) {
        switch level {
        case 0:
            fireMissiles(interval: 1.00)
        case 1:
            fireMissiles(interval: 0.75)
        case 2:
            fireMissiles(interval: 0.55)
        case 3:
            fireMissiles(interval: 0.30)
        case 4:
            fireMissiles(interval: 0.15)
        case 5:
            fireMissiles(interval: 0.10)
        case 6:
            fireMissiles(interval: 0.07)
        default:
            fireMissiles(interval: 1)
        }
    }
    
    func spawnRandomMissile() {
        let randomXSpawn = CGFloat(arc4random_uniform(UInt32(self.screenSize.width)))
        spawnMissileAt(xSpawn: randomXSpawn)
    }
    
    func spawnMissileAt(xSpawn: CGFloat) {
        let warningView = UIImageView(image: nil)

        warningView.image = UIImage.animatedImage(with: warningArray, duration: 0.25)
        warningView.frame = CGRect(x: xSpawn - (75/2), y: 0, width: 75, height: 75)
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
            
            missileView.frame = CGRect(x: xSpawn - (30/2), y: -100, width: 30, height: 90) //Spawn at y = -100 for the missile not to be visible.
            
            self.view.addSubview(missileView)
            
            self.dynamicAnimator.addBehavior(self.gravityBehavior)
            self.gravityBehavior.addItem(missileView)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.9) {
                if(self.gameInPlay) {
                    self.score = self.score! + self.level! + self.bonus!
                }
                
                self.detectCollision(missile: missileView)
                
                if(self.onslaught) {
                    switch self.level! {
                    case 0:
                        if(self.score! >= 10) {self.bonus! = self.bonus! + 1; self.armor! = self.armor! + 2; self.levelUp()}
                    case 1:
                        if(self.score! >= 50) {self.bonus! = self.bonus! + 2; self.armor! = self.armor! + 3; self.levelUp()}
                    case 2:
                        if(self.score! >= 100) {self.bonus! = self.bonus! + 3; self.armor! = self.armor! + 4; self.levelUp()}
                    case 3:
                        if(self.score! >= 500) {self.bonus! = self.bonus! + 4; self.armor! = self.armor! + 5; self.levelUp()}
                    case 4:
                        if(self.score! >= 1000) {self.bonus! = self.bonus! + 5; self.armor! = self.armor! + 7; self.levelUp()}
                    case 5:
                        if(self.score! >= 5000) {self.bonus! = self.bonus! + 10; self.armor! = self.armor! + 10; self.levelUp()}
                    case 6:
                        self.bonus! = self.bonus! + 1
                        if(self.dodges! % 100 == 0) {self.armor! = self.armor! + 10} //Maybe change to 200
                    default:
                        break
                    }
                }
            }
        }
    }
    
    func detectCollision(missile: UIImageView) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.05) {
            if (missile.frame.intersects(self.planeImg.frame)) {
                self.armor = self.armor! - 1
                if(self.onslaught && self.gameInPlay) {
                    self.updateStats()
                }
                
                if(self.armor < 1) {
                    self.handleGameOver()
                } else {
                    self.handleMissileHit()
                }
            } else {
                if(missile.center.y > self.screenSize.maxY && self.gameInPlay) {
                    self.dodges = self.dodges! + 1
                    if(self.onslaught && self.gameInPlay) {
                        self.updateStats()
                    }
                } else if(self.gameInPlay) {
                    self.detectCollision(missile: missile)
                }
            }
        }
    }
    
    func levelUp() {
        self.level = self.level! + 1
    }
    
    func setAnimatedBackground(dur: Double) {
        backgroundImg.image = UIImage.animatedImage(with: backgroundArray, duration: dur)
    }
    
    func displayMenu() {
        loadDefaults()
        mainMenuBackground = UIImageView(image: nil)
        mainMenuBackground.image = UIImage(named: "screenMain.png")
        mainMenuBackground.frame = CGRect(x: 0, y: 0, width: self.screenSize.width + 1, height: self.screenSize.height + 1)
        self.mainMenuBackground.isHidden = false
        
        self.view.addSubview(mainMenuBackground)
        
        levelSelector = UISegmentedControl(items: self.levels)
        levelSelector.selectedSegmentIndex = 1
        levelSelector.center = CGPoint(x: self.screenSize.width / 2, y: self.screenSize.height * 0.83)
        levelSelector.backgroundColor = UIColor(red:172/255.0, green:189/255.0, blue:83/255.0, alpha:1)
        levelSelector.tintColor = UIColor(red:75/255.0, green:83/255.0, blue:32/255.0, alpha:1)
        (levelSelector.subviews[3] as UIView).backgroundColor = UIColor.black
        (levelSelector.subviews[3] as UIView).tintColor = UIColor.red
        levelSelector.layer.cornerRadius = 5.0
        
        self.levelSelector.isHidden = false
        self.view.addSubview(levelSelector)
       
        aircraftSelector = UISegmentedControl(items: self.planes)
        aircraftSelector.selectedSegmentIndex = 0
        aircraftSelector.center = CGPoint(x: self.screenSize.width / 2, y: self.screenSize.height * 0.88)
        aircraftSelector.backgroundColor = UIColor(red:172/255.0, green:189/255.0, blue:83/255.0, alpha:1)
        aircraftSelector.tintColor = UIColor(red:75/255.0, green:83/255.0, blue:32/255.0, alpha:1)
        aircraftSelector.layer.cornerRadius = 5.0
        
        self.aircraftSelector.isHidden = false
        self.view.addSubview(aircraftSelector)
        
        startButton = UIButton(frame: CGRect(x: (self.screenSize.width / 2) - 60, y: (self.screenSize.height * 0.95) - 15, width: 120, height: 30))
        startButton.backgroundColor = UIColor(red:75/255.0, green:83/255.0, blue:32/255.0, alpha:1)
        startButton.setTitle("Start Game!", for: UIControlState.normal)
        startButton.addTarget(self, action: #selector(self.startButtonTapped(_:)), for: .touchDown)
        
        self.startButton.isHidden = false
        self.view.addSubview(startButton)
    }
    
    @objc func startButtonTapped(_ button: UIButton) {
        playButtonAction()
    }
    
    @objc func mainMenuButtonTapped(_ button: UIButton) {
        mainMenuButtonAction()
    }
    
    func mainMenuButtonAction() {
        if(endGameButton != nil) {
            endGameButton.isHidden = true
        }
        if(endMenuGameOverBackground != nil) {
            endMenuGameOverBackground.isHidden = true
        }
        if(endMenuTimeUpBackground != nil) {
            endMenuTimeUpBackground.isHidden = true
        }
        if(endGameTextFieldA != nil) {
            endGameTextFieldA.isHidden = true
        }
        if(endGameTextFieldB != nil) {
            endGameTextFieldB.isHidden = true
        }
        displayMenu()
    }
    
    func playButtonAction() {
        parseGameAttributes()
        hideMenu()
        loadGame(plane: self.aircraftType, level: self.level)
        self.gameInPlay = true;
        if(!self.onslaught) {
            startTimer()
        }
        startLaunch(level: self.level)
    }
    
    func updateStats() {
        let statsA = "Armor: " + String(self.armor!) + " | Score: " + String(self.score!) + " | Avoided: " + String(self.dodges!)
        let statsB = "Bonus: " + String(self.bonus!) + " | Level: " + self.onslaughtLevels[self.level!]
        self.gameTextFieldA.text = statsA
        self.gameTextFieldB.text = statsB
    }
    
    func handleMissileHit() {
        let explosionView = UIImageView(image: nil)
        explosionView.image = UIImage.animatedImage(with: explosionArray, duration: 0.5)
        explosionView.isHidden = false
        explosionView.frame = CGRect(x: self.planeImg.center.x, y: self.planeImg.center.y, width: 50, height: 50)
        explosionView.center = CGPoint(x: self.planeImg.center.x, y: self.planeImg.center.y)
        self.view.addSubview(explosionView)
        
        playHitSound()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            explosionView.isHidden = true
        }
    }
    
    func playGameOverExplosion() {
        let explosionView = UIImageView(image: nil)
        explosionView.image = UIImage.animatedImage(with: explosionArray, duration: 1.5)
        explosionView.isHidden = false
        explosionView.frame = CGRect(x: self.planeImg.center.x, y: self.planeImg.center.y, width: 200, height: 200)
        explosionView.center = CGPoint(x: self.planeImg.center.x, y: self.planeImg.center.y)
        self.view.addSubview(explosionView)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            explosionView.isHidden = true
        }
        
        self.planeImg.isHidden = true
    }
    
    func startTimer() {
        if(gameInPlay) {
            self.time = self.time! - 1
            if(self.time! >= 10) {
                self.screenTimer.text = "00:" + String(self.time!)
            } else {
                self.screenTimer.text = "00:0" + String(self.time!)
            }
            
            if(self.time <= 0) {
                handleTimeUp()
            } else {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.startTimer()
                }
            }
        }
    }
    
    func handleGameOver() {
        self.gameInPlay = false
        playGameOverExplosion()
        playGameOverSound()
        self.backgroundImg.stopAnimating()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4) {
            self.displayGameOverScreen()
            if(!self.onslaught) {
                self.screenTimer.isHidden = true
            }
        }
    }
    
    func handleTimeUp() {
        self.gameInPlay = false
        self.backgroundImg.stopAnimating()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4) {
            self.displayTimeUpScreen()
            if(!self.onslaught) {
                self.screenTimer.isHidden = true
            }
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0) {
            self.screenTimer.textColor = UIColor.red
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.screenTimer.textColor = UIColor.red
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.screenTimer.textColor = UIColor.red
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.screenTimer.textColor = UIColor.red
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.screenTimer.textColor = UIColor.black
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            self.screenTimer.textColor = UIColor.black
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.5) {
            self.screenTimer.textColor = UIColor.black
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.5) {
            self.screenTimer.textColor = UIColor.black
        }
    }
    
    func displayGameOverScreen() {
        endMenuGameOverBackground = UIImageView(image: nil)
        endMenuGameOverBackground.image = UIImage(named: "screenGameOver.png")
        endMenuGameOverBackground.frame = CGRect(x: 0, y: 0, width: self.screenSize.width + 1, height: self.screenSize.height + 1)
        endMenuGameOverBackground.isHidden = false
        
        self.view.addSubview(endMenuGameOverBackground)
        
        if(endGameTextFieldA == nil) {
            endGameTextFieldA = UITextField()
            endGameTextFieldA.frame = CGRect(x: self.screenSize.width * 0.5, y: self.screenSize.height * 0.6, width: self.screenSize.width, height: 40)
            endGameTextFieldA.center = CGPoint(x: self.screenSize.width * 0.5, y: self.screenSize.height * 0.8)
            endGameTextFieldA.textColor = UIColor.yellow
            endGameTextFieldA.backgroundColor = UIColor.black
            endGameTextFieldA.textAlignment = .center
        } else {
            endGameTextFieldA.textColor = UIColor.yellow
            endGameTextFieldA.backgroundColor = UIColor.black
            endGameTextFieldA.text = ""
        }
        if(self.onslaught) {
            endGameTextFieldA.textColor = UIColor.cyan
            endGameTextFieldA.text = "Nice job!!!"
        } else {
            endGameTextFieldA.textColor = UIColor.orange
            endGameTextFieldA.text = "You crashed before the end of the timer!"
        }
        endGameTextFieldA.isHidden = false
        self.view.addSubview(endGameTextFieldA)
        
        if(endGameTextFieldB == nil) {
            endGameTextFieldB = UITextField()
            endGameTextFieldB.frame = CGRect(x: self.screenSize.width * 0.5, y: self.screenSize.height * 0.6, width: self.screenSize.width, height: 40)
            endGameTextFieldB.center = CGPoint(x: self.screenSize.width * 0.5, y: self.screenSize.height * 0.85)
            endGameTextFieldB.textColor = UIColor.yellow
            endGameTextFieldB.backgroundColor = UIColor.black
            endGameTextFieldB.textAlignment = .center
        } else {
            endGameTextFieldB.textColor = UIColor.yellow
            endGameTextFieldB.backgroundColor = UIColor.black
            endGameTextFieldB.text = ""
        }
        if(self.onslaught) {
            endGameTextFieldB.textColor = UIColor.yellow
            endGameTextFieldB.text = "Your final score was " + String(self.score!) + " points"
        } else {
            endGameTextFieldB.textColor = UIColor.red
            endGameTextFieldB.text = "Keep training and play Onslaught mode later!"
        }
        endGameTextFieldB.isHidden = false
        self.view.addSubview(endGameTextFieldB)
        
        endGameButton = UIButton(frame: CGRect(x: (self.screenSize.width / 2), y: (self.screenSize.height * 0.95), width: 200, height: 30))
        endGameButton.center = CGPoint(x: (self.screenSize.width * 0.75), y: (self.screenSize.height * 0.05))
        endGameButton.backgroundColor = UIColor.blue
        endGameButton.setTitle("Back to main menu!", for: UIControlState.normal)
        endGameButton.addTarget(self, action: #selector(self.mainMenuButtonTapped(_:)), for: .touchDown)
        
        self.endGameButton.isHidden = false
        self.view.addSubview(endGameButton)
    }
    
    func displayTimeUpScreen() {
        endMenuTimeUpBackground = UIImageView(image: nil)
        endMenuTimeUpBackground.image = UIImage(named: "screenTimeUp.png")
        endMenuTimeUpBackground.frame = CGRect(x: 0, y: 0, width: self.screenSize.width + 1, height: self.screenSize.height + 1)
        self.endMenuTimeUpBackground.isHidden = false
        
        self.view.addSubview(endMenuTimeUpBackground)
        
        if(endGameTextFieldA == nil) {
            endGameTextFieldA = UITextField()
            endGameTextFieldA.frame = CGRect(x: self.screenSize.width * 0.5, y: self.screenSize.height * 0.6, width: self.screenSize.width, height: 40)
            endGameTextFieldA.center = CGPoint(x: self.screenSize.width * 0.5, y: self.screenSize.height * 0.8)
            endGameTextFieldA.textColor = UIColor.yellow
            endGameTextFieldA.backgroundColor = UIColor.black
            endGameTextFieldA.textAlignment = .center
        } else {
            endGameTextFieldA.textColor = UIColor.yellow
            endGameTextFieldA.backgroundColor = UIColor.black
            endGameTextFieldA.text = ""
        }
        endGameTextFieldA.textColor = UIColor.cyan
        endGameTextFieldA.text = "Good job! You completed the 20 second training!"
        endGameTextFieldA.isHidden = false
        self.view.addSubview(endGameTextFieldA)
        
        if(endGameTextFieldB == nil) {
            endGameTextFieldB = UITextField()
            endGameTextFieldB.frame = CGRect(x: self.screenSize.width * 0.5, y: self.screenSize.height * 0.6, width: self.screenSize.width, height: 40)
            endGameTextFieldB.center = CGPoint(x: self.screenSize.width * 0.5, y: self.screenSize.height * 0.85)
            endGameTextFieldB.textColor = UIColor.green
            endGameTextFieldB.backgroundColor = UIColor.black
            endGameTextFieldB.textAlignment = .center
        } else {
            endGameTextFieldB.textColor = UIColor.green
            endGameTextFieldB.backgroundColor = UIColor.black
            endGameTextFieldB.text = ""
        }
        endGameTextFieldB.textColor = UIColor.green
        endGameTextFieldB.text = "Now try Onslaught mode for the full experience!"
        endGameTextFieldB.isHidden = false
        self.view.addSubview(endGameTextFieldB)
        
        endGameButton = UIButton(frame: CGRect(x: (self.screenSize.width / 2), y: (self.screenSize.height * 0.95), width: 200, height: 30))
        endGameButton.center = CGPoint(x: (self.screenSize.width * 0.75), y: (self.screenSize.height * 0.05))
        endGameButton.backgroundColor = UIColor.blue
        endGameButton.setTitle("Back to main menu!", for: UIControlState.normal)
        endGameButton.addTarget(self, action: #selector(self.mainMenuButtonTapped(_:)), for: .touchDown)
        
        self.endGameButton.isHidden = false
        self.view.addSubview(endGameButton)
    }
    
    func playGameOverSound() {
        guard let url = Bundle.main.url(forResource: "soundFinalExplosion", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            gameOverAudioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let gameOverAudioPlayer = gameOverAudioPlayer else { return }
            
            gameOverAudioPlayer.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playHitSound() {
        guard let url = Bundle.main.url(forResource: "soundHit", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            hitAudioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let hitAudioPlayer = hitAudioPlayer else { return }
            
            hitAudioPlayer.play()
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                self.playStaticSound()
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playStaticSound() {
        guard let url = Bundle.main.url(forResource: "soundStaticJet", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            staticAudioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let staticAudioPlayer = staticAudioPlayer else { return }
            
            staticAudioPlayer.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func parseGameAttributes() {
        self.aircraftType = self.aircraftSelector.selectedSegmentIndex
        if(self.levelSelector.selectedSegmentIndex != 4) {
            self.level = self.levelSelector.selectedSegmentIndex
        } else {
            self.level = 0
            self.onslaught = true
        }
    }
    
    func hideMenu() {
        self.mainMenuBackground.isHidden = true
        self.startButton.isHidden = true
        self.aircraftSelector.isHidden = true
        self.levelSelector.isHidden = true
    }
}
