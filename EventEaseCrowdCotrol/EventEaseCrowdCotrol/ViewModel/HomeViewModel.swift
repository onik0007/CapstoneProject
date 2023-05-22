//
//  HomeViewModel.swift
//  EventEaseCrowdCotrol
//
//  Created by Kino Porteous on 4/4/23.
//

import SwiftUI

import SwiftUI
import CoreLocation

class HomeViewModel : NSObject, ObservableObject, CLLocationManagerDelegate{
    @Published var search = ""
    @Published var items : [Party] = []
    //@Published var filtered : [Party] = []        // used for searching party
    @Published var cartItems : [Cart] = []
   /*
    @Published var locationManager = CLLocationManager()
    @Published var userLocation : CLLocation!
    @Published var noLocation = false
    
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    
        // checking Location Access....
        
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("authorized")
            self.noLocation = false
            manager.requestLocation()
        case .denied:
            print("denied")
            self.noLocation = true
        default:
            print("unknown")
            self.noLocation = false
            // Direct Call
            locationManager.requestWhenInUseAuthorization()
            // Modifying Info.plist...
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // reading User Location And Extracting Details....
        
        self.userLocation = locations.last
        //self.extractLocation()
        // after Extracting Location Logging In....
        //self.login()
    }
    */
    
    func addItem1(item: Party) {
        // Check if the item is already in the cart
        if let index = items.firstIndex(where: { $0.title == item.title }) {
            // If it is, update the quantity
            items[index].quantity += item.quantity
        } else {
            // Otherwise, add the item to the cart
            items.append(item)
        }
    }
    
    func calculateTotalPrice()->String{
        var price : Float = 0
        cartItems.forEach{(item) in
            price += Float(item.quantity) * Float(truncating: item.item.cost as NSNumber)
        }
        return getPrice(value: price)
    }
    func getPrice(value: Float)->String{
        let format = NumberFormatter()
        format.numberStyle = .currency
        return format.string(from: NSNumber(value: value)) ?? ""
    }
    
    func addToCart(item: Party){
        
        self.items[getIndex(item: item, isCartIndex: false)].isAdded = !item.isAdded
        //self.filtered[getIndex(item: item, isCartIndex: false)].isAdded = !item.isAdded
        
        if item.isAdded{
            self.cartItems.remove(at: getIndex(item: item, isCartIndex: true))
            return
        }
        self.cartItems.append(Cart(item: item, quantity: 1))
    }
    func getIndex(item: Party, isCartIndex: Bool) -> Int {
        let index = self.items.firstIndex{ (item1) -> Bool in
            return item.id == item1.id
        } ?? 0
        let cartIndex = self.cartItems.firstIndex{ (item1) -> Bool in
            
            return item.id == item1.item.id
        } ?? 0
        
        return isCartIndex ? cartIndex : index
    }
}
