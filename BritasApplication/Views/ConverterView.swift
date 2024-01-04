//
//  ConverterView.swift
//  BritasApplication
//
//  Created by Pontus Berggren on 2024-01-03.
//

import SwiftUI

struct ConverterView: View {
   
    @State private var inputNumber = 0.0
    @State private var inputSelectedUnit = "inch"
    @State private var outputSelectedUnit = "cm"
    @State private var inputValueOption = [String(localized:"inch"), "cm", "meter", "mm", "dm"]
    @State private var outputValueOption = [String(localized:"inch"), "cm", "meter", "mm", "dm"]
    @State private var outputNumber = "0.0"
    
    @FocusState private var showingKeyBoard: Bool
    
    
    func unitConverter() -> Double {
        if inputSelectedUnit == "mm" {
            let inputLength: Measurement<UnitLength> = Measurement(value: inputNumber, unit: .millimeters)
            if outputSelectedUnit == "inch" {
                let lengthInInches = inputLength.converted(to: .inches)
                return lengthInInches.value
            } else if outputSelectedUnit == "cm" {
                let lengthInCm = inputLength.converted(to: .centimeters)
                return lengthInCm.value
            } else if outputSelectedUnit == "meter" {
                let lengthInMeter = inputLength.converted(to: .meters)
                return lengthInMeter.value
            } else if outputSelectedUnit == "dm" {
                let lengthInDecimeter = inputLength.converted(to: .decimeters)
                return lengthInDecimeter.value
            } else {
                return inputLength.value
            }
        } else if inputSelectedUnit == "cm" {
                let inputLength: Measurement<UnitLength> = Measurement(value: inputNumber, unit: .centimeters)
                if outputSelectedUnit == "inch" {
                    let lengthInInches = inputLength.converted(to: .inches)
                    return lengthInInches.value
                } else if outputSelectedUnit == "mm" {
                    let lengthInMm = inputLength.converted(to: .millimeters)
                    return lengthInMm.value
                } else if outputSelectedUnit == "meter" {
                    let lengthInMeter = inputLength.converted(to: .meters)
                    return lengthInMeter.value
                } else if outputSelectedUnit == "dm" {
                    let lengthInDecimeter = inputLength.converted(to: .decimeters)
                    return lengthInDecimeter.value
                } else {
                    return inputLength.value
                }
        } else if inputSelectedUnit == "meter" {
            let inputLength: Measurement<UnitLength> = Measurement(value: inputNumber, unit: .meters)
            if outputSelectedUnit == "inch" {
                let lengthInInches = inputLength.converted(to: .inches)
                return lengthInInches.value
            } else if outputSelectedUnit == "mm" {
                let lengthInCm = inputLength.converted(to: .millimeters)
                return lengthInCm.value
            } else if outputSelectedUnit == "cm" {
                let lengthInCm = inputLength.converted(to: .centimeters)
                return lengthInCm.value
            } else if outputSelectedUnit == "dm" {
                let lengthInDecimeter = inputLength.converted(to: .decimeters)
                return lengthInDecimeter.value
            } else {
                return inputLength.value
            }
            
            
        } else if inputSelectedUnit == "inch" {
            let inputLength: Measurement<UnitLength> = Measurement(value: inputNumber, unit: .inches)
            if outputSelectedUnit == "meter" {
                let lengthInMeter = inputLength.converted(to: .meters)
                return lengthInMeter.value
            } else if outputSelectedUnit == "mm" {
                let lengthInCm = inputLength.converted(to: .millimeters)
                return lengthInCm.value
            } else if outputSelectedUnit == "cm" {
                let lengthInCm = inputLength.converted(to: .centimeters)
                return lengthInCm.value
            } else if outputSelectedUnit == "dm" {
                let lengthInDecimeter = inputLength.converted(to: .decimeters)
                return lengthInDecimeter.value
            } else {
                return inputLength.value
            }
            
            
        }else {
            let inputLength: Measurement<UnitLength> = Measurement(value: inputNumber, unit: .decimeters)
            if outputSelectedUnit == "meter" {
                let lengthInMeter = inputLength.converted(to: .meters)
                return lengthInMeter.value
            } else if outputSelectedUnit == "mm" {
                let lengthInCm = inputLength.converted(to: .millimeters)
                return lengthInCm.value
            } else if outputSelectedUnit == "cm" {
                let lengthInCm = inputLength.converted(to: .meters)
                return lengthInCm.value
            } else if outputSelectedUnit == "inch" {
                let lengthInInches = inputLength.converted(to: .inches)
                return lengthInInches.value
            } else {
                return inputLength.value
            }
            
            
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Submit value and unit") {
                    TextField("Submit value", value: $inputNumber, format: .number).keyboardType(.decimalPad)
                        .focused($showingKeyBoard)
                    
                    Picker("Pick a unit", selection: $inputSelectedUnit) {
                        ForEach(inputValueOption, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Choose unit") {
                    Picker("Pick a unit", selection: $outputSelectedUnit) {
                        ForEach(outputValueOption, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Converted value") {
                    Text(unitConverter(), format: .number)
                }
                
            }
            .toolbar {
                if showingKeyBoard {
                    Button("Done") {
                       showingKeyBoard = false
                    }
                }
            }
            .navigationTitle("Convert unit")
        }
    }
}

#Preview {
    ConverterView()
}

