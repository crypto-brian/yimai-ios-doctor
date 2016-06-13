//
//  YMCommonLayout.swift
//  YiMai
//
//  Created by why on 16/4/16.
//  Copyright © 2016年 why. All rights reserved.
//

import Foundation
import UIKit
import Neon

public class TextFieldCreateParam {
    public var Placholder : String = ""
    public var DefaultText : String = ""
    public var Frame : CGRect = CGRect()
    public var BackgroundColor : UIColor = UIColor.whiteColor()
    public var FontSize : CGFloat = 12.0
    public var FontColor : UIColor = UIColor.blackColor()
    public var BackgroundImageName : String = ""
    public var BackgroundImage : UIImage? = nil
}

public class TextFieldPaddingParam {
    public var LeftPadding : UIView? = nil
    public var RightPadding : UIView? = nil
}

public class YMLayout {
    public static let TextFieldDelegate = YMTextFieldDelegate()

    public static func GetSuitableImageView(imageName: String) -> YMTouchableImageView {
        let suitableImageView = YMTouchableImageView(image: UIImage(named:imageName))
        
        suitableImageView.frame = CGRect(x: 0, y: 0, width: suitableImageView.width.LayoutImgVal(), height: suitableImageView.height.LayoutImgVal())
        return suitableImageView
    }
    
    public static func GetSuitableImageView(image: UIImage) -> YMTouchableImageView {
        let suitableImageView = YMTouchableImageView(image: image)
        
        suitableImageView.frame = CGRect(x: 0, y: 0, width: suitableImageView.width.LayoutImgVal(), height: suitableImageView.height.LayoutImgVal())
        return suitableImageView
    }
    
    public static func GetTouchableImageView(useObject actionTarget: AnyObject, useMethod actionFunc: Selector, imageName: String) -> YMTouchableImageView{
        let newImageView = YMLayout.GetSuitableImageView(imageName)
        let tapGR = UITapGestureRecognizer(target: actionTarget, action: actionFunc)
        
        newImageView.userInteractionEnabled = true
        newImageView.addGestureRecognizer(tapGR)
        
        return newImageView
    }
    
    public static func GetTouchableImageView(useObject actionTarget: AnyObject, useMethod actionFunc: Selector, image: UIImage) -> YMTouchableImageView{
        let newImageView = YMLayout.GetSuitableImageView(image)
        let tapGR = UITapGestureRecognizer(target: actionTarget, action: actionFunc)
        
        newImageView.userInteractionEnabled = true
        newImageView.addGestureRecognizer(tapGR)
        
        return newImageView
    }
    
    public static func GetTouchableView(useObject actionTarget: AnyObject, useMethod actionFunc: Selector, userStringData: String = "") -> YMTouchableView {
        let newView = YMTouchableView()

        newView.UserStringData = userStringData
        let tapGR = UITapGestureRecognizer(target: actionTarget, action: actionFunc)

        newView.userInteractionEnabled = true
        newView.addGestureRecognizer(tapGR)
        newView.backgroundColor = YMColors.White

        return newView
    }
    
    public static func GetTextField(param: TextFieldCreateParam) -> YMTextField {
        let newTextField = YMTextField(aDelegate: nil)

        newTextField.placeholder = param.Placholder
        newTextField.font = UIFont.systemFontOfSize(param.FontSize)
        newTextField.textColor = param.FontColor
        newTextField.delegate = YMLayout.TextFieldDelegate
        newTextField.text = ""
        
        if(nil != param.BackgroundImage) {
            newTextField.background = param.BackgroundImage
        } else if ("" != param.BackgroundImageName) {
            newTextField.background = UIImage(named: param.BackgroundImageName)
        } else {
            newTextField.backgroundColor = param.BackgroundColor
        }
        
        return newTextField
    }
    
    public static func GetTextFieldWithMaxCharCount(createParam: TextFieldCreateParam, maxCharCount: Int) -> YMTextField {
        let textField = YMLayout.GetTextField(createParam)
        textField.MaxCharCount = maxCharCount
        
        return textField
    }
    
    public static func GetCellPhoneField(param: TextFieldCreateParam) -> YMTextField {
        let newTextField = YMLayout.GetTextFieldWithMaxCharCount(param, maxCharCount: 13)
        newTextField.keyboardType = UIKeyboardType.NumberPad

        return newTextField
    }
    
    public static func GetPasswordField(createParam: TextFieldCreateParam) ->  YMTextField {
        let textField = YMLayout.GetTextField(createParam)
        textField.secureTextEntry = true
        return textField
    }
    
    public static func GetPasswordFieldWithMaxCharCount(createParam: TextFieldCreateParam, maxCharCount: Int) ->  YMTextField {
        let textField = YMLayout.GetPasswordField(createParam)
        textField.MaxCharCount = maxCharCount
        return textField
    }
    
    public static func GetStoryboardControllerByName(storyboardName: String) -> UIViewController? {
        let newStroyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return newStroyboard.instantiateInitialViewController()
    }
    
    public static func BodyLayoutWithTop(parentView: UIView, bodyView: UIScrollView) {
        parentView.addSubview(bodyView)
        bodyView.backgroundColor = YMColors.BackgroundGray
        bodyView.fillSuperview()
        bodyView.contentInset = YMSizes.PageScrollBodyInsetOnlyTop
    }
    
    public static func BodyLayoutWithTopAndBottom(parentView: UIView, bodyView: UIScrollView) {
        parentView.addSubview(bodyView)
        bodyView.backgroundColor = YMColors.BackgroundGray
        bodyView.fillSuperview()
        bodyView.contentInset = YMSizes.PageScrollBodyInset
    }
    
    public static func DrawGrayVerticalSpace(parentView: UIView, height: CGFloat, relativeTo: UIView? = nil) -> UIView {
        let spaceView = UIView()
        spaceView.backgroundColor = YMColors.BackgroundGray
        
        parentView.addSubview(spaceView)
        if(nil != relativeTo){
            spaceView.align(Align.UnderMatchingLeft, relativeTo: relativeTo!, padding: 0, width: parentView.width, height: height)
        } else {
            spaceView.anchorAndFillEdge(Edge.Top, xPad: 0, yPad: 0, otherSize: height)
        }
        
        return spaceView
    }
    
    public static func ClearView(view target: UIView) {
        for view in target.subviews{
            view.removeFromSuperview()
        }
    }
    
    public static func SetHScrollViewContentSize(scrollView: UIScrollView, lastSubView: UIView) {
        scrollView.contentSize = CGSizeMake(lastSubView.width + lastSubView.frame.origin.x,
                                            scrollView.height)
    }
    
    public static func SetVScrollViewContentSize(scrollView: UIScrollView, lastSubView: UIView) {
        scrollView.contentSize = CGSizeMake(scrollView.width,
                                            lastSubView.height + lastSubView.frame.origin.y)
    }
}



























