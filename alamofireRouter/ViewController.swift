//
//  ViewController.swift
//  alamofireRouter
//
//  Created by SourceKhone on 6/22/19.
//  Copyright © 2019 mrs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//test
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        callApi(productID: "5ce7b3c6a72c4918b83c23df")
    }


    func callApi(productID:String) {
        ApiHelper.sharedInstants.getProduct(productID: productID){ (response: Any, hasErr: Bool) in
            if hasErr == false {
                print(response)
            }else{
                print("error:\(response)")
            }
        }
    }
}

