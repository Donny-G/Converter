//
//  ContentView.swift
//  Converter
//
//  Created by DeNNiO   G on 01.05.2020.
//  Copyright © 2020 Donny G. All rights reserved.
//

import SwiftUI

extension UIView {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIApplication.shared.windows
            .first {$0.isKeyWindow}?
            .endEditing(true)
    }
}

struct ContentView: View {
    
    @State private var enteredUnits = ""
    @State private var fromUnit = 0
    @State private var toUnit = 1
    @State private var type = 0
    
    let unitsType = ["km", "m", "mi"]
    let weightUnits = ["kg","g", "t"]
    let typeOfMeasurement = ["Distance", "Weight"]
    
    func calculation(enteredUnits: String, from: Int, to: Int) -> Double {
        let tfDate = Double(enteredUnits) ?? 0
        var temp = 0.0
        switch type {
            
        case 0:
            if from == 0 && to == 0 {
                temp = tfDate
            } else if from == 0 && to == 1 {
            temp = tfDate * 1000
            } else if from == 1 && to == 0 {
            temp = tfDate / 1000
            } else if from == 1 && to == 1 {
            temp = tfDate
            } else if from == 0 && to == 2 {
                temp = tfDate / 1.609344
            } else if from == 1 && to == 2 {
                temp = (tfDate / 1000) / 1.609344
            } else if from == 2 && to == 2 {
                temp = tfDate
            } else if from == 2 && to == 1 {
                temp = (tfDate * 1.609344) * 1000
            } else if from == 2 && to == 0 {
                temp = tfDate * 1.609344
            }
            
        case 1:
            if from == 0 && to == 0 {
            temp = tfDate
            }else if from == 0 && to == 1 {
            temp = tfDate * 1000
            }else if from == 0 && to == 2 {
            temp = tfDate / 1000
            }else if from == 1 && to == 0 {
            temp = tfDate / 1000
            }else if from == 1 && to == 1 {
            temp = tfDate
            }else if from == 1 && to == 2 {
            temp = tfDate / 1000000
            }else if from == 2 && to == 0 {
            temp = tfDate * 1000
            }else if from == 2 && to == 1 {
            temp = tfDate * 1000000
            }else if from == 2 && to == 2 {
            temp = tfDate
            }
            
        default:
            print("new type")
        }
        return temp
    }
    
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter units to convert", text: $enteredUnits)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Choose measurement type")) {
                    Picker("Type", selection: $type) {
                        ForEach(0 ..< typeOfMeasurement.count){
                            Text(self.typeOfMeasurement[$0])
                        }
                    }
                        .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("From units")) {
                    Picker("From", selection: $fromUnit) {
                        if type == 0 {
                            ForEach(0 ..< unitsType.count) {
                                Text(self.unitsType[$0])
                                }
                        } else {
                            ForEach(0 ..< weightUnits.count) {
                                Text(self.weightUnits[$0])
                                }
                        }
                    }
                        .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("To units")) {
                    Picker("To", selection: $toUnit) {
                        if type == 0 {
                            ForEach(0 ..< unitsType.count) {
                                Text(self.unitsType[$0])
                            }
                        } else {
                            ForEach(0 ..< weightUnits.count) {
                                Text(self.weightUnits[$0])
                            }
                        }
                    }
                        .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Result")) {
                    Text("\(calculation(enteredUnits: enteredUnits, from: fromUnit, to: toUnit))")
                }
            }.navigationBarTitle("Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
