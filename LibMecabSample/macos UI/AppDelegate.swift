import Cocoa
// import mecab_ko

class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    // let taskVC: TasksViewController = TasksViewController()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        let jpBundlePath = Bundle.main.path(forResource: DEFAULT_JAPANESE_RESOURCES_BUNDLE_NAME, ofType: "bundle")
        print(jpBundlePath!)
        let jpBundleResourcePath = Bundle.init(path: jpBundlePath!)!.resourcePath
        print(jpBundleResourcePath!)
        
        let koBundlePath = Bundle.main.path(forResource: DEFAULT_KOREAN_RESOURCES_BUNDLE_NAME, ofType: "bundle")
        print(koBundlePath!)
        let koBundleResourcePath = Bundle.init(path: koBundlePath!)!.resourcePath
        print(koBundleResourcePath!)
        
        let mecabJapanese: Mecab = Mecab.init(dicDirPath: jpBundleResourcePath!)
        let mecabKorean: Mecab = Mecab.init(dicDirPath: koBundleResourcePath!)
        let japaneseNodes: [MecabNode]? = mecabJapanese.parseToNode(with: "この番組はご覧のスポンサーの提供で送りします。")
        japaneseNodes?.forEach({ node in print("[\(node.surface)] \(node.features?[0] ?? "*") \(node.features?[6] ?? "*")") })
        
        let koreanNodes: [MecabNode]? = mecabKorean.parseToNode(with: "mecab-ko-dic은 MeCab을 사용하여, 한국어 형태소 분석을 하기 위한 프로젝트입니다.")
        koreanNodes?.forEach({ node in print("[\(node.surface)] (\(node.features?[0] ?? "*")) \(node.features?[6] ?? "*")") })
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

