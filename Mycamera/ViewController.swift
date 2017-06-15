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
    UIView.animate(withDuration: 1.0, delay: 0.0, options: .repeat, animations: {
      self.usa.center.y += 100.0
    }, completion: nil)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBOutlet weak var pictureimage: UIImageView!
  
  @IBOutlet weak var usa: UIImageView!

  @IBAction func cameraButtonAction(_ sender: Any) {
    //カメラかフォトライブラリーどちらかから画像を取得するか選択
    let alertController = UIAlertController(title: "確認", message: "選択してください", preferredStyle: .actionSheet)
    //カメラが利用可能かチェック
    if UIImagePickerController.isSourceTypeAvailable(.camera){
      //カメラを起動するための選択肢を定義
      let cameraAction = UIAlertAction(title: "カメラ", style: .default, handler: {(action:UIAlertAction) in
        //カメラを起動
        let ipc : UIImagePickerController = UIImagePickerController()
        ipc.sourceType = .camera
        ipc.delegate = self
        ipc.present(ipc, animated: true, completion: nil)
      })
      alertController.addAction(cameraAction)
      
    }
      //フォトライブラリーが利用可能かチェック
      if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
        //フォトライブラリーを起動するための選択肢を定義
        let photoLibraryAction = UIAlertAction(title: "フォトライブラリー", style: .default, handler: { (acotion:UIAlertAction) in
          // フォトライブラリーを起動
          let ipc : UIImagePickerController = UIImagePickerController()
          ipc.sourceType = .photoLibrary
          ipc.delegate = self
          self.present(ipc, animated: true,completion: nil)
        })
      alertController.addAction(photoLibraryAction)
        
      
      let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
    
    alertController.popoverPresentationController?.sourceView = view
    
    present(alertController,animated: true, completion: nil)
        alertController.addAction(cancelAction)
    
    }
    
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
    // 表示画面をアンラップしてシェア画面として取り出し
    if let shareImage = pictureimage.image{
      //UIActivityViewControllerに渡す配列を作成
      let shareItems = [shareImage]
      //　[]配列型
      
      let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
      //インスタ出したりとかもできる
      
      //Ipad 特有の設定　落ちない対策
      controller.popoverPresentationController?.sourceView = view
      
      //UIActivityViewControllerを表示
      present(controller, animated: true, completion: nil)
      //閉じる処理がないのでdismissがない
    }
  }

    //撮影が終わった時の呼ばれるdelegateメゾット
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[ String : Any]){
      //撮影した写真をcaptureImageに渡す
      captureImage = info[UIImagePickerControllerOriginalImage] as? UIImage
      //as? キャスト、型を変換する UIimage　！だと落ちる　コンパイルが通らない
      
      //モダールビューを閉じる　dismiss　presentと対義語
      dismiss(animated: true, completion: {
        // エフェクト画面に遷移
        self.performSegue(withIdentifier: "showEffectView", sender:  nil)
      })
    }
  
      //次の画像遷移するときに渡す画像を格納する場所
      var captureImage : UIImage?
  
      override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        //次のインスタンスを取得
        let nextViewcontroller = segue.destination as! EffectViewController
        //次の画面のインスタンスに取得した画像を渡す
        nextViewcontroller.originalImage = captureImage
  }
}
