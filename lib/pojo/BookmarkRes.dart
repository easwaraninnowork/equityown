
 class BookmarkRes {

  var message;

   String getMessage() {
    return message;
  }

  BookmarkRes.fromJson(Map<String, dynamic> json) {
   message = json['message'];
  }

   void setMessage(String message) {
    this.message = message;
  }

}