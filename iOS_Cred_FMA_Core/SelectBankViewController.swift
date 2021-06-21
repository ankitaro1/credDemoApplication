//
//  SelectBankViewController.swift
//  iOS_Cred_FMA_Core
//
//  Created by Ankit sharma7 on 20/06/21.
//

import UIKit

open class SelectBankViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet public var titleLabel: UILabel?
    @IBOutlet public var descLabel: UILabel?
    @IBOutlet public var bankNameLabel: UILabel?
    @IBOutlet public var bankIdLabel: UILabel?
    @IBOutlet public var bankButton: UIButton?
    @IBOutlet public var changeAccountButton: UIButton?
    @IBOutlet public var bottomButton: UIButton?
    @IBOutlet public var containerView: UIView?
    var dismissClosure: () -> Void = {
    }
    
    var bankIsSelected: Bool = false
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setUITextData()
        setUI()
    }
    
    func setUITextData() {
        self.titleLabel?.text = Constants.thirdScreenTitle
        self.descLabel?.text = Constants.thirdScreenDesc
        self.changeAccountButton?.setTitle(Constants.changeAccountTitle, for: .normal)
        self.bottomButton?.setTitle(Constants.selectYouBankAccountText, for: .normal)
        self.bankNameLabel?.text = Constants.bankNameText
        self.bankIdLabel?.text = Constants.bankId
        self.bottomButton?.setTitle(Constants.thirdScreenBottomBtnTitle, for: .normal)
    }
    
    func setUI() {
        self.titleLabel?.textColor = UIColor(named: ImageConstants.lightCream)
        self.descLabel?.textColor = UIColor(named: ImageConstants.lightCream)
        self.view.backgroundColor = .clear
        self.containerView?.backgroundColor = UIColor(named: ImageConstants.thirdBlackColor)
        self.changeAccountButton?.layer.borderWidth = CGFloat(1.0)
        self.changeAccountButton?.layer.borderColor = UIColor.white.cgColor
        self.changeAccountButton?.layer.cornerRadius = CGFloat(12)
        self.bankNameLabel?.textColor = .white
        self.bankIdLabel?.textColor = UIColor.gray
        self.changeAccountButton?.setTitleColor(.white, for: .normal)
        self.bottomButton?.layer.cornerRadius = CGFloat(12)
        self.bottomButton?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.bottomButton?.setTitleColor(UIColor(named: ImageConstants.lightPink), for: .normal)
        self.bottomButton?.backgroundColor = UIColor(named: ImageConstants.lightPurple)
        self.containerView?.layer.cornerRadius = CGFloat(12)
        self.containerView?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTouchAction))
        tapGesture.delegate = self
        self.view?.addGestureRecognizer(tapGesture)
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(backgroundTouchAction))
        swipeGesture.direction = .left
        self.view?.addGestureRecognizer(swipeGesture)
    }
    
    @objc func backgroundTouchAction() {
        dismissClosure()
        self.dismiss(animated: true, completion: nil)
    }
    
    func setSelectionIcon() {
        if self.bankIsSelected {
            bankButton?.setImage(UIImage.init(named: ImageConstants.filledIcon), for: .normal)
        } else {
            bankButton?.setImage(UIImage.init(named: ImageConstants.unfilledIcon), for: .normal)
        }
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if containerView?.frame.contains(touch.location(in: view)) ?? false {
            return false
        }
        return true
    }

    @IBAction func bankButtonPressed(_ sender: UIButton) {
        self.bankIsSelected = !self.bankIsSelected
        self.setSelectionIcon()
    }
    
    

}
