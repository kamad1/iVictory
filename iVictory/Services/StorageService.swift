
import FirebaseStorage
import Foundation

class StorageService {
    static let shared = StorageService(); private init() {}
    private let bucket = Storage.storage().reference()
    private var profilePictures: StorageReference {bucket.child("profilePictures")}
    
    // выгрузка картинки на сервер
    func upload(data: Data, for userId: String) async throws {
        let filePath = profilePictures.child("\(userId).jpg")
        let outMetaData = StorageMetadata()
        outMetaData.contentType = "image/jpeg"
        let imMetaData = try await filePath.putDataAsync(data, metadata: outMetaData)
        
    }
    
    // для загрузки картинки
    func downloadPP(byUserID id: String) async throws -> Data {
        let filePath = profilePictures.child("\(id).jpg")
        let data = try await filePath.data(maxSize: 5 * 1024 * 1024)
        return data
    }
}
