//
//  WebRTCClient.swift
//  WeRTCVideoChatDemo
//
//  Created by Apple on 16/04/21.
//

import Foundation
import WebRTC

protocol WebRTCClientDelegate: AnyObject {
    func webRTCClient(_ client: WebRTCClient, sendData data: Data)

}

class WebRTCClient: NSObject{
    
    static let factory: RTCPeerConnectionFactory = {
        RTCInitializeSSL()
        var videoEncoderFactory = RTCDefaultVideoEncoderFactory()
        var videoDecoderFactory = RTCDefaultVideoDecoderFactory()
        
//        if TARGET_OS_SIMULATOR != 0 {
//            print("setup vp8 codec")
//            videoEncoderFactory = RTCSimluatorVideoEncoderFactory()
//            videoDecoderFactory = RTCSimulatorVideoDecoderFactory()
//        }
        
        return RTCPeerConnectionFactory(encoderFactory: videoEncoderFactory, decoderFactory: videoDecoderFactory)
    }()
    
    private let mediaConstraints = [kRTCMediaConstraintsOfferToReceiveAudio: kRTCMediaConstraintsValueTrue,
                                   kRTCMediaConstraintsOfferToReceiveVideo: kRTCMediaConstraintsValueTrue]
    
    weak var delegate: WebRTCClientDelegate?
    
    public var peerConnection: RTCPeerConnection?
    
    private var localVideoSource: RTCVideoSource?
    var localVideoTrack: RTCVideoTrack?
    private var videoCapturer: RTCVideoCapturer?
    var remoteVideoTrack: RTCVideoTrack?
    
    public var isConnected: Bool = false
    
    var audioTrack:RTCAudioTrack!
    
    var uv:LocalVideoCallingUV!
    
    var currentCandidate:RTCIceCandidate!
    
    override init() {
        super.init()
        setup()
    }
    
    func setup() {
     
        let rtcConf = RTCConfiguration()
        //rtcConf.iceServers = [RTCIceServer(urlStrings: ["stun:stun.l.google.com:19302"])]
   
        let userProfileJsonDict = (GeneralFunctions.getValue(key: Utils.USER_PROFILE_DICT_KEY) as! String).toDict().dictOf(Utils.message_str)
       
        let serverArray = userProfileJsonDict.arrOf("WEBRTC_ICE_SERVER_LIST")
        for i in 0..<serverArray.count{
            let dic = serverArray[i] as! NSDictionary
            if(dic.get("TURN_URL") == ""){
                rtcConf.iceServers.append(RTCIceServer.init(urlStrings: [dic.get("STUN_URL")], username: dic.get("USER_NAME"), credential: dic.get("Password")))
            }else{
                rtcConf.iceServers.append(RTCIceServer.init(urlStrings: [dic.get("STUN_URL"), dic.get("TURN_URL")], username: dic.get("USER_NAME"), credential: dic.get("Password")))
            }
            
        }
     
        rtcConf.sdpSemantics = RTCSdpSemantics.unifiedPlan
        let mediaConstraints = RTCMediaConstraints.init(mandatoryConstraints: nil, optionalConstraints: ["DtlsSrtpKeyAgreement": "true"]) //["DtlsSrtpKeyAgreement": "true"]
        peerConnection = WebRTCClient.factory.peerConnection(with: rtcConf, constraints: mediaConstraints, delegate: self)
       

        createMediaSenders()
        configureAudioSession()

    }
    
    private func onConnected(){
        self.isConnected = true
        

        DispatchQueue.main.async {
           // self.remoteRenderView?.isHidden = false
           // self.delegate?.didConnectWebRTC()
        }
    }
    
    
    
    private func createMediaSenders() {
        guard let peerConnection = peerConnection else {
            print("Check PeerConnection")
            return
        }
        
        let constraints = RTCMediaConstraints(mandatoryConstraints: [:], optionalConstraints: nil)
        let audioSource = WebRTCClient.factory.audioSource(with: constraints)
        self.audioTrack = WebRTCClient.factory.audioTrack(with: audioSource, trackId: "ARDAMSa0")
        
        let mediaTrackStreamIDs = ["ARDAMS"]
        
        peerConnection.add(audioTrack, streamIds: mediaTrackStreamIDs)
        
        let videoSource = WebRTCClient.factory.videoSource()
        localVideoSource = videoSource
        let videoTrack = WebRTCClient.factory.videoTrack(with: videoSource, trackId: "ARDAMSv0")
        localVideoTrack = videoTrack
        videoCapturer = RTCCameraVideoCapturer(delegate: videoSource)

        peerConnection.add(videoTrack, streamIds: mediaTrackStreamIDs)

        remoteVideoTrack = peerConnection.transceivers.first { $0.mediaType == .video }?.receiver.track as? RTCVideoTrack
        

       
    }
    
