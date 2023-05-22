//
//  CoSineIndex.swift
//  EventEaseCrowdCotrol
//
//  Created by Kino Porteous on 5/16/23.
//

import SwiftUI
import NaturalLanguage

struct CoSineIndex: View {
    
    @EnvironmentObject private var pvm: PromoViewModel
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack {
            Text("Similarity index")
                .padding()
                .foregroundColor(.black)
            
            let dayOfWeek = pvm.getDayOfWeek(userData.selected_wakeup)
            
            List {
                ForEach(sampleParty, id: \.self) { item in
                    let sentence1 = pvm.vecToSentence(party_cost: "\(item.cost)", selected_theme: item.party_theme, selected_parish: item.party_parish, isHoliday: "\(item.isHoliday)", wakeup: item.day)
                    
                    let sentence2 = pvm.vecToSentence(party_cost: "\(userData.selected_party_cost)", selected_theme: userData.selected_theme, selected_parish: userData.selected_parish, isHoliday: "\(userData.selected_isHoliday)", wakeup: dayOfWeek ?? "Saturday")
                    
                    let allWordsVec = pvm.extractWords(sentence1: sentence1, sentence2: sentence2)
                    let vec1 = pvm.convertSentenceToVector(sentence: sentence1, vocabulary: allWordsVec)
                    let vec2 = pvm.convertSentenceToVector(sentence: sentence2, vocabulary: allWordsVec)
                    
                    let similarity = (pvm.cosineSim(A: vec1, B: vec2)) * 100
                    let simF = String(format: "%.2f", similarity)
                    
                    if similarity > 50 {
                        HStack {
                            Image(item.image)
                                .resizable()
                                .frame(width: 120, height: 120)
                                .cornerRadius(10)
                            
                            Spacer()
                            
                            HStack {
                                Text("Compared to - \(item.title)")
                                Text("\(simF)%")
                            }
                        }
                        Text("Event Forecast:  ")
                            .font(.headline)
                        let forecast = pvm.forecast(similarity_score: similarity, attendees: Double(item.attendees), parking: Double(item.attendees))
                        Text(forecast)
                            .font(.subheadline)
                    }
                }
            }
        }

        /*
        VStack {
            Text("Similarity index")
                .padding()
                .foregroundColor(.black)
            let dayOfWeek = pvm.getDayOfWeek(userData.selected_wakeup)
            List {
                ForEach(sampleParty, id: \.self) { item in
                    let sentence1 = pvm.vecToSentence(party_cost: "\(item.cost)", selected_theme: item.party_theme, selected_parish: item.party_parish, isHoliday: "\(item.isHoliday)", wakeup: item.day)
                    let sentence2 = pvm.vecToSentence(party_cost: "\(userData.selected_party_cost)", selected_theme: userData.selected_theme, selected_parish: userData.selected_parish, isHoliday: "\(userData.selected_isHoliday)", wakeup: dayOfWeek ?? "Saturday")//wakeup: "\(userData.selected_wakeup)")
                    
                    let allWordsVec = pvm.extractWords(sentence1: sentence1, sentence2: sentence2)
                    
                    let vec1 = pvm.convertSentenceToVector(sentence: sentence1, vocabulary: allWordsVec)
                    let vec2 = pvm.convertSentenceToVector(sentence: sentence2, vocabulary: allWordsVec)
                    
                    //let similarity = (pvm.cosineSimilarity(vectorA: vec1, vectorB: vec2))
                    let similarity = (pvm.cosineSim(A: vec1, B: vec2) ) * 100
                    //let simF = NumberFormatter().string(from: similarity as NSNumber)
                    let simF = String(format: "%.2f", similarity)
                    
                    if similarity > 50 {
                        HStack{
                            Image(item.image)
                                .resizable()
                                .frame(width: 120, height: 120)
                                .cornerRadius(10)
                            
                            Spacer()
                            HStack{
                                Text("Compared to - ",item.title)
                                //Test
                                //Text("\(vec1.map { String(format: "%.2f", $0) }.joined(separator: ", "))")
                                //Text("\(vec2.map { String(format: "%.2f", $0) }.joined(separator: ", "))")
                                //Text("\(sentence1)")
                                Text("\(simF)%")
                                //Text("Similarity is: \(similarity)%")
                            }
                        }//.padding()
                        Text("Event Forecast:  ")
                            .font(.headline)
                        let forecast = pvm.forecast(similarity_score: similarity, attendees: Double(item.attendees), parking: Double(item.attendees))
                        Text(forecast)
                            .font(.subheadline)
                    }
                }
            }
            
            
        }*/
        
    }
}
