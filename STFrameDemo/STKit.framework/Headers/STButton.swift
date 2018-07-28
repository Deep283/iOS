//
//  STButton.swift
//  STKit
//
//  Created by vinay shinde on 17/12/17.
//  Copyright © 2017 vinay shinde. All rights reserved.
//

import UIKit
open class STButton: UIButton {

    public var action: (() -> ())?
     
    
    public init(x1: Int,y1: Int) {
            super.init(frame: CGRect(x: x1, y: y1, width: 343, height: 50))
        sharedInit()
        }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
        }
    private func sharedInit() {
        addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
    }
    
    @objc private func touchUpInside() {
        action?()
    }
    
}
