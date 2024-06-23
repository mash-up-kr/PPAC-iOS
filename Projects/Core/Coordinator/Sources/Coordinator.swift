//
//  Coordinator.swift
//  Coordinator
//
//  Created by 장혜령 on 2024/06/23.
//

import SwiftUI

public protocol Coordinator: AnyObject, Hashable, ObservableObject {
    var path: NavigationPath { get set }
    var childCoordinator: [any Coordinator] { get set }
    
//    func push()
//    func finish() // pop to root
//    func pop()
//    func present()
//    func dismiss()
}

extension Coordinator {
    
    
    func push(_ coordinator: any Coordinator) { // path에 append 할 수 있는
        //path?.append(coordinator)
    }
    func pop() {
       path.removeLast()
     }
     
     func popToRoot() {
         path.removeLast(path.count)
     }
}
