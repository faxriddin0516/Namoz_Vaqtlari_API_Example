//
//  CustomModal.swift
//  Namoz_Vaqtlari_API
//
//  Created by MacAir on 03/01/23.
//

import Foundation

struct TimeList: Decodable {
    
    let date     : String
    let weekdate : String
    let result   : Result
}
struct Result: Decodable {
    let tong_saharlik : String
    let quyosh       : String
    let peshin       : String
    let asr          : String
    let shom_iftor   : String
    let xufton       : String
}
