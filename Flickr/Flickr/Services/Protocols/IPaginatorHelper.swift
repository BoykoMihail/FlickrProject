//
//  IPaginatorHelper.swift
//  Flickr
//
//  Created by m.a.boyko on 09.07.2022.
//

import Foundation

protocol IPaginatorHelper {
    func loadInitialData() async throws -> PaginatorHelperResult
    func loadNextPage() async throws -> PaginatorHelperResult
}
