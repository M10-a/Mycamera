//
//  ViewController.swift
//  Mycamera
//
//  Created by 浅野未央 on 2017/06/09.
//  Copyright © 2017年 mio. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UINavigationControllerDelegate , UIImagePickerControllerDelegate {
  //UINavigationControllerDelegate , UIImagePickerControllerDelegateふたつ書かないと機能しない
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBOutlet weak var pictureimage: UIImageView!
  

  @IBAction func cameraButtonAction(_ sender: Any) {
    
//    let alertController = UIAlertController(title: "確認", message: "選択してください", preferredStyle: .actionSheet)
//    
//    let comeraAction = UIAlertAction(title: "カメラ", stile .df)
    
    
    if UIImagePickerController.isSourceTypeAvailable(.camera){
    print("カメラは利用できます")
      let ipc = UIImagePickerController()
      
      ipc.sourceType = .camera
      
      ipc.delegate = self
      
      present(ipc, animated: true, completion: nil)
    }else{
    print("カメラが起動できません")}
  }
  @IBAction func SNSButtonAction(_ sender: Any) {
    
    if let shareImage = pictureimage.image{
      
      let shareItems = [shareImage]
      //　[]配列型
      
      let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
      //インスタ出したりとかもできる

      controller.popoverPresentationController?.sourceView = view
      //Ipad 特有の設定
      
      present(controller, animated: true, completion: nil)
      //閉じる処理がないのディディスミスがない
    }
    
    func UIImagePickerController(_ picker: UIImagePickerController, didFinispickingMadiaWediawithInfo info:[
      String : Any]){
      
      pictureimage.image = info[UIImagePickerControllerOriginalImage]as?UIImage
      //as? キャスト、型を変換する UIimage
      //！だと落ちる　コンパイルが通らない
    //
      dismiss(animated: true, completion: nil)
      //presentと対義語
    }
    
  }
}
