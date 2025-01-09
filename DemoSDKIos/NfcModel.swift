//
//  NfcModel.swift
//  DemoSDKIos
//
//  Created by Loc hv on 9/1/25.
//


import Foundation

struct NfcModel: Codable {
    var sessionId: String?
    var type: String?
    var number: String?
    var name: String?
    var firstName: String?
    var lastName: String?
    var dob: String?
    var sex: String?
    var nationality: String?
    var doe: String?
    var mrz: String?
    var file: String?
    var aaSignature: String?
    var aaPublicKey: String?
    var keyAlg: String?
    var imgLiveNess: String?
    var faceMatching: String?
    var isFaceMatching: Bool?
    var verifyDocumentNumber: Bool = false

    // Base64 fields
    var sodData: String?
    var dg1DataB64: String?
    var dg2DataB64: String?
    var dg13DataB64: String?
    var dg14DataB64: String?
    var fileId: String?
    var bodyFileId: String?

    // DG13VNM data
    var numberVMN: String?
    var nameVNM: String?
    var dobVMN: String?
    var sexVMN: String?
    var nationalityVMN: String?
    var nationVNM: String?
    var religionVMN: String?
    var homeTownVMN: String?
    var residentVMN: String?
    var identificationSignsVNM: String?
    var registrationDateVMN: String?
    var doeVMN: String?
    var nameDadVMN: String?
    var nameMomVMN: String?
    var otherPaper: String?
    var nameCouple: String?
    var raw: String?
    var phone: String?
    var isView: Bool = false
    var statusSuccess: Bool = false
    var visibleButtonDetail: Bool = true
    var kind: String?

    // Decode from JSON
    static func fromJson(_ json: [String: Any]) -> NfcModel? {
        guard let data = try? JSONSerialization.data(withJSONObject: json, options: []) else { return nil }
        return try? JSONDecoder().decode(NfcModel.self, from: data)
    }

    // Encode to JSON for Base64
    func toJsonBase64() -> [String: Any] {
        return [
            "sodData": sodData ?? "",
            "dg1DataB64": dg1DataB64 ?? "",
            "dg2DataB64": dg2DataB64 ?? "",
            "dg13DataB64": dg13DataB64 ?? "",
            "dg14DataB64": dg14DataB64 ?? "",
            "fileId": fileId ?? "",
            "bodyFileId": bodyFileId ?? "",
            "phone": phone ?? ""
        ]
    }

    // Encode to JSON
    func toJson() -> [String: Any] {
        return [
            "sessionId": sessionId ?? "",
            "type": type ?? "",
            "number": number ?? "",
            "name": nameVNM ?? "",
            "dob": dobVMN ?? "",
            "sex": sex ?? "",
            "nationality": nationality ?? "",
            "doe": doeVMN ?? "",
            "MRZ": mrz ?? "",
            "poo": homeTownVMN ?? "",
            "por": residentVMN ?? "",
            "religion": religionVMN ?? "",
            "nation": nationVNM ?? "",
            "registerDate": registrationDateVMN ?? "",
            "symbol": identificationSignsVNM ?? "",
            "father": nameDadVMN ?? "",
            "mother": nameMomVMN ?? "",
            "aaSignature": aaSignature ?? "",
            "aaPublicKey": aaPublicKey ?? "",
            "keyAlg": keyAlg?.split(separator: ".").last ?? "",
            "file": file ?? "",
            "identity": otherPaper ?? "",
            "raw": raw ?? "",
            "couple": nameCouple ?? ""
        ]
    }

    // Encode full JSON
    func toJsonFull() -> [String: Any] {
        return [
            "sessionId": sessionId ?? "",
            "type": type ?? "",
            "number": number ?? "",
            "name": name ?? "",
            "firstName": firstName ?? "",
            "lastName": lastName ?? "",
            "dob": dob ?? "",
            "sex": sex ?? "",
            "nationality": nationality ?? "",
            "doe": doe ?? "",
            "MRZ": mrz ?? "",
            "file": file ?? "",
            "aaSignature": aaSignature ?? "",
            "aaPublicKey": aaPublicKey ?? "",
            "keyAlg": keyAlg?.split(separator: ".").last ?? "",
            "imgLiveNess": imgLiveNess ?? "",
            "faceMatching": faceMatching ?? "",
            "isFaceMatching": isFaceMatching ?? false,
            "verifyDocumentNumber": verifyDocumentNumber,
            "sodData": sodData ?? "",
            "dg1DataB64": dg1DataB64 ?? "",
            "dg2DataB64": dg2DataB64 ?? "",
            "dg13DataB64": dg13DataB64 ?? "",
            "dg14DataB64": dg14DataB64 ?? "",
            "fileId": fileId ?? "",
            "bodyFileId": bodyFileId ?? "",
            "numberVMN": numberVMN ?? "",
            "nameVNM": nameVNM ?? "",
            "dobVMN": dobVMN ?? "",
            "sexVMN": sexVMN ?? "",
            "nationalityVMN": nationalityVMN ?? "",
            "nationVNM": nationVNM ?? "",
            "religionVMN": religionVMN ?? "",
            "homeTownVMN": homeTownVMN ?? "",
            "residentVMN": residentVMN ?? "",
            "identificationSignsVNM": identificationSignsVNM ?? "",
            "registrationDateVMN": registrationDateVMN ?? "",
            "doeVMN": doeVMN ?? "",
            "nameDadVMN": nameDadVMN ?? "",
            "nameMomVMN": nameMomVMN ?? "",
            "otherPaper": otherPaper ?? "",
            "nameCouple": nameCouple ?? "",
            "raw": raw ?? "",
            "phone": phone ?? "",
            "isView": isView,
            "statusSuccess": statusSuccess,
            "visibleButtonDetail": visibleButtonDetail,
            "kind": kind ?? ""
        ]
    }
}
