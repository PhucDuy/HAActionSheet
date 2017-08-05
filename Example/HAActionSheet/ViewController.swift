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
  }
  
  @IBAction func showAction(_ sender: Any) {
    let view = HAActionSheet(fromView: self.view, sourceData: ["Sample", "Sample"])
    view.delegate = self
    view.show()
  }
}

extension ViewController: HAActionSheetDelegate {
  func haActionSheet(_ actionSheet: HAActionSheet, didSelectRowAt index: Int) {
    print(index)
  }
}
