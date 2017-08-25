//
//  ValidatedFile.swift
//  Gfoods
//
//  Created by 林磊 on 2017/8/25.
//  Copyright © 2017年 com.youlu. All rights reserved.

//全部的正则表达式
import UIKit

enum ValidatedType {
    case Email
    case Mobile
    case LoginCode
    case PayForCode
    case IdCard
    case Card
}
func ValidateText(validatedType type: ValidatedType, validateString: String) -> Bool {
    do {
        let pattern: String
        if type == ValidatedType.Email {
            pattern = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
        }else if type == ValidatedType.Mobile {
            pattern = "^1[0-9]{10}$"
        }else if type == ValidatedType.LoginCode{
            pattern = "^[A-Z0-9a-z]{6,18}"
        }else if type == ValidatedType.IdCard{
            pattern = "(^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$)|(^[1-9]\\d{5}\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{2}[0-9Xx]$)"
        }else if type == ValidatedType.Card{
            pattern = "^(\\d{16}|\\d{19})$"
        }else{
            pattern = "^\\d{6}$"
        }
        let regex: NSRegularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
        let matches = regex.matches(in: validateString, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, validateString.characters.count))
        return matches.count > 0
    }
    catch {
        return false
    }
}
//邮箱
func EmailIsValidated(vStr: String) -> Bool {
    return ValidateText(validatedType: ValidatedType.Email, validateString: vStr)
}
//手机号
func MobileIsValidated(vStr: String) -> Bool {
    return ValidateText(validatedType: ValidatedType.Mobile, validateString: vStr)
}
//登录密码
func LoginCodeIsValidated(vStr: String) -> Bool {
    return ValidateText(validatedType: ValidatedType.LoginCode, validateString: vStr)
}
//支付密码
func PayForCodeIsValidated(vStr: String) -> Bool {
    return ValidateText(validatedType: ValidatedType.PayForCode, validateString: vStr)
}
//身份证
func IdCardIsValidated(vStr: String) -> Bool {
    return ValidateText(validatedType: ValidatedType.IdCard, validateString: vStr)
}
//银行卡
func CardIsValidated(vStr: String) -> Bool {
    return ValidateText(validatedType: ValidatedType.Card, validateString: vStr)
}
