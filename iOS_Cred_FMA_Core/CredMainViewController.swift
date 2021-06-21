//
//  CredMainViewController.swift
//  iOS_Cred_FMA_Core
//
//  Created by Ankit sharma7 on 20/06/21.
//

import UIKit
import HGCircularSlider

open class CredMainViewController: UIViewController {

    @IBOutlet public var titleLabel: UILabel?
    
    @IBOutlet public var descLabel: UILabel?
    
    @IBOutlet public var bottomButton: UIButton?
    
    @IBOutlet public var circularContentView: UIView?
    
    @IBOutlet public var mainContentView: UIView?
    
    @IBOutlet public var mainConstainerViewTopConstraint: NSLayoutConstraint?
    
    @IBOutlet public var downButton: UIButton?
    @IBOutlet public var circularView: CircularSlider?
    @IBOutlet public var creditedAmountLabel: UILabel?
    @IBOutlet public var amountValueLabel: UILabel?
    
    var selectedAmount: CGFloat = 0
    
    override open  func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setUITextData()
        setUpCircularView()
    }
    
    func setUI() {
        self.titleLabel?.textColor = UIColor(named: ImageConstants.lightCream)
        self.descLabel?.textColor = UIColor(named: ImageConstants.lightCream)
        self.view.backgroundColor = .black
        self.mainContentView?.layer.cornerRadius = CGFloat(12)
        self.mainContentView?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.mainContentView?.backgroundColor = UIColor(named: ImageConstants.lightBlack)
        self.bottomButton?.setTitleColor(UIColor(named: ImageConstants.lightPink), for: .normal)
        self.bottomButton?.backgroundColor = UIColor(named: ImageConstants.lightPurple)
        self.circularContentView?.layer.cornerRadius = CGFloat(12)
        self.bottomButton?.layer.cornerRadius = CGFloat(12)
        self.bottomButton?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func setUpCircularView() {
        circularView?.diskFillColor = .clear
        circularView?.endThumbStrokeColor = .clear
        circularView?.endThumbStrokeHighlightedColor = .clear
        circularView?.trackColor = UIColor(named: ImageConstants.lightPink) ?? .black
        circularView?.trackFillColor = UIColor(named: ImageConstants.lightBlack) ?? .black
        circularView?.backgroundColor = .clear
        circularView?.trackShadowColor = .clear
        circularView?.diskColor = .clear
        circularView?.maximumValue = 487891
        circularView?.minimumValue = 0
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(circularViewTapped))
        self.view?.addGestureRecognizer(tapGesture)
        self.creditedAmountLabel?.text = Constants.creditedAmountText
        self.amountValueLabel?.text = Constants.currencySymbol + CGFloat(round(100*(circularView?.endPointValue ?? 0)/100)).description
    }
    
    @objc
    func circularViewTapped() {
        self.amountValueLabel?.text = Constants.currencySymbol + CGFloat(round(100*(circularView?.endPointValue ?? 0)/100)).description
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        circularViewTapped()
    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        circularViewTapped()
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        circularViewTapped()
    }
    
    func setUITextData() {
        self.downButton?.isHidden = true
        self.titleLabel?.text = Constants.firstScreenTitle
        self.descLabel?.text = Constants.firstScreenDesc
        self.bottomButton?.setTitle(Constants.firstScreenBottomButtonTitle, for: .normal)
    }
    
    @IBAction open  func bottomButtomPressed(_ sender: UIButton) {
        self.selectedAmount = circularView?.endPointValue ?? 0
        let targetVC = SelectEmiViewController()
        let emiOption1 = EmiUIModel(time: 12, amount: CGFloat(round(100*(selectedAmount/12)/100)))
        let emiOption2 = EmiUIModel(time: 9, amount: CGFloat(round(100*(selectedAmount/9)/100)))
        let emiOption3 = EmiUIModel(time: 6, amount: CGFloat(round(100*(selectedAmount/6)/100)))
        let emiOption4 = EmiUIModel(time: 3, amount: CGFloat(round(100*(selectedAmount/3)/100)))
        targetVC.list = [emiOption1, emiOption2, emiOption3, emiOption4]
        targetVC.containerViewTopConstraint?.constant = self.mainConstainerViewTopConstraint?.constant ?? 0
        targetVC.modalPresentationStyle = .overCurrentContext
        targetVC.dismissClosure = { [weak self] in
            self?.setUITextData()
        }
        self.present(targetVC, animated: false) {
            self.titleLabel?.text = Constants.creditAmountText
            self.descLabel?.text = Constants.currencySymbol + CGFloat(round(100*(self.selectedAmount)/100)).description
            self.downButton?.isHidden = false
        }
    }
    
    
    
    
}
