class Book {
  String? bookName;
  String? publisher;
  String? author;
  String? category;
  int? pageNumber;
  int? publishedYear;
  bool? isPublish;

  Book({this.bookName, this.publisher, this.author, this.category, this.pageNumber, this.publishedYear, this.isPublish});

  Book.fromJson(Map<String, dynamic> json) {
    bookName = json['bookName'];
    publisher = json['publisher'];
    author = json['author'];
    category = json['category'];
    pageNumber = json['pageNumber'];
    publishedYear = json['publishedYear'];
    isPublish = json['isPublish'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookName'] = bookName;
    data['publisher'] = publisher;
    data['author'] = author;
    data['category'] = category;
    data['pageNumber'] = pageNumber;
    data['publishedYear'] = publishedYear;
    data['isPublish'] = isPublish;
    return data;
  }
}
