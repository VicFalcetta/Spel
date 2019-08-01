//
//  JogosJogadosTableViewController.swift
//  Spel
//
//  Created by Victor Falcetta do Nascimento on 24/07/19.
//  Copyright © 2019 Victor Falcetta do Nascimento. All rights reserved.
//

import UIKit
import CoreData

class JogosJogadosTableViewController: UITableViewController {
    
    var tabJogosJogados: ListaJogosJogados
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
//Usado apenas para testes o comando abaixo
//    @IBAction func addJogoJogado(_ sender: Any) {
//        let newRowIndex = tabJogosJogados.jogosJogadosArray.count
//        _ = tabJogosJogados.addNovoJogo()
//        let indexPath = IndexPath(row: newRowIndex, section: 0)
//        let arrayIndexPath = [indexPath]
//        tableView.insertRows(at: arrayIndexPath, with: .automatic)
//    }
    
    required init?(coder aDecoder: NSCoder) {
    
        tabJogosJogados = ListaJogosJogados()
        
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isOpaque = true
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2117647059, green: 0.7098039216, blue: 0.8705882353, alpha: 1)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        do {
            tabJogosJogados.jogosJogadosArray = try context.fetch(JogoJogado.fetchRequest())
        }catch let error as NSError {
            print("Não foi possivel buscar o dado. \(error), \(error.userInfo)")
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tabJogosJogados.jogosJogadosArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JogosJogadosItem", for: indexPath)
        let itemJogo = tabJogosJogados.jogosJogadosArray[indexPath.row]
        configJogo(for: cell, with: itemJogo)
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        context.delete(tabJogosJogados.jogosJogadosArray[indexPath.row])
        tabJogosJogados.jogosJogadosArray.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        tableView.reloadData()
        
        do{
            try context.save()
        }catch{
            fatalError()
        }
        
        
        //Não precisa fazer isso, mas fornece um output melhor para o usuário final. Isso aqui é bom para fazer os visuais.
        
    }
    
    func configJogo(for cell: UITableViewCell, with item: JogoJogado){
        if let labelNome = cell.viewWithTag(1000) as? UILabel {
            labelNome.text = item.nome
        }
        
        if let labelPlat = cell.viewWithTag(1001) as? UILabel {
            labelPlat.text = item.plataforma
        }
        
        if let labelNota = cell.viewWithTag(1002) as? UILabel {
            labelNota.text = String(item.nota)
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddJogoSegue"{
            if let addJogoTableController = segue.destination as? AddJogoTableController{
                addJogoTableController.delegate = self
            }
        }
    }
 

}

extension JogosJogadosTableViewController: AddJogoViewControllerDelegate{
    func addJogoViewControllerDidCancel(_ controller: AddJogoTableController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addJogoViewController(_ controller: AddJogoTableController, didFinishAdding item: JogoJogado) {
        navigationController?.popViewController(animated: true)
        let rowIndex = tabJogosJogados.jogosJogadosArray.count
        tabJogosJogados.jogosJogadosArray.append(item)
        let indexPath = IndexPath(row: rowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    
}
