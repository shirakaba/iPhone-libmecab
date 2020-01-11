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
        
        let jpBundlePath = Bundle.main.path(forResource: DEFAULT_JAPANESE_RESOURCES_BUNDLE_NAME, ofType: "bundle")
        print(jpBundlePath!)
        let koBundlePath = Bundle.main.path(forResource: DEFAULT_KOREAN_RESOURCES_BUNDLE_NAME, ofType: "bundle")
        print(koBundlePath!)
        
        let mecabJapanese: Mecab = Mecab.init(dicDirPath: jpBundlePath!)
        let mecabKorean: Mecab = Mecab.init(dicDirPath: koBundlePath!)
        let japaneseNodes: [MecabNode]? = mecabJapanese.parseToNode(with: "この番組はご覧のスポンサーの提供で送りします。")
        print(japaneseNodes!)
        japaneseNodes?.forEach({ node in print("[\(node.surface)] \(node.partOfSpeech ?? "*") \(node.originalForm ?? "*")") })
        
        let koreanNodes: [MecabNode]? = mecabKorean.parseToNode(with: "띄어쓰기를 하지 않는 일본어와 달리 띄어쓰기를 하는 한국어 특성에 맞게 특정 품사가 띄어쓰기 되어있는 경우 해당 품사의 비용을 늘리는 기능 (사전 설정(dicrc)에 설정 값을 지정)")
        koreanNodes?.forEach({ node in print("[\(node.surface)] (\(node.partOfSpeech ?? "*")) \(node.originalForm ?? "*")") })
    }


}

