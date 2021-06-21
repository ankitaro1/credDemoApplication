//
//  SelectEmiCell.swift
//  iOS_Cred_FMA_Core
//
//  Created by Ankit sharma7 on 20/06/21.
//

import UIKit

open class SelectEmiCell: UICollectionViewCell {
    @IBOutlet public var emiSelctionImageView: UIImageView?
    @IBOutlet public var amountTitleLabel: UILabel?
    @IBOutlet public var timePeriodLabel: UILabel?
    @IBOutlet public var calculationLabel: UILabel?
    
    var data: EmiUIModel?
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        self.amountTitleLabel?.textColor = .white
        self.timePeriodLabel?.textColor = UIColor(named: ImageConstants.lightPink)
        self.calculationLabel?.textColor = UIColor(named: ImageConstants.lightPink)
        self.amountTitleLabel?.font = UIFont(name: "Helvetica Neue", size: CGFloat(12))
        self.timePeriodLabel?.font = UIFont(name: "Helvetica Neue", size: CGFloat(12))
        self.calculationLabel?.font = UIFont(name: "Helvetica Neue", size: CGFloat(12))
    }
    
    func setData() {
        self.amountTitleLabel?.text = Constants.currencySymbol + (self.data?.amount.description ?? "") + Constants.perMonthText
        self.timePeriodLabel?.text =  String(format: Constants.timePeriodtext, (self.data?.time.description ?? ""))
        self.calculationLabel?.text = Constants.seeCalculationText
        if self.data?.isSelected ?? false {
            emiSelctionImageView?.image = UIImage.init(named: ImageConstants.filledIcon)
        } else {
            emiSelctionImageView?.image = UIImage.init(named: ImageConstants.unfilledIcon)
        }
    }
}


class EmiUIModel {
    var time: Int
    var amount: CGFloat
    var isSelected: Bool = false
    init(time: Int, amount: CGFloat) {
        self.time = time
        self.amount = amount
    }
}
