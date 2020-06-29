//
//  Mecab.swift
//  LibMecabSample
//
//  Created by jamie on 29/04/2017.
//
// This code is currently not used in the project, but does compile.


#if canImport(UIKit)
// For iOS, we have use_frameworks! on and no bridging header, so we have to
// explicitly import mecab_ko in each file we use the Mecab Obj-C library.
import mecab_ko
import UIKit
#elseif canImport(Cocoa)
// For macOS, we have use_frameworks! off (for example purposes).
// the bridging header means that we don't need to import mecab_ko anywhere.
import Cocoa
#endif

#if canImport(UIKit)
class Uivc: UIViewController {
    override func viewDidLoad() {
        let mecab : Mecab = Mecab()
        let nodes : [MecabNode] = mecab.parseToNode(with: "これ は なん です か。")
        print(nodes[0].feature)
    }
}
#else
class Nsvc: NSViewController {
    override func viewDidLoad() {
        let mecab : Mecab = Mecab()
        let nodes : [MecabNode] = mecab.parseToNode(with: "これはなんですか。")
        print(nodes[0].feature!)
    }
}
#endif
