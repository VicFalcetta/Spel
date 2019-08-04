//
//  AddJogoTableController.swift
//  Spel
//
//  Created by Victor Falcetta do Nascimento on 27/07/19.
//  Copyright © 2019 Victor Falcetta do Nascimento. All rights reserved.
//

import UIKit
import CoreData

protocol AddJogoViewControllerDelegate: class {
    
    func addJogoViewControllerDidCancel(_ controller: AddJogoTableController)
    func addJogoViewController(_ controller: AddJogoTableController, didFinishAdding item: JogoJogado)
}

class AddJogoTableController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   
    weak var delegate:AddJogoViewControllerDelegate?
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    @IBOutlet weak var textFieldNomeJogo: UITextField!
    @IBOutlet weak var textFieldPlatJogo: UITextField!
    @IBOutlet weak var addJogoOutlet: UIBarButtonItem!
    @IBOutlet weak var pickerNota: UIPickerView!
    
    var pickerNotas: [String] = [String]()
    
    
    
    
    @IBAction func addNovoJogo(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        let jogo = JogoJogado(entity: JogoJogado.entity(), insertInto: context)
        if let fieldNomeJogo = textFieldNomeJogo.text{
            jogo.nome = fieldNomeJogo
        }
        if let fieldPlatJogo = textFieldPlatJogo.text{
            jogo.plataforma = fieldPlatJogo
        }
        
        jogo.nota = Int32(pickerNota.selectedRow(inComponent: 0))
        
        
        delegate?.addJogoViewController(self, didFinishAdding: jogo)
        appDelegate.saveContext()
        
    }
    
    @IBAction func cancelarNovoJogo(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        delegate?.addJogoViewControllerDidCancel(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isOpaque = true
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2117647059, green: 0.7098039216, blue: 0.8705882353, alpha: 1)
        
//        textview.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
//        textview.text = "Digite sua descrição aqui..."
        
        textFieldNomeJogo.delegate = self
        textFieldPlatJogo.delegate = self
//        textview.delegate = self
        
        self.pickerNota.delegate = self
        self.pickerNota.dataSource = self
        
        pickerNotas = ["1","2","3","4","5"]
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerNotas.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerNotas[row]
    }

    

}

extension AddJogoTableController: UITextFieldDelegate, UITextViewDelegate{
    //Coisas do textField
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    //Esse método abaixo está muito bugado, pedir ajuda para as outras pessoas para o tentar corrigir. Mas acredito que ele não seja necessário.
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        guard let oldTextNome = textFieldNomeJogo.text,
//              let stringRangeNome = Range(range, in: oldTextNome) else{
//                return false
//        }
//
//        guard let oldTextPlat = textFieldPlatJogo.text,
//              let stringRangePlat = Range(range, in: oldTextPlat) else{
//                return false
//        }
//
//
//        let newTextNome = oldTextNome.replacingCharacters(in: stringRangeNome, with: string)
//        let newTextPlat = oldTextPlat.replacingCharacters(in: stringRangePlat, with: string)
//        if newTextNome.isEmpty || newTextPlat.isEmpty{
//            addJogoOutlet.isEnabled = false
//        }else{
//            addJogoOutlet.isEnabled = true
//        }
//
//        return true
//    }
    
        
    
    //Coisas do textView
    
    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textview.text == "Digite sua descrição aqui..."{
//            textview.text = ""
//            textview.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        }
//    }
//
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textview.text.isEmpty{
//            textview.text = "Digite sua descrição aqui..."
//            textview.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//        }
//    }
//
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if text == "\n" {
//            textview.resignFirstResponder()
//            return false
//        }
//        return true
//    }

}
