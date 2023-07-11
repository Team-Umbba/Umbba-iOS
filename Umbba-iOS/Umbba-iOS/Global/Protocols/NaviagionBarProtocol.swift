//
//  NaviagionBarProtocol.swift
//  Umbba-iOS
//
//  Created by 최영린 on 2023/07/11.
//

import Foundation

protocol NavigationBarDelegate: AnyObject {
    func backButtonTapped()
    func completeButtonTapped()
}
