//
//  Mecab.swift
//  LibMecabSample
//
//  Created by jamie on 29/04/2017.
//
// This code is currently not used in the project, but does compile.

import UIKit

class Uivc: UIViewController {
    override func viewDidLoad() {
        let mecab : MecabObjC = MecabObjC()
        let nodes : [Node] = mecab.parseToNode(with: "これはなんですか。")
        print(nodes[0].feature)
    }
}
