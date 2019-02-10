//
//  QLearning.swift
//  QLearning
//
//  Created by Luis Luna on 2/9/19.
//  Copyright © 2019 DeepTech. All rights reserved.
//

import Foundation

class QLearning {
    
   
    
    var delegate: TrainingViewController
    
    init (delegate: TrainingViewController) {
        self.delegate = delegate
    }
    
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
    
    var isTraining = false
    var numberOfTrainings = -1
    let gamma = 0.8
    
    let finalState = 9
    
    func startTraining() -> [[Int]]? {
        if isTraining || self.numberOfTrainings == -1 {
            print("Ya hay una sesión de entrenamiento en curso...")
            return nil
        }
        
        var initialStateNumber: Int!
        var initialState: [Int]!
        var nextState: Int!
        var actualState: Int!
        isTraining = true
        
        for episodeNumber in 0...numberOfTrainings { //////Base de TODO
            print("Episodio actual = \(episodeNumber)")
            repeat {
                initialState  = self.R.randomElement()!
                initialStateNumber = R.firstIndex(of: initialState)!// Se escoje estado inicial del robot
            } while initialStateNumber == finalState
            
            log(str: "Estado inicial es = \(initialStateNumber!)")
            actualState = initialStateNumber
            
            while actualState != finalState {
                nextState = self.getActionFor(state: actualState) // VER
                
                log(str: "Estados posibles para \(actualState) = \(nextState)")
                
                //// Actualizar Q con la formula'
                
                let resultadoQ = Int(Double(R[actualState][nextState]) + (self.gamma * self.getMaxFromNext(state: nextState)))
                log(str: "Resultado ==  \(resultadoQ)")
                
                Q[actualState][nextState] = resultadoQ
                
                actualState = nextState
                log(str: "Actual state ahora es = \(actualState)")
                
            }
            
  
            
        }
        

        isTraining = false
        
        log(str: "Resultado = \(Q)")
        return Q

    }
    
    func log(str: String) {
        print(str)
        DispatchQueue.main.sync {
            self.delegate.logTextView.text = self.delegate.logTextView.text + "\n" + str
            
            let range = NSMakeRange(self.delegate.logTextView.text.count - 1, 1)
            self.delegate.logTextView.scrollRangeToVisible(range)
        }
        
        
        
    }
    
    func getMaxFromNext(state: Int) -> Double {
        var valorMaximo = 0
        let possibles = Q[state]
        
        for i in possibles {
            if i > valorMaximo {
                valorMaximo = i
            }
        }
        
        return Double(valorMaximo)
        
        
    }
    
    func getActionFor(state: Int)-> Int {
        var possibleStates = [Int]()
        
        let states = R[state]
        var pos = 0
        for i in states {
            if i == 00 || i == 100 {
                possibleStates.append(pos)
            }
            pos += 1
        }
        var i = possibleStates.randomElement()!
        log(str: "elemento random \(i)")
        return i
    }

    
    
    
    
    
    
    
}
