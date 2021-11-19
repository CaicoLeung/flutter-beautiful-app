class HotelListData {
  HotelListData({
    this.imagePath = '',
    this.titleText = '',
    this.subText = '',
    this.dist = 1.8,
    this.rating = 4.5,
    this.reviews = 80,
    this.perNight = 180
  });

  String imagePath;
  String titleText;
  String subText;
  double dist;
  double rating;
  int reviews;
  int perNight;

  static List<HotelListData> hotelList = <HotelListData>[
    HotelListData(
      imagePath: 'assets/hotel/hotel_1.png',
      titleText: 'Grand Royal Hotel',
      subText: 'Wembley, London',
      dist: 2.0,
      reviews: 80,
      rating: 4.4,
      perNight: 180,
    ),
    HotelListData(
      imagePath: 'assets/hotel/hotel_2.png',
      titleText: 'Queen Hotel',
      subText: 'Wembley, London',
      dist: 4.0,
      reviews: 74,
      rating: 4.5,
      perNight: 200,
    ),
    HotelListData(
      imagePath: 'assets/hotel/hotel_3.png',
      titleText: 'Grand Royal Hotel',
      subText: 'Wembley, London',
      dist: 3.0,
      reviews: 62,
      rating: 4.0,
      perNight: 60,
    ),
    HotelListData(
      imagePath: 'assets/hotel/hotel_4.png',
      titleText: 'Queen Hotel',
      subText: 'Wembley, London',
      dist: 7.0,
      reviews: 90,
      rating: 4.4,
      perNight: 170,
    ),
    HotelListData(
      imagePath: 'assets/hotel/hotel_5.png',
      titleText: 'Grand Royal Hotel',
      subText: 'Wembley, London',
      dist: 2.0,
      reviews: 240,
      rating: 4.5,
      perNight: 200,
    ),
  ];
}