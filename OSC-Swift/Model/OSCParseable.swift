//
//  OSCParseable.swift
//  OSC-Swift
//
//  Created by awd on 2017/12/19.
//  Copyright © 2017年 awd. All rights reserved.
//

import Foundation
import Ono

protocol OSCParseable {
    init(_ xml:ONOXMLElement)
    //func parseRootElement(xml:AEXMLDocument) -> [AEXMLElement]
}

class OSCBaseModel : OSCParseable {
    init(){}
    required init(_ xml:ONOXMLElement) {
        assert(false, "override this")
    }
}
