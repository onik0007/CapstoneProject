//
//  Order.swift
//  EventEaseCrowdCotrol
//
//  Created by Kino Porteous on 5/12/23.
//

import SwiftUI

class Order: ObservableObject {
    @Published var items = [Party]()
    
    /*var total : Float {
        if items.count > 0 {
            return items.reduce(0) { $0 + $1.cost}
        }else {
            return 0
        }
    }*/
    func add(item: Party) {
        items.append(item)
    }
    func remove(item: Party){
        if let index = items.firstIndex(of: item){
            items.remove(at: index)
        }
    }
    func getPrice(value: Float)->String{
        let format = NumberFormatter()
        format.numberStyle = .currency
        return format.string(from: NSNumber(value: value)) ?? ""
    }
}
