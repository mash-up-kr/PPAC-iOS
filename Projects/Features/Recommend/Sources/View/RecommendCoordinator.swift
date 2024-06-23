//
//  RecommendCoordinator.swift
//  Recommend
//
//  Created by 장혜령 on 2024/06/23.
//

import Coordinator
import SwiftUI

public class RecommendCoordinator: Coordinator, ObservableObject {
    @Published public var path: NavigationPath?
    public var childCoordinator: [Coordinator] = []
    
}
