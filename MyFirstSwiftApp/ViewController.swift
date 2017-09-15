//
//  ViewController.swift
//  MyFirstSwiftApp
//
//  Created by Steven Galvin on 9/12/17.
//  Copyright © 2017 Steven Galvin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var contact : Contact?
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var numberTextField: UITextField!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isInAddMode = presentingViewController is UINavigationController
        
        if isInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController!.popViewController(animated: true)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if saveButton === sender as AnyObject {
            let name = nameTextField.text ?? ""
            let number = numberTextField.text ?? ""
            contact = Contact(name: name, number: number)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let contact = contact {
            nameTextField.text = contact.name
            numberTextField.text = contact.number
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

