//
//  Contact.swift
//  MyFirstSwiftApp
//
//  Created by Steven Galvin on 9/12/17.
//  Copyright © 2017 Steven Galvin. All rights reserved.
//

import Foundation

class Contact: NSObject, NSCoding {
    var name: String
    var number: String
    
    static let Dir = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = Dir.appendingPathComponent("contacts")
    
    required init?(name: String, number: String) {
        self.name = name
        self.number = number
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(number, forKey: "number")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let number = aDecoder.decodeObject(forKey: "number") as! String
        self.init(name: name, number: number)
    }
}
