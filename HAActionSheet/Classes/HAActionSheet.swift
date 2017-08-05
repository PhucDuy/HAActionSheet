//
//  HAActionSheet.swift
//  HAActionSheet
//
//  Created by Hasan Asan on 04/08/2017.
//  Copyright © 2017 Hasan Ali Asan. All rights reserved.
//

import UIKit

public class HAActionSheet: UIView {
  @IBOutlet private var view              : UIView!
  @IBOutlet private var listContainerView : UIView!
  @IBOutlet private var cancelButton      : UIButton!
  @IBOutlet private var tableView         : UITableView!
  
  @IBOutlet private var listContainerHeightConst : NSLayoutConstraint!
  @IBOutlet private var listContainerTopConst    : NSLayoutConstraint!
  
  public var delegate: HAActionSheetDelegate!
  
  var animatedCells                      = [IndexPath]()
  var cancelButtonTitle                  = ""
  public var buttonCornerRadius: CGFloat = 0.0
  public var disableAnimation            = true
  public var titleFont                   = UIFont.systemFont(ofSize: 17)
  public var cancelButtonTitleColor      = UIColor.red
  public var cancelButtonBackgroundColor = UIColor.white
  public var buttonTitleColor            = UIColor.blue
  public var buttonBackgroundColor       = UIColor.white
  public var seperatorColor              = UIColor(red: 237.0/255.0,
                                                   green: 237.0/255.0,
                                                   blue: 239.0/255.0,
                                                   alpha: 1)
  
  var sourceData: [String]!
  
  public init(fromView: UIView, sourceData: [String], cancelButtonTitle: String? = "Cancel") {
    super.init(frame: fromView.frame)
    
    let podBundle = Bundle.init(for: self.classForCoder)
    if let bundleURL = podBundle.url(forResource: "HAActionSheet", withExtension: "bundle") {
      let bundle = Bundle.init(url: bundleURL)
      UINib(nibName: "HAActionSheet", bundle: bundle).instantiate(withOwner: self, options: nil)
      addSubview(view)
      view.frame = self.bounds
      fromView.addSubview(self)
      
      self.sourceData = sourceData
      self.cancelButtonTitle = cancelButtonTitle!
    }else {
      assertionFailure("Could not create a path to the bundle")
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  @IBAction func cancelButtonAction(_ sender: Any) {
    if let _ = self.delegate.didCancel?(self) {
      self.delegate.didCancel!(self)
    }
    
    self.removeView()
  }
  
  public func show() {
    self.cancelButton.setTitleColor(self.cancelButtonTitleColor, for: .normal)
    self.cancelButton.backgroundColor = self.cancelButtonBackgroundColor
    self.cancelButton.titleLabel?.font = self.titleFont
    self.listContainerView.layer.cornerRadius = self.buttonCornerRadius
    self.cancelButton.layer.cornerRadius = self.buttonCornerRadius
    
    self.tableView.delegate = self
    self.tableView.dataSource = self
    
    var scrollPoint: CGPoint!
    self.tableView.reloadData()
    if self.tableView.contentSize.height < self.frame.size.height {
      self.listContainerTopConst.isActive = false
      self.listContainerHeightConst.constant = self.tableView.contentSize.height
      scrollPoint = CGPoint(x: 0, y: self.tableView.frame.size.height)
    } else {
      self.listContainerHeightConst.constant = self.tableView.frame.size.height
      self.listContainerTopConst.isActive = true
      scrollPoint = CGPoint(x: 0, y: self.tableView.contentSize.height - self.tableView.frame.size.height)
    }
    
    self.tableView.setContentOffset(scrollPoint, animated: false)
    self.listContainerView.transform = CGAffineTransform(translationX: 0,
                                                         y: self.frame.size.height)
    self.cancelButton.transform = CGAffineTransform(translationX: 0,
                                                    y: self.frame.size.height)
    
    UIView.animate(withDuration: 0.4, animations: {
      self.cancelButton.transform = .identity
      self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
      self.listContainerView.transform = .identity
    })
    
//    UIView.animate(withDuration: 0.4, animations: {
//      
//    })
  }
  
  func removeView() {
    DispatchQueue.main.async {
      UIView.animate(withDuration: 0.4, animations: {
        self.cancelButton.transform = CGAffineTransform(translationX: 0, y: self.frame.size.height)
        self.view.backgroundColor = .clear
      })
      
      UIView.animate(withDuration: 0.2, animations: {
        self.listContainerView.transform = CGAffineTransform(translationX: 0, y: self.frame.size.height)
      }, completion: { (_) in
        self.removeFromSuperview()
      })
    }
  }
}

extension HAActionSheet: UITableViewDataSource {
  public func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  public func tableView(_ tableView: UITableView,
                        numberOfRowsInSection section: Int) -> Int {
    return self.sourceData.count
  }
  
  public func tableView(_ tableView: UITableView,
                        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
    if cell == nil {
      let podBundle = Bundle.init(for: self.classForCoder)
      if let bundleURL = podBundle.url(forResource: "HAActionSheet", withExtension: "bundle") {
        let bundle = Bundle.init(url: bundleURL)
        let customCell = UINib(nibName: "HAActionSheetCell", bundle: bundle).instantiate(withOwner: self, options: nil)[0] as? HAActionSheetCell
        customCell?.prepare(title: self.sourceData[indexPath.row],
                            titleColor: self.buttonTitleColor,
                            bgColor: self.buttonBackgroundColor,
                            seperatorColor: self.seperatorColor,
                            font: self.titleFont)
        cell = customCell
      }else {
        assertionFailure("Could not create a path to the bundle")
      }
    }
    
    return cell!
  }
}

extension HAActionSheet: UITableViewDelegate {
  public func tableView(_ tableView: UITableView,
                        heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  public func tableView(_ tableView: UITableView,
                        estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
  public func tableView(_ tableView: UITableView,
                        didSelectRowAt indexPath: IndexPath) {
    self.delegate.haActionSheet(self, didSelectRowAt: indexPath.row)
    self.removeView()
  }
  
  public func tableView(_ tableView: UITableView,
                        willDisplay cell: UITableViewCell,
                        forRowAt indexPath: IndexPath) {
    if disableAnimation {
      return
    }
    
    if !self.animatedCells.contains(indexPath) {
      self.animatedCells.append(indexPath)
      cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
      UIView.animate(withDuration: 0.5, animations: {
        cell.layer.transform = CATransform3DMakeScale(1.0,1.0,1)
      },completion: { finished in
        UIView.animate(withDuration: 0.1, animations: {
          cell.layer.transform = CATransform3DMakeScale(1,1,1)
        })
      })
    }
  }
}

@objc public protocol HAActionSheetDelegate {
  @objc optional func didCancel(_ pickerView: HAActionSheet)
  @objc func haActionSheet(_ actionSheet: HAActionSheet, didSelectRowAt index: Int)
}
