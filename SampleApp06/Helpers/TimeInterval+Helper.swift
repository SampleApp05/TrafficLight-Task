//
//  TimeInterval+Helper.swift
//  SampleApp06
//
//  Created by Daniel Velikov on 24.03.25.
//

import Foundation

extension TimeInterval {
    var inNanoSeconds: UInt64 { UInt64(self * 1_000_000_000) }
}
