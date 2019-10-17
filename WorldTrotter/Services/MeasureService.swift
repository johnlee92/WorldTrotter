//
//  MeasureService.swift
//  WorldTrotter
//
//  Created by 이재현 on 2019/10/18.
//  Copyright © 2019 Jaehyeon Lee. All rights reserved.
//

import Foundation

final class MeasureService {
  
  let numberFormatter: NumberFormatter = {
      let nf = NumberFormatter()
      nf.numberStyle = .decimal
      nf.minimumFractionDigits = 0
      nf.maximumFractionDigits = 1
      return nf
  }()
  
  func fahrenheitToCelsius(_ value: Double) -> String? {
    let fahrenheit = Measurement.init(value: value,
                                      unit: UnitTemperature.fahrenheit)
    let celsius = fahrenheit.converted(to: .celsius).value
    return numberFormatter.string(from: .init(value: celsius))
  }
}
