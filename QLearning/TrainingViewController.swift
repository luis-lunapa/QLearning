//
//  TrainingViewController.swift
//  QLearning
//
//  Created by Luis Luna on 2/9/19.
//  Copyright © 2019 DeepTech. All rights reserved.
//

import UIKit
import AVFoundation

class TrainingViewController: UIViewController {
    
    @IBOutlet weak var logTextView: UITextView!
    
    @IBOutlet weak var numeroEntrenamientosTxt: UITextField!
    
    @IBOutlet weak var InitialStatePickerView: UIPickerView!
    
    @IBOutlet weak var gifImageView: UIImageView!
    
    var player = AVAudioPlayer.init()
    
    let estados = ["Estado inicial","0", "1", "2", "3", "4", "5", "6", "7", "8"]
    
    @IBOutlet weak var resultadoView: UIView!
    var trainingSession: QLearning!
    
    var selectedInitialState = -1
    
    var QMatrix: [[Int]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIDevice.current.setValue(Int(UIInterfaceOrientation.landscapeLeft.rawValue), forKey: "orientation")
        self.trainingSession = QLearning(delegate: self)
        self.InitialStatePickerView.delegate = self
        self.InitialStatePickerView.dataSource = self
        self.gifImageView.loadGif(asset: "donCangrejo")
        self.gifImageView.isHidden = true
        
        
        

        // Do any additional setup after loading the view.
    }
    
    func setUpAnimacionCangrejo() {
        
        self.gifImageView.isHidden = false
        let path = Bundle.main.path(forResource: "electricZoo2", ofType : "mp3")!
        let url = URL(fileURLWithPath : path)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.numberOfLoops = 100
            player.play()
            
        } catch {
            
            print ("No se puede reproducir bip bup bup bop")
            
        }
        
    }
    @IBAction func startTrainingDidPressed(_ sender: Any) {
        let number = Int(self.numeroEntrenamientosTxt.text!) ?? -1
        
        setUpAnimacionCangrejo()
        
        
        
        
        self.trainingSession.numberOfTrainings = number
        self.view.endEditing(true)
        
        DispatchQueue.global().async {
            self.trainingSession.startTraining() {
                [unowned self] qMatrix, error in
                
                if error != nil {
                    performUIUpdatesOnMain {
                        self.player.pause()
                        self.gifImageView.isHidden = true
                        
                        self.showMessage(title: "Error", text: error ?? "")
                    }
                    
                    
                } else {
                    self.QMatrix = qMatrix
                    
                    performUIUpdatesOnMain {
                        self.player.pause()
                        self.gifImageView.isHidden = true
                        self.logTextView.text = "\(self.logTextView.text) \n \(self.printMatrix(matrix: self.QMatrix!)))"
                        self.showMessage(title: "Listo", text: "Entrenamiento Completado")
                    }
                }
                

            }
            
            
        }
       
        
    }
    
    @IBAction func mostrarResultadoDidPressed(_ sender: Any) {
        
        if selectedInitialState == -1 {
            ///Mostrar alerta
            self.showMessage(title: "Error", text: "Escoja un estado inicial")
            print("Escoja estado inicial")
            return
        }
        
        if let q = self.QMatrix {
            let animacion = self.storyboard?.instantiateViewController(withIdentifier: "animacion") as! AnimationResultViewController
            animacion.selectedInitialState = self.selectedInitialState
            animacion.Q = q
            animacion.trainingSession = self.trainingSession
            
            self.show(animacion, sender: self)

        } else {
            self.showMessage(title: "Error", text: "Aún no se ha iniciado entrenamiento")
            print("Aun no se ha iniciado entrenamiento")
            
        }
        
    }
    
    func showMessage(title: String, text: String) {
        let alert = UIAlertController.init(title: title, message: text, preferredStyle: .alert)
        let ok = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true)
        
        
    }
    
    func printMatrix(matrix: [[Int]])-> String {
        var str = """
"""
        
        for i in matrix {
            str.append("\(i)\n")

        }
        
        return str
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TrainingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.estados.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if row == 0 {
            return estados[row]
        } else {
            return "Estado: \(estados[row])"
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row != 0 {
            self.selectedInitialState = Int(estados[row])!
        }
        
    }
    
    
    
    
    
}

func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
