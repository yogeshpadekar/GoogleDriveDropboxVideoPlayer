//
//  ViewController.swift
//  GoogleDriveDropboxVideoPlayer
//
//  Created by Yogesh on 30/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController, UIDocumentPickerDelegate {
    
    @IBOutlet weak private var txtURL: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
  // MARK: - == User Defined Methods ==
    @IBAction func loadMoviewPlayerFullScreen() {
        if !(self.txtURL?.text?.isEmpty ?? false) {
        var strmPlayerURL = self.txtURL?.text
            if (strmPlayerURL?.contains("dropbox.com") ?? false), (strmPlayerURL?.hasSuffix("?dl=0") ?? false) {
              strmPlayerURL = strmPlayerURL?.replacingOccurrences(of: "?dl=0", with: "?raw=1")
            } else if (strmPlayerURL?.contains("drive.google.com") ?? false), (strmPlayerURL?.contains("file/d/") ?? false), let arrURLComponents = strmPlayerURL?.components(separatedBy:
                "file/d/"), arrURLComponents.count > 1 {
                let strURLPrefix = arrURLComponents.first
                let strVideoId = arrURLComponents[1].components(separatedBy: "/").first
                strmPlayerURL = (strURLPrefix ?? "") + "uc?export=open&id=" + (strVideoId ?? "")
            }
            print("player url = \(String(describing: strmPlayerURL))")
        let moviePlayer = AVPlayer(url: URL(string: strmPlayerURL ?? "https://www.google.com")!)
            let moviePlayerController = AVPlayerViewController()
            moviePlayerController.player = moviePlayer
            moviePlayerController.view.backgroundColor = UIColor.white
        
            moviePlayerController.player?.play()
            moviePlayerController.modalPresentationStyle = .fullScreen
            self.present(moviePlayerController, animated: false) {}
        }
    }

}

