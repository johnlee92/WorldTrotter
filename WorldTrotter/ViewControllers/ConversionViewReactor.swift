//
//  ConversionViewReactor.swift
//  WorldTrotter
//
//  Created by 이재현 on 2019/10/17.
//  Copyright © 2019 Jaehyeon Lee. All rights reserved.
//

import ReactorKit
import RxSwift

final class ConversionViewReactor: Reactor {
  enum Action {
    case textFieldEditingChanged(String)
  }
  
  enum Mutation {
    case setCelsiusStringValue(String)
  }
  
  struct State {
    var celsiusStringValue: String = "???"
  }
  
  let initialState = State()
  var measureService: MeasureService
  
  init(measureService: MeasureService) {
    self.measureService = measureService
    defer { _ = self.state }
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case let .textFieldEditingChanged(text):
      if let value = Double(text),
        let celsius = measureService.fahrenheitToCelsius(value) {
        return .just(Mutation.setCelsiusStringValue(celsius))
      } else {
        return .just(Mutation.setCelsiusStringValue("???"))
      }
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {
    case let .setCelsiusStringValue(value):
      state.celsiusStringValue = value
    }
    return state
  }
}
