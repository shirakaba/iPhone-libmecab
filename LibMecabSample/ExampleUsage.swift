//
//  Mecab.swift
//  LibMecabSample
//
//  Created by jamie on 29/04/2017.
//
// This code is currently not used in the project, but does compile.


#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
import Cocoa
#endif

#if canImport(UIKit)
class Uivc: UIViewController {
    override func viewDidLoad() {
        let mecab : Mecab = Mecab()
        let nodes : [Node] = mecab.parseToNode(with: "これはなんですか。")
        print(nodes[0].feature)
    }
}
#else
class Nsvc: NSViewController {
    override func viewDidLoad() {
        let mecab : Mecab = Mecab()
        let nodes : [Node] = mecab.parseToNode(with: "これはなんですか。")
        print(nodes[0].feature!)
    }
}
#endif
