//
//  GerenciadorDeAcoes.swift
//  ContatosIP67
//
//  Created by ios6998 on 12/07/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit

class GerenciadorDeAcoes: NSObject{
    let contato: Contato
    var controller: UIViewController!
    
    init(do contato: Contato){
        self.contato = contato
    }
    
    func exibirAcoes(em controller: UIViewController){
        self.controller = controller
        
        let alert =    UIAlertController(title: "Menu", message: nil, preferredStyle: .actionSheet)
        
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .destructive, handler: nil)
        
        let ligar = UIAlertAction(title: "Ligar", style: .default, handler: {action in self.ligar()})
        
        let mostarMapa = UIAlertAction(title: "Ver no Mapa", style: .default, handler: {action in self.abrirMapa()})
        let abrirSite = UIAlertAction(title: "Abrir Site", style: .default, handler: {action in self.abrirSite()})
        let exibirTemperatura = UIAlertAction(title: "Ver Temperatuira", style: .default, handler: {action in self.exibirTemperatura()})
        alert.addAction(cancelar)
        alert.addAction(ligar)
        alert.addAction(abrirSite)
        alert.addAction(mostarMapa)
        alert.addAction(exibirTemperatura)
        self.controller.present(alert, animated: true, completion: nil)
        
    }
    
    
    func exibirTemperatura(){
        let temperaturaViewController = controller.storyboard?.instantiateViewController(withIdentifier: "temperaturaViewController") as! TemperaturaViewController
        
        temperaturaViewController.contato = self.contato
        
        controller.navigationController?.pushViewController(temperaturaViewController, animated: true)
    }
    
    func abrirAplicativo(_ url: String){
        //UIApplication.shared.open(URL(string:url)!,options:[:],
        UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
        
    }
    
    func abrirSite(){
        var site =  self.contato.site
        if (!(site?.hasPrefix("http://"))!){
            site = "http://\(site!)"
        }
        
        abrirAplicativo(site!)
        
    }
    
    func ligar(){
        var telefone = self.contato.telefone
        telefone = "tel://" + telefone!
        
        print(telefone!)
        
        abrirAplicativo(telefone!)
        
    }
    
    func abrirMapa(){
        let url = ("http://maps.google.com/maps?q=" + self.contato.endereco!).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        //.addingPercentEncoding(withAllowedCharacters: characterSet.urlQueryAllowed)!
        abrirAplicativo(url)
        
        print("Ver o mapa")
    }
    
}
