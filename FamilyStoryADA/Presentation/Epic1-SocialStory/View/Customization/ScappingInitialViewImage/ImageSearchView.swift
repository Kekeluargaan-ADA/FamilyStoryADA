//
//  ImageSearchView.swift
//  FamilyStoryADA
//
//  Created by Daniel Ian on 11/11/24.
//

import SwiftUI

struct ImageSearchView: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.4427*width, y: 0.74672*height))
        path.addCurve(to: CGPoint(x: 0.37965*width, y: 0.74629*height), control1: CGPoint(x: 0.42168*width, y: 0.74672*height), control2: CGPoint(x: 0.40031*width, y: 0.74648*height))
        path.addLine(to: CGPoint(x: 0.36164*width, y: 0.74609*height))
        path.addCurve(to: CGPoint(x: 0.25363*width, y: 0.69957*height), control1: CGPoint(x: 0.31699*width, y: 0.74406*height), control2: CGPoint(x: 0.28316*width, y: 0.73555*height))
        path.addCurve(to: CGPoint(x: 0.22461*width, y: 0.59613*height), control1: CGPoint(x: 0.22777*width, y: 0.66801*height), control2: CGPoint(x: 0.22574*width, y: 0.63973*height))
        path.addCurve(to: CGPoint(x: 0.22461*width, y: 0.40383*height), control1: CGPoint(x: 0.22297*width, y: 0.53293*height), control2: CGPoint(x: 0.22297*width, y: 0.46645*height))
        path.addCurve(to: CGPoint(x: 0.2602*width, y: 0.29285*height), control1: CGPoint(x: 0.22586*width, y: 0.35656*height), control2: CGPoint(x: 0.22887*width, y: 0.32551*height))
        path.addCurve(to: CGPoint(x: 0.37453*width, y: 0.25391*height), control1: CGPoint(x: 0.29309*width, y: 0.25855*height), control2: CGPoint(x: 0.32684*width, y: 0.25516*height))
        path.addCurve(to: CGPoint(x: 0.47051*width, y: 0.25266*height), control1: CGPoint(x: 0.40586*width, y: 0.25309*height), control2: CGPoint(x: 0.43813*width, y: 0.25266*height))
        path.addCurve(to: CGPoint(x: 0.56684*width, y: 0.25391*height), control1: CGPoint(x: 0.50289*width, y: 0.25266*height), control2: CGPoint(x: 0.53531*width, y: 0.25309*height))
        path.addCurve(to: CGPoint(x: 0.67027*width, y: 0.28293*height), control1: CGPoint(x: 0.61039*width, y: 0.25504*height), control2: CGPoint(x: 0.63871*width, y: 0.25707*height))
        path.addCurve(to: CGPoint(x: 0.71727*width, y: 0.40715*height), control1: CGPoint(x: 0.71199*width, y: 0.31711*height), control2: CGPoint(x: 0.71617*width, y: 0.35766*height))
        path.addCurve(to: CGPoint(x: 0.7175*width, y: 0.41559*height), control1: CGPoint(x: 0.7173*width, y: 0.4098*height), control2: CGPoint(x: 0.71742*width, y: 0.41266*height))
        path.addCurve(to: CGPoint(x: 0.7173*width, y: 0.45441*height), control1: CGPoint(x: 0.71785*width, y: 0.42863*height), control2: CGPoint(x: 0.71828*width, y: 0.4434*height))
        path.addCurve(to: CGPoint(x: 0.70508*width, y: 0.46512*height), control1: CGPoint(x: 0.71641*width, y: 0.46457*height), control2: CGPoint(x: 0.70695*width, y: 0.46512*height))
        path.addCurve(to: CGPoint(x: 0.69281*width, y: 0.45406*height), control1: CGPoint(x: 0.7032*width, y: 0.46512*height), control2: CGPoint(x: 0.69363*width, y: 0.46457*height))
        path.addCurve(to: CGPoint(x: 0.69234*width, y: 0.42605*height), control1: CGPoint(x: 0.69215*width, y: 0.44551*height), control2: CGPoint(x: 0.69227*width, y: 0.43562*height))
        path.addCurve(to: CGPoint(x: 0.69234*width, y: 0.40723*height), control1: CGPoint(x: 0.69242*width, y: 0.4198*height), control2: CGPoint(x: 0.6925*width, y: 0.41332*height))
        path.addLine(to: CGPoint(x: 0.69223*width, y: 0.40258*height))
        path.addCurve(to: CGPoint(x: 0.65813*width, y: 0.30469*height), control1: CGPoint(x: 0.69137*width, y: 0.36574*height), control2: CGPoint(x: 0.69063*width, y: 0.33395*height))
        path.addCurve(to: CGPoint(x: 0.5702*width, y: 0.27844*height), control1: CGPoint(x: 0.63039*width, y: 0.27977*height), control2: CGPoint(x: 0.6025*width, y: 0.27914*height))
        path.addLine(to: CGPoint(x: 0.56391*width, y: 0.27828*height))
        path.addCurve(to: CGPoint(x: 0.47125*width, y: 0.27715*height), control1: CGPoint(x: 0.53363*width, y: 0.27754*height), control2: CGPoint(x: 0.50246*width, y: 0.27715*height))
        path.addCurve(to: CGPoint(x: 0.37793*width, y: 0.27828*height), control1: CGPoint(x: 0.44004*width, y: 0.27715*height), control2: CGPoint(x: 0.40863*width, y: 0.27754*height))
        path.addLine(to: CGPoint(x: 0.37348*width, y: 0.2784*height))
        path.addCurve(to: CGPoint(x: 0.27492*width, y: 0.31305*height), control1: CGPoint(x: 0.33633*width, y: 0.27926*height), control2: CGPoint(x: 0.30426*width, y: 0.28*height))
        path.addCurve(to: CGPoint(x: 0.24902*width, y: 0.3923*height), control1: CGPoint(x: 0.25316*width, y: 0.33758*height), control2: CGPoint(x: 0.25039*width, y: 0.36238*height))
        path.addCurve(to: CGPoint(x: 0.24855*width, y: 0.54434*height), control1: CGPoint(x: 0.24902*width, y: 0.39246*height), control2: CGPoint(x: 0.24855*width, y: 0.54434*height))
        path.addCurve(to: CGPoint(x: 0.25469*width, y: 0.55344*height), control1: CGPoint(x: 0.24855*width, y: 0.54832*height), control2: CGPoint(x: 0.25098*width, y: 0.55191*height))
        path.addCurve(to: CGPoint(x: 0.25832*width, y: 0.55414*height), control1: CGPoint(x: 0.25586*width, y: 0.55391*height), control2: CGPoint(x: 0.25711*width, y: 0.55414*height))
        path.addCurve(to: CGPoint(x: 0.26539*width, y: 0.55113*height), control1: CGPoint(x: 0.26094*width, y: 0.55414*height), control2: CGPoint(x: 0.26352*width, y: 0.55309*height))
        path.addCurve(to: CGPoint(x: 0.30762*width, y: 0.52391*height), control1: CGPoint(x: 0.27941*width, y: 0.53648*height), control2: CGPoint(x: 0.29082*width, y: 0.52734*height))
        path.addCurve(to: CGPoint(x: 0.32324*width, y: 0.52227*height), control1: CGPoint(x: 0.31301*width, y: 0.52281*height), control2: CGPoint(x: 0.31828*width, y: 0.52227*height))
        path.addCurve(to: CGPoint(x: 0.37629*width, y: 0.54844*height), control1: CGPoint(x: 0.34238*width, y: 0.52227*height), control2: CGPoint(x: 0.35922*width, y: 0.53059*height))
        path.addCurve(to: CGPoint(x: 0.38883*width, y: 0.56313*height), control1: CGPoint(x: 0.38059*width, y: 0.55293*height), control2: CGPoint(x: 0.38457*width, y: 0.55789*height))
        path.addCurve(to: CGPoint(x: 0.40242*width, y: 0.57898*height), control1: CGPoint(x: 0.39316*width, y: 0.56848*height), control2: CGPoint(x: 0.39762*width, y: 0.57398*height))
        path.addLine(to: CGPoint(x: 0.40273*width, y: 0.5793*height))
        path.addCurve(to: CGPoint(x: 0.41297*width, y: 0.58445*height), control1: CGPoint(x: 0.40398*width, y: 0.5807*height), control2: CGPoint(x: 0.40738*width, y: 0.58445*height))
        path.addCurve(to: CGPoint(x: 0.41477*width, y: 0.58434*height), control1: CGPoint(x: 0.41344*width, y: 0.58445*height), control2: CGPoint(x: 0.4143*width, y: 0.58438*height))
        path.addCurve(to: CGPoint(x: 0.43219*width, y: 0.5702*height), control1: CGPoint(x: 0.41859*width, y: 0.58379*height), control2: CGPoint(x: 0.42023*width, y: 0.58246*height))
        path.addLine(to: CGPoint(x: 0.43281*width, y: 0.56957*height))
        path.addCurve(to: CGPoint(x: 0.47055*width, y: 0.53055*height), control1: CGPoint(x: 0.44547*width, y: 0.55664*height), control2: CGPoint(x: 0.4582*width, y: 0.54336*height))
        path.addCurve(to: CGPoint(x: 0.50219*width, y: 0.49777*height), control1: CGPoint(x: 0.48105*width, y: 0.51961*height), control2: CGPoint(x: 0.4916*width, y: 0.50863*height))
        path.addCurve(to: CGPoint(x: 0.51301*width, y: 0.48645*height), control1: CGPoint(x: 0.50586*width, y: 0.49402*height), control2: CGPoint(x: 0.50945*width, y: 0.4902*height))
        path.addCurve(to: CGPoint(x: 0.58488*width, y: 0.4418*height), control1: CGPoint(x: 0.53559*width, y: 0.4625*height), control2: CGPoint(x: 0.55504*width, y: 0.4418*height))
        path.addCurve(to: CGPoint(x: 0.60297*width, y: 0.44406*height), control1: CGPoint(x: 0.59059*width, y: 0.4418*height), control2: CGPoint(x: 0.59668*width, y: 0.44258*height))
        path.addCurve(to: CGPoint(x: 0.64199*width, y: 0.46938*height), control1: CGPoint(x: 0.61559*width, y: 0.44711*height), control2: CGPoint(x: 0.63383*width, y: 0.45895*height))
        path.addCurve(to: CGPoint(x: 0.64348*width, y: 0.48215*height), control1: CGPoint(x: 0.64613*width, y: 0.47465*height), control2: CGPoint(x: 0.64469*width, y: 0.47965*height))
        path.addCurve(to: CGPoint(x: 0.6325*width, y: 0.4893*height), control1: CGPoint(x: 0.64137*width, y: 0.48648*height), control2: CGPoint(x: 0.63703*width, y: 0.4893*height))
        path.addCurve(to: CGPoint(x: 0.62758*width, y: 0.48832*height), control1: CGPoint(x: 0.6309*width, y: 0.4893*height), control2: CGPoint(x: 0.62922*width, y: 0.48895*height))
        path.addCurve(to: CGPoint(x: 0.62129*width, y: 0.48336*height), control1: CGPoint(x: 0.62551*width, y: 0.4875*height), control2: CGPoint(x: 0.62363*width, y: 0.48566*height))
        path.addCurve(to: CGPoint(x: 0.61699*width, y: 0.47934*height), control1: CGPoint(x: 0.61988*width, y: 0.48199*height), control2: CGPoint(x: 0.61848*width, y: 0.48063*height))
        path.addCurve(to: CGPoint(x: 0.5859*width, y: 0.46633*height), control1: CGPoint(x: 0.60676*width, y: 0.4707*height), control2: CGPoint(x: 0.59629*width, y: 0.46633*height))
        path.addCurve(to: CGPoint(x: 0.5352*width, y: 0.49867*height), control1: CGPoint(x: 0.565*width, y: 0.46633*height), control2: CGPoint(x: 0.54918*width, y: 0.48352*height))
        path.addCurve(to: CGPoint(x: 0.52684*width, y: 0.50758*height), control1: CGPoint(x: 0.53238*width, y: 0.50172*height), control2: CGPoint(x: 0.52961*width, y: 0.50473*height))
        path.addCurve(to: CGPoint(x: 0.46898*width, y: 0.56727*height), control1: CGPoint(x: 0.50742*width, y: 0.52738*height), control2: CGPoint(x: 0.48789*width, y: 0.54766*height))
        path.addCurve(to: CGPoint(x: 0.43746*width, y: 0.59988*height), control1: CGPoint(x: 0.45848*width, y: 0.57816*height), control2: CGPoint(x: 0.44801*width, y: 0.58902*height))
        path.addCurve(to: CGPoint(x: 0.41289*width, y: 0.60914*height), control1: CGPoint(x: 0.43059*width, y: 0.60586*height), control2: CGPoint(x: 0.42188*width, y: 0.60914*height))
        path.addCurve(to: CGPoint(x: 0.38605*width, y: 0.59754*height), control1: CGPoint(x: 0.4027*width, y: 0.60914*height), control2: CGPoint(x: 0.39316*width, y: 0.60504*height))
        path.addCurve(to: CGPoint(x: 0.37559*width, y: 0.58516*height), control1: CGPoint(x: 0.38313*width, y: 0.59445*height), control2: CGPoint(x: 0.37949*width, y: 0.58992*height))
        path.addCurve(to: CGPoint(x: 0.33359*width, y: 0.54828*height), control1: CGPoint(x: 0.36305*width, y: 0.56965*height), control2: CGPoint(x: 0.34879*width, y: 0.55207*height))
        path.addCurve(to: CGPoint(x: 0.32168*width, y: 0.54676*height), control1: CGPoint(x: 0.32949*width, y: 0.54727*height), control2: CGPoint(x: 0.32547*width, y: 0.54676*height))
        path.addCurve(to: CGPoint(x: 0.2802*width, y: 0.57156*height), control1: CGPoint(x: 0.30254*width, y: 0.54676*height), control2: CGPoint(x: 0.29117*width, y: 0.55938*height))
        path.addCurve(to: CGPoint(x: 0.25555*width, y: 0.60074*height), control1: CGPoint(x: 0.27352*width, y: 0.57898*height), control2: CGPoint(x: 0.26383*width, y: 0.59004*height))
        path.addLine(to: CGPoint(x: 0.25461*width, y: 0.60191*height))
        path.addCurve(to: CGPoint(x: 0.24957*width, y: 0.61574*height), control1: CGPoint(x: 0.25242*width, y: 0.60465*height), control2: CGPoint(x: 0.24938*width, y: 0.60836*height))
        path.addCurve(to: CGPoint(x: 0.28711*width, y: 0.69848*height), control1: CGPoint(x: 0.25039*width, y: 0.65176*height), control2: CGPoint(x: 0.2623*width, y: 0.67805*height))
        path.addCurve(to: CGPoint(x: 0.3602*width, y: 0.72121*height), control1: CGPoint(x: 0.31176*width, y: 0.71875*height), control2: CGPoint(x: 0.33527*width, y: 0.71996*height))
        path.addCurve(to: CGPoint(x: 0.41094*width, y: 0.72227*height), control1: CGPoint(x: 0.37477*width, y: 0.72195*height), control2: CGPoint(x: 0.39043*width, y: 0.72227*height))
        path.addCurve(to: CGPoint(x: 0.43574*width, y: 0.72215*height), control1: CGPoint(x: 0.41922*width, y: 0.72227*height), control2: CGPoint(x: 0.42746*width, y: 0.72223*height))
        path.addCurve(to: CGPoint(x: 0.46043*width, y: 0.72203*height), control1: CGPoint(x: 0.44398*width, y: 0.72211*height), control2: CGPoint(x: 0.45219*width, y: 0.72203*height))
        path.addCurve(to: CGPoint(x: 0.50422*width, y: 0.72281*height), control1: CGPoint(x: 0.47797*width, y: 0.72203*height), control2: CGPoint(x: 0.49152*width, y: 0.72227*height))
        path.addCurve(to: CGPoint(x: 0.51227*width, y: 0.73438*height), control1: CGPoint(x: 0.51168*width, y: 0.72559*height), control2: CGPoint(x: 0.51227*width, y: 0.7323*height))
        path.addCurve(to: CGPoint(x: 0.50426*width, y: 0.7459*height), control1: CGPoint(x: 0.51227*width, y: 0.73855*height), control2: CGPoint(x: 0.51012*width, y: 0.74367*height))
        path.addCurve(to: CGPoint(x: 0.44281*width, y: 0.74672*height), control1: CGPoint(x: 0.4859*width, y: 0.74645*height), control2: CGPoint(x: 0.46578*width, y: 0.74672*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.73492*width, y: 0.74723*height))
        path.addCurve(to: CGPoint(x: 0.72695*width, y: 0.74422*height), control1: CGPoint(x: 0.73223*width, y: 0.74723*height), control2: CGPoint(x: 0.72953*width, y: 0.74621*height))
        path.addLine(to: CGPoint(x: 0.68723*width, y: 0.70461*height))
        path.addCurve(to: CGPoint(x: 0.68031*width, y: 0.70176*height), control1: CGPoint(x: 0.68535*width, y: 0.70273*height), control2: CGPoint(x: 0.68285*width, y: 0.70176*height))
        path.addCurve(to: CGPoint(x: 0.67523*width, y: 0.7032*height), control1: CGPoint(x: 0.67855*width, y: 0.70176*height), control2: CGPoint(x: 0.6768*width, y: 0.70223*height))
        path.addCurve(to: CGPoint(x: 0.63129*width, y: 0.71555*height), control1: CGPoint(x: 0.66203*width, y: 0.71129*height), control2: CGPoint(x: 0.64684*width, y: 0.71555*height))
        path.addCurve(to: CGPoint(x: 0.55766*width, y: 0.67324*height), control1: CGPoint(x: 0.60082*width, y: 0.71555*height), control2: CGPoint(x: 0.57262*width, y: 0.69934*height))
        path.addCurve(to: CGPoint(x: 0.55664*width, y: 0.5909*height), control1: CGPoint(x: 0.54305*width, y: 0.64773*height), control2: CGPoint(x: 0.54266*width, y: 0.61699*height))
        path.addCurve(to: CGPoint(x: 0.625*width, y: 0.54652*height), control1: CGPoint(x: 0.57051*width, y: 0.56504*height), control2: CGPoint(x: 0.59605*width, y: 0.54848*height))
        path.addCurve(to: CGPoint(x: 0.63062*width, y: 0.54633*height), control1: CGPoint(x: 0.62687*width, y: 0.54641*height), control2: CGPoint(x: 0.62875*width, y: 0.54633*height))
        path.addCurve(to: CGPoint(x: 0.69945*width, y: 0.58125*height), control1: CGPoint(x: 0.65793*width, y: 0.54633*height), control2: CGPoint(x: 0.68367*width, y: 0.55937*height))
        path.addCurve(to: CGPoint(x: 0.70313*width, y: 0.67539*height), control1: CGPoint(x: 0.71941*width, y: 0.60895*height), control2: CGPoint(x: 0.72086*width, y: 0.6459*height))
        path.addCurve(to: CGPoint(x: 0.70457*width, y: 0.6873*height), control1: CGPoint(x: 0.70082*width, y: 0.67922*height), control2: CGPoint(x: 0.70141*width, y: 0.68414*height))
        path.addLine(to: CGPoint(x: 0.7441*width, y: 0.72695*height))
        path.addCurve(to: CGPoint(x: 0.74598*width, y: 0.73984*height), control1: CGPoint(x: 0.7482*width, y: 0.73223*height), control2: CGPoint(x: 0.74738*width, y: 0.73684*height))
        path.addCurve(to: CGPoint(x: 0.73484*width, y: 0.74723*height), control1: CGPoint(x: 0.74387*width, y: 0.74426*height), control2: CGPoint(x: 0.73941*width, y: 0.74723*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.63117*width, y: 0.57074*height))
        path.addCurve(to: CGPoint(x: 0.62551*width, y: 0.57098*height), control1: CGPoint(x: 0.6293*width, y: 0.57074*height), control2: CGPoint(x: 0.62742*width, y: 0.57082*height))
        path.addCurve(to: CGPoint(x: 0.57789*width, y: 0.60277*height), control1: CGPoint(x: 0.60523*width, y: 0.57277*height), control2: CGPoint(x: 0.58742*width, y: 0.58469*height))
        path.addCurve(to: CGPoint(x: 0.57863*width, y: 0.66055*height), control1: CGPoint(x: 0.56828*width, y: 0.62102*height), control2: CGPoint(x: 0.56855*width, y: 0.64262*height))
        path.addCurve(to: CGPoint(x: 0.63129*width, y: 0.69102*height), control1: CGPoint(x: 0.58918*width, y: 0.67934*height), control2: CGPoint(x: 0.60938*width, y: 0.69102*height))
        path.addCurve(to: CGPoint(x: 0.67867*width, y: 0.66777*height), control1: CGPoint(x: 0.65012*width, y: 0.69102*height), control2: CGPoint(x: 0.66738*width, y: 0.68254*height))
        path.addCurve(to: CGPoint(x: 0.6848*width, y: 0.6043*height), control1: CGPoint(x: 0.69273*width, y: 0.64934*height), control2: CGPoint(x: 0.69508*width, y: 0.625*height))
        path.addCurve(to: CGPoint(x: 0.63117*width, y: 0.57074*height), control1: CGPoint(x: 0.67457*width, y: 0.58359*height), control2: CGPoint(x: 0.65398*width, y: 0.57074*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.41203*width, y: 0.48285*height))
        path.addCurve(to: CGPoint(x: 0.3543*width, y: 0.45305*height), control1: CGPoint(x: 0.38867*width, y: 0.48285*height), control2: CGPoint(x: 0.36762*width, y: 0.47199*height))
        path.addCurve(to: CGPoint(x: 0.34832*width, y: 0.3816*height), control1: CGPoint(x: 0.33938*width, y: 0.43184*height), control2: CGPoint(x: 0.33715*width, y: 0.40512*height))
        path.addCurve(to: CGPoint(x: 0.40684*width, y: 0.34145*height), control1: CGPoint(x: 0.35941*width, y: 0.35828*height), control2: CGPoint(x: 0.38129*width, y: 0.34328*height))
        path.addCurve(to: CGPoint(x: 0.41219*width, y: 0.34125*height), control1: CGPoint(x: 0.40863*width, y: 0.34133*height), control2: CGPoint(x: 0.41043*width, y: 0.34125*height))
        path.addCurve(to: CGPoint(x: 0.47398*width, y: 0.37781*height), control1: CGPoint(x: 0.43813*width, y: 0.34125*height), control2: CGPoint(x: 0.46121*width, y: 0.35492*height))
        path.addCurve(to: CGPoint(x: 0.47238*width, y: 0.44941*height), control1: CGPoint(x: 0.48664*width, y: 0.40051*height), control2: CGPoint(x: 0.48605*width, y: 0.42727*height))
        path.addCurve(to: CGPoint(x: 0.41203*width, y: 0.48285*height), control1: CGPoint(x: 0.45945*width, y: 0.47035*height), control2: CGPoint(x: 0.43691*width, y: 0.48285*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.41227*width, y: 0.3657*height))
        path.addCurve(to: CGPoint(x: 0.4077*width, y: 0.3659*height), control1: CGPoint(x: 0.41078*width, y: 0.3657*height), control2: CGPoint(x: 0.40926*width, y: 0.36578*height))
        path.addCurve(to: CGPoint(x: 0.37176*width, y: 0.38938*height), control1: CGPoint(x: 0.39266*width, y: 0.36727*height), control2: CGPoint(x: 0.37922*width, y: 0.37605*height))
        path.addCurve(to: CGPoint(x: 0.37055*width, y: 0.43289*height), control1: CGPoint(x: 0.36422*width, y: 0.40285*height), control2: CGPoint(x: 0.36375*width, y: 0.4191*height))
        path.addCurve(to: CGPoint(x: 0.41242*width, y: 0.45848*height), control1: CGPoint(x: 0.37824*width, y: 0.44844*height), control2: CGPoint(x: 0.39465*width, y: 0.45848*height))
        path.addLine(to: CGPoint(x: 0.41242*width, y: 0.45848*height))
        path.addCurve(to: CGPoint(x: 0.44094*width, y: 0.44852*height), control1: CGPoint(x: 0.42297*width, y: 0.45848*height), control2: CGPoint(x: 0.43281*width, y: 0.45504*height))
        path.addCurve(to: CGPoint(x: 0.45574*width, y: 0.3968*height), control1: CGPoint(x: 0.45656*width, y: 0.4359*height), control2: CGPoint(x: 0.46238*width, y: 0.41563*height))
        path.addCurve(to: CGPoint(x: 0.41227*width, y: 0.3657*height), control1: CGPoint(x: 0.44906*width, y: 0.37793*height), control2: CGPoint(x: 0.43199*width, y: 0.3657*height))
        path.closeSubpath()
        return path
    }
}
