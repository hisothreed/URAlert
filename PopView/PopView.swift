//
//  PopView.swift
//  PopView
//
//  Created by Hiso3d on 12/7/16.
//  Copyright © 2016 Hiso3d. All rights reserved.
//

import UIKit

public class PopView: UIView {

    
    
    ///// properties
    
    
    private var viewHeight = UIScreen.main.bounds.height
    private var viewWidth = UIScreen.main.bounds.width
    private var alertHeight : CGFloat?
    private var alertWidth : CGFloat?
    private weak var delegate: popVAlertDelegate?
    
    private var buttons : [UIButton?]!
    private var picType : String?
    private var backColor : UIColor?
    private var popv : UIView?
    
    public func setBackgroundsColor (color: UIColor) { backColor = color }
    
    
    
    public enum types {
    
       case warning 
       case error
       case done
        
    }
    
    public enum introAnimations {
    
        case none
        case fadeIn
        
    }
    public enum outroAnimation {
        
        case none
        case fadeOut
        
    }
    
    
    
    //// Initializers
    
    public init(title: String,type : types,description: String?, delegate: popVAlertDelegate){
        super.init(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight))
        self.center.x = viewWidth/2
        self.center.y = viewHeight/2
        self.initalizeWithTitle(title: title,description: description, type: type, delegate: delegate)
    }
    
    public init(title: String,description: String?,type: types, withButtonsWithTitles : [String],delegate: popVAlertDelegate){
        super.init(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight))
        self.center.x = viewWidth/2
        self.center.y = viewHeight/2
        self.initalizeWithButtons(title: title,description: description,type: type, buttonstitles: withButtonsWithTitles, delegate: delegate)
        
    }
    
    
    
    ///// Set-Ups
    
    private func setUpBlurView() {
    
        let blurView : UIView = {
        let view : UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.viewWidth, height: self.viewHeight))
         let blurEffect: UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
         var blurview = UIView()
                    blurview = UIVisualEffectView(effect: blurEffect)
         blurview.frame = view.bounds
         blurview.translatesAutoresizingMaskIntoConstraints = false
                
         view.addSubview(blurview)
            
         return view
            
          }()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapBlur(_:)))
        
        blurView.addGestureRecognizer(tapGesture)
        
        self.addSubview(blurView)
        
        blurView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        blurView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    }
    
    
    private func initalizeWithTitle(title: String,description: String?,type : types, delegate: popVAlertDelegate) {
    
        self.delegate = delegate
        
        let heightOfLabelView = heightForView(text: title)
        
        let popV : UIView = {
        
            let view = UIView(frame: CGRect(x: 0, y: 0, width: self.viewWidth/1.5, height: self.viewHeight/9))
            
            view.frame.size.height = heightOfLabelView
            view.center = self.center
            view.backgroundColor = UIColor.white
            view.layer.cornerRadius = 0
            view.layer.masksToBounds = true
            view.clipsToBounds = false
            return view
        }()
        
        
        let labele : UILabel = {
        
            let label = UILabel(frame: CGRect(x: 0, y:0, width: popV.frame.width - 6 , height: heightOfLabelView))
            label.center.x = popV.frame.width / 2
            label.center.y = 20
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.numberOfLines = 0
            let font = UIFont(name: "Avenir Next", size: 20.0)
            label.font = font
            label.text = title
            label.textColor = UIColor.black
            label.textAlignment = NSTextAlignment.center
            
            
            return label
            
        }()

 
        popV.addSubview(labele)
        
        if description != nil {
            
            let heightOFDetailLabel = heightForView(text: description!)
            
            let detailLabel : UILabel = {
                
                let label = UILabel(frame: CGRect(x: 0, y:0, width: popV.frame.width - 6 , height: heightOFDetailLabel))
                
                label.center.x = popV.frame.width / 2
                label.center.y = heightOFDetailLabel + 10
                
            
                let font = UIFont(name: "Avenir Next", size: 15.0)
                label.font = font
                label.lineBreakMode = NSLineBreakMode.byWordWrapping
                label.numberOfLines = 0
                label.text = description
                label.textColor = UIColor.darkGray
                label.textAlignment = NSTextAlignment.center
                
                return label
                
            }()
            popV.frame.size.height = popV.frame.size.height + heightOFDetailLabel
            popV.addSubview(detailLabel)
            
            
        }

        
        
        
        
        let button : UIButton = {
        
           
            let but = UIButton(frame: CGRect(x: 0, y: popV.frame.height - self.viewHeight/16 , width: popV.frame.width, height: self.viewHeight/16))
            
            but.setTitle("Dismiss", for: UIControlState.normal)
            but.addTarget(self, action: #selector(self.PressedButton(sender:)), for: UIControlEvents.touchUpInside)
            but.setTitleColor(UIColor.blue, for: UIControlState.normal)
            but.layer.masksToBounds = true

            return but
        }()
        
        
        popV.addSubview(button)
        self.popv = popV

        
     }
    
    private func initalizeWithButtons(title: String,description: String?,type: types, buttonstitles : [String],delegate: popVAlertDelegate){
        
        setUpBlurView()
        
        self.delegate = delegate
        
        let heightOfLabelView = heightForView(text: title)
        
        let popV : UIView = {
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: self.viewWidth/1.5, height: self.viewHeight/15))
            
            if buttonstitles.count == 2 {
                
                view.frame.size.height = view.frame.size.height + heightOfLabelView
                
            }else{
            
                let buttonsHeights = Int(self.viewHeight/16) * buttonstitles.count
                view.frame.size.height = view.frame.size.height + heightOfLabelView + CGFloat(buttonsHeights)
                
            }
            
            view.center = self.center
            view.backgroundColor = UIColor.white
            view.layer.cornerRadius = 0
            view.layer.masksToBounds = true
            view.clipsToBounds = false
            
            return view
        }()
        
        popv = popV
        
        
        
        let labele : UILabel = {
            
            let label = UILabel(frame: CGRect(x: 0, y:5, width: popV.frame.width , height: heightOfLabelView))
            
            if buttonstitles.count == 2 {
                
                label.center.x = popV.frame.width / 2
                label.center.y = 20
                
                //                label.center.y = popV.frame.height / 2 - self.viewHeight/32
                
            }
            
            
            
            let font = UIFont(name: "Avenir Next", size: 20.0)
            label.font = font
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.numberOfLines = 0
            label.text = title
            label.textColor = UIColor.black
            label.textAlignment = NSTextAlignment.center
            
            return label
        }()
        
        popV.addSubview(labele)
        
        if description != nil {
            
            let heightOFDetailLabel = heightForView(text: description!)
            
            let detailLabel : UILabel = {
                
                let label = UILabel(frame: CGRect(x: 0, y: labele.bounds.height + 5, width: popV.frame.width, height: heightOFDetailLabel))
                if buttonstitles.count == 2 {
                    
                    label.center.x = popV.frame.width / 2
                    label.center.y = heightOFDetailLabel + 10
                    
                }
                
                
                let font = UIFont(name: "Avenir Next", size: 15.0)
                label.font = font
                label.lineBreakMode = NSLineBreakMode.byWordWrapping
                label.numberOfLines = 0
                label.text = description
                label.textColor = UIColor.darkGray
                label.textAlignment = NSTextAlignment.center
                
                return label
                
            }()
            popV.frame.size.height = popV.frame.size.height + heightOFDetailLabel
            popV.addSubview(detailLabel)
            
            
        }
        
        var buttonss = [UIButton]()
        
        for button in buttonstitles {
            
            let but = UIButton()
            but.setTitle(button, for: UIControlState.normal)
            but.setTitleColor(UIColor.blue, for: UIControlState.normal)
            but.layer.cornerRadius = 0
            but.layer.borderWidth = 0.5
            but.layer.borderColor = UIColor.lightGray.cgColor
            buttonss.append(but)
        }
        
        if (buttonss.count) == 2 {
            
            let buttonleft = buttonss[0]
            let buttonRight = buttonss[1]
            
            
            buttonleft.frame = CGRect(x: 0, y: popV.frame.height - self.viewHeight/16, width: (popv?.frame.width)!/2, height: self.viewHeight/16)
            
            buttonleft.tag = 0
            
            buttonleft.addTarget(self, action: #selector(self.PressedButton(sender:)), for: UIControlEvents.touchUpInside)
            
            popV.addSubview(buttonleft)
            
            
            buttonRight.frame = CGRect(x: (buttonleft.frame.width), y: popV.frame.height - self.viewHeight/16, width: (popv?.frame.width)!/2, height: self.viewHeight/16)
            buttonRight.tag = 1
            buttonRight.addTarget(self, action: #selector(self.PressedButton(sender:)), for: UIControlEvents.touchUpInside)
            
            
            popV.addSubview(buttonRight)
            
            buttons = buttonss
        }else{
        
            buttons = buttonss
            let count = buttonss.count
            for i in 1...count {
            
                print(i)
                print(buttonss.count)
                let cgFloati = CGFloat(i)
                let button = buttonss[i-1]
                button.frame = CGRect(x: 0, y: popV.frame.height - ( cgFloati * self.viewHeight/16), width: (popv?.frame.width)!, height: self.viewHeight/16)
                button.tag = i
                button.addTarget(self, action: #selector(self.PressedButton(sender:)), for: .touchUpInside)
                popV.addSubview(button)
                
                
                
            }
            
        }
        
        self.addSubview(popV)
        
        
    }

    
    
    /////// Methods
    
    public func show(animation: introAnimations) {
    
        let window = UIApplication.shared.keyWindow
        window?.addSubview(self)
        
        setUpBlurView()
        
        switch animation {
        
        case .none :
               self.addSubview(popv!)
               break
        case .fadeIn :
            
               self.popv?.alpha = 0
               self.addSubview(popv!)
               
               UIView.animate(withDuration: 0.2) {
                
                self.popv?.alpha = 1
                
            }
               break
            
        default :
            
            break
            
        }
        
        
        
    }
    
    
    func PressedButton(sender: UIButton) {
    
            delegate?.didPressButton!(alert: self,AtIndexpath: sender.tag)
    }
    
    public func dismiss(withAnimation: outroAnimation) {
        
        
        switch withAnimation {
        
        case .none:
            self.removeFromSuperview()
            break
        case .fadeOut:
            UIView.animate(withDuration: 0.2, animations: {
                
                self.popv?.alpha = 0
                
            }) { (true) in
                
                self.removeFromSuperview()
                
            }
        }
        
        
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func heightForView(text:String) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: (self.viewWidth/1.5), height: 1000))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        let font = UIFont(name: "Avenir Next", size: 18.0)
        label.text = text
        label.font = font
        label.sizeToFit()
        return label.frame.height
    }

    
    func tapBlur(_ sender: UITapGestureRecognizer) {
        self.dismiss(withAnimation: .none)
    }
    
}



   //// protocols

@objc public protocol popVAlertDelegate : NSObjectProtocol {
     @objc optional func didPressButton(alert: PopView,AtIndexpath indexPath : Int)
     @objc optional func willPressBackView(alert: PopView)
}



