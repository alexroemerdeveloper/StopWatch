//
//  RoundedButton.swift
//  StopWatch
//
//  Created by Alexander Römer on 21.12.19.
//  Copyright © 2019 Alexander Römer. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

  override func awakeFromNib() {
        layer.cornerRadius = frame.size.height/2
    }
}
