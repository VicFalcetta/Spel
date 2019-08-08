//
//  AddDesejadoTableViewController.swift
//  Spel
//
//  Created by Victor Falcetta do Nascimento on 29/07/19.
//  Copyright © 2019 Victor Falcetta do Nascimento. All rights reserved.
//

import UIKit
import CoreData

protocol AddDesejadoTableViewControllerDelegate: class {
    func addJogoDesejadoViewControllerDidCancel (_ controller: AddDesejadoTableViewController)
    func addJogoDesejadoViewController(_ controller: AddDesejadoTableViewController, didFinishAdding item: JogoDesejado)
}

class AddDesejadoTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    weak var delegate: AddDesejadoTableViewControllerDelegate?
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var addNomeDesejado: UITextField!
    @IBOutlet weak var addDesejadoPlat: UITextField!
    @IBOutlet weak var addDesejadoVontade: UIPickerView!
    @IBOutlet weak var addDesejado: UIBarButtonItem!
    
    @IBAction func addJogoDesejado(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        let jogo = JogoDesejado(entity: JogoDesejado.entity(), insertInto: context)
        if let fieldNomeDesejado = addNomeDesejado.text {
            jogo.nome = fieldNomeDesejado
        }
        if let fieldPlatDesejado = addDesejadoPlat.text{
            jogo.plataforma = fieldPlatDesejado
        }
        jogo.vontade = Int32(addDesejadoVontade.selectedRow(inComponent: 0) + 1)
        
        delegate?.addJogoDesejadoViewController(self, didFinishAdding: jogo)
        appDelegate.saveContext()
        
        
    }
    
    @IBAction func cancelJogoDesejado(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        delegate?.addJogoDesejadoViewControllerDidCancel(self)
    }
    
    var pickerVontades: [String] = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isOpaque = true
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2117647059, green: 0.7098039216, blue: 0.8705882353, alpha: 1)
        
        addNomeDesejado.delegate = self
        addDesejadoPlat.delegate = self
        
        self.addDesejadoVontade.delegate = self
        self.addDesejadoVontade.dataSource = self
        pickerVontades = ["1","2","3","4","5"]

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
        return pickerVontades.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerVontades[row]
    }


}

extension AddDesejadoTableViewController: UITextFieldDelegate, UITextViewDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
