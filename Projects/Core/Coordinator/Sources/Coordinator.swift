//
//  Coordinator.swift
//  Coordinator
//
//  Created by 장혜령 on 2024/06/23.
//

import SwiftUI

//public enum FullScreenCover: String, Identifiable {
//    case detailMim
//    public var id: String { self.rawValue }
//}

public protocol Coordinator: AnyObject {
    var path: NavigationPath { get set }
    var childCoordinator: [any Coordinator] { get set }
    
//    func push()
//    func finish() // pop to root
    func pop()
    func popToRoot()
//    func present()
//    func dismiss()
}

public extension Coordinator  {
    
    //var id: String { UUID().uuidString }
//    static func == (lhs: any Coordinator, rhs: any Coordinator) -> Bool {
//        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
//    }
//    
    func push() { }
//    func push(_ coordinator: any Coordinator) { // path에 append 할 수 있는
////        path.append(coordinator)
////        self.childCoordinator.append(coordinator)
//    }
    func pop() {
       path.removeLast()
        //childCoordinator.remove last
     }
     
     func popToRoot() {
         //let pathCount = path?.count ?? 0
         path.removeLast(path.count)
         childCoordinator = []
     }
}

