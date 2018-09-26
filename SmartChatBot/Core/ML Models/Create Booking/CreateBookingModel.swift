//
//  CreateBookingModel.swift
//  SmartChatBot
//
//  Created by Kostis on 24/09/2018.
//  Copyright © 2018 Atcom. All rights reserved.
//

import Foundation

class CreateBookingModel {
    
    enum BoatType: String {
        case sailing = "sailing boat"
        case inflatable = "inflatable boat"
    }
    
    var boatType: BoatType?
    var numberOfPassengers: Int?
    
    init(boatType: BoatType?, numberOfPassengers: Int?) {
        self.boatType = boatType
        self.numberOfPassengers = numberOfPassengers
    }
}
