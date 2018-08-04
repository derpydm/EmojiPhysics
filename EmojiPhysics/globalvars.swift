//
//  globalvars.swift
//  EmojiPhysics
//
//  Created by Sean on 4/8/18.
//  Copyright © 2018 Sean. All rights reserved.
//

import Foundation
var selectedEmoji = 0
struct EmojiTheme {
    var title: String
    var emojis: [Character]
}
var emojis = [EmojiTheme(title: "Classic", emojis:["😂","🐒","👩🏼‍🎓","👦🏻","😱","😅","💩"]), EmojiTheme(title: "Modern", emojis:["😂","🐒","💩"]), EmojiTheme(title: "Another", emojis:["😂","🐒","🐧"])]
