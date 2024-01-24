//
//  Extensions:Functions.swift
//  KnightlyContracts
//
//  Created by Process Fusion on 2022-07-04.
//

import Foundation

func random(digits:Int) -> String {
    var number = String()
    for _ in 1...digits {
       number += "\(Int.random(in: 1...9))"
    }
    return number
}

func randomString(length: Int) -> String {
  let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  return String((0..<length).map{ _ in letters.randomElement()! })
}

extension String
{
    static let formUrlencodedAllowedCharacters =
        CharacterSet(charactersIn: "0123456789" +
            "abcdefghijklmnopqrstuvwxyz" +
            "ABCDEFGHIJKLMNOPQRSTUVWXYZ" +
            "-._* ")

    public func formUrlencoded() -> String
    {
        let encoded = addingPercentEncoding(withAllowedCharacters: String.formUrlencodedAllowedCharacters)
        return encoded?.replacingOccurrences(of: " ", with: "+") ?? ""
    }
}

class HTTPUtils
{
    public class func formUrlencode(_ values: [String: String]) -> String
    {
        return values.map
        { key, value in
            return "\(key.formUrlencoded())=\(value.formUrlencoded())"
        }.joined(separator: "&")
    }
}

extension Date
{
    var ticks: UInt64
    {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
}
