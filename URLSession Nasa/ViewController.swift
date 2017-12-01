//
//  ViewController.swift
//  URLSession Nasa
//
//  Created by C4Q on 12/1/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var nasaImageView: UIImageView!
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
   
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    var nasaObject: NASAObject? {
        didSet {
            if let nasaObject = nasaObject {
            self.titleLabel.text = nasaObject.title
                loadImage(from: nasaObject.hdurl ?? nasaObject.url)
            }
        }
    }
    
    
    @IBAction func loadImageButtonPressed(_ sender: UIButton) {
        let selectedDate = datePicker.date
        let longDescription = selectedDate.description
        let ymd = longDescription.components(separatedBy: " ")[0]
        loadObject(for: ymd)
       
        
    }
    
    func loadImage(from urlStr: String) {
        guard let url = URL(string: urlStr) else {return}
        let mySession = URLSession(configuration: .default)
        let myTask = mySession.dataTask(with: url){(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                guard let data = data else {return}
                if let error = error {
                    print(error)
                }
                guard let onlineImage = UIImage(data: data) else {return}
                self.nasaImageView.image = onlineImage
                self.nasaImageView.setNeedsLayout()
            }
           
            
        }
        myTask.resume()
        
    }
    
    func loadObject(for YMD: String) {
        let myKey = "L9g82iCF4fd9hJtHQm0qJTKmK88f8acmBpChLKqt"
        let str = "https://api.nasa.gov/planetary/apod?date=\(YMD)&api_key=\(myKey)"
        guard let url = URL(string: str) else {return}
        let mySession = URLSession(configuration: .default)
        let completion: (Data?, URLResponse?, Error?) -> Void = {(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                guard let data = data else {return}
                if let error = error {
                    print(error)
                    
                }
                do {
                    let onlineNasaObjext = try JSONDecoder().decode(NASAObject.self, from: data)
                    self.nasaObject = onlineNasaObjext
                    self.titleLabel.text = onlineNasaObjext.title
                }
                catch {
                    print(error)
                }
                
            }
        }
        let myTask = mySession.dataTask(with: url, completionHandler: completion)
        myTask.resume()
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
        
    }
    
    
    
    
}

