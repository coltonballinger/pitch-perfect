//
//  RecordedAudio.swift
//  Pitch Perfect II
//
//  Created by Ballinger, Colton J. on 3/5/15.
//  Copyright (c) 2015 Ballinger, Colton J. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    
    var Title: String!
    var filePathUrl: NSURL!
    
    init(Title: String, filePathUrl: NSURL) {
        
        self.Title = Title
        self.filePathUrl = filePathUrl
    }
}
