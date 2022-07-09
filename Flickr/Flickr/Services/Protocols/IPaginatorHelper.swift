//
//  IPaginatorHelper.swift
//  Flickr
//
//  Created by m.a.boyko on 09.07.2022.
//

import Foundation

protocol IPaginatorHelper {
    func loadInitialData() async -> PaginatorHelperResult
    func loadNextPage() async -> PaginatorHelperResult
}
