//
//  String+Helpers.swift
//  IntergrationJira
//
//  Created by Khushnid Ch on 21/07/22.
//

import UIKit

extension String {
    var isValidUrl: Bool {
        let regex = "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
}
