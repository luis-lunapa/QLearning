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
    
   
    var trainingSession: QLearning!
    
    
    var cuartos = [UIView]()
    
    var Q: [[Int]]!
    var selectedInitialState: Int!
    
    var ruta = [Int]()
    

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        cuartos = [view0, view1, view2, view3, view4, view5, view6, view7, view8, view9]
        
        cuartos[self.selectedInitialState].addSubview(self.robot)
       
    
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
    
    func calcularRuta() {
        let finalState = trainingSession.finalState
        var actualState: Int! = self.selectedInitialState /// Estado inicial es el actual
        
        while actualState != finalState {
            
            if let nextState = getMaxActionFrom(states: Q[actualState]) {
                self.ruta.append(nextState)
    
                actualState = nextState
                
            } else {
                
                print("No se puede calcular ruta completa porque hace falta más entrenamiento")
                break
                
            }
            
            
        }

        

        
    }
    
    func getMaxActionFrom(states: [Int]) -> Int? {
        
        var posicionValorMaximo = -1
        var valorMaximo = -1
       // let possibles = Q[state]
        var position = 0
        for i in states {
            if i > valorMaximo {
                valorMaximo = i
                posicionValorMaximo = position
                
            }
            position += 1
        }
        
        if valorMaximo == 0 {
            return nil
        }
        
        return posicionValorMaximo
        
        
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
    
    func mostrarRuta() {
        print("En mostrar ruta !!!!")
        if self.ruta.isEmpty {
            return
        }
        print("self.ruta.last! != 9 === \(self.ruta.last! != 9)")
        if self.ruta.last! != 9 {
            self.showMessage(title: "Error", text: "Robot necesita más entrenamiento para continuar")
        }
        
        let numeroEstados = self.ruta.count - 1
        var posicion = 0
        
        let animacionTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            timer in
            print("Posicion actual = \(posicion)")
            if posicion > numeroEstados {
                timer.invalidate()
                self.showMessage(title: "Mesaje", text: "Robot llegó a su destino ! = \n \(self.ruta)")
            
                
                
                
                return
            }
            
            self.robot.removeFromSuperview()
            self.cuartos[self.ruta[posicion]].addSubview(self.robot)
            
            
            
            
            posicion += 1
        }

        
        
        
        
        
        
        
        
        
      
        
        
    }
    
    // MARK: - IBActions
    
    
    @IBAction func startDidPressed(_ sender: Any) {
        self.ruta.removeAll()
        self.cuartos[self.selectedInitialState].addSubview(robot)
        //self.startTraining()
        self.calcularRuta()
        self.mostrarRuta()
        
    }
    
    func showMessage(title: String, text: String) {
        let alert = UIAlertController.init(title: title, message: text, preferredStyle: .alert)
        let ok = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true)
        
        
    }
    

}





