//
//  SelectVideoViewController.swift
//  MobileAssignment
//
//  Created by Şevval Armağan on 24.01.2022.
//

import UIKit
import AVKit
import MobileCoreServices
import RealmSwift

class SelectVideoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func selectVideoButton(_ sender: Any) {
        VideoHelper.startMediaBrowser(delegate: self, sourceType: .savedPhotosAlbum)
    }
}

extension SelectVideoViewController: UIImagePickerControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        // 1
        guard
            let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String,
            mediaType == (kUTTypeMovie as String),
            let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL
        else { return }
        
        dismiss(animated: true) { [self] in
            let initViewController = self.storyboard!.instantiateViewController(withIdentifier: "PlayViewController")  as! PlayViewController
            initViewController.url = url
            self.present(initViewController, animated: false, completion: nil)
        }
    }
}

// MARK: - UINavigationControllerDelegate
extension SelectVideoViewController: UINavigationControllerDelegate {
}
