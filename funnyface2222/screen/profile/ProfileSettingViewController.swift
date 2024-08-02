//
//  ProfileSettingViewController.swift
//  funnyface2222
//
//  Created by Lê Duy Tân on 2/8/24.
//

import UIKit
import AlamofireImage
import Kingfisher
import SETabView

class ProfileSettingViewController: UIViewController, SETabItemProvider {

    var seTabBarItem: UITabBarItem? {
        return UITabBarItem(title: "", image: UIImage(named: "user"), tag: 0)
    }
    var userId: Int = Int(AppConstant.userId.asStringOrEmpty()) ?? 0

    var dataUserEvent: [Sukien] = []
    var dataRecentCommemt: [CommentUser] = []
    
    @IBOutlet weak var cacluachon:UICollectionView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nameTopLabel: UILabel!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameBotLabel: UILabel!
    @IBOutlet weak var eventCountLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var textDefaultLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        backgroundView.backgroundColor = .black
//        isSearchUser = false
        callApiProfile()
        callAPIUserEvent()
        callAPIRecentComment()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cacluachon.register(UINib(nibName: "phanduoicell", bundle: nil), forCellWithReuseIdentifier: "phanduoicell")


        setupUI()
    }
    
    private func setupUI() {
        backButton.setTitle("", for: .normal)
        nameBotLabel.font = .quickSandBold(size: 16)
        nameTopLabel.font = .quickSandBold(size: 16)
        cameraButton.setTitle("", for: .normal)
        editButton.setTitle("   Edit profile", for: .normal)
        editButton.layer.cornerRadius = 8
        editButton.layer.masksToBounds = true
        
        moreButton.setTitle("", for: .normal)
        moreButton.layer.cornerRadius = 8
        moreButton.layer.masksToBounds = true
        
        textDefaultLabel.font = .quickSandMedium(size: 14)
        eventCountLabel.font = .quickSandBold(size: 14)
        commentCountLabel.font = .quickSandBold(size: 14)
        viewCountLabel.font = .quickSandBold(size: 14)
        
        coverImage.image = UIImage(named: "background")
        coverImage.contentMode = .scaleAspectFill

    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: false)
        self.dismiss(animated: true)
    }
    
    @IBAction func editButton(_ sender: Any) {
        
    }
    
    @IBAction func moreButton(_ sender: Any) {
        
    }
    
    func callApiProfile() {
        APIService.shared.getProfile(user: self.userId ) { result, error in
            if let success = result {
                if let idUser = success.id_user{
                    self.nameTopLabel.text = success.user_name ?? ""
//                    self.countEventLabel.text = success.count_sukien?.toString()
//                    self.countCommentLabel.text = success.count_comment?.toString()
//                    self.countViewLabel.text = (success.count_view ?? 0).toString()
//                    self.ipRegisterLabel.text = "Ip Register: " + (success.ip_register ?? "")
//                    self.deviceRegisterLabel.text = "Device Register: " + (success.device_register ?? "")
//                    self.emailLabel.text = success.email ?? ""
                    let escapedString = success.link_avatar?.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
                    if let url = URL(string: escapedString ?? "") {
                        let processor = DownsamplingImageProcessor(size: self.avatarImage.bounds.size)
                        |> RoundCornerImageProcessor(cornerRadius: 50)
                        self.avatarImage.kf.indicatorType = .activity
                        self.avatarImage.kf.setImage(
                            with: url,
                            placeholder: UIImage(named: "placeholderImage"),
                            options: [
                                .processor(processor),
                                .scaleFactor(UIScreen.main.scale),
                                .transition(.fade(1)),
                                .cacheOriginalImage
                            ])
                        {
                            result in
                            switch result {
                            case .success(let value):
                                print("Task done for: \(value.source.url?.absoluteString ?? "")")
                            case .failure(let error):
                                print("Job failed: \(error.localizedDescription)")
                            }
                        }
                    }
                }else{
                    if let message = success.ketqua{
                        let alert = UIAlertController(title: "Error Get Data", message: message, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            switch action.style{
                            case .default:
                                AppConstant.logout()
                                self.navigationController?.pushViewController(loginView(nibName: "loginView", bundle: nil), animated: true)
                            case .cancel:
                                AppConstant.logout()
                                self.navigationController?.pushViewController(loginView(nibName: "loginView", bundle: nil), animated: true)
                            case .destructive:
                                AppConstant.logout()
                                self.navigationController?.pushViewController(loginView(nibName: "loginView", bundle: nil), animated: true)
                            }
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    
    func callAPIUserEvent() {
        APIService.shared.getUserEvent(user:  self.userId) { result, error in
            if let success = result {
                let data = success.list_sukien.compactMap {$0.sukien.first }
                self.dataUserEvent = data
                self.eventCountLabel.text = String(data.count) 
            }
        }
    }
    
    func callAPIRecentComment() {
        APIService.shared.getRecentComment(user: self.userId) { result, error in
            if let success = result {
                self.dataRecentCommemt = success.comment_user.reversed()
                
                if self.dataRecentCommemt.count == 0 {
                    self.commentCountLabel.text = "0"
                } else {
                    self.commentCountLabel.text = String(self.dataRecentCommemt.count)
                }
            }
        }
    }
    
    
    
}

extension ProfileSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
       
            return 1
     
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = DetailSwapVideoVC(nibName: "DetailSwapVideoVC", bundle: nil)
//        var itemLink:DetailVideoModel = DetailVideoModel()
//        itemLink.linkimg = self.listTemplateVideo[indexPath.row].link_image
//        itemLink.link_vid_swap = self.listTemplateVideo[indexPath.row].link_vid_swap
//        itemLink.noidung = self.listTemplateVideo[indexPath.row].noidung_sukien
//        itemLink.id_sukien_video = self.listTemplateVideo[indexPath.row].id_video
//        itemLink.id_video_swap = self.listTemplateVideo[indexPath.row].id_video
//        itemLink.ten_video = self.listTemplateVideo[indexPath.row].ten_su_kien
//        itemLink.idUser = self.listTemplateVideo[indexPath.row].id_user
////            itemLink.thoigian_swap = Floatself.listTemplateVideo[indexPath.row].thoigian_taovid
////\            itemLink.device_tao_vid = self.listTemplateVideo[indexPath.row].thoigian_taovid
//        itemLink.thoigian_sukien = self.listTemplateVideo[indexPath.row].thoigian_taosk
//        itemLink.link_video_goc = self.listTemplateVideo[indexPath.row].link_vid_swap
//        itemLink.ip_tao_vid = self.listTemplateVideo[indexPath.row].id_video
//        itemLink.link_vid_swap = self.listTemplateVideo[indexPath.row].link_vid_swap
//        vc.itemDataSend = itemLink
//        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//        self.present(vc, animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "phanduoicell", for: indexPath) as! phanduoicell
        APIService.shared.getLoveHistory(pageLoad: 1, idUser: String(AppConstant.userId ?? 0 ) ){result, error in
            if let result = result{
                cell.dataList_All = result.list_sukien.compactMap {$0.sukien.first }
                print("lít dataa")
                print(cell.dataList_All)
                cell.listSukien = result.list_sukien
                cell.cacluachon2.reloadData()
            }
        }
        
    //    print(cell.dataList_All[indexPath.row].id_user)
       
        return cell
           
        
     
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
    

        return UICollectionReusableView()
    }
    
}

extension ProfileSettingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if UIDevice.current.userInterfaceIdiom == .pad{
            return CGSize(width: UIScreen.main.bounds.width, height: 800)
        }
        if indexPath.row == 0 {
            return CGSize(width: (UIScreen.main.bounds.width), height: 500)
        }
        return CGSize(width: (UIScreen.main.bounds.width), height: 800)
        
    }
}

