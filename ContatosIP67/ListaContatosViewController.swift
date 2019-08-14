//
//  ListaContatosViewController.swift
//  ContatosIP67
//
//  Created by ios6998 on 11/07/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit

class ListaContatosViewController: UITableViewController, FormularioDelegate {
    
   
    
    var linhaDestaque : IndexPath?
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var linha = tableView.dequeueReusableCell(withIdentifier: "minhaLinha")
        
        if linha == nil {
            linha = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "minhaLinha")
            
        }
        let contato = ContatoDao.getInstance().contatos[indexPath.row]
        
        linha?.textLabel?.text = contato.nome
        
        
        return linha!
        
    }
    
    
    override func viewDidLoad() {
        
        let cliqueLonge = UILongPressGestureRecognizer(target: self, action: #selector(exibirMenu(gesture: )))
        
        self.tableView.addGestureRecognizer(cliqueLonge)
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
    }
    
    func exibirMenu(gesture: UIGestureRecognizer){
        
        let ponto = gesture.location(in: self.tableView)
        if let IndexPath = self.tableView.indexPathForRow(at: ponto){
            let contato = ContatoDao.getInstance().contatos[IndexPath.row]
            let acoes = GerenciadorDeAcoes(do: contato)
            acoes.exibirAcoes(em: self)

        }
        //        if let ponto = (gesture.state == .began) {
        //            let alert =    UIAlertController(title: "Atenção", message: "Press long", preferredStyle: .alert)
        //
        //
        //            let cancelar = UIAlertAction(title: "Cancelar", style: .destructive, handler: nil)
        //
        //            let ligar = UIAlertAction(title: "Ligar", style: .default, handler: {action in self.ligar()})
        //            let mostarMapa = UIAlertAction(title: "Ver no Mapa", style: .default, handler: {action in self.abrirMapa()})
        //
        //            alert.addAction(cancelar)
        //            alert.addAction(ligar)
        //            alert.addAction(mostarMapa)
        //            self.navigationController?.present(alert, animated: true, completion: nil)
        
        //        }
    }
    
    
    func ligar(){
        
    }
    
    func abrirMapa(){
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let dao = ContatoDao.getInstance()
            dao.remove(indexPath.row)
            dao.contatos.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func atualizado(contato: Contato) {
        self.linhaDestaque = IndexPath(row: ContatoDao.getInstance().buscaPosicaDoContato(contato), section: 0)
        ContatoDao.getInstance().saveContext()
        print("Atualizado: \(contato.nome) index: \(self.linhaDestaque)")
    }
    
    func adicionado(contato: Contato){
        self.linhaDestaque = IndexPath(row: ContatoDao.getInstance().buscaPosicaDoContato(contato), section: 0)
        print("Adicionado: \(contato.nome)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueForm" {
            if let formulario = segue.destination as? FormularioViewController{
                formulario.delegate = self
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let board =  UIStoryboard(name: "Main", bundle: nil)
        let form = board.instantiateViewController(withIdentifier: "formulario") as! FormularioViewController
        
        form.delegate = self
        
        let contato = ContatoDao.getInstance().contatos[indexPath.row]
        
        form.contatoSelecionado(contato)
        
        self.navigationController?.pushViewController(form, animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let linha = self.linhaDestaque {
            self.tableView.selectRow(at: linha, animated: true, scrollPosition: .middle)
            self.tableView.deselectRow(at: linha, animated: true)
            self.linhaDestaque = Optional.none
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //self.tableView.isEditing = false
        self.tableView.setEditing(false, animated: true)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContatoDao.rowCount()
    }
    
}
