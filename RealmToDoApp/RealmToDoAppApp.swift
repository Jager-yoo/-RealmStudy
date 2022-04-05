//
//  RealmToDoAppApp.swift
//  RealmToDoApp
//
//  Created by 유재호 on 2022/04/05.
//

import SwiftUI

@main
struct RealmToDoAppApp: App {
    // App 프로토콜? -> https://developer.apple.com/documentation/swiftui/app
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .onAppear {
                    // Realm 데이터가 어디에 저장되는지 확인하기 위한 코드
                    print("⚠️⚠️⚠️")
                    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
                    
                    // 콘솔로그에 지저분하게 많이 뜨는 레이아웃 관련 오류를 안 뜨게 해주는 코드
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                }
        }
    }
}
