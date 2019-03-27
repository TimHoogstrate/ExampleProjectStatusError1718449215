//
//  AudioDecoder.swift
//  Apple4ChannelBug
//
//  Created by Tim Hoogstrate on 22/03/2019.
//  Copyright © 2019 Tim Hoogstrate. All rights reserved.
//

import UIKit
import CoreAudio
import AudioToolbox
import AVFoundation

public class TSAudioDecoder {
    
    private var sampleRate:Float64 = 44100
    private var numberOfChannels:UInt32 = 1
    
    private(set) var status: OSStatus = noErr {
        didSet {
            if status != noErr {
                if status == 1718449215 {
                    print("Audio decoder status:  \(self.status) \(numberOfChannels) channel audio")
                } else {
                    print("Audio decoder status:  \(self.status)")
                }
            }
        }
    }
    
    private var outputCallback: AudioQueueOutputCallback = {(
        
        inUserData: UnsafeMutableRawPointer?,
        inAQ: AudioQueueRef,
        inBuffer: AudioQueueBufferRef) in
        print("Finished playing audio sample")
    }
    
    var counter = 0
    
    public func addAudioSamplesToQueue(audioSample: AudioSample) {
        if queue == nil {
            return
        }
        
        guard buffers.count > 0 else {
            return
        }
        
        let buffer = buffers[counter]
        
        // Copy encoded data into AudioQueue memory
        memcpy(buffer!.pointee.mAudioData, audioSample.audioData, audioSample.audioData.count)
        // Create audioStreamPacketDexcription to go along with this packet.
        var description = AudioStreamPacketDescription.init(mStartOffset: 0,
                                                            mVariableFramesInPacket: 1024,
                                                            mDataByteSize: UInt32(audioSample.audioData.count))
        // Set the encoded data size on the buffer
        buffer!.pointee.mAudioDataByteSize = UInt32(audioSample.audioData.count)
        // Enqueue buffer into decoder
        status = AudioQueueEnqueueBuffer(queue!, buffer!, 1, UnsafeMutablePointer<AudioStreamPacketDescription>(&description))
        
        counter+=1
        
        if counter == defaultNumberOfBuffers {
            counter = 0
        }
    }
    
    public func startSession(audioSample: AudioSample) {
        setParameters(audioSample: audioSample)
        initializeForAudioQueue()
        startQueueIfNeed()
        if buffers.count != defaultNumberOfBuffers {
            createBuffers()
        }
        addAudioSamplesToQueue(audioSample:audioSample)
    }
    
    private func setParameters(audioSample: AudioSample) {
        numberOfChannels = audioSample.channels
        sampleRate = audioSample.sampleRate
    }
    
    func initializeForAudioQueue() {
        fileTypeHint = kAudioFileAAC_ADTSType
        var inDesc = AudioStreamBasicDescription(mSampleRate: sampleRate, mFormatID: kAudioFormatMPEG4AAC, mFormatFlags: 0, mBytesPerPacket: 0, mFramesPerPacket: 1024, mBytesPerFrame: 0, mChannelsPerFrame: numberOfChannels, mBitsPerChannel: 0, mReserved: 0)
        var queue: AudioQueueRef? = nil
        
        status = AudioQueueNewOutput(
            &inDesc,
            outputCallback,
            unsafeBitCast(self, to: UnsafeMutableRawPointer.self),
            nil,
            CFRunLoopMode.commonModes.rawValue,
            0,
            &queue)
        
//        print("BUFFERS MADE STATUS: \(status)")
        self.queue = queue
    }
    
    private var queue: AudioQueueRef? = nil
    
    func startQueueIfNeed() {
        guard let queue: AudioQueueRef = queue else {
            return
        }
        status = AudioQueuePrime(queue, 0, nil)
        status = AudioQueueStart(queue, nil)
        print("AudioQueueStart: \(status)")
    }
    
    
    
    func createBuffers() {
        guard queue != nil else {
            return
        }
        if buffers.count != defaultNumberOfBuffers {
            for _ in 0..<defaultNumberOfBuffers {
                var buffer: AudioQueueBufferRef? = nil
                status = AudioQueueAllocateBuffer(queue!, defaultBufferSize, &buffer)
                
                if status != 0 {
                    return
                }
                buffers.append(buffer)
            }
        }
    }
    
    private var started: Bool = false
    var runloop: CFRunLoop?
    let defaultNumberOfBuffers: Int = 128
    let defaultBufferSize: UInt32 = 128 * 5000
    private var buffers: [AudioQueueBufferRef?] = []

    private var current: Int = 0
    private var packetDescriptions: [AudioStreamPacketDescription] = []
    
    private var fileStreamID: AudioFileStreamID? = nil
    
    var fileTypeHint: AudioFileTypeID?
}
