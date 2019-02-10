//
//  TrainingViewController.swift
//  QLearning
//
//  Created by Luis Luna on 2/9/19.
//  Copyright © 2019 DeepTech. All rights reserved.
//

import UIKit

class TrainingViewController: UIViewController {
    
    @IBOutlet weak var logTextView: UITextView!
    
    @IBOutlet weak var numeroEntrenamientosTxt: UITextField!
    
    @IBOutlet weak var InitialStatePickerView: UIPickerView!
    
    let estados = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    @IBOutlet weak var resultadoView: UIView!
    var trainingSession: QLearning!
    
    var selectedInitialState = "-1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.trainingSession = QLearning(delegate: self)
        self.InitialStatePickerView.delegate = self
        self.InitialStatePickerView.dataSource = self
        

        // Do any additional setup after loading the view.
    }
    

    @IBAction func startTrainingDidPressed(_ sender: Any) {
        let number = Int(self.numeroEntrenamientosTxt.text!) ?? -1
        
        self.trainingSession.numberOfTrainings = number
        
        DispatchQueue.global().async {
             let q = self.trainingSession.startTraining()
            
        }
       
        
    }
    
    @IBAction func mostrarResultadoDidPressed(_ sender: Any) {
        
        
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
        return "Estado: \(estados[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedInitialState = estados[row]
    }
    
    
    
    
    
}
