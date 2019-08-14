//
//  ContatoDAO.swift
//  ContatosIP67
//
//  Created by ios6998 on 10/07/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import Foundation

class ContatoDao: CoreDataUtil{
    
    static private var defaultDAO: ContatoDao!
    
    // 3 formas de inicializar um Array
    //   var contatos: Array<Contato> = Array()
    //   var contatos:[Contato] = [Contato]()
    var contatos = [Contato]()
  
    func listaContatos()-> Void{
        let query = NSFetchRequest<Contato>(entityName: "Contato")
        let orderBy =  NSSortDescriptor(key: "nome", ascending: true)
        query.sortDescriptors = [orderBy]
        do {
         let resposta =   try self.persistentContainer.viewContext.fetch(query)
            self.contatos =  resposta
        } catch  {
            
        }
    }
    
    static func rowCount()-> Int{
        
        if defaultDAO == nil {
            defaultDAO = ContatoDao()
        }
        return defaultDAO.contatos.count
    }
    
    func adiciona(contato: Contato){
        contatos.append(contato)
        saveContext()
    }
    
    func buscaPosicaDoContato(_ contato: Contato) -> Int {
        return contatos.index(of: contato)!
    }
    
    func remove(_ posicao: Int){
        let contato = contatos[posicao]
        self.persistentContainer.viewContext.delete(contato)
        saveContext()
    }
    
    static func getInstance() -> ContatoDao{
        if defaultDAO == nil {
            defaultDAO = ContatoDao()
        }
        return defaultDAO
    }
    
    func novoContato()-> Contato {
        
        return NSEntityDescription.insertNewObject(forEntityName: "Contato", into: self.persistentContainer.viewContext) as! Contato
        
        //        self.contatos = Array() // pode ter ou não
    }
    
    override  private  init(){
        super.init()
        self.listaContatos()
    }
}
