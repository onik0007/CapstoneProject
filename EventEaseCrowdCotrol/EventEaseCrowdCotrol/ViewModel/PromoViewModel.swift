//
//  PromoViewModel.swift
//  EventEaseCrowdCotrol
//
//  Created by Kino Porteous on 5/15/23.
//

import Foundation
//import SwiftUI

class PromoViewModel: ObservableObject {
    var x :[String] = []
    func forecast(similarity_score: Double, attendees: Double, parking: Double) -> String{
        let lower_range_score = similarity_score / 3
        let upper_range_score = (similarity_score / 3) + 1
        
        let attendees_forcastupper = String(format: "%.f",((attendees * upper_range_score) / 1.7) / 100)
        let attendees_forcastlower = String(format: "%.f",((attendees * lower_range_score) / 1.2) / 100)
        
        let parking_forcastupper = String(format: "%.f",((parking * upper_range_score) / 2.1) / 100)
        let parking_forcastlower = String(format: "%.f",((parking * lower_range_score) / 2.7) / 100)
        
        return  "Attendee: \(attendees_forcastupper) - \(attendees_forcastlower)  Parking: \(parking_forcastlower) - \(parking_forcastupper)"
    }
    func cosineSimilarity(vectorA: [Double], vectorB: [Double]) -> Double {
        // Ensure both vectors have the same length
        guard vectorA.count == vectorB.count else {
            fatalError("Vectors must have the same length")
        }
        
        // Calculate the dot product of the vectors
        let dotProduct = zip(vectorA, vectorB).map { $0 * $1 }.reduce(0, +)
        
        // Calculate the magnitudes of the vectors
        let magnitudeA = sqrt(vectorA.map { $0 * $0 }.reduce(0, +))
        let magnitudeB = sqrt(vectorB.map { $0 * $0 }.reduce(0, +))
        
        // Calculate the cosine similarity
        let similarity = dotProduct / (magnitudeA * magnitudeB)
        
        return similarity
    }
    ///*******************************************************************
    func cosineSim(A: [Double], B: [Double]) -> Double {
        return dot(A: A, B: B) / (magnitude(A: A) * magnitude(A: B))
    }
    
    /** Dot Product **/
    func dot(A: [Double], B: [Double]) -> Double {
        var x: Double = 0
        for i in 0...A.count-1 {
            x += A[i] * B[i]
        }
        return x
    }
    
    /** Vector Magnitude **/
    func magnitude(A: [Double]) -> Double {
        var x: Double = 0
        for elt in A {
            x += elt * elt
        }
        return sqrt(x)
    }
    // sentence converrter
    func convertSentenceToVector(sentence: String, vocabulary: [String]) -> [Double] {
        var vector = [Double](repeating: 0.0, count: vocabulary.count)
        
        let words = sentence.lowercased().components(separatedBy: " ")
        for word in words {
            if let index = vocabulary.firstIndex(of: word) {
                vector[index] += 1.0
            }
        }
        return vector
    }

    func randomPercentage() -> Double {
        let randomValue = Double.random(in: 0.3...0.75)
           return randomValue * 100
       }
    // words to sentence
    func vecToSentence(party_cost:String,selected_theme: String, selected_parish:String, isHoliday:String, wakeup:String) -> String{
        let x = "\(party_cost)" + " " + "\(selected_theme)" + " " + "\(selected_parish)" + " " + "\(isHoliday)" + " " + "\(wakeup)"
    return x
    }
    // converts sentences to all words
    func extractWords(sentence1: String, sentence2: String) -> [String] {
        var words = Set<String>()
        
        let components1 = sentence1.components(separatedBy: .whitespaces)
        let components2 = sentence2.components(separatedBy: .whitespaces)
        
        for component in components1 {
            if !component.isEmpty {
                words.insert(component)
            }
        }
        
        for component in components2 {
            if !component.isEmpty {
                words.insert(component)
            }
        }
        
        return Array(words)
    }
    func getDayOfWeek(_ date: Date) -> String? {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: date)
            
        return components.weekday.flatMap { weekday in calendar.weekdaySymbols[safe: weekday - 1]?.capitalized
            }
    }
}
extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
