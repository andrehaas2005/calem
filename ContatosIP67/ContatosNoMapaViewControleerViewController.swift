//
//  ContatosNoMapaViewControleerViewController.swift
//  ContatosIP67
//
//  Created by ios6998 on 13/07/17.
//  Copyright © 2017 Caelum. All rights reserved.
//

import UIKit
import MapKit

class ContatosNoMapaViewControleerViewController: UIViewController {
    
    // weak tem relacao com o ARC -> Gerenciamento de memoria, quer dizer que se precisar pode destruir da memoria.
    //
    @IBOutlet weak var mapa : MKMapView!
    
    var contatos = [Contato]()
    
    let manager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        
        let gps = MKUserTrackingBarButtonItem(mapView: self.mapa)
        
        
        navigationItem.rightBarButtonItem = gps
        
        manager.requestAlwaysAuthorization()
        manager.requestWhenInUseAuthorization()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override  func viewDidAppear(_ animated: Bool) {
        let contatos = ContatoDao.getInstance().contatos
        self.mapa.addAnnotations(contatos)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.mapa.removeAnnotations(contatos)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
