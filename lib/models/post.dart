class Post {
  String id, title, content, dateWritten, featuredImage;
  String authorName;
  String authorAvatar;
  List<dynamic> comments;
  int votesUp, votesDown;
  List<int> votersUp, votersDown;
  int userId, categoryId;

  Post(
      {this.id,
      this.title,
      this.content,
      this.dateWritten,
      this.featuredImage,
      this.authorName,
      this.authorAvatar,
      this.comments,
      this.votesUp,
      this.votesDown,
      this.votersUp,
      this.votersDown,
      this.userId,
      this.categoryId});
}
