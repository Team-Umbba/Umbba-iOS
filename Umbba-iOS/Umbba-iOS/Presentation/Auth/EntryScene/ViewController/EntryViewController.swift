//
//  EntryViewController.swift
//  Umbba-iOS
//
//  Created by 고아라 on 2023/07/05.
//

import UIKit

final class EntryViewController: UIViewController {

    private let entryView = EntryView()
    
    override func loadView() {
        super.loadView()
        self.view = entryView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
