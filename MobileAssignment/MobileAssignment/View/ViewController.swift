//
//  ViewController.swift
//  MobileAssignment
//
//  Created by Şevval Armağan on 20.01.2022.
//
import MobileCoreServices
import UIKit
import AVKit

class ViewController: UIViewController {
    
    @objc func video(
        _ videoPath: String,
        didFinishSavingWithError error: Error?,
        contextInfo info: AnyObject
    ) {
        let title = (error == nil) ? "Success" : "Error"
        let message = (error == nil) ? "Video was saved" : "Video failed to save"
        
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(
            title: "OK",
            style: UIAlertAction.Style.cancel,
            handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func record(_ sender: AnyObject) {
        VideoHelper.startMediaBrowser(delegate: self, sourceType: .camera)
    }
    @IBAction func playVideo(_ sender: AnyObject) {
        let initViewController = self.storyboard!.instantiateViewController(withIdentifier: "SelectVideoViewController")  as! SelectVideoViewController
            self.present(initViewController, animated: false, completion: nil)


    }
    
}

// MARK: - UIImagePickerControllerDelegate
extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        dismiss(animated: true, completion: nil)
        
        guard
            let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String,
            mediaType == (kUTTypeMovie as String),
            let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL,
            UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path)
        else { return }
        
        // Handle a movie capture
        UISaveVideoAtPathToSavedPhotosAlbum(
            url.path,
            self,
            #selector(video(_:didFinishSavingWithError:contextInfo:)),
            nil)
        }
    }

// MARK: - UINavigationControllerDelegate
extension ViewController: UINavigationControllerDelegate {
}
