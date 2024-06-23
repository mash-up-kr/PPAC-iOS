//
//  AppCoordinator.swift
//  Home
//
//  Created by 장혜령 on 2024/06/23.
//

import Coordinator
import MyPage
import Recommend
import Search
import SwiftUI


public class HomeCoordinator: Coordinator, ObservableObject {
    @Published public var path: NavigationPath? = NavigationPath()
    public var childCoordinator: [Coordinator] = [] // 여기에 미리 다 채워?
    
    @Published var mainTab: MainTab = .recommend
    public init() { }
    
    init(path: NavigationPath? = nil, childCoordinator: [Coordinator] = [], mainTab: MainTab = .recommend) {
        self.path = path
        self.childCoordinator = childCoordinator
        self.mainTab = mainTab
    }
}

public struct HomeCoordinatorView: View {
    @ObservedObject var coordinator: HomeCoordinator
    
    public init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    public var body: some View {
        ZStack {
            VStack {
                TabView(selection: $coordinator.mainTab) {
                    RecommendView()
                        .tag(MainTab.recommend)
                    SearchView()
                        .tag(MainTab.search)
                    MyPageView()
                        .tag(MainTab.mypage)
                }
            }
            CustomTabBar(selectedTab: $coordinator.mainTab)
        }
        .edgesIgnoringSafeArea(.bottom)

    }
}
//        NavigationStack(path: $coordinator.path) {
//            // 처음 시작할 화면
//            coordinator.build(page: .apple)
//                .navigationDestination(for: Page.self) { page in
//                    coordinator.build(page: page)
//                }
//                .sheet(item: $coordinator.sheet) { sheet in
//                    coordinator.build(sheet: sheet)
//                }
//                .fullScreenCover(item: $coordinator.fullScreenCover) { fullScreenCover in
//                    coordinator.build(fullScreenCover: fullScreenCover)
//                }
//        }
