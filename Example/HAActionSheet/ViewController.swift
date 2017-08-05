//
//  ViewController.swift
//  HAActionSheet
//
//  Created by hasanlsn on 08/05/2017.
//  Copyright (c) 2017 hasanlsn. All rights reserved.
//

import UIKit
import HAActionSheet

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let view = HAActionSheet(fromView: self.view, sourceData: ["Sample", "Sample"])
//    view.delegate = self
    view.show()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

//extension ViewController: HAActionSheetDelegate {
//  func HAActionSheet(_ actionSheet: HAActionSheet, didSelectRowAt index: Int) {
//    print(index)
//  }
//}
