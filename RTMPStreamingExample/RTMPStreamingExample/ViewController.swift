//
//  ViewController.swift
//  RTMPStreamingExample
//
//  Created by Bastek on 9/11/18.
//  Copyright © 2018 PeerStream, Inc. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // mandatory initial audio setup (not sure why this isn't wrapped in a framework??)
        let session: AVAudioSession = AVAudioSession.sharedInstance()
        do {
            try session.setPreferredSampleRate(44_100)
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .allowBluetooth)
            try session.setMode(AVAudioSessionModeDefault)
            try session.setActive(true)
        } catch {}
    }
}

