//
//  EffectViewController.swift
//  Mycamera
//
//  Created by 浅野未央 on 2017/06/10.
//  Copyright © 2017年 mio. All rights reserved.
//

import UIKit

class EffectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
      //画面遷移時に元の画像を表示
      effectImage.image = originalImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
  @IBOutlet weak var effectImage: UIImageView!
  
  let filterArray = ["CIphotoEffectMono",
                     "CIphotoEffectChrome",
                     "CIphotoEffectFade",
                     "CIphotoEffectInsutant",
                     "CIphotoEffectNoir",
                     "CIphotoEffectProcess",
                     "CIphotoEffectTonal",
                     "CIphotoEffectTransfer",
                     "CISepiaTone"
  ]
  var filterSelectNumber = 0
  
  //エフェクト前画像　前の画面より画像を設定
  var originalImage :UIImage?
  //オプショナル型

  @IBAction func effectButtonAction(_ sender: Any) {
    let filterName = filterArray[filterSelectNumber]
    
    filterSelectNumber += 1
    
    if filterSelectNumber == filterArray.count {
    filterSelectNumber = 0
    }
    //元の画像の￥回転角度を取得
    let rotate = originalImage!.imageOrientation
    //UIimage形式の画像をCIImage形式の画像に変換
    let inputImage = CIImage(image: originalImage!)
    //フィルターの種類を引数で指定された種類を指定してCIFilterのインスタンスを取得
    let effectFilter = CIFilter(name: filterName)!
    //CIFilter 検索すると色々出てくる
    
    //エフェクトのパラメータを初期化
    effectFilter.setDefaults()
    //インスタンスにエフェクトする元画像を設定
    effectFilter.setValue(inputImage, forKey: kCIInputImageKey)
    //エフェクト後のCIImage形式の画像を取り出す
    let outputImage = effectFilter.outputImage
    //CIContextnoのインスタンスを取得　キャンバスを作る
    let ciContext = CIContext(options: nil)
    //エフェクト後の画像をCIContext上に描画し、結果をCGimageとしてCGimage形式の画像を取得
    let cgImage = ciContext.createCGImage(outputImage!, from: outputImage!.extent)
    //エフェクト後の画像をCGimage形式の画像からUIimage形式の画像に回転角度を指定して変換しImageViewに表示
    effectImage.image = UIImage(cgImage: cgImage!, scale: 1.0, orientation: rotate)
  }
  
  @IBAction func sharButtonAction(_ sender: Any) {
    //UIActivityViewControllerに表示している画像を渡す
  let controller = UIActivityViewController(activityItems: [effectImage.image!], applicationActivities: nil)
  //ipadで落ちない対策
  controller.popoverPresentationController?.sourceView = view
    //UIActivityViewControllerを表示
    present(controller, animated: true, completion: nil)
  }
  @IBAction func closeButtonAction(_ sender: Any) {
    //画像を閉じて前の画面に戻る
    dismiss(animated: true, completion: nil)
  }
  
}
//したから出てくる画面；モーダル