    func routeChange(_ n: Notification) {
        
        
        if(AVAudioSession.sharedInstance().isHeadphonesConnected || AVAudioSession.sharedInstance().isOtherDeviceConnected){
            if(self.uv != nil){
                self.uv.speakerImgTapped = true
                self.uv.speakerTapped(makeOn: false)
            }
            
            return
        }
        
        
        guard let info = n.userInfo,
            let value = info[AVAudioSessionRouteChangeReasonKey] as? UInt,
            let reason = AVAudioSession.RouteChangeReason(rawValue: value) else {
            if(self.uv != nil){
                self.uv.speakerImgTapped = true
                self.uv.speakerTapped(makeOn: true)
            }
            
            try? AVAudioSession.sharedInstance().overrideOutputAudioPort(.speaker)
            return
            
        }
        

        print("UVVV:\(String(describing: self.uv))")
        if(self.uv != nil && (self.uv.speakerImgTapped == true || (self.uv.isSpeakerOn == false && reason.rawValue != 2))){
            self.uv.speakerImgTapped = false
            return
        }
       
        print("Route Change:\(reason.rawValue)")
        switch reason {
        case .newDeviceAvailable:
            if(self.uv != nil){
                self.uv.speakerImgTapped = true
                self.uv.speakerTapped(makeOn: false)
            }
            
            try? AVAudioSession.sharedInstance().overrideOutputAudioPort(.none)
        case .oldDeviceUnavailable:
            if(self.uv != nil){
                self.uv.speakerImgTapped = true
                self.uv.speakerTapped(makeOn: true)
            }
            
            try? AVAudioSession.sharedInstance().overrideOutputAudioPort(.speaker)
        case .categoryChange:
            if(self.uv != nil){
                self.uv.speakerImgTapped = true
                self.uv.speakerTapped(makeOn: true)
            }
            
            try? AVAudioSession.sharedInstance().overrideOutputAudioPort(.speaker)
      
        default:
            if(self.uv != nil){
                self.uv.speakerImgTapped = true
                self.uv.speakerTapped(makeOn: true)
            }
            
            try? AVAudioSession.sharedInstance().overrideOutputAudioPort(.speaker)
            break
        }
    }
    
    public func configureAudioSession() {
        let audioSession = RTCAudioSession.sharedInstance()
        
        audioSession.lockForConfiguration()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord.rawValue)
            try audioSession.setMode(AVAudioSession.Mode.voiceChat.rawValue)
            try audioSession.overrideOutputAudioPort(.none)
            try audioSession.setActive(true)
        } catch let error {
            print("Error changeing AVAudioSession category: \(error)")
        }
        audioSession.unlockForConfiguration()
        
        NotificationCenter.default.addObserver(forName: AVAudioSession.routeChangeNotification, object: nil, queue: nil, using: routeChange)
    }
    
    func didCaptureLocalFrame(_ videoFrame: RTCVideoFrame) {
        guard let videoSource = localVideoSource,
            let videoCapturer = videoCapturer else { return }
        
        videoSource.capturer(videoCapturer, didCapture: videoFrame)
    }
    
    func setupLocalRenderer(_ renderer: RTCVideoRenderer) {
        guard let localVideoTrack = localVideoTrack else {
            print("Check Local Video track")
            return
        }
        
        localVideoTrack.add(renderer)
    }
    
    func setupRemoteRenderer(_ renderer: RTCVideoRenderer) {
        guard let remoteVideoTrack = remoteVideoTrack else {
            print("Check Remote Video track")
            return
        }
        
        remoteVideoTrack.add(renderer)
    }
    
    func offer() {
        guard let peerConnection = peerConnection else {
            print("--No Peer Connection--")
            return
        }
        
        peerConnection.offer(for: RTCMediaConstraints(mandatoryConstraints: mediaConstraints, optionalConstraints: nil), completionHandler: { [weak self](sdp, error) in
            guard self != nil else {
                return
                
            }
            
            guard sdp != nil else {
                if let error = error {
                    print(error)
                }
                return
            }
           
            self?.setLocalSDP(sdp!)
        })
    }
    
    func setLocalSDP(_ sdp: RTCSessionDescription) {
        guard let peerConnection = peerConnection else {
            print("Check PeerConnection")
            return
        }
        
        peerConnection.setLocalDescription(sdp, completionHandler: { (error) in
            if let error = error {
                debugPrint(error)
            }
        })
        
        if let data = sdp.JSONData() {
            self.delegate?.webRTCClient(self, sendData: data)
            print("Send Local SDP")
        }
    }
    
    func addCandidate(candidate:RTCIceCandidate){
        guard let peerConnection = peerConnection else {
            print("Check Peer connection")
            return
        }
        peerConnection.add(candidate)
    }
    
    func handleRemoteDescription(_ desc: RTCSessionDescription) {
        guard let peerConnection = peerConnection else {
            print("Check Peer connection")
            return
        }
        
       // hasReceivedSdp = true
        
        peerConnection.setRemoteDescription(desc, completionHandler: { [weak self](error) in
            if let error = error {
                print(error)
            }

            if desc.type == .offer,
                self?.peerConnection?.localDescription == nil {
                self?.answer()
            }
        })
    }
    
    private func answer() {
        guard let peerConnection = peerConnection else {
            print("Check PeerConnection")
            return
        }

        print("WebRTC Answer.")
        peerConnection.answer(for: RTCMediaConstraints(mandatoryConstraints: mediaConstraints, optionalConstraints: nil),
                               completionHandler: { [weak self](sdp, error) in
                                guard let sdp = sdp else {
                                    if let error = error {
                                        print(error)
                                    }
                                    return
                                }
                                self?.setLocalSDP(sdp)
        })
    }

    
}

