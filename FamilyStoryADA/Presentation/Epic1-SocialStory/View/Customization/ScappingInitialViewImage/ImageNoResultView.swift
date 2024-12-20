//
//  ImageNoResultImageView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 11/11/24.
//

import SwiftUI

struct ImageNoResultView: Shape {
    let widthRatio: CGFloat
    let heightRatio: CGFloat
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = 153.75 * widthRatio
        let height = 131.25 * heightRatio
        path.move(to: CGPoint(x: 0.41447*width, y: 0.98462*height))
        path.addCurve(to: CGPoint(x: 0.27039*width, y: 0.98385*height), control1: CGPoint(x: 0.36645*width, y: 0.98462*height), control2: CGPoint(x: 0.31776*width, y: 0.98462*height))
        path.addLine(to: CGPoint(x: 0.24671*width, y: 0.98385*height))
        path.addCurve(to: CGPoint(x: 0.06118*width, y: 0.88692*height), control1: CGPoint(x: 0.16974*width, y: 0.97923*height), control2: CGPoint(x: 0.11184*width, y: 0.96154*height))
        path.addCurve(to: CGPoint(x: 0.01579*width, y: 0.68846*height), control1: CGPoint(x: 0.02171*width, y: 0.82846*height), control2: CGPoint(x: 0.01776*width, y: 0.77231*height))
        path.addCurve(to: CGPoint(x: 0.01579*width, y: 0.31*height), control1: CGPoint(x: 0.01316*width, y: 0.56385*height), control2: CGPoint(x: 0.01316*width, y: 0.43308*height))
        path.addCurve(to: CGPoint(x: 0.08092*width, y: 0.08538*height), control1: CGPoint(x: 0.01776*width, y: 0.21615*height), control2: CGPoint(x: 0.02368*width, y: 0.15*height))
        path.addCurve(to: CGPoint(x: 0.26776*width, y: 0.01385*height), control1: CGPoint(x: 0.13553*width, y: 0.02231*height), control2: CGPoint(x: 0.18816*width, y: 0.01615*height))
        path.addCurve(to: CGPoint(x: 0.42961*width, y: 0.01154*height), control1: CGPoint(x: 0.32039*width, y: 0.01231*height), control2: CGPoint(x: 0.375*width, y: 0.01154*height))
        path.addCurve(to: CGPoint(x: 0.59145*width, y: 0.01385*height), control1: CGPoint(x: 0.48421*width, y: 0.01154*height), control2: CGPoint(x: 0.53882*width, y: 0.01231*height))
        path.addCurve(to: CGPoint(x: 0.76579*width, y: 0.07077*height), control1: CGPoint(x: 0.66447*width, y: 0.01615*height), control2: CGPoint(x: 0.7125*width, y: 0.02*height))
        path.addCurve(to: CGPoint(x: 0.84474*width, y: 0.31538*height), control1: CGPoint(x: 0.83618*width, y: 0.13846*height), control2: CGPoint(x: 0.84342*width, y: 0.21769*height))
        path.addCurve(to: CGPoint(x: 0.84474*width, y: 0.33231*height), control1: CGPoint(x: 0.84474*width, y: 0.32077*height), control2: CGPoint(x: 0.84474*width, y: 0.32615*height))
        path.addCurve(to: CGPoint(x: 0.84474*width, y: 0.40846*height), control1: CGPoint(x: 0.84474*width, y: 0.35769*height), control2: CGPoint(x: 0.84605*width, y: 0.38692*height))
        path.addCurve(to: CGPoint(x: 0.82434*width, y: 0.42923*height), control1: CGPoint(x: 0.84342*width, y: 0.42846*height), control2: CGPoint(x: 0.82763*width, y: 0.42923*height))
        path.addCurve(to: CGPoint(x: 0.80395*width, y: 0.40769*height), control1: CGPoint(x: 0.82105*width, y: 0.42923*height), control2: CGPoint(x: 0.80526*width, y: 0.42846*height))
        path.addCurve(to: CGPoint(x: 0.80329*width, y: 0.35231*height), control1: CGPoint(x: 0.80263*width, y: 0.39077*height), control2: CGPoint(x: 0.80329*width, y: 0.37154*height))
        path.addCurve(to: CGPoint(x: 0.80329*width, y: 0.31538*height), control1: CGPoint(x: 0.80329*width, y: 0.34*height), control2: CGPoint(x: 0.80329*width, y: 0.32692*height))
        path.addLine(to: CGPoint(x: 0.80329*width, y: 0.30615*height))
        path.addCurve(to: CGPoint(x: 0.74539*width, y: 0.11308*height), control1: CGPoint(x: 0.80197*width, y: 0.23385*height), control2: CGPoint(x: 0.80066*width, y: 0.17077*height))
        path.addCurve(to: CGPoint(x: 0.59737*width, y: 0.06154*height), control1: CGPoint(x: 0.69868*width, y: 0.06385*height), control2: CGPoint(x: 0.65197*width, y: 0.06308*height))
        path.addLine(to: CGPoint(x: 0.5875*width, y: 0.06154*height))
        path.addCurve(to: CGPoint(x: 0.43158*width, y: 0.05923*height), control1: CGPoint(x: 0.53684*width, y: 0.06*height), control2: CGPoint(x: 0.48487*width, y: 0.05923*height))
        path.addCurve(to: CGPoint(x: 0.27303*width, y: 0.06154*height), control1: CGPoint(x: 0.37829*width, y: 0.05923*height), control2: CGPoint(x: 0.32566*width, y: 0.05923*height))
        path.addLine(to: CGPoint(x: 0.26513*width, y: 0.06154*height))
        path.addCurve(to: CGPoint(x: 0.09934*width, y: 0.13*height), control1: CGPoint(x: 0.20263*width, y: 0.06308*height), control2: CGPoint(x: 0.14868*width, y: 0.06462*height))
        path.addCurve(to: CGPoint(x: 0.05592*width, y: 0.28615*height), control1: CGPoint(x: 0.0625*width, y: 0.17846*height), control2: CGPoint(x: 0.05789*width, y: 0.22692*height))
        path.addCurve(to: CGPoint(x: 0.05526*width, y: 0.58538*height), control1: CGPoint(x: 0.05592*width, y: 0.28615*height), control2: CGPoint(x: 0.05526*width, y: 0.58538*height))
        path.addCurve(to: CGPoint(x: 0.06579*width, y: 0.60308*height), control1: CGPoint(x: 0.05526*width, y: 0.59308*height), control2: CGPoint(x: 0.05921*width, y: 0.6*height))
        path.addCurve(to: CGPoint(x: 0.07171*width, y: 0.60462*height), control1: CGPoint(x: 0.06776*width, y: 0.60385*height), control2: CGPoint(x: 0.06974*width, y: 0.60462*height))
        path.addCurve(to: CGPoint(x: 0.08355*width, y: 0.59846*height), control1: CGPoint(x: 0.07632*width, y: 0.60462*height), control2: CGPoint(x: 0.08026*width, y: 0.60231*height))
        path.addCurve(to: CGPoint(x: 0.15461*width, y: 0.54462*height), control1: CGPoint(x: 0.10724*width, y: 0.56923*height), control2: CGPoint(x: 0.12632*width, y: 0.55154*height))
        path.addCurve(to: CGPoint(x: 0.18026*width, y: 0.54154*height), control1: CGPoint(x: 0.16316*width, y: 0.54231*height), control2: CGPoint(x: 0.17237*width, y: 0.54154*height))
        path.addCurve(to: CGPoint(x: 0.25921*width, y: 0.58*height), control1: CGPoint(x: 0.20921*width, y: 0.54154*height), control2: CGPoint(x: 0.23487*width, y: 0.55385*height))
        path.addCurve(to: CGPoint(x: 0.29013*width, y: 0.62*height), control1: CGPoint(x: 0.27039*width, y: 0.59231*height), control2: CGPoint(x: 0.27961*width, y: 0.60538*height))
        path.addCurve(to: CGPoint(x: 0.31447*width, y: 0.65308*height), control1: CGPoint(x: 0.29803*width, y: 0.63077*height), control2: CGPoint(x: 0.30592*width, y: 0.64231*height))
        path.addLine(to: CGPoint(x: 0.31447*width, y: 0.65308*height))
        path.addCurve(to: CGPoint(x: 0.33158*width, y: 0.66385*height), control1: CGPoint(x: 0.31645*width, y: 0.65692*height), control2: CGPoint(x: 0.32237*width, y: 0.66385*height))
        path.addCurve(to: CGPoint(x: 0.3375*width, y: 0.66308*height), control1: CGPoint(x: 0.34079*width, y: 0.66385*height), control2: CGPoint(x: 0.33553*width, y: 0.66385*height))
        path.addCurve(to: CGPoint(x: 0.36316*width, y: 0.63692*height), control1: CGPoint(x: 0.34211*width, y: 0.66154*height), control2: CGPoint(x: 0.34342*width, y: 0.66*height))
        path.addLine(to: CGPoint(x: 0.36447*width, y: 0.63538*height))
        path.addCurve(to: CGPoint(x: 0.43026*width, y: 0.55615*height), control1: CGPoint(x: 0.38684*width, y: 0.60923*height), control2: CGPoint(x: 0.40855*width, y: 0.58231*height))
        path.addCurve(to: CGPoint(x: 0.48158*width, y: 0.49385*height), control1: CGPoint(x: 0.44737*width, y: 0.53538*height), control2: CGPoint(x: 0.46447*width, y: 0.51462*height))
        path.addCurve(to: CGPoint(x: 0.50066*width, y: 0.47077*height), control1: CGPoint(x: 0.48816*width, y: 0.48615*height), control2: CGPoint(x: 0.49408*width, y: 0.47846*height))
        path.addCurve(to: CGPoint(x: 0.62171*width, y: 0.38385*height), control1: CGPoint(x: 0.53816*width, y: 0.42385*height), control2: CGPoint(x: 0.57039*width, y: 0.38385*height))
        path.addCurve(to: CGPoint(x: 0.64671*width, y: 0.38692*height), control1: CGPoint(x: 0.67303*width, y: 0.38385*height), control2: CGPoint(x: 0.63816*width, y: 0.38462*height))
        path.addCurve(to: CGPoint(x: 0.71711*width, y: 0.43769*height), control1: CGPoint(x: 0.67039*width, y: 0.39231*height), control2: CGPoint(x: 0.70066*width, y: 0.41462*height))
        path.addCurve(to: CGPoint(x: 0.72039*width, y: 0.46308*height), control1: CGPoint(x: 0.72434*width, y: 0.44846*height), control2: CGPoint(x: 0.72237*width, y: 0.45846*height))
        path.addCurve(to: CGPoint(x: 0.70197*width, y: 0.47769*height), control1: CGPoint(x: 0.71711*width, y: 0.47154*height), control2: CGPoint(x: 0.70987*width, y: 0.47769*height))
        path.addCurve(to: CGPoint(x: 0.69342*width, y: 0.47538*height), control1: CGPoint(x: 0.69408*width, y: 0.47769*height), control2: CGPoint(x: 0.69671*width, y: 0.47769*height))
        path.addCurve(to: CGPoint(x: 0.68289*width, y: 0.46538*height), control1: CGPoint(x: 0.69013*width, y: 0.47385*height), control2: CGPoint(x: 0.68684*width, y: 0.47*height))
        path.addCurve(to: CGPoint(x: 0.67566*width, y: 0.45769*height), control1: CGPoint(x: 0.68026*width, y: 0.46308*height), control2: CGPoint(x: 0.67829*width, y: 0.46*height))
        path.addCurve(to: CGPoint(x: 0.62303*width, y: 0.43231*height), control1: CGPoint(x: 0.65855*width, y: 0.44077*height), control2: CGPoint(x: 0.64079*width, y: 0.43231*height))
        path.addCurve(to: CGPoint(x: 0.5375*width, y: 0.49615*height), control1: CGPoint(x: 0.5875*width, y: 0.43231*height), control2: CGPoint(x: 0.56118*width, y: 0.46615*height))
        path.addCurve(to: CGPoint(x: 0.52368*width, y: 0.51385*height), control1: CGPoint(x: 0.53289*width, y: 0.50231*height), control2: CGPoint(x: 0.52829*width, y: 0.50846*height))
        path.addCurve(to: CGPoint(x: 0.425*width, y: 0.63308*height), control1: CGPoint(x: 0.49079*width, y: 0.55308*height), control2: CGPoint(x: 0.45724*width, y: 0.59385*height))
        path.addCurve(to: CGPoint(x: 0.37303*width, y: 0.69615*height), control1: CGPoint(x: 0.40789*width, y: 0.65385*height), control2: CGPoint(x: 0.39079*width, y: 0.67462*height))
        path.addCurve(to: CGPoint(x: 0.33158*width, y: 0.71462*height), control1: CGPoint(x: 0.36118*width, y: 0.70769*height), control2: CGPoint(x: 0.34671*width, y: 0.71462*height))
        path.addCurve(to: CGPoint(x: 0.28618*width, y: 0.69154*height), control1: CGPoint(x: 0.31645*width, y: 0.71462*height), control2: CGPoint(x: 0.29803*width, y: 0.70615*height))
        path.addCurve(to: CGPoint(x: 0.26842*width, y: 0.66692*height), control1: CGPoint(x: 0.28092*width, y: 0.68538*height), control2: CGPoint(x: 0.275*width, y: 0.67692*height))
        path.addCurve(to: CGPoint(x: 0.19737*width, y: 0.59462*height), control1: CGPoint(x: 0.24737*width, y: 0.63615*height), control2: CGPoint(x: 0.22303*width, y: 0.60154*height))
        path.addCurve(to: CGPoint(x: 0.17829*width, y: 0.59154*height), control1: CGPoint(x: 0.19079*width, y: 0.59308*height), control2: CGPoint(x: 0.18421*width, y: 0.59154*height))
        path.addCurve(to: CGPoint(x: 0.1*width, y: 0.65*height), control1: CGPoint(x: 0.14211*width, y: 0.59154*height), control2: CGPoint(x: 0.11974*width, y: 0.62308*height))
        path.addCurve(to: CGPoint(x: 0.09276*width, y: 0.66077*height), control1: CGPoint(x: 0.09737*width, y: 0.65385*height), control2: CGPoint(x: 0.09474*width, y: 0.65692*height))
        path.addLine(to: CGPoint(x: 0.08882*width, y: 0.66615*height))
        path.addCurve(to: CGPoint(x: 0.06645*width, y: 0.69769*height), control1: CGPoint(x: 0.08092*width, y: 0.67615*height), control2: CGPoint(x: 0.07368*width, y: 0.68692*height))
        path.addLine(to: CGPoint(x: 0.06513*width, y: 0.7*height))
        path.addCurve(to: CGPoint(x: 0.05658*width, y: 0.72769*height), control1: CGPoint(x: 0.06118*width, y: 0.70538*height), control2: CGPoint(x: 0.05658*width, y: 0.71308*height))
        path.addCurve(to: CGPoint(x: 0.11382*width, y: 0.88462*height), control1: CGPoint(x: 0.05855*width, y: 0.79692*height), control2: CGPoint(x: 0.07632*width, y: 0.84538*height))
        path.addCurve(to: CGPoint(x: 0.26118*width, y: 0.93538*height), control1: CGPoint(x: 0.16053*width, y: 0.93308*height), control2: CGPoint(x: 0.20724*width, y: 0.93462*height))
        path.addLine(to: CGPoint(x: 0.27171*width, y: 0.93538*height))
        path.addCurve(to: CGPoint(x: 0.35987*width, y: 0.93692*height), control1: CGPoint(x: 0.29737*width, y: 0.93615*height), control2: CGPoint(x: 0.32434*width, y: 0.93692*height))
        path.addCurve(to: CGPoint(x: 0.40526*width, y: 0.93692*height), control1: CGPoint(x: 0.39539*width, y: 0.93692*height), control2: CGPoint(x: 0.39013*width, y: 0.93692*height))
        path.addCurve(to: CGPoint(x: 0.45066*width, y: 0.93692*height), control1: CGPoint(x: 0.42039*width, y: 0.93692*height), control2: CGPoint(x: 0.43553*width, y: 0.93692*height))
        path.addCurve(to: CGPoint(x: 0.54671*width, y: 0.93846*height), control1: CGPoint(x: 0.47697*width, y: 0.93692*height), control2: CGPoint(x: 0.51118*width, y: 0.93692*height))
        path.addCurve(to: CGPoint(x: 0.56053*width, y: 0.96077*height), control1: CGPoint(x: 0.55921*width, y: 0.94385*height), control2: CGPoint(x: 0.56053*width, y: 0.95692*height))
        path.addCurve(to: CGPoint(x: 0.54671*width, y: 0.98385*height), control1: CGPoint(x: 0.56053*width, y: 0.96923*height), control2: CGPoint(x: 0.55724*width, y: 0.97923*height))
        path.addCurve(to: CGPoint(x: 0.41316*width, y: 0.98538*height), control1: CGPoint(x: 0.50658*width, y: 0.98462*height), control2: CGPoint(x: 0.46316*width, y: 0.98538*height))
        path.addLine(to: CGPoint(x: 0.41316*width, y: 0.98538*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.80066*width, y: 0.98462*height))
        path.addCurve(to: CGPoint(x: 0.75855*width, y: 0.97923*height), control1: CGPoint(x: 0.78684*width, y: 0.98462*height), control2: CGPoint(x: 0.77303*width, y: 0.98308*height))
        path.addCurve(to: CGPoint(x: 0.62368*width, y: 0.85154*height), control1: CGPoint(x: 0.69803*width, y: 0.96385*height), control2: CGPoint(x: 0.64868*width, y: 0.91769*height))
        path.addCurve(to: CGPoint(x: 0.63158*width, y: 0.64615*height), control1: CGPoint(x: 0.59803*width, y: 0.78462*height), control2: CGPoint(x: 0.60066*width, y: 0.71*height))
        path.addCurve(to: CGPoint(x: 0.66645*width, y: 0.59154*height), control1: CGPoint(x: 0.63816*width, y: 0.63308*height), control2: CGPoint(x: 0.64605*width, y: 0.61538*height))
        path.addCurve(to: CGPoint(x: 0.7875*width, y: 0.53231*height), control1: CGPoint(x: 0.70066*width, y: 0.55077*height), control2: CGPoint(x: 0.74408*width, y: 0.53538*height))
        path.addCurve(to: CGPoint(x: 0.8*width, y: 0.53231*height), control1: CGPoint(x: 0.79145*width, y: 0.53231*height), control2: CGPoint(x: 0.79605*width, y: 0.53231*height))
        path.addCurve(to: CGPoint(x: 0.96776*width, y: 0.64692*height), control1: CGPoint(x: 0.87039*width, y: 0.53231*height), control2: CGPoint(x: 0.93289*width, y: 0.57538*height))
        path.addCurve(to: CGPoint(x: 0.96579*width, y: 0.87462*height), control1: CGPoint(x: 1.00263*width, y: 0.71846*height), control2: CGPoint(x: 1.00197*width, y: 0.80385*height))
        path.addCurve(to: CGPoint(x: 0.93618*width, y: 0.92154*height), control1: CGPoint(x: 0.95855*width, y: 0.88846*height), control2: CGPoint(x: 0.95395*width, y: 0.90154*height))
        path.addCurve(to: CGPoint(x: 0.80066*width, y: 0.98462*height), control1: CGPoint(x: 0.89474*width, y: 0.96769*height), control2: CGPoint(x: 0.84737*width, y: 0.98462*height))
        path.addLine(to: CGPoint(x: 0.80066*width, y: 0.98462*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.68158*width, y: 0.66231*height))
        path.addCurve(to: CGPoint(x: 0.67961*width, y: 0.66231*height), control1: CGPoint(x: 0.68158*width, y: 0.66231*height), control2: CGPoint(x: 0.68026*width, y: 0.66231*height))
        path.addCurve(to: CGPoint(x: 0.66776*width, y: 0.67154*height), control1: CGPoint(x: 0.67434*width, y: 0.66231*height), control2: CGPoint(x: 0.67039*width, y: 0.66615*height))
        path.addCurve(to: CGPoint(x: 0.64868*width, y: 0.77923*height), control1: CGPoint(x: 0.65197*width, y: 0.70154*height), control2: CGPoint(x: 0.64474*width, y: 0.74077*height))
        path.addCurve(to: CGPoint(x: 0.80066*width, y: 0.93615*height), control1: CGPoint(x: 0.65724*width, y: 0.86846*height), control2: CGPoint(x: 0.72237*width, y: 0.93615*height))
        path.addCurve(to: CGPoint(x: 0.87303*width, y: 0.91385*height), control1: CGPoint(x: 0.87895*width, y: 0.93615*height), control2: CGPoint(x: 0.85066*width, y: 0.92846*height))
        path.addCurve(to: CGPoint(x: 0.88092*width, y: 0.9*height), control1: CGPoint(x: 0.87763*width, y: 0.91077*height), control2: CGPoint(x: 0.88026*width, y: 0.90538*height))
        path.addCurve(to: CGPoint(x: 0.87632*width, y: 0.88385*height), control1: CGPoint(x: 0.88158*width, y: 0.89462*height), control2: CGPoint(x: 0.88026*width, y: 0.88769*height))
        path.addLine(to: CGPoint(x: 0.69342*width, y: 0.66769*height))
        path.addCurve(to: CGPoint(x: 0.68158*width, y: 0.66231*height), control1: CGPoint(x: 0.69013*width, y: 0.66385*height), control2: CGPoint(x: 0.68618*width, y: 0.66231*height))
        path.addLine(to: CGPoint(x: 0.68158*width, y: 0.66231*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.8*width, y: 0.58*height))
        path.addCurve(to: CGPoint(x: 0.72697*width, y: 0.60231*height), control1: CGPoint(x: 0.77434*width, y: 0.58*height), control2: CGPoint(x: 0.74934*width, y: 0.58769*height))
        path.addCurve(to: CGPoint(x: 0.71842*width, y: 0.61615*height), control1: CGPoint(x: 0.72237*width, y: 0.60538*height), control2: CGPoint(x: 0.71974*width, y: 0.61077*height))
        path.addCurve(to: CGPoint(x: 0.72303*width, y: 0.63231*height), control1: CGPoint(x: 0.71711*width, y: 0.62154*height), control2: CGPoint(x: 0.71908*width, y: 0.62846*height))
        path.addLine(to: CGPoint(x: 0.90724*width, y: 0.84846*height))
        path.addCurve(to: CGPoint(x: 0.91908*width, y: 0.85385*height), control1: CGPoint(x: 0.91053*width, y: 0.85231*height), control2: CGPoint(x: 0.91447*width, y: 0.85385*height))
        path.addCurve(to: CGPoint(x: 0.92171*width, y: 0.85385*height), control1: CGPoint(x: 0.92368*width, y: 0.85385*height), control2: CGPoint(x: 0.92105*width, y: 0.85385*height))
        path.addCurve(to: CGPoint(x: 0.93355*width, y: 0.84385*height), control1: CGPoint(x: 0.92697*width, y: 0.85308*height), control2: CGPoint(x: 0.93158*width, y: 0.84923*height))
        path.addCurve(to: CGPoint(x: 0.94605*width, y: 0.70846*height), control1: CGPoint(x: 0.95263*width, y: 0.8*height), control2: CGPoint(x: 0.95724*width, y: 0.75385*height))
        path.addCurve(to: CGPoint(x: 0.8*width, y: 0.58*height), control1: CGPoint(x: 0.92763*width, y: 0.63308*height), control2: CGPoint(x: 0.86711*width, y: 0.58*height))
        path.addLine(to: CGPoint(x: 0.8*width, y: 0.58*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.33092*width, y: 0.46462*height))
        path.addCurve(to: CGPoint(x: 0.23355*width, y: 0.40615*height), control1: CGPoint(x: 0.29145*width, y: 0.46462*height), control2: CGPoint(x: 0.25592*width, y: 0.44308*height))
        path.addCurve(to: CGPoint(x: 0.22368*width, y: 0.26538*height), control1: CGPoint(x: 0.20855*width, y: 0.36462*height), control2: CGPoint(x: 0.20461*width, y: 0.31154*height))
        path.addCurve(to: CGPoint(x: 0.32237*width, y: 0.18615*height), control1: CGPoint(x: 0.24211*width, y: 0.21923*height), control2: CGPoint(x: 0.27895*width, y: 0.19*height))
        path.addCurve(to: CGPoint(x: 0.33158*width, y: 0.18615*height), control1: CGPoint(x: 0.32566*width, y: 0.18615*height), control2: CGPoint(x: 0.32829*width, y: 0.18615*height))
        path.addCurve(to: CGPoint(x: 0.43553*width, y: 0.25846*height), control1: CGPoint(x: 0.375*width, y: 0.18615*height), control2: CGPoint(x: 0.41447*width, y: 0.21308*height))
        path.addCurve(to: CGPoint(x: 0.43289*width, y: 0.39923*height), control1: CGPoint(x: 0.45658*width, y: 0.30308*height), control2: CGPoint(x: 0.45592*width, y: 0.35615*height))
        path.addCurve(to: CGPoint(x: 0.33158*width, y: 0.46538*height), control1: CGPoint(x: 0.41118*width, y: 0.44077*height), control2: CGPoint(x: 0.37303*width, y: 0.46538*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.33158*width, y: 0.23385*height))
        path.addCurve(to: CGPoint(x: 0.32368*width, y: 0.23385*height), control1: CGPoint(x: 0.32895*width, y: 0.23385*height), control2: CGPoint(x: 0.32632*width, y: 0.23385*height))
        path.addCurve(to: CGPoint(x: 0.26316*width, y: 0.28*height), control1: CGPoint(x: 0.29868*width, y: 0.23615*height), control2: CGPoint(x: 0.27566*width, y: 0.25385*height))
        path.addCurve(to: CGPoint(x: 0.26118*width, y: 0.36538*height), control1: CGPoint(x: 0.25066*width, y: 0.30615*height), control2: CGPoint(x: 0.24934*width, y: 0.33846*height))
        path.addCurve(to: CGPoint(x: 0.33158*width, y: 0.41615*height), control1: CGPoint(x: 0.27434*width, y: 0.39615*height), control2: CGPoint(x: 0.30197*width, y: 0.41615*height))
        path.addLine(to: CGPoint(x: 0.33158*width, y: 0.41615*height))
        path.addCurve(to: CGPoint(x: 0.37961*width, y: 0.39615*height), control1: CGPoint(x: 0.34934*width, y: 0.41615*height), control2: CGPoint(x: 0.36579*width, y: 0.40923*height))
        path.addCurve(to: CGPoint(x: 0.40461*width, y: 0.29462*height), control1: CGPoint(x: 0.40592*width, y: 0.37154*height), control2: CGPoint(x: 0.41579*width, y: 0.33154*height))
        path.addCurve(to: CGPoint(x: 0.33158*width, y: 0.23308*height), control1: CGPoint(x: 0.39342*width, y: 0.25769*height), control2: CGPoint(x: 0.36447*width, y: 0.23308*height))
        path.addLine(to: CGPoint(x: 0.33158*width, y: 0.23308*height))
        path.closeSubpath()
        return path
    }
}
