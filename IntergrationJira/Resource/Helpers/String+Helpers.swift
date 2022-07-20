//
//  String+Helpers.swift
//  IntergrationJira
//
//  Created by Khushnid Ch on 21/07/22.
//

import UIKit

func verifyUrl(urlString: String?) -> Bool {
    if let urlString = urlString {
        if let url = NSURL(string: urlString) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
    }
    return false
}
