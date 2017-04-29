//
//  Mecab.swift
//  LibMecabSample
//
//  Created by jamie on 29/04/2017.
//
//

import Foundation
import UIKit

class Uivc: UIViewController {
    override func viewDidLoad() {
        let mecab : Mecab = Mecab()
        let nodes : [Node] = mecab.parseToNode(with: "これはなんですか。")
    }
}
