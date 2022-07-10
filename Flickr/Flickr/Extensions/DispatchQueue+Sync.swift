//
//  DispatchQueue+Sync.swift
//  Flickr
//
//  Created by Михаил Бойко on 10.07.2022.
//

import Foundation

extension DispatchQueue {
    func syncIfNotMain(execute block: () -> Void) {
        guard !Thread.isMainThread else {
            block()
            return
        }

        sync {
            block()
        }
    }
}
