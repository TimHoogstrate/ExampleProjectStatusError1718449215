//
//  AudioSample.swift
//  Apple4ChannelBug
//
//  Created by Tim Hoogstrate on 22/03/2019.
//  Copyright © 2019 Tim Hoogstrate. All rights reserved.
//

import UIKit

public struct AudioSample {
    public var channels:UInt32 = 0
    public var sampleRate:Float64 = 0
    public var audioData:[UInt8] = []
}
