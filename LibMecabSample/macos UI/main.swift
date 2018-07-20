//
//  main.swift
//  LibMecabSample-macos
//
//  Created by jamie on 20/07/2018.
//

import Foundation
import Cocoa

let myApp: NSApplication = NSApplication.shared
let myDelegate: AppDelegate = AppDelegate()
// https://github.com/ptmt/react-native-macos/blob/master/RNTester/RNTester/main.m
let argvArray: NSMutableArray = NSMutableArray()
for i in 1..<CommandLine.argc {
    // print(NSString(utf8String: CommandLine.unsafeArgv[Int(i)]!)!)
    argvArray.add(NSString(utf8String: CommandLine.unsafeArgv[Int(i)]!)!)
}
myDelegate.argv = argvArray
myApp.delegate = myDelegate
_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
