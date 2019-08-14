//
//  FormularioViewController.swift
//  ContatosIP67
//
//  Created by ios6998 on 10/07/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class FormularioViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var CampoNome : UITextField!
    @IBOutlet var CampoTelefone : UITextField!
    @IBOutlet var CampoEndereco : UITextField!
    @IBOutlet var CampoSite : UITextField!
    @IBOutlet var CampoEmail : UITextField!
    
    @IBOutlet var CampoLat : UITextField!
    @IBOutlet weak var CampoLong: UITextField!
    @IBOutlet var loading : UIActivityIndicatorView!
    @IBOutlet var CampoFoto : UIImageView!
    
    //
    private var contato : Contato!
    
    var delegate: FormularioDelegate!
    
    let dao = ContatoDao.getInstance()
    
    @IBAction func buscarCoordenadas(sender: UIButton){
        
        self.loading.startAnimating()
        sender.isEnabled = false
        sender.isHidden = true
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(self.CampoEndereco.text!) { (resultado, error) in
            
            // pegou a resposta
            if error == nil  {
                let placemark = resultado?[0]
                let coordenadas = placemark?.location!.coordinate
                
                self.CampoLat.text = coordenadas?.latitude.description
                self.CampoLong.text = coordenadas?.longitude.description
            }
            self.loading.stopAnimating()
        sender.isHidden = false
            sender.isEnabled = true
        }
    }
    
    @IBAction func criaContato(){
        
        self.pegaDadosDoFurmulario()
        //let Dao = ContatoDao.getInstance()
        dao.adiciona(contato: contato)
        
        self.delegate?.adicionado(contato: contato)
        
        _ =  self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    func tirarFoto(sender: AnyObject){
        //        if UIImagePickerController.isSourceTypeAvailable(.camera){
        //            //camera disponivel
        //        }else{
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker,animated: true,completion: nil)
        //        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let foto = info[UIImagePickerControllerEditedImage] as? UIImage{
            self.CampoFoto.image = foto
        }
        print("Chaves: \(info.keys)")
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func contatoSelecionado(_ contato: Contato){
        self.contato = contato
    }
    
    override func viewDidLoad() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tirarFoto(sender: )))
        self.CampoFoto.addGestureRecognizer(tap)
        
        if self.contato != nil{
            //popula o formulario com as informações do clique
            
            self.CampoNome.text = self.contato.nome
            self.CampoEndereco.text = self.contato.endereco
            self.CampoEmail.text = self.contato.email
            self.CampoTelefone.text = self.contato.telefone
            self.CampoSite.text = self.contato.site
            self.CampoLat.text = self.contato.latitude.description
            self.CampoLong.text = self.contato.longitude.description
            if let foto = self.contato.foto{
                self.CampoFoto.image = foto
            }
            
            let botaoConfirmar = UIBarButtonItem(title: "Atualizar", style: .plain, target: self, action: #selector(atualiza))
            
            
            self.navigationItem.rightBarButtonItem = botaoConfirmar
        }
    }
    
    
    func atualiza(){
        pegaDadosDoFurmulario()
         dao.saveContext()
       // self.delegate.adicionado(contato: contato)
        _ = self.navigationController?.popViewController(animated: true)
        
        
    }
    
    func pegaDadosDoFurmulario()-> Void{
        
        if(contato == nil){
            contato = dao.novoContato()
        }
        
        // não ha necessidade de tipar (let contato = Contato())
        // let contato: Contato = Contato()
        contato.foto = self.CampoFoto.image
        contato.nome = self.CampoNome.text!
        
        contato.telefone = self.CampoTelefone.text!
        contato.endereco = self.CampoEndereco.text!
        contato.site = self.CampoSite.text!
        contato.email = self.CampoEmail.text!
        
        
        if let latitude = Double(self.CampoLat.text!){
            self.contato.latitude = latitude as NSNumber
        }
        
        if let longitude = Double(self.CampoLong.text!){
            self.contato.longitude = longitude as NSNumber
        }
        
        
        
        
        
        // Utilizando sem objeto, somente em memoria
        //    let nome: String = CampoNome.text!
        //    let telefone: String = CampoTelefone.text!
        //    let endereco: String = CampoEndereco.text!
        //    let site: String = CampoSite.text!
        //    let email: String = CampoEmail.text!
        
        //    print("O nome :\(nome) \n telefone: \(telefone) \n endereço : \(endereco) \n site: \(site) \n email: \(email)")
        
        
        
    }
}
