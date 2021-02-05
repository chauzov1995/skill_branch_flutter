class PhotoList {
  List<Photo> photos;

  PhotoList({this.photos});

  PhotoList.fromJson(List<dynamic> json) {
    photos = List<Photo>();
    json.forEach((value) {
      photos.add(Photo.fromJson(value as Map<String, dynamic>));
    });
  }

  List<dynamic> toJson() {
    List<dynamic> result = List<dynamic>();

    photos.forEach((element) {
      result.add(element.toJson());
    });

    return result;
  }
}



class Photo {
  Photo({
    this.id,
    this.color,
    this.width,
    this.height,
    this.urls,
    this.likes,
    this.likedByUser,
    this.description,
    this.user,
  });

  String id;
  String color;
  int width;
  int height;
  Urls urls;
  int likes;
  bool likedByUser;
  String description;
  User user;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    id: json["id"] == null ? null : json["id"],
    color: json["color"] == null ? null : json["color"],
    width: json["width"] == null ? null : json["width"],
    height: json["height"] == null ? null : json["height"],
    urls: json["urls"] == null ? null : Urls.fromJson(json["urls"]),
    likes: json["likes"] == null ? null : json["likes"],
    likedByUser: json["liked_by_user"] == null ? null : json["liked_by_user"],
    description: json["description"] == null ? null : json["description"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "color": color == null ? null : color,
    "width": width == null ? null : width,
    "height": height == null ? null : height,
    "urls": urls == null ? null : urls.toJson(),
    "likes": likes == null ? null : likes,
    "liked_by_user": likedByUser == null ? null : likedByUser,
    "description": description == null ? null : description,
    "user": user == null ? null : user.toJson(),
  };
}

class Urls {
  Urls({
    this.raw,
    this.full,
    this.regular,
    this.small,
    this.thumb,
  });

  String raw;
  String full;
  String regular;
  String small;
  String thumb;

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
    raw: json["raw"] == null ? null : json["raw"],
    full: json["full"] == null ? null : json["full"],
    regular: json["regular"] == null ? null : json["regular"],
    small: json["small"] == null ? null : json["small"],
    thumb: json["thumb"] == null ? null : json["thumb"],
  );

  Map<String, dynamic> toJson() => {
    "raw": raw == null ? null : raw,
    "full": full == null ? null : full,
    "regular": regular == null ? null : regular,
    "small": small == null ? null : small,
    "thumb": thumb == null ? null : thumb,
  };
}

class User {
  User({
    this.id,
    this.updatedAt,
    this.username,
    this.name,
    this.firstName,
    this.lastName,
    this.twitterUsername,
    this.portfolioUrl,
    this.bio,
    this.links,
    this.profileImage,
    this.instagramUsername,
    this.totalCollections,
    this.totalLikes,
    this.totalPhotos,
    this.acceptedTos,
  });

  String id;
  DateTime updatedAt;
  String username;
  String name;
  String firstName;
  dynamic lastName;
  String twitterUsername;
  String portfolioUrl;
  String bio;
  Links links;
  ProfileImage profileImage;
  String instagramUsername;
  int totalCollections;
  int totalLikes;
  int totalPhotos;
  bool acceptedTos;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    username: json["username"] == null ? null : json["username"],
    name: json["name"] == null ? null : json["name"],
    firstName: json["first_name"] == null ? null : json["first_name"],
    lastName: json["last_name"],
    twitterUsername: json["twitter_username"] == null ? null : json["twitter_username"],
    portfolioUrl: json["portfolio_url"] == null ? null : json["portfolio_url"],
    bio: json["bio"] == null ? null : json["bio"],
    links: json["links"] == null ? null : Links.fromJson(json["links"]),
    profileImage: json["profile_image"] == null ? null : ProfileImage.fromJson(json["profile_image"]),
    instagramUsername: json["instagram_username"] == null ? null : json["instagram_username"],
    totalCollections: json["total_collections"] == null ? null : json["total_collections"],
    totalLikes: json["total_likes"] == null ? null : json["total_likes"],
    totalPhotos: json["total_photos"] == null ? null : json["total_photos"],
    acceptedTos: json["accepted_tos"] == null ? null : json["accepted_tos"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "username": username == null ? null : username,
    "name": name == null ? null : name,
    "first_name": firstName == null ? null : firstName,
    "last_name": lastName,
    "twitter_username": twitterUsername == null ? null : twitterUsername,
    "portfolio_url": portfolioUrl == null ? null : portfolioUrl,
    "bio": bio == null ? null : bio,
    "links": links == null ? null : links.toJson(),
    "profile_image": profileImage == null ? null : profileImage.toJson(),
    "instagram_username": instagramUsername == null ? null : instagramUsername,
    "total_collections": totalCollections == null ? null : totalCollections,
    "total_likes": totalLikes == null ? null : totalLikes,
    "total_photos": totalPhotos == null ? null : totalPhotos,
    "accepted_tos": acceptedTos == null ? null : acceptedTos,
  };
}

class Links {
  Links({
    this.self,
    this.html,
    this.photos,
    this.likes,
    this.portfolio,
    this.following,
    this.followers,
  });

  String self;
  String html;
  String photos;
  String likes;
  String portfolio;
  String following;
  String followers;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: json["self"] == null ? null : json["self"],
    html: json["html"] == null ? null : json["html"],
    photos: json["photos"] == null ? null : json["photos"],
    likes: json["likes"] == null ? null : json["likes"],
    portfolio: json["portfolio"] == null ? null : json["portfolio"],
    following: json["following"] == null ? null : json["following"],
    followers: json["followers"] == null ? null : json["followers"],
  );

  Map<String, dynamic> toJson() => {
    "self": self == null ? null : self,
    "html": html == null ? null : html,
    "photos": photos == null ? null : photos,
    "likes": likes == null ? null : likes,
    "portfolio": portfolio == null ? null : portfolio,
    "following": following == null ? null : following,
    "followers": followers == null ? null : followers,
  };
}

class ProfileImage {
  ProfileImage({
    this.small,
    this.medium,
    this.large,
  });

  String small;
  String medium;
  String large;

  factory ProfileImage.fromJson(Map<String, dynamic> json) => ProfileImage(
    small: json["small"] == null ? null : json["small"],
    medium: json["medium"] == null ? null : json["medium"],
    large: json["large"] == null ? null : json["large"],
  );

  Map<String, dynamic> toJson() => {
    "small": small == null ? null : small,
    "medium": medium == null ? null : medium,
    "large": large == null ? null : large,
  };
}