extension RTCSessionDescription {
    func JSONData() -> Data? {
        let typeStr = RTCSessionDescription.string(for: self.type)
        let dict = ["type": typeStr,
                    "description": self.sdp]
        return dict.JSONData
    }
}

extension String {
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
        return nil
    }
}

extension Dictionary {
    var JSONData: Data? {
        guard let data = try? JSONSerialization.data(withJSONObject: self,
                                                            options: [.prettyPrinted]) else {
            return nil
        }
        return data
    }
}

extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}

extension WebRTCClient: RTCPeerConnectionDelegate {
    func peerConnection(_ peerConnection: RTCPeerConnection, didChange stateChanged: RTCSignalingState) {
       
        
        print("signaling state changed:\(stateChanged)" )
    }
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceConnectionState) {
        print("--Peer didChange newState--:\(newState.rawValue)")
        
        switch newState {
        case .connected, .completed:
            if !self.isConnected {
                self.onConnected()
            }
        case .failed:
            if(self.uv != nil && self.uv.webRTCClient != nil){
                DispatchQueue.main.async {
                    self.uv.callEndViewSetup()
                }
                
            }
        default:
            if self.isConnected{
                //self.onDisConnected()
            }
        }
    }
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didAdd stream: RTCMediaStream) {
        print("did add stream")
      
    }
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didGenerate candidate: RTCIceCandidate) {
        print("--Peer didGenerate candidatel--")
        self.currentCandidate = candidate
        guard let message = candidate.JSONData() else { return }
        delegate?.webRTCClient(self, sendData: message)
    }
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didRemove stream: RTCMediaStream) {
        print("--- did remove stream ---")
    }
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didOpen dataChannel: RTCDataChannel) {
        
        print("--Peer didOpen dataChannel--")
       // self.remoteDataChannel = dataChannel
       // self.delegate?.didOpenDataChannel()
    }
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didRemove candidates: [RTCIceCandidate]) {
        print("--Peer didRemove candidates--")
    }
    
    func peerConnectionShouldNegotiate(_ peerConnection: RTCPeerConnection) {
        print("--Peer ShouldNegotiate--")
    }
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceGatheringState) {
        
        print("--Peer Gathering State--")
    }
}

// For Simulator Video Factory
class RTCSimluatorVideoEncoderFactory: RTCDefaultVideoEncoderFactory {
    
    override init() {
        super.init()
    }
    
    override class func supportedCodecs() -> [RTCVideoCodecInfo] {
        var codecs = super.supportedCodecs()
        codecs = codecs.filter{$0.name != "H264"}
        return codecs
    }
}

class RTCSimulatorVideoDecoderFactory: RTCDefaultVideoDecoderFactory {
    
    override init() {
        super.init()
    }
    
    override func supportedCodecs() -> [RTCVideoCodecInfo] {
        var codecs = super.supportedCodecs()
        codecs = codecs.filter{$0.name != "H264"}
        return codecs
    }
}


extension RTCIceCandidate {
    func JSONData() -> Data? {
        let dict = ["type": "candidate",
                    "sdpMLineIndex": "\(self.sdpMLineIndex)",
                    "sdpMid": self.sdpMid,
                    "sdp": self.sdp
        ]
        return dict.JSONData
    }

    static func candidate(from: [String: Any]) -> RTCIceCandidate? {
        let sdp = from["sdp"] as? String
        let sdpMid = from["sdpMid"] as? String
        let labelStr = from["sdpMLineIndex"] as? String
        let label = (from["label"] as? Int32) ?? 0
        
        return RTCIceCandidate(sdp: sdp ?? "", sdpMLineIndex: Int32(labelStr ?? "") ?? label, sdpMid: sdpMid)
    }
}

extension AVAudioSession {

    static var isHeadphonesConnected: Bool {
        return sharedInstance().isHeadphonesConnected
    }

    var isHeadphonesConnected: Bool {
        
        return !currentRoute.outputs.filter { $0.isHeadphones }.isEmpty
    }
        
    var isOtherDeviceConnected: Bool {
        for output in currentRoute.outputs{
            if(output.description == AVAudioSession.Port.bluetoothLE.rawValue || output.description == AVAudioSession.Port.bluetoothHFP.rawValue || output.description == AVAudioSession.Port.bluetoothHFP.rawValue || output.description == AVAudioSession.Port.HDMI.rawValue || output.description == AVAudioSession.Port.bluetoothA2DP.rawValue || output.description == AVAudioSession.Port.carAudio.rawValue || output.description == AVAudioSession.Port.usbAudio.rawValue){
                return true
            }
        }
        
        return false
    }

}

extension AVAudioSessionPortDescription {
    var isHeadphones: Bool {
        return portType == AVAudioSession.Port.headphones
    }
}
