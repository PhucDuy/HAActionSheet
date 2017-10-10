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
  let data = ["Apple",
              "Orange",
              "Banana",
              "Berry"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func showAction(_ sender: Any) {
    let view = HAActionSheet(fromView: self.view, sourceData: data)
    view.title = "Fruits"
    view.message = "Pick a fruit"
    view.show { (canceled, index) in
      if !canceled {
       print(self.data[index!])
      }
    }
  }
}
