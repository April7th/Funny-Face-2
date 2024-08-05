//
//  ReportViewController.swift
//  funnyface2222
//
//  Created by Lê Duy Tân on 5/8/24.
//

import UIKit

class ReportViewController: UIViewController {
    
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var report1Label:UILabel!
    @IBOutlet weak var report2Label:UILabel!
    @IBOutlet weak var report3Label:UILabel!
    @IBOutlet weak var report4Label:UILabel!
    @IBOutlet weak var otherLabel:UILabel!
    @IBOutlet weak var otherButton:UIButton!
    @IBOutlet weak var cancelButton:UIButton!
    @IBOutlet weak var okButton:UIButton!
    @IBOutlet weak var textFieldInput: UITextField!
    @IBOutlet weak var xButton:UIButton!

    
 
    override func viewDidLoad() {
        super.viewDidLoad()

        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        setupUI()
    }
    
    private func setupUI() {
        titleLabel.textColor = UIColor(hexString: "#FF0000")
        titleLabel.font = .quickSandBold(size: 20)
        report1Label.font = .quickSandBold(size: 16)
        report2Label.font = .quickSandBold(size: 16)
        report3Label.font = .quickSandBold(size: 16)
        report4Label.font = .quickSandBold(size: 16)
        otherLabel.font = .quickSandBold(size: 16)
        
        
        otherButton.setTitle("", for: .normal)
        cancelButton.setTitle("Cancel", for: .normal)
        okButton.setTitle("OK", for: .normal)
        xButton.setTitle("", for: .normal)

        
        cancelButton.setCustomFontForAllState(name: quicksandBold, size: 18)
        okButton.setCustomFontForAllState(name: quicksandBold, size: 18)
        


    }
    
    @IBAction func checkboxTapped(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func okButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func otherButtonTapped(_ sender: UIButton) {
        
    }

   

}


class HalfSizePresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        
        let width = containerView.bounds.width - 16
        let height = containerView.bounds.height / 2
        let x = CGFloat(8)
        let y = (containerView.bounds.height - height) / 2
        
        return CGRect(x: x, y: y, width: width, height: height)
    }

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        // Add a dimming view for a better user experience
        containerView?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }

    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        // Remove the dimming view when the transition ends
        containerView?.backgroundColor = .clear
    }
}
