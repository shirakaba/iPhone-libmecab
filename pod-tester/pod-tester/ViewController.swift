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
        
        let bundlePath = Bundle.main.path(forResource: "mecab-naist-jdic-utf-8", ofType: "bundle")
        print(bundlePath!)
//        let resourceBundle = Bundle.init(path: bundlePath!)
//        print(resourceBundle)
        
        let mecab: Mecab = Mecab()
        // let nodes: [Node]? = mecab.parseToNode(with: "この番組はご覧のスポンサーの提供で送りします。")
        let nodes: [Node]? = mecab.parseToNode(with: "この番組はご覧のスポンサーの提供で送りします。", dicdirPath: bundlePath!)
        print(nodes ?? "Unable to deduce nodes")
    }


}

