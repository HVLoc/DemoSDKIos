//
//  CCCDVerificationView.swift
//  DemoSDKIos
//
//  Created by Loc hv on 8/1/25.
//
import SwiftUI

struct CCCDVerificationView: View {
    let data: NfcModel // Struct này đại diện cho dữ liệu CCCD của bạn.
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Xác thực CCCD")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                // Ảnh khuôn mặt
//                HStack {
//                    Image(uiImage: data.file) // Ảnh từ dữ liệu
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 100, height: 100)
//                        .clipShape(Circle())
//                    
//                    Image(uiImage: data.imgLiveNess) // Ảnh chụp live
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 100, height: 100)
//                        .clipShape(Circle())
//                }
//                .frame(maxWidth: .infinity)
//                .padding(.bottom)
//                
                Text("Kết quả: \(data.faceMatching)%")
                    .font(.headline)
//                    .foregroundColor(data.faceMatching > 80 ? .green : .red)
                    .padding(.bottom)
                
                Divider()
                
                // Thông tin chi tiết
                Group {
                    InfoRow(label: "Họ và tên:", value: data.nameVNM ?? "")
                    InfoRow(label: "CCCD Số:", value: data.number ?? "")
                    InfoRow(label: "Giấy tờ khác:", value: data.otherPaper ?? "Không")
                    InfoRow(label: "Ngày sinh:", value: data.dobVMN ?? "")
                    InfoRow(label: "Giới tính:", value: data.sexVMN ?? "")
                    InfoRow(label: "Quốc gia:", value: data.nationalityVMN ?? "")
                    InfoRow(label: "Tôn giáo:", value: data.religionVMN ?? "")
                    InfoRow(label: "Dân tộc:", value: data.nationVNM ?? "")
                    InfoRow(label: "Quê quán:", value: data.homeTownVMN ?? "")
                    InfoRow(label: "Nơi thường trú:", value: data.residentVMN ?? "")
                    InfoRow(label: "Dấu hiệu nhận biết:", value: data.identificationSignsVNM ?? "")
                    InfoRow(label: "Ngày cấp:", value: data.registrationDateVMN ?? "")
                    InfoRow(label: "Ngày hết hạn:", value: data.doeVMN ?? "")
                    InfoRow(label: "Tên bố:", value: data.nameDadVMN ?? "Không có")
                    InfoRow(label: "Tên mẹ:", value: data.nameMomVMN ?? "Không có")
                }
                
                Spacer()
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss() // Đóng màn hình
                }) {
                    Text("Quay lại")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
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
    let value: String?
    
    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.gray)
            Spacer()
            Text( value ?? "" )
                .font(.subheadline)
        }
    }
}

func presentCCCDVerificationView(data: [String: Any]) {
    // Parse dữ liệu nhận từ Flutter thành đối tượng CCCDData
    guard let parsedData = NfcModel.fromJson(data) else { return }
    
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
