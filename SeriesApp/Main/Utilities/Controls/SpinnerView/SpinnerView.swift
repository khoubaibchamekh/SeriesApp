//
//  SpinnerView.swift
//  SeriesApp
//
//  Created by Khoubaib Chamekh on 10/17/21.
//

import UIKit

@IBDesignable
public class SpinnerView: UIView {
    
    var contentView: UIView?
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var roundView: UIView!
    
    //MARK: - UI Setup
    override public func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
        isUserInteractionEnabled = false
        roundView.layer.cornerRadius = 16
        roundView.layer.borderWidth = 1.0
        roundView.isHidden = true
        contentView?.isHidden = true
    }
    
    private func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "SpinnerView", bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil
        ).first as? UIView
    }
    
    // Show spinner and start animating
    public func startAnimating() {
        isUserInteractionEnabled = true
        contentView?.isHidden = false
        roundView.isHidden = true
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
    }
    
    // Hide spinner and stop animating
    public func stopAnimating() {
        isUserInteractionEnabled = false
        roundView.isHidden = true
        contentView?.isHidden = true
        activityIndicatorView.isHidden = true
        activityIndicatorView.stopAnimating()
    }
}
