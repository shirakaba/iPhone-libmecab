//
//  ViewController.swift
//  pod-tester
//
//  Created by jamie on 08/01/2020.
//  Copyright © 2020 Bottled Logic. All rights reserved.
//

import UIKit
import mecab_ko

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
         let mecab: Mecab = Mecab()
         let nodes: [Node]? = mecab.parseToNode(with: "この番組はご覧のスポンサーの提供で送りします。")
         print(nodes ?? "Unable to deduce nodes")
    }


}

