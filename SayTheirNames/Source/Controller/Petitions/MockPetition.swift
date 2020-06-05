//
//  MockPetition.swift
//  Say Their Names
//
//  Copyright (c) 2020 Say Their Names Team (https://github.com/Say-Their-Name)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

/// This is a mock PresentedPetition implementation  that's meant to be used to test the layout of PetitionCollectionViewCell
///
/// Once we have real data coming from the server, this will not be needed
///
/// It uses data from the Figma page
struct MockPetition: PresentedPetition {
    
    let title: String
    
    var summary: String { "Following the tragic news surrounding the murder of George Floyd by Minneapolis police officers…" }
    
    var image: UIImage? {
        hasImage ? UIImage(named: "Group 6") : nil
    }
    
    let isVerified: Bool
    let hasImage: Bool
    
    init(title: String, verified: Bool, hasImage: Bool) {
        self.title = title
        self.isVerified = verified
        self.hasImage = hasImage
    }
}
