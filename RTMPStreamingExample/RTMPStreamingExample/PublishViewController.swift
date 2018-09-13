//
//  ViewController.swift
//  RTMPStreamingExample
//
//  Created by Bastek on 9/11/18.
//  Copyright © 2018 PeerStream, Inc. All rights reserved.
//

import UIKit
import AVFoundation
import HaishinKit
import VideoToolbox


class PublishViewController: UIViewController {

    let rtmpConnection:RTMPConnection = RTMPConnection()
    var rtmpStream: RTMPStream?


    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            self.rtmpStream = RTMPStream(connection: self.rtmpConnection)
            guard let rtmpStream = self.rtmpStream else { return }

            rtmpStream.syncOrientation = true
            rtmpStream.captureSettings = [
                "sessionPreset": AVCaptureSession.Preset.hd1280x720.rawValue,
                "continuousAutofocus": true,
                "continuousExposure": true
            ]
            rtmpStream.videoSettings = [
                "width": 720,
                "height": 1280
            ]
            rtmpStream.audioSettings = [
                "sampleRate": 44_100
            ]

            rtmpStream.attachAudio(AVCaptureDevice.default(for: AVMediaType.audio)) { error in
                print(">>> ATTACH AUDIO ERROR: \(error)")
            }
            rtmpStream.attachCamera(DeviceUtil.device(withPosition: .back)) { error in
                print(">>> ATTACH CAMERA ERROR: \(error)")
            }

            let hkView = GLHKView(frame: self.view.bounds)
            hkView.videoGravity = AVLayerVideoGravity.resizeAspectFill
            hkView.attachStream(rtmpStream)

            // add ViewController#view
            self.view.insertSubview(hkView, at: 0)

            self.rtmpConnection.connect("rtmp://192.168.86.244/oflaDemo")
            rtmpStream.publish("test")
        }
    }


    @IBAction func onClose(_ sender: UIButton) {
        rtmpStream?.close()
        rtmpConnection.close()

        self.dismiss(animated: true) {
        }
    }
}

