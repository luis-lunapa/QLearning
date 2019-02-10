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
    
   
    
    
    
    var cuartos = [UIView]()
    
    var Q: [[Int]]!
    

    
    

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
        //self.startTraining()
    }
    

}




