//
//  PlayViewController.swift
//  MobileAssignment
//
//  Created by Şevval Armağan on 22.01.2022.
//

import UIKit
import AVFoundation
import RealmSwift

class PlayViewController: ViewController {
  
    @IBOutlet weak var videoView: UIView!
    var player: AVPlayer = AVPlayer()
    var playerLayer: AVPlayerLayer = AVPlayerLayer()
    var url: URL!
    var viewModel = ViewModel()
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var segmentLabel: UILabel!
    @IBOutlet weak var inOutLabel: UILabel!
    @IBOutlet weak var shotXLabel: UILabel!
    @IBOutlet weak var shotYLabel: UILabel!
    var data: Response?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circleView.layer.cornerRadius = 25
        setupUI()
        viewModel.fetch { [self]  response in
               data = response
              setData()
            }
        
        }
    private func setupUI(){
        setVideoView(url: url)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player.play()
   
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer.frame = videoView.bounds
    }
    
    func setVideoView(url: URL){
        player = AVPlayer(url: url)
        playerLayer = AVPlayerLayer(player: player)
        videoView.layer.addSublayer(playerLayer)
    }
    
    func setData(){
        
        DispatchQueue.main.async { [self] in
            
            let randomdata = Int.random(in: 0..<viewModel.response2!.data!.count)
            pointLabel.text = String(((viewModel.response2?.data![randomdata].shots![0].point)!))
            segmentLabel.text = String(((viewModel.response2?.data![randomdata].shots![0].segment)!))
            inOutLabel.text = String(((viewModel.response2?.data![randomdata].shots![0].inOut)!))
            shotXLabel.text = String(((viewModel.response2?.data![randomdata].shots![0].shotPosX)!))
            shotYLabel.text = String(((viewModel.response2?.data![randomdata].shots![0].shotPosY)!))
        }

    }
}
