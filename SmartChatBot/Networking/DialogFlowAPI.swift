//
//  DialogFlowAPI.swift
//  SmartChatBot
//
//  Created by Kostis on 21/09/2018.
//  Copyright © 2018 Atcom. All rights reserved.
//

import Foundation
import ApiAI

class DialogFlowAPI {
    
    static func sendRequest(with text: String, completion: @escaping(String?) -> Void) {
        let request = ApiAI.shared().textRequest()
        request?.query = text
        
        request?.setMappedCompletionBlockSuccess({ (request, response) in
            guard let response = response as? AIResponse, let textResponse = response.result.fulfillment.speech else { print("invalid response from dialog flow api") ; return }
            guard let parameters = response.result.parameters as? Dictionary<String, AIResponseParameter> else { print("nil parameters found") ; return }
            guard let intent = response.result.metadata.intentName, let mlIntent = MLIntents.init(rawValue: intent) else { print("no intent found") ; return }
            
            switch mlIntent {
            case .create_booking: fullfillment(forCreateBookingWith: parameters)
            case .default_welcome: break
            case .default_fallback: break
            }
            
            completion(textResponse)
        }, failure: { (request, error) in
            print(error.debugDescription)
        })
        
        ApiAI.shared().enqueue(request)
    }
    
    static func fullfillment(forCreateBookingWith parameters: Dictionary<String, AIResponseParameter>) {
        guard let boatType = parameters["boatType"]?.stringValue, let numberOfPassengers = parameters["number"]?.numberValue as? Int else { print("not all required parameters fullfiled") ; return }
        
        let createBookingModel = CreateBookingModel(boatType: CreateBookingModel.BoatType.init(rawValue: boatType), numberOfPassengers: numberOfPassengers)
        // do here whatever you want with the data
    }
}
