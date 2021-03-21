//
//  ContentView.swift
//  LengthConversion
//
//  Created by Hithakshi on 21/03/21.
//

import SwiftUI

struct ContentView: View {
    @State private var inputUnit = 0
    @State private var outputUnit = 0
    @State private var input = ""

    enum Unit: String, CaseIterable {
        case mts
        case km = "Km"
        case ft = "Ft"
        case yards
        case miles

        var unitLength: UnitLength {
            switch self {
            case .mts: return UnitLength.meters
            case .km: return UnitLength.kilometers
            case .ft: return UnitLength.feet
            case .yards: return UnitLength.yards
            case .miles: return UnitLength.miles
            }
        }
    }

    let lengthUnits = Unit
        .allCases
        .compactMap { $0.rawValue }

    var output: Double {
        guard let input = Double(self.input) else {
            return 0
        }
        guard let inputUnit = Unit(rawValue: lengthUnits[self.inputUnit]) else {
            return 0
        }
        guard let outputUnit = Unit(rawValue: lengthUnits[self.outputUnit]) else {
            return 0
        }
        return Measurement(
            value: input,
            unit: inputUnit.unitLength
        )
        .converted(to: outputUnit.unitLength)
        .value
    }

    var body: some View {
        Form {
            TextField("Enter the measurement", text: $input)
                .keyboardType(.decimalPad)

            Section(header: Text("Input Unit")) {
                Picker("Pick input unit", selection: $inputUnit) {
                    ForEach(0..<lengthUnits.count) {
                        Text(self.lengthUnits[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }

            Section(header: Text("Output Unit")) {
                Picker("Pick output unit", selection: $outputUnit) {
                    ForEach(0..<lengthUnits.count) {
                        Text(self.lengthUnits[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }

            Section(header: Text("Converted measurement")) {
                Text("\(output, specifier: "%.2f")")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
