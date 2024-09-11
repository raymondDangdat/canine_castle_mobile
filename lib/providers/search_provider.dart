import 'package:flutter/material.dart';

import '../resources/constants/image_constant.dart';
// import 'package:http/http.dart' as http;

class SearchProvider extends ChangeNotifier {
  bool _isDogTab = true;
  bool get isDogTab => _isDogTab;

  void updateIsDogTab({bool newValue = true}) {
    _isDogTab = newValue;
    notifyListeners();
  }

  final List<Dog> _dogs = [
    Dog(
        name: "Blackie",
        breed: "Dutch pug",
        images: [oscarBig, oscarBig, oscarBig],
        location: "Lagos",
        age: "2YRS",
        noOfRating: 10,
        rating: 4.5,
        noPuppyDeal: "100,000",
        puppyDeal: "60,000",
        dogOwner: DogOwner(name: "Dev Ray", avatar: devRayAvatar),
        isFavourite: true,
        reviews: [
          Review(
              dogOwner: DogOwner(name: "Dev Ray", avatar: devRayAvatar),
              rating: "4",
              reviewText:
                  "Oscar gene is really a strong one,  My female dog birthed 4 of oscar gene out of 6 puppies"),
          Review(
              dogOwner: DogOwner(name: "Dev Ray", avatar: devRayAvatar),
              rating: "4",
              reviewText:
                  "Oscar gene is really a strong one,  My female dog birthed 4 of oscar gene out of 6 puppies"),
          Review(
              dogOwner: DogOwner(name: "Dev Ray", avatar: devRayAvatar),
              rating: "4",
              reviewText:
                  "Oscar gene is really a strong one,  My female dog birthed 4 of oscar gene out of 6 puppies"),
          Review(
              dogOwner: DogOwner(name: "Dev Ray", avatar: devRayAvatar),
              rating: "4",
              reviewText:
                  "Oscar gene is really a strong one,  My female dog birthed 4 of oscar gene out of 6 puppies"),
        ]),
    Dog(
      name: "Oliver",
      breed: "Dutch pug",
      images: [hanineBig, hanineBig, hanineBig],
      location: "Jos",
      age: "4YRS",
      rating: 4,
      noOfRating: 23,
      isFavourite: false,
      noPuppyDeal: "110,000",
      puppyDeal: "70,000",
      dogOwner: DogOwner(name: "Dev Ray", avatar: johnDoeAvatar),
      reviews: [],
    ),
    Dog(
      name: "Scorpio",
      breed: "Dutch pug",
      images: [oscarBig, oscarBig, oscarBig, oscarBig, oscarBig],
      location: "Ogun",
      age: "3YRS",
      noOfRating: 50,
      rating: 5,
      isFavourite: false,
      noPuppyDeal: "120,000",
      puppyDeal: "80,000",
      dogOwner: DogOwner(name: "Dev Ray", avatar: devRayAvatar),
      reviews: [],
    ),
    Dog(
        name: "Oscar",
        breed: "Dutch pug",
        images: [hanineBig, hanineBig, hanineBig, hanineBig],
        location: "Abuja",
        age: "3YRS",
        noOfRating: 220,
        rating: 4.2,
        noPuppyDeal: "100,000",
        puppyDeal: "60,000",
        dogOwner: DogOwner(name: "Dev Ray", avatar: johnDoeAvatar),
        isFavourite: true,
        reviews: []),
    Dog(
      name: "Dog5",
      breed: "Dutch pug",
      images: [oscarBig, oscarBig, oscarBig],
      location: "Jos",
      age: "5YRS",
      noOfRating: 10,
      rating: 4.5,
      isFavourite: false,
      noPuppyDeal: "150,000",
      puppyDeal: "90,000",
      dogOwner: DogOwner(name: "Dev Ray", avatar: devRayAvatar),
      reviews: [],
    ),
    Dog(
        name: "Dog 6",
        breed: "Dutch pug",
        images: [hanineBig, hanineBig, hanineBig],
        location: "Lagos",
        age: "2YRS",
        noOfRating: 60,
        rating: 3.5,
        noPuppyDeal: "100,000",
        puppyDeal: "60,000",
        dogOwner: DogOwner(name: "Dev Ray", avatar: devRayAvatar),
        isFavourite: false,
        reviews: []),
  ];

  List<Dog> get dogs => _dogs;

  void updateIsFavourite({required Dog dog, required int index}) {
    _dogs[index] = Dog(
        name: dog.name,
        breed: dog.breed,
        images: dog.images,
        location: dog.location,
        age: dog.age,
        noPuppyDeal: dog.noPuppyDeal,
        puppyDeal: dog.puppyDeal,
        rating: dog.rating,
        noOfRating: dog.noOfRating,
        dogOwner: dog.dogOwner,
        isFavourite: dog.isFavourite == false ? true : false,
        reviews: dog.reviews);
    notifyListeners();
  }

  Dog? _selectedDog;
  Dog? get selectedDog => _selectedDog;

  void updateSelectedDog(Dog? dog) {
    _selectedDog = dog;
    notifyListeners();
  }
}

class Dog {
  final String name;
  final String breed;
  final List<String> images;
  final String location;
  final String age;
  final String gender;
  final bool isFavourite;
  final double rating;
  final int noOfRating;
  final String description;
  final String puppyDeal;
  final String noPuppyDeal;
  final DogOwner dogOwner;
  final List<Review> reviews;

  Dog(
      {required this.name,
      required this.breed,
      required this.images,
      required this.location,
      required this.age,
      this.rating = 0,
      this.noOfRating = 0,
      this.gender = "Male",
      this.description =
          "Blackie is an energetic young Dutch pug with a shiny black coat. Blackie also enjoys curling  ...Read more",
      required this.isFavourite,
      required this.noPuppyDeal,
      required this.puppyDeal,
      required this.dogOwner,
      required this.reviews});
}

class DogOwner {
  final String name;
  final String avatar;

  DogOwner({required this.name, required this.avatar});
}

class Review {
  final DogOwner dogOwner;
  final String reviewText;
  final String rating;

  Review(
      {required this.dogOwner, required this.rating, required this.reviewText});
}
