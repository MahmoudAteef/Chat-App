class Category{
  static String musicID = 'music';
  static String moviesID = 'movies';
  static String sportsID = 'sports';

  String id;
  late String image;
  late String title;
  Category(this.title,this.image,this.id);
  Category.fromId(this.id){
      image = 'assets/images/$id.png';
      title = id;

  }
  static List<Category> getCategories(){
    return [
      Category.fromId(musicID),
      Category.fromId(moviesID),
      Category.fromId(sportsID),
    ];
  }
}