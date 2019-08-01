//
//  JogosDesejadosTableViewController.swift
//  Spel
//
//  Created by Victor Falcetta do Nascimento on 29/07/19.
//  Copyright © 2019 Victor Falcetta do Nascimento. All rights reserved.
//

import UIKit

class JogosDesejadosTableViewController: UITableViewController {
    
    var tabJogosDesejados: ListaJogosDesejados
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    required init?(coder aDecoder: NSCoder) {
        tabJogosDesejados = ListaJogosDesejados()
        super.init(coder: aDecoder)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isOpaque = true
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2117647059, green: 0.7098039216, blue: 0.8705882353, alpha: 1)

    }

    // MARK: - Table view data source
    
    override func viewWillAppear(_ animated: Bool) {
        do{
            tabJogosDesejados.jogosDesejadosArray = try context.fetch(JogoDesejado.fetchRequest())
        }catch let error as NSError {
            print("Não foi possivel buscar o dado. \(error), \(error.userInfo)")
            
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tabJogosDesejados.jogosDesejadosArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JogosDesejadosItem", for: indexPath)
        let itemJogo = tabJogosDesejados.jogosDesejadosArray[indexPath.row]
        configJogo(for: cell, with: itemJogo)
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        context.delete(tabJogosDesejados.jogosDesejadosArray[indexPath.row])
        tabJogosDesejados.jogosDesejadosArray.remove(at: indexPath.row)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addDesejadoSegue"{
            if let addDesejadoTableController = segue.destination as? AddDesejadoTableViewController{
                addDesejadoTableController.delegate = self
            }
        }
    }
    
    func configJogo(for cell: UITableViewCell, with item: JogoDesejado){
        if let labelNome = cell.viewWithTag(1003) as? UILabel {
            labelNome.text = item.nome
        }
        
        if let labelPlat = cell.viewWithTag(1004) as? UILabel {
            labelPlat.text = item.plataforma
        }
        
        if let labelNota = cell.viewWithTag(1005) as? UILabel {
            labelNota.text = String(item.vontade)
        }
        
        
    }
    
    

}

extension JogosDesejadosTableViewController: AddDesejadoTableViewControllerDelegate{
    
    
    func addJogoDesejadoViewControllerDidCancel(_ controller: AddDesejadoTableViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addJogoDesejadoViewController(_ controller: AddDesejadoTableViewController, didFinishAdding item: JogoDesejado) {
        navigationController?.popViewController(animated: true)
        let rowIndex = tabJogosDesejados.jogosDesejadosArray.count
        tabJogosDesejados.jogosDesejadosArray.append(item)
        let indexPath = IndexPath(row: rowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
}
