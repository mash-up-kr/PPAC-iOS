//
//  RecommendCoordinator.swift
//  Recommend
//
//  Created by 장혜령 on 2024/06/23.
//
//
import SwiftUI
import Coordinator
import DetailMim

public class RecommendCoordinator: Coordinator, ObservableObject {
    @Published public var path: NavigationPath
    //@Published public var fullScreenCover: FullScreenCover?
    public var childCoordinator: [any Coordinator] = []
    //public var detailCoordinator: DetailMimCoordinator
    
    public init(path: NavigationPath, childCoordinator: [any Coordinator] = []) {
        self.path = path
        self.childCoordinator = childCoordinator
        //self.fullScreenCover = nil
        //self.detailCoordinator = DetailMimCoordinator(path: path, isPresented: true, childCoordinator: [])
    }
}

public struct RecommendCoordinatorView: View {
    @ObservedObject public var coordinator: RecommendCoordinator
    
    public init(coordinator: RecommendCoordinator) {
        self.coordinator = coordinator
    }
    
    public var body: some View {
        NavigationStack(path: $coordinator.path) {
            RecommendView()
//            .fullScreenCover(item: $coordinator.fullScreenCover) { _ in
//                Text("이게 떠야돼")
//                //DetailMimCoordinatorView(coordinator: coordinator.detailCoordinator)
//                //DetailMimView()
//            }
            
            .environmentObject(coordinator)
        }
    }
}

#Preview {
    let recommendCoordinator = RecommendCoordinator(path: NavigationPath(), childCoordinator: [])
    return RecommendCoordinatorView(coordinator: recommendCoordinator)
}



//public class RecommendCoordinator: Coordinator, ObservableObject {
//    @Published public var path: NavigationPath
//    public var childCoordinator: [any Coordinator] = []
//    @Published public var fullScreenCover: FullScreenCover? // 나중에 detailData로 넘겨줄 mim 데이터를 넣기?
//    public var detailCoordinator: (any Coordinator)?
//
//    public init(path: NavigationPath, childCoordinator: [any Coordinator] = []) {
//        self.path = path
//        self.childCoordinator = childCoordinator
//        self.detailCoordinator = nil
//        self.fullScreenCover = .detailMim
//    }
//
//    @ViewBuilder
//    func buildDetailMimView() -> some View {
//        DetailMimView()
//        //Text("이게 문제읹듯?")
//    }
//}
//
