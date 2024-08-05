//
//  testViewController.swift
//  funnyface2222
//
//  Created by quocanhppp on 15/01/2024.
//

import UIKit
import SETabView
import SwiftKeychainWrapper

class testViewController: UIViewController,SETabItemProvider {
    var seTabBarItem: UITabBarItem? {
        return UITabBarItem(title: "haha", image: UIImage(named: "notification"), tag: 0)
    }
    var dataList_All: [Sukien] = []
    var dataDetail: [EventModel] = []
    var dataComment : [DataComment] = []
    
    @IBOutlet weak var notiLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var commentNotiTableView: UITableView!

    
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        callAPIgetdataComment()
    }
    
    private func setupUI() {
        notiLabel.font = .quickSandBold(size: 24)
        searchButton.setTitle("", for: .normal)
        commentNotiTableView.backgroundColor = .clear
        commentNotiTableView.register(cellType: CommentNotificationTableViewCell.self)
        if let url = URL(string: AppConstant.linkAvatar.asStringOrEmpty()) {
//            profileImage.af.setImage(withURL: url)
        }
        
    }
    func callAPIgetdataComment() {
        APIService.shared.getPageComment(page: 1, idUser: String(AppConstant.userId ?? 0)) { result, error in
            if let success = result{
                self.dataComment = success.comment
//                self.maxPage = 1
                var dataNewComment : [DataComment] = self.dataComment
                if let number_user: Int = KeychainWrapper.standard.integer(forKey: "number_user"){
                    for item in 0..<number_user{
                        let idUserNumber = "id_user_" + String(item)
                        if let idUser: String = KeychainWrapper.standard.string(forKey: idUserNumber){
                            var kiemtra = 0
                            for itemDataComment in dataNewComment{
                                if (itemDataComment.noi_dung_cmt)?.urlEncoded == idUser{
                                    dataNewComment.remove(at: kiemtra)
                                    kiemtra = kiemtra - 1
                                }else{
                                    kiemtra = kiemtra + 1
                                }
                            }
                        }
                    }
                    self.dataComment = dataNewComment
                }
                self.commentNotiTableView.reloadData()
                
            }
        }
    }
    
   

}

extension testViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataComment.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentNotificationTableViewCell", for: indexPath) as? CommentNotificationTableViewCell else {
            return UITableViewCell()
        }
        let linkImagePro = dataComment[indexPath.row].avatar_user?.replacingOccurrences(of: "/var/www/build_futurelove", with: "https://futurelove.online", options: .literal, range: nil)
        cell.id_comment = "\(dataComment[indexPath.row].id_comment)"
        cell.id_user_comment = "\(dataComment[indexPath.row].id_user)"
        cell.linkAvatar = linkImagePro ?? ""
        cell.configCellComment(model: dataComment[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
   
    
}

extension testViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
    }
    
    
}
