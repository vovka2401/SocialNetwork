import SwiftUI

struct LoginView: View {
    @State var isLoginMode = true
    @State var email = ""
    @State var password = ""
    @State var shouldShowImagePicker = false
    @State var image: UIImage?

    var body: some View {
        NavigationStack {
            ScrollView {
                Picker(selection: $isLoginMode, label: Text("Picker here")) {
                    Text("Login")
                        .tag(true)
                    Text("Create Account")
                        .tag(false)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .onChange(of: isLoginMode) { _ in
                    email = ""
                    password = ""
                }
                if !isLoginMode {
                    Button {
                        shouldShowImagePicker.toggle()
                    } label: {
                        VStack {
                            if let image {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 128, height: 128)
                                    .cornerRadius(64)
                            } else {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 64))
                                    .padding()
                                    .foregroundColor(Color(.label))
                            }
                        }
                        .overlay {
                            Circle()
                                .stroke(lineWidth: 3)
                                .fill(Color(.label))
                        }
                        .padding(6)
                    }
                }
                Group {
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                    SecureField("Password", text: $password)
                }
                .padding(12)
                .background(.white)
                .cornerRadius(5)
                Button {
                    if isLoginMode {
                        loginUser()
                    } else {
                        createNewAccount()
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text(isLoginMode ? "Log In" : "Create Account")
                            .foregroundColor(.white)
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.vertical, 12)
                        Spacer()
                    }
                    .background(.blue)
                }
                .cornerRadius(5)
                .padding(.top, 5)
            }
            .padding()
            .navigationTitle(isLoginMode ? "Log In" : "Create Account")
            .background(Color(white: 0, opacity: 0.05).ignoresSafeArea())
        }
        .fullScreenCover(isPresented: $shouldShowImagePicker) {
            ImagePicker(image: $image)
        }
    }
}

extension LoginView {
    private func createNewAccount() {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to create user: ", error)
            } else {
                persistImageToStorage()
                print("Successfully created user: \(result?.user.uid ?? "")")
            }
        }
    }

    private func loginUser() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to login user: ", error)
            } else {
                print("Successfully logged in user: \(result?.user.uid ?? "")")
            }
        }
    }

    private func persistImageToStorage() {
//            guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
//            let ref = FirebaseManager.shared.storage.reference(withPath: uid)
//            guard let imageData = self.image?.jpegData(compressionQuality: 0.5) else { return }
//            ref.putData(imageData, metadata: nil) { metadata, err in
//                if let err = err {
//                    self.loginStatusMessage = "Failed to push image to Storage: \(err)"
//                    return
//                }
//                
//                ref.downloadURL { url, err in
//                    if let err = err {
//                        self.loginStatusMessage = "Failed to retrieve downloadURL: \(err)"
//                        return
//                    }
//                    
//                    self.loginStatusMessage = "Successfully stored image with url: \(url?.absoluteString ?? "")"
//                    print(url?.absoluteString)
//                    
//                    guard let url = url else { return }
//                    self.storeUserInformation(imageProfileUrl: url)
//                }
//            }
        }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
