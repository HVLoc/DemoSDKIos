//
//  CCCDVerificationView.swift
//  DemoSDKIos
//
//  Created by Loc hv on 8/1/25.
//
import SwiftUI

struct CCCDVerificationView: View {
    let data: CCCDData // Struct này đại diện cho dữ liệu CCCD của bạn.
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Xác thực CCCD")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                // Ảnh khuôn mặt
                HStack {
                    Image(uiImage: data.citizenImage) // Ảnh từ dữ liệu
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                    
                    Image(uiImage: data.liveImage) // Ảnh chụp live
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom)
                
                Text("Kết quả: \(data.matchResult)%")
                    .font(.headline)
                    .foregroundColor(data.matchResult > 80 ? .green : .red)
                    .padding(.bottom)
                
                Divider()
                
                // Thông tin chi tiết
                Group {
                    InfoRow(label: "Họ và tên:", value: data.fullName)
                    InfoRow(label: "CCCD Số:", value: data.cccdNumber)
                    InfoRow(label: "Ngày sinh:", value: data.birthDate)
                    InfoRow(label: "Giới tính:", value: data.gender)
                    InfoRow(label: "Quốc gia:", value: data.nationality)
                    InfoRow(label: "Tôn giáo:", value: data.religion)
                    InfoRow(label: "Dân tộc:", value: data.ethnicity)
                    InfoRow(label: "Quê quán:", value: data.hometown)
                    InfoRow(label: "Nơi thường trú:", value: data.residence)
                    InfoRow(label: "Dấu hiệu nhận biết:", value: data.distinctiveSigns)
                    InfoRow(label: "Ngày cấp:", value: data.issueDate)
                    InfoRow(label: "Ngày hết hạn:", value: data.expiryDate)
                    InfoRow(label: "Tên bố:", value: data.fatherName)
                    InfoRow(label: "Tên mẹ:", value: data.motherName)
                }
                
                Spacer()
                
                Button(action: {
                    // Hành động khi nhấn Tiếp tục
                }) {
                    Text("Tiếp tục")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(8)
                }
                .padding(.top)
            }
            .padding()
        }
    }


}

// Hàng hiển thị thông tin
struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .font(.subheadline)
        }
    }
}

func presentCCCDVerificationView(data: [String: Any]) {
    // Parse dữ liệu nhận từ Flutter thành đối tượng CCCDData
    let parsedData = parseCCCDData(from: data)
    
    // Khởi tạo view SwiftUI
    let cccdView = CCCDVerificationView(data: parsedData)
    
    // Sử dụng UIHostingController để nhúng SwiftUI
    let hostingController = UIHostingController(rootView: cccdView)
    
    if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
        rootViewController.present(hostingController, animated: true, completion: nil)
    } else {
        print("Root view controller not found")
    }
}

// Ví dụ hàm parse để chuyển đổi String -> CCCDData
func parseCCCDData(from data: [String: Any]) -> CCCDData {
    return CCCDData(
        citizenImage: UIImage(named: "citizen") ?? UIImage(), // Thay bằng ảnh thực
        liveImage: UIImage(named: "live") ?? UIImage(),       // Thay bằng ảnh thực
        matchResult: data["matchResult"] as? Int ?? 0,
        fullName: data["name"] as? String ?? "",
        cccdNumber: data["number"] as? String ?? "",
        birthDate: data["dob"] as? String ?? "",
        gender: data["sex"] as? String ?? "",
        nationality: data["nationality"] as? String ?? "",
        religion: data["religion"] as? String ?? "",
        ethnicity: data["nation"] as? String ?? "",
        hometown: data["poo"] as? String ?? "",
        residence: data["por"] as? String ?? "",
        distinctiveSigns: data["symbol"] as? String ?? "",
        issueDate: data["registerDate"] as? String ?? "",
        expiryDate: data["doe"] as? String ?? "",
        fatherName: data["father"] as? String ?? "",
        motherName: data["mother"] as? String ?? ""
    )
}

// Dữ liệu mẫu
struct CCCDData {
    var citizenImage: UIImage
    var liveImage: UIImage
    var matchResult: Int
    var fullName: String
    var cccdNumber: String
    var birthDate: String
    var gender: String
    var nationality: String
    var religion: String
    var ethnicity: String
    var hometown: String
    var residence: String
    var distinctiveSigns: String
    var issueDate: String
    var expiryDate: String
    var fatherName: String
    var motherName: String
}

struct CCCDVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        CCCDVerificationView(
            data: CCCDData(
                citizenImage: UIImage(named: "citizen")!,
                liveImage: UIImage(named: "live")!,
                matchResult: 90,
                fullName: "Hà Văn Lộc",
                cccdNumber: "020098007724",
                birthDate: "18/08/1998",
                gender: "Nam",
                nationality: "Việt Nam",
                religion: "Không",
                ethnicity: "Nùng",
                hometown: "X. Chi Lăng, Chi Lăng, Lạng Sơn",
                residence: "Thôn Làng Đồn, X. Chi Lăng, Chi Lăng, Lạng Sơn",
                distinctiveSigns: "Nốt ruồi C:1cm dưới sau đuôi mắt phải",
                issueDate: "02/10/2023",
                expiryDate: "18/08/2038",
                fatherName: "Hà Văn Thắng",
                motherName: "Nông Thị Dinh"
            )
        )
    }
}
