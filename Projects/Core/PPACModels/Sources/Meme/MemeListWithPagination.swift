//
//  MemeListWithPagination.swift
//  PPACModels
//
//  Created by 장혜령 on 2024/07/21.
//

import Foundation

public struct MemeListWithPagination {
  public let pagination: Pagination
  public let memeList: [MemeDetail]
  
  public init(
    pagination: Pagination,
    memeList: [MemeDetail]
  ) {
    self.pagination = pagination
    self.memeList = memeList
  }
  
  public struct Pagination {
    /// 전체 페이지 개수
    public let totalPages: Int
    /// 전체 밈 개수
    public let totalMemes: Int
    /// page 당 밈 개수
    public let perPageOfMemes: Int
    /// 현재 page
    public let currentPage: Int
    
    public init(
      totalPages: Int,
      totalMemes: Int,
      perPageOfMemes: Int,
      currentPage: Int
    ) {
      self.totalPages = totalPages
      self.totalMemes = totalMemes
      self.perPageOfMemes = perPageOfMemes
      self.currentPage = currentPage
    }
    
    static public let `default` = Pagination(totalPages: 1, totalMemes: 0, perPageOfMemes: 10, currentPage: 0)
  }
}

public extension MemeListWithPagination {
  static let mock = MemeListWithPagination(
    pagination: Pagination(
      totalPages: 1,
      totalMemes: 5,
      perPageOfMemes: 5,
      currentPage: 1
    ),
    memeList: [])
}
