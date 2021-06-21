//
//  SelectEmiViewController.swift
//  iOS_Cred_FMA_Core
//
//  Created by Ankit sharma7 on 20/06/21.
//

import UIKit


open class SelectEmiViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate {

    @IBOutlet public var titleLabel: UILabel?
    @IBOutlet public var descLabel: UILabel?
    @IBOutlet public var emiCollectionView: UICollectionView?
    @IBOutlet public var customButton: UIButton?
    @IBOutlet public var containerView: UIView?
    @IBOutlet public var containerViewTopConstraint: NSLayoutConstraint?
    @IBOutlet public var bottomButton: UIButton?
    @IBOutlet public var emiDetailsView: UIView?
    @IBOutlet public var emiTitleLabel: UILabel?
    @IBOutlet public var emiValueLabel: UILabel?
    @IBOutlet public var durationTitleLabel: UILabel?
    @IBOutlet public var durationValueLabel: UILabel?
    @IBOutlet public var downButton: UIButton?
    
    
    var list: [EmiUIModel] = []
    var selectedIndex: Int = 0
    var dismissClosure: () -> Void = {
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setUITextData()
        self.list.first?.isSelected = true
        self.emiCollectionView?.delegate = self
        self.emiCollectionView?.dataSource = self
        self.emiCollectionView?.register(UINib(nibName: "SelectEmiCell", bundle: Constants.sdkBundle), forCellWithReuseIdentifier: "SelectEmiCell")
    }
    
    func setUI() {
        self.emiDetailsView?.isHidden = true
        self.emiDetailsView?.backgroundColor = .clear
        self.titleLabel?.textColor = UIColor(named: ImageConstants.lightCream)
        self.descLabel?.textColor = UIColor(named: ImageConstants.lightCream)
        self.emiTitleLabel?.textColor = UIColor(named: ImageConstants.lightCream)
        self.emiValueLabel?.textColor = UIColor(named: ImageConstants.lightCream)
        self.durationTitleLabel?.textColor = UIColor(named: ImageConstants.lightCream)
        self.durationValueLabel?.textColor = UIColor(named: ImageConstants.lightCream)
        self.containerView?.backgroundColor = UIColor(named: ImageConstants.veryLightBlack)
        self.view.backgroundColor = .clear
        self.emiCollectionView?.backgroundColor = UIColor(named: ImageConstants.veryLightBlack)
        self.customButton?.setTitleColor(UIColor.white, for: .normal)
        self.customButton?.layer.borderWidth = CGFloat(1.0)
        self.customButton?.layer.borderColor = UIColor.white.cgColor
        self.customButton?.layer.cornerRadius = CGFloat(12)
        self.containerView?.layer.cornerRadius = CGFloat(12)
        self.containerView?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.bottomButton?.layer.cornerRadius = CGFloat(12)
        self.bottomButton?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.bottomButton?.setTitleColor(UIColor(named: ImageConstants.lightPink), for: .normal)
        self.bottomButton?.backgroundColor = UIColor(named: ImageConstants.lightPurple)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTouchAction))
        tapGesture.delegate = self
        self.view?.addGestureRecognizer(tapGesture)
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(backgroundTouchAction))
        swipeGesture.direction = .left
        self.view?.addGestureRecognizer(swipeGesture)
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if containerView?.frame.contains(touch.location(in: view)) ?? false {
            return false
        }
        return true
    }
    
    @objc func backgroundTouchAction() {
        dismissClosure()
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUITextData() {
        self.titleLabel?.text = Constants.secondScreenTitle
        self.descLabel?.text = Constants.secondScreenDesc
        self.customButton?.setTitle(Constants.customButtonTitle, for: .normal)
        self.bottomButton?.setTitle(Constants.selectYouBankAccountText, for: .normal)
        self.emiTitleLabel?.text = Constants.emiText
        self.emiValueLabel?.text = self.list[selectedIndex].amount.description +  Constants.perMonthText
        self.durationTitleLabel?.text = Constants.durationText
        self.durationValueLabel?.text = self.list[selectedIndex].time.description + Constants.monthsText
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 4
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SelectEmiCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectEmiCell", for: indexPath) as? SelectEmiCell ?? SelectEmiCell()
        cell.data = self.list[indexPath.row]
        cell.setData()
        cell.backgroundColor = UIColor(named: ImageConstants.collectionCellColors[indexPath.row])
        cell.layer.cornerRadius = CGFloat(12)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row != selectedIndex {
            self.list[selectedIndex].isSelected = false
            self.selectedIndex = indexPath.row
            self.list[indexPath.row].isSelected = true
            self.emiCollectionView?.reloadData()
            self.setUITextData()
        }
    }
    
    @IBAction func bottomButtonPressed(_ sender: UIButton) {
        let targetVC = SelectBankViewController()
        targetVC.modalPresentationStyle = .overCurrentContext
        targetVC.dismissClosure = { [weak self] in
            self?.emiDetailsView?.isHidden = true
            self?.titleLabel?.isHidden = false
            self?.descLabel?.isHidden = false
        }
        self.present(targetVC, animated: false) { [weak self] in
            self?.emiDetailsView?.isHidden = false
            self?.titleLabel?.isHidden = true
            self?.descLabel?.isHidden = true
        }
    }
    
}
