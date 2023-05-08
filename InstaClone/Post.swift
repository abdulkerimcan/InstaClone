
import Foundation

class Post {
    var date : String?
    var imageUrl : String?
    var likes : Int?
    var postComment : String?
    var postedBy : String?
    
    init(date: String? = nil, imageUrl: String? = nil, likes: Int? = nil, postComment: String? = nil, postedBy: String? = nil) {
        self.date = date
        self.imageUrl = imageUrl
        self.likes = likes
        self.postComment = postComment
        self.postedBy = postedBy
    }
}
