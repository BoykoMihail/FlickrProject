//
//  ImageCellViewModel.swift
//  Flickr
//
//  Created by m.a.boyko on 02.07.2022.
//

import UIKit
typealias GetImageblockParametr = (Task<UIImage, Never>) -> Void
typealias GetImageblock = (@escaping GetImageblockParametr) -> Void

struct ImageCellViewModel {
    private let getImageblock: GetImageblock

    init(getImageblock: @escaping GetImageblock) {
        self.getImageblock = getImageblock
    }

    func getImageFromUrl(completion: @escaping GetImageblockParametr) {
        getImageblock {
            completion($0)
        }
    }
}
