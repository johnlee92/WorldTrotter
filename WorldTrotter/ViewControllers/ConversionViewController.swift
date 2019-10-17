//
//  ViewController.swift
//  WorldTrotter
//
//  Created by 이재현 on 2019/10/17.
//  Copyright © 2019 Jaehyeon Lee. All rights reserved.
//

import UIKit

import ReactorKit
import RxSwift
import RxCocoa
import RxKeyboard

final class ConversionViewController: BaseViewController, View {
  
  // MARK: Constants
  
  private enum Metric {
  }
  
  private enum Font {
  }
  
  private enum Color {
  }
  
  
  // MARK: Properties
  
  
  // MARK: UI
  
  let celsiusLabel = UILabel().then {
    $0.textAlignment = .center
    $0.text = "???"
  }
  
  let textField = UITextField().then {
    $0.placeholder = "Enter Fahrenheit Temperature"
    $0.textAlignment = .center
    $0.keyboardType = .decimalPad
  }
  
  let stackView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 24.f
  }
  
  
  // MARK: Initializing
  
  init(reactor: ConversionViewReactor) {
    defer { self.reactor = reactor }
    super.init()
  }
  
  required convenience init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tabBarItem = .init(title: "Convert", image: #imageLiteral(resourceName: "ConvertIcon"), tag: 0)
    
    view.addSubview(stackView)
    
    stackView.addArrangedSubview(textField)
    stackView.addArrangedSubview(celsiusLabel)
  }
  
  override func prepareConstraints() {
    stackView.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
  
  // MARK: Binding
  
  func bind(reactor: ConversionViewReactor) {
    // Input
    view.rx.tapGesture()
      .subscribe({ [weak self] _ in
        self?.textField.resignFirstResponder()
      })
      .disposed(by: self.disposeBag)
    
    textField.rx.text
      .distinctUntilChanged()
      .compactMap { $0 }
      .map { Reactor.Action.textFieldEditingChanged($0) }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)
    
    // Output
    reactor.state.map { $0.celsiusStringValue }
      .distinctUntilChanged()
      .bind(to: celsiusLabel.rx.text)
      .disposed(by: self.disposeBag)
  }
}

