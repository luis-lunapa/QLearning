//
//  ViewController.swift
//  QLearning
//
//  Created by Luis Luna on 2/9/19.
//  Copyright © 2019 DeepTech. All rights reserved.
//

import UIKit

class AnimationResultViewController: UIViewController {
    
    @IBOutlet var robot: UIImageView!
    
    @IBOutlet weak var view0: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view7: UIView!
    @IBOutlet weak var view8: UIView!
    @IBOutlet weak var view9: UIView!
    
    let numberOfTrainings = 4000
    
    var isTraining = false
    
    var cuartos = [UIView]()
    var Q: [[Int]] = [
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    ]
    
    let R: [[Int]] = [
        [-1, 00, -1, -1, 00, -1, -1, -1, -1, -1],
        [00, -1, 00, -1, -1, -1, -1, -1, -1, -1],
        [-1, 00, -1, -1, -1, -1, -1, -1, 00, -1],
        [-1, -1, -1, -1, -1, -1, -1, -1, 00, -1],
        [00, -1, -1, -1, -1, 00, -1, -1, 00, -1],
        [-1, -1, -1, -1, 00, -1, 00, -1, -1, -1],
        [-1, -1, -1, -1, -1, 00, -1, -1, -1, -1],
        [-1, -1, -1, -1, -1, -1, -1, -1, 00, -1],
        [-1, -1, 00, 00, 00, -1, -1, 00, -1, 100],
        [-1, -1, -1, -1, -1, -1, -1, -1, 00, 100]
    ]
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        cuartos = [view0, view1, view2, view3, view4, view5, view6, view7, view8, view9]
    
        // Do any additional setup after loading the view, typically from a nib.
//        let _ = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) {
//
//            timer in
//            self.fadeOutRobot() {
//                done in
//                self.fadeInRobot(to: self.view8)
//            }
//           //
//
//
//
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func startTraining() {
        if isTraining {
            print("Ya hay una sesión de entrenamiento en curso...")
            return
        }
        var initialState: UIView!
        var initialStateNumber: Int!
        var episodeNumber = 1
        isTraining = true

        for episodeNumber in 0...numberOfTrainings { //////Base de TODO
            print("Episodio actual = \(episodeNumber)")
            repeat {
                initialState  = self.cuartos.randomElement()!
                initialStateNumber = cuartos.firstIndex(of: initialState)!// Se escoje estado inicial del robot
            } while initialState == self.view9
            
            print("El estado inicial es = \(initialState)")
            
            initialState.addSubview(self.robot)
            
            
            
            print("Estados posibles para \(initialStateNumber) === \(self.getActionFor(state: initialStateNumber))")
            
            
            
            
            
        }
        
        
        
      
        
        
        isTraining = false
        //self.robot.removeFromSuperview()
        
    }
    
    
    func getActionFor(state: Int)-> Int {
        var possibleStates = [Int]()
        
        
        
        let states = R[state]
        
        for i in states {
            if i == 00 {
                possibleStates.append(i)
            }
        }
        return possibleStates.randomElement()!
    }
    
    func getIndex(of view: UIView) -> Int {
        return self.cuartos.firstIndex(of: view)!
        
    }
    

    
    func fadeOutRobot(completion: @escaping(Bool)->()) {
        UIView.animate(withDuration: 1, animations: {
            self.robot.alpha = 0
        }) { _ in
            self.robot.removeFromSuperview()
            completion(true)

        }
  
    }
    
    
    func fadeInRobot(to targetView: UIView) {
        UIView.animate(withDuration: 1, animations: {
            targetView.addSubview(self.robot)
            self.robot.alpha = 1
            
        })
    }
    
    // MARK: - IBActions
    
    
    @IBAction func startDidPressed(_ sender: Any) {
        self.startTraining()
    }
    

}




