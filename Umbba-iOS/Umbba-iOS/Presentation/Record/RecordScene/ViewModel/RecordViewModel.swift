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
    func patchAlbum(image: UIImage)
}

protocol RecordViewModelOutputs {
    var albumData: BehaviorRelay<[AlbumEntity]> { get }
    var putImageSuccess: PublishSubject<Bool> { get }
}

protocol RecordViewModelType {
    var inputs: RecordViewModelInputs { get }
    var outputs: RecordViewModelOutputs { get }
}

final class RecordViewModel: RecordViewModelInputs, RecordViewModelOutputs, RecordViewModelType {
    
    var inputs: RecordViewModelInputs { return self }
    var outputs: RecordViewModelOutputs { return self }
    
    var uploadImage: UIImage?
    var fileName: String = ""
 
    // output
    
    var albumData: BehaviorRelay<[AlbumEntity]> = BehaviorRelay<[AlbumEntity]>(value: [])
    var putImageSuccess: PublishSubject<Bool> = PublishSubject<Bool>()
    
    // input
    
    func getAlbum() {
        self.getAlbumAPI()
    }
    
    func deleteButtonTapped(idx: Int) {
        self.deleteAlbumAPI(id: idx)
    }
    
    func patchAlbum(image: UIImage) {
        self.uploadImage = image
        self.patchAlbumImageAPI()
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
    
    func patchAlbumImageAPI() {
        RecordService.shared.patchAlbumImageAPI { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<AlbumImageEntity> {
                    if let imageUrlData = data.data {
                        dump(imageUrlData)
                        self.fileName = imageUrlData.fileName
                        self.putImageAPI(serverUrl: imageUrlData.url)
                    }
                }
            default:
                break
            }
        }
    }
    
    func putImageAPI(serverUrl: String) {
        RecordService.shared.putAlbumAPI(img: self.uploadImage ?? UIImage(), serverUrl: serverUrl) { networkResult in
            switch networkResult {
            case 200:
                self.putImageSuccess.onNext(true)
            default:
                self.putImageSuccess.onNext(false)
            }
        }
    }
}
