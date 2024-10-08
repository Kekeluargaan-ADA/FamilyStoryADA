//
//  CroppedPhotosPickerOptions.swift
//  CroppedPhotosPickerDemo
//
//  Created by Alex Nagy on 16.04.2024.
//

import Foundation
import SwiftUI
import CropViewController
import TOCropViewController

struct CroppedPhotosPickerOptions {
    var minimumAspectRatio: CGFloat?
    var title: String?
    var showActivitySheetOnDone: Bool?
    var imageCropFrame: CGRect?
    var angle: Int?
    var aspectRatioPreset: CropViewControllerAspectRatioPreset? = .presetCustom
    var customAspectRatio: CGSize? = CGSize(width: 3, height: 4)
    var customAspectRatioName: String? = "3x4"
    var aspectRatioLockEnabled: Bool? = true
    var aspectRatioLockDimensionSwapEnabled: Bool? = false
    var resetAspectRatioEnabled: Bool?
    var toolbarPosition: CropViewControllerToolbarPosition?
    var rotateClockwiseButtonHidden: Bool? = true
    var rotateButtonsHidden: Bool? = true
    var resetButtonHidden: Bool?
    var aspectRatioPickerButtonHidden: Bool? = true
    var doneButtonHidden: Bool?
    var cancelButtonHidden: Bool?
    var activityItems: [Any]?
    var applicationActivities: [UIActivity]?
    var excludedActivityTypes: [UIActivity.ActivityType]?
    var allowedAspectRatios: [CropViewControllerAspectRatioPreset]?
    var hidesNavigationBar: Bool?
    var doneButtonTitle: String?
    var cancelButtonTitle: String?
    var showOnlyIcons: Bool?
    var showCancelConfirmationDialog: Bool?
    var doneButtonColor: Color?
    var cancelButtonColor: Color?
    var reverseContentLayout: Bool?
}
