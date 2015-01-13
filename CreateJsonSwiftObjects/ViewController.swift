//
//  ViewController.swift
//  CreateJsonSwiftObjects
//
//  Created by Eoin Norris on 05/01/2015.
//  Copyright (c) 2015 Eoin Norris. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var startConnection: NSButton!

    var parser = EOINJsonParser()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


    @IBAction func startConnection(sender: NSButton) {
        parser.startConnection()
    }
}

