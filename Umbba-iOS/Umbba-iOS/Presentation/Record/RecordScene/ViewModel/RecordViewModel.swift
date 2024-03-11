//
//  RecordViewModel.swift
//  Umbba-iOS
//
//  Created by 고아라 on 3/1/24.
//

import UIKit

import RxSwift
import RxCocoa
import Alamofire

protocol RecordViewModelInputs {
    func getAlbum()
    func deleteButtonTapped(idx: Int)
}

protocol RecordViewModelOutputs {
    var albumData: BehaviorRelay<[AlbumEntity]> { get }
}

protocol RecordViewModelType {
    var inputs: RecordViewModelInputs { get }
    var outputs: RecordViewModelOutputs { get }
}

final class RecordViewModel: RecordViewModelInputs, RecordViewModelOutputs, RecordViewModelType {
    
    var inputs: RecordViewModelInputs { return self }
    var outputs: RecordViewModelOutputs { return self }
    
    var image: Data?
    var location: String = ""
    var firstDelete: Bool = false
 
    // output
    
    var albumData: BehaviorRelay<[AlbumEntity]> = BehaviorRelay<[AlbumEntity]>(value: [])
    
    // input
    
    func getAlbum() {
        self.getAlbumAPI()
    }
    
    func deleteButtonTapped(idx: Int) {
        self.deleteAlbumAPI(id: idx)
    }
    
    init() {
        self.getAlbumAPI()
    }
}

extension RecordViewModel {
    
    func getAlbumAPI() {
        RecordService.shared.getAlbumAPI { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<[AlbumEntity]> {
                    dump(data)
                    if let albumData = data.data {
                        self.albumData.accept(albumData)
                    }
                }
            default:
                break
            }
        }
    }
    
    func deleteAlbumAPI(id: Int) {
        RecordService.shared.deleteAlbumAPI(albumId: id) { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<AlbumDeleteEntity> {
                    dump(data)
                }
            default:
                break
            }
        }
    }
}
