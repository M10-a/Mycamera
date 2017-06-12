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
  
  var originalImage :UIImage?
  //オプショナル型

  @IBAction func effectButtonAction(_ sender: Any) {
    let filterName = "CIpotoEffectMono"
    
    let rotate = originalImage!.imageOrientation
    //回転角度の取得
    
    let effectFilter = CIFilter(name: filterName)!
    
    //CIFilter 検索すると色々出てくる
    
    effectFilter.setDefaults()
   // パラメータ設定
    
    effectFilter.setValue(inputImage, forKey: kCIInputImageKey)
    
    let outputImage = effectFilter.outputImage
    
    let ciContext = CIContext(options: nil)
    //キャンバスを作る
    
    let cgImage = ciContext.createCGImage(outputImage!, from: outputImage!.extent)
    
    effectImage.image = UIImage(cgImage: cgImage!, scale: 1.0, orientation: rotate)
  }
  
  @IBAction func sharButtonAction(_ sender: Any) {
    
    let controller = UIActivityViewController(activityItems: [effectImage.image!], applicationActivities: nil)
  }
  controller.popoverPre
  
  @IBAction func closeButtonAction(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
}
//したから出てくる画面；モーダル
