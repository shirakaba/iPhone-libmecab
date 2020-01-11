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
        japaneseNodes?.forEach({ node in print("[\(node.surface)] \(node.partOfSpeech ?? "*") \(node.originalForm ?? "*")") })
        
        let koreanNodes: [MecabNode]? = mecabKorean.parseToNode(with: "mecab-ko-dic은 MeCab을 사용하여, 한국어 형태소 분석을 하기 위한 프로젝트입니다.")
        koreanNodes?.forEach({ node in print("[\(node.surface)] (\(node.partOfSpeech ?? "*")) \(node.originalForm ?? "*")") })
    }


}

