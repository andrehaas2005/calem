//
//  TemperaturaViewController.swift
//  ContatosIP67
//
//  Created by André Haas on 07/08/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit

class TemperaturaViewController : UIViewController {
    
    @IBOutlet weak var labelCondicoesAtual: UILabel!
    @IBOutlet weak var labelTempAtual: UILabel!
    @IBOutlet weak var labelTemperaturaMaxima: UILabel!
    @IBOutlet weak var labelTemperaturaMinimo: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var contato : Contato?
    
    let URL_BASE = "http://api.openweathermap.org/data/2.5/weather?APPID=3ca83540b668636a4ea8bdaa745b9f92&units=metric"
    let URL_BASE_IMAGE = "http://openweathermap.org/img/w/"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let contato = self.contato{
            if let endpoint = URL(string: URL_BASE + "&lat=\(contato.latitude ?? 0)&lon=\(contato.longitude ?? 0)"){
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: endpoint){
                    (data,response,error) in
                    if let httpResponse = response as? HTTPURLResponse {
                        if httpResponse.statusCode == 200 {
                            
                            do{
                                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]{
                                    let main = json["main"] as! [String:AnyObject]
                                   
                                    let temp_min = main["temp_min"] as! Double
                                    let temp_max = main["temp_max"] as! Double
                                    let weather = json["weather"]![0] as! [String:AnyObject]
                                    let icon = weather["icon"] as! String
                                    let condicao = weather["main"] as! String
                                    let atual = main["temp"] as! Double
                                    
                                    DispatchQueue.main.async {
                                        self.labelCondicoesAtual.text = condicao
                                        self.labelTempAtual.text = atual.description
                                        self.labelTemperaturaMinimo.text = temp_min.description + "o"
                                        self.labelTemperaturaMaxima.text = temp_max.description + "o"
                                        self.pegaImagem(icon)
                                        
                                        self.labelCondicoesAtual.isHidden = false
                                        self.labelTemperaturaMinimo.isHidden = false
                                        self.labelTemperaturaMaxima.isHidden = false
                                    }
                                    
                                }
                            }catch let error as NSError{
                                print("Nao foi possivel fazer o parse do JSON: \(error.localizedDescription)")
                            }
                            
                            
                            
                        }else{
                            print("ocorreu algum problema com a requisicao")
                        }
                        
                    }
                }
                task.resume()
            }
        }
        
    }
    
    private func pegaImagem(_ icon:String){
        if let endpoint = URL(string: URL_BASE_IMAGE + icon + ".png"){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: endpoint){ (data, response, error) in
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        DispatchQueue.main.async {
                            print("Exibir Imagem")
                            self.imageView.image = UIImage(data: data!)
                        }
                    }
                }
            }
            task.resume()
        }
        
    }
}
