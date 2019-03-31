//
//  Extensions.swift
//  MovieDB
//
//  Created by Samarth Paboowal on 31/03/19.
//  Copyright © 2019 Samarth Paboowal. All rights reserved.
//

import Foundation

extension String {
    
    func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
}
