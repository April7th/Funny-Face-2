//
//  EditProfileViewController.swift
//  funnyface2222
//
//  Created by Lê Duy Tân on 2/8/24.
//

import UIKit
import Kingfisher

class EditProfileViewController: UIViewController {
    
    
    var IsStopBoyAnimation = true
    var selectedImage:UIImage!
    var image_Data_Nam:UIImage = UIImage()
    var linkImageVideoSwap:String = ""
    var linkImagePro:String = ""
    
    var userId: Int = Int(AppConstant.userId.asStringOrEmpty()) ?? 0
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var boyImage: UIImageView!
    @IBOutlet weak var uploadLabel: UILabel!
    @IBOutlet weak var yourNameLabel: UILabel!
    @IBOutlet weak var yourNameTextField: UITextField!
    



    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        setupUI()
    }
    
    private func setupUI() {
        backButton.setTitle("", for: .normal)
        saveButton.titleLabel?.font = .quickSandSemiBold(size: 14)
        titleLabel.font = .quickSandBold(size: 20)
        uploadLabel.font = .quickSandSemiBold(size: 14)
        yourNameLabel.font = .quickSandBold(size: 16)
        
        
        
        yourNameTextField.attributedPlaceholder = NSAttributedString(
            string: "@trunghieu",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.font: UIFont.quickSandSemiBold(size: 16)]
        )
//        yourNameTextField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: false)
        self.dismiss(animated: true)
    }

    @IBAction func saveAction(_ sender: Any) {
        
    }
    
    @IBAction func changeAVATR(_ sender: Any) {
        let vc = ChangerAvatarViewController(nibName: "ChangerAvatarViewController", bundle: nil)
//        vc.data = self.dataUserEvent
        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        vc.hidesBottomBarWhenPushed = false
        self.present(vc, animated: true, completion: nil)
    }
       
}
