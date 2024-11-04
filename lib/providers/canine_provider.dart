import 'dart:convert';
import 'dart:io';
import 'package:canine_castle_mobile/models/canines_model.dart';
import 'package:canine_castle_mobile/models/pet_breed_model.dart';
import 'package:canine_castle_mobile/models/single_canine_model.dart';
import 'package:canine_castle_mobile/models/state_model.dart';
import 'package:canine_castle_mobile/resources/constants/string_constants.dart';
import 'package:canine_castle_mobile/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import '../keys/keys.dart';
import '../models/lat_long_model.dart';
import '../models/place_prediction_model.dart';
import '../resources/constants/connectivity.dart';
import '../resources/constants/endpoints.dart';
import '../services/api_client.dart';
import 'package:http/http.dart' as http;

class CanineProvider extends ChangeNotifier {
  bool makeCanineProfilePublic = true;
  bool isThisCanineAPedigree = true;

  void toggleMakeCanineProfilePublic() {
    makeCanineProfilePublic = !makeCanineProfilePublic;
    notifyListeners();
  }

  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);

  Future<void> selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedFromDate,
        firstDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedFromDate) {
      selectedFromDate = picked;
      notifyListeners();
    }
  }

  Future<void> selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedToDate,
        firstDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedToDate) {
      selectedToDate = picked;
      notifyListeners();
    }
  }

  void toggleCanineAPedigree() {
    isThisCanineAPedigree = !isThisCanineAPedigree;
    notifyListeners();
  }

  List<File> canineImages = [];

  void addOrRemoveCanineImage({File? image, int index = 0}) {
    if (image != null) {
      debugPrint("To be added:::::: $index");
      canineImages.insert(index, image);
    } else {
      canineImages.removeAt(index);
    }
    notifyListeners();
  }

  final nameOfCanineController = TextEditingController();
  final canineAgeController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();
  final puppyDealAmountController = TextEditingController();
  final noPuppyDealAmountController = TextEditingController();

  bool gettingPetBreeds = false;

  List<PetBreedData> petBreeds = [];
  PetBreedData? selectedBreed;
  void updateSelectedBreed(PetBreedData? breed) {
    selectedBreed = breed;
    notifyListeners();
  }

  Future<bool> getPetBreeds({required BuildContext context}) async {
    notifyListeners();
    bool fetched = false;
    final connected = await connectionChecker();
    if (connected) {
      if (petBreeds.isEmpty) {
        gettingPetBreeds = true;
        notifyListeners();
      }
      try {
        if (context.mounted) {
          (bool, String) requestFetched = await ApiClient().getRequest(
              "breeds/all",
              context: context,
              printResponseBody: false,
              requestName: "Get Pet Breeds");
          gettingPetBreeds = false;
          if (requestFetched.$1) {
            final petBreedModel = petBreedModelFromJson(requestFetched.$2);
            petBreeds = petBreedModel.data;
            fetched = true;
            notifyListeners();
          } else {
            gettingPetBreeds = false;
            notifyListeners();
          }
        }
      } on SocketException catch (_) {
        resMessage = "Internet connection is not available";
        gettingPetBreeds = false;
        notifyListeners();
      } catch (e) {
        resMessage = "Please try again";
        gettingPetBreeds = false;
        debugPrint("Get User Profile Exception::::::::${e.toString()}");
        notifyListeners();
      }
    } else {
      resMessage = "Internet connection is not available";
      gettingPetBreeds = false;
      notifyListeners();
    }
    return fetched;
  }

  List<StateCityData> statesList = [];
  List<StateCityData> citiesList = [];
  bool gettingStates = false;
  bool gettingCities = false;
  StateCityData? selectedState;
  void updateSelectedState(StateCityData? state) {
    selectedState = state;
    notifyListeners();
  }

  StateCityData? selectedCity;
  void updateSelectedCity(StateCityData? state) {
    selectedCity = state;
    notifyListeners();
  }

  Future<bool> getStatesOrCities(
      {required BuildContext context, String stateId = ""}) async {
    notifyListeners();
    bool fetched = false;
    final connected = await connectionChecker();
    if (connected) {
      if (stateId.isEmpty) {
        gettingStates = true;
        citiesList = [];
      } else {
        gettingCities = true;
        citiesList = [];
      }
      String url = stateId.isEmpty
          ? "countries/states/1"
          : "countries/states/lgas/$stateId";
      debugPrint("State ID::::: $stateId The URL is::::::::::::$url");
      notifyListeners();
      try {
        if (context.mounted) {
          (bool, String) requestFetched = await ApiClient().getRequest(url,
              context: context,
              printResponseBody: true,
              requestName: "Get State or Cities");
          gettingCities = false;
          gettingStates = false;
          if (requestFetched.$1) {
            final stateOrCityModel = stateModelFromJson(requestFetched.$2);
            if (stateId.isEmpty) {
              statesList = stateOrCityModel.data;
            } else {
              citiesList = stateOrCityModel.data;
            }
            fetched = true;
            notifyListeners();
          } else {
            gettingPetBreeds = false;
            notifyListeners();
          }
        }
      } on SocketException catch (_) {
        resMessage = "Internet connection is not available";
        gettingPetBreeds = false;
        notifyListeners();
      } catch (e) {
        resMessage = "Please try again";
        gettingPetBreeds = false;
        debugPrint("Get User Profile Exception::::::::${e.toString()}");
        notifyListeners();
      }
    } else {
      resMessage = "Internet connection is not available";
      gettingPetBreeds = false;
      notifyListeners();
    }
    return fetched;
  }

  SingleCanineData? selectedCanine;
  void updateSelectedCanine(SingleCanineData? canine) {
    selectedCanine = canine;
    notifyListeners();
  }

  List<CanineData> myCanines = [];
  List<CanineData> allCanines = [];

  CanineData? selectedFemaleDog;
  void updateSelectedFemaleDog(CanineData? canine) {
    selectedFemaleDog = canine;
    notifyListeners();
  }

  CrossDealData? selectedCrossDeal;
  void updateSelectedCrossDeal(CrossDealData? crossDeal) {
    selectedCrossDeal = crossDeal;
    debugPrint("Cross Deal Selected:: ${selectedCrossDeal?.type}");
    notifyListeners();
  }

  bool gettingCanines = false;
  Future<bool> getCanines(
      {required BuildContext context,
      bool isFetchAll = false,
      bool filterFemaleCanines = false}) async {
    notifyListeners();
    bool fetched = false;
    final connected = await connectionChecker();
    if (connected) {
      gettingCanines = true;
      myCanines = [];
      String url = isFetchAll ? "pets/all" : "pets/all?my-canines=all";
      notifyListeners();
      try {
        if (context.mounted) {
          (bool, String) requestFetched = await ApiClient().getRequest(url,
              context: context,
              printResponseBody: false,
              requestName: "Get Canines");
          gettingCanines = false;
          if (requestFetched.$1) {
            final caninesModel = caninesModelFromJson(requestFetched.$2);
            if (isFetchAll) {
              allCanines = caninesModel.data;
            } else {
              myCanines = caninesModel.data;
              if (filterFemaleCanines) {
                myCanines = myCanines
                    .where((canine) =>
                        canine.gender.toString().toLowerCase() ==
                        female.toLowerCase())
                    .toList();
                // myCanines = myCanines.where(canine).toList();
              }
            }
            fetched = true;
            notifyListeners();
          } else {
            gettingCanines = false;
            notifyListeners();
          }
        }
      } on SocketException catch (_) {
        resMessage = "Internet connection is not available";
        gettingCanines = false;
        notifyListeners();
      } catch (e) {
        resMessage = "Please try again";
        gettingCanines = false;
        debugPrint("Get Canines Exception::::::::${e.toString()}");
        notifyListeners();
      }
    } else {
      resMessage = "Internet connection is not available";
      gettingCanines = false;
      notifyListeners();
    }
    return fetched;
  }

  bool gettingSingleCanine = false;
  Future<bool> getSingleCanine(
      {required BuildContext context, required String canineSlug}) async {
    notifyListeners();
    bool fetched = false;
    final connected = await connectionChecker();
    if (connected) {
      gettingSingleCanine = true;
      String url = "pets/single/$canineSlug";
      notifyListeners();
      try {
        if (context.mounted) {
          (bool, String) requestFetched = await ApiClient().getRequest(url,
              context: context,
              printResponseBody: false,
              requestName: "Get Canines");
          gettingSingleCanine = false;
          if (requestFetched.$1) {
            final singleCanineModel =
                singleCanineModelFromJson(requestFetched.$2);
            selectedCanine = singleCanineModel.data;
            fetched = true;
            notifyListeners();
          } else {
            gettingSingleCanine = false;
            notifyListeners();
          }
        }
      } on SocketException catch (_) {
        resMessage = "Internet connection is not available";
        gettingSingleCanine = false;
        notifyListeners();
      } catch (e) {
        resMessage = "Please try again";
        gettingSingleCanine = false;
        debugPrint("Get Canines Exception::::::::${e.toString()}");
        notifyListeners();
      }
    } else {
      resMessage = "Internet connection is not available";
      gettingSingleCanine = false;
      notifyListeners();
    }
    return fetched;
  }

  bool addingCanine = false;
  String addedCanineID = "";
  bool isErrorMessage = true;

  void resetIsSuccessMessage() {
    isErrorMessage = true;
    notifyListeners();
  }

  Future<bool> addCanine({required BuildContext context}) async {
    notifyListeners();
    bool fetched = false;
    final connected = await connectionChecker();
    final body = {
      "name": nameOfCanineController.text,
      "gender": selectedGender.toLowerCase(),
      "breed": selectedBreed?.id ?? "",
      "address": addressController.text,
      "age": canineAgeController.text,
      "contractBrief": descriptionController.text,
      "puppyDealAmount": puppyDealAmountController.text.replaceAll(",", ""),
      "noPuppyDealAmount": noPuppyDealAmountController.text.replaceAll(",", ""),
      "state": selectedState?.id ?? "",
      "city": selectedCity?.id ?? "",
      "longitude": latLongModel?.results[0].geometry.location?.lng ?? "",
      "latitude": latLongModel?.results[0].geometry.location?.lat ?? "",
      "isPublic": makeCanineProfilePublic,
      "isPedigree": isThisCanineAPedigree
    };
    if (connected) {
      String url = "pets/create";
      notifyListeners();
      try {
        if (context.mounted) {
          addingCanine = true;

          if (addedCanineID.isEmpty) {
            (bool, String) requestFetched = await ApiClient().postRequest(url,
                context: context,
                body: body,
                printResponseBody: true,
                requestName: "Add Canine");
            addingCanine = false;
            if (requestFetched.$1) {
              fetched = true;
              final decodedResponse = json.decode(requestFetched.$2);
              // resMessage = decodedResponse['message'];
              notifyListeners();
              // final canineAddedModel =
              //     canineAddedModelFromJson(requestFetched.$2);
              addedCanineID = "${decodedResponse['data']['id']}";
              uploadPetImages(petId: addedCanineID, context: context);
              notifyListeners();
            } else {
              addingCanine = false;
              resMessage = requestFetched.$2;
              notifyListeners();
            }
          } else {
            uploadPetImages(petId: addedCanineID, context: context);
          }
        }
      } on SocketException catch (_) {
        resMessage = "Internet connection is not available";
        addingCanine = false;
        notifyListeners();
      } catch (e) {
        resMessage = "Please try again";
        addingCanine = false;
        debugPrint("Add Canine Exception::::::::${e.toString()}");
        notifyListeners();
      }
    } else {
      resMessage = "Internet connection is not available";
      addingCanine = false;
      notifyListeners();
    }
    return fetched;
  }

  Future<bool> sendStudRequest({required BuildContext context}) async {
    isErrorMessage = true;
    notifyListeners();
    bool fetched = false;
    final connected = await connectionChecker();
    final body = {
      "deal": selectedCrossDeal?.type,
      "offerAmount": yourOfferController.text.isEmpty
          ? selectedCrossDeal?.amount
          : yourOfferController.text.replaceAll(",", ""),
      "message": messageController.text,
      "male": selectedCanine?.id,
      "female": selectedFemaleDog?.id,
      "expectedDateFrom":
          "${selectedFromDate.year}-${selectedFromDate.month < 10 ? '0${selectedFromDate.month}' : selectedFromDate.month}-${selectedFromDate.day < 10 ? '0${selectedFromDate.day}' : selectedFromDate.day}",
      "expectedDateTo":
          "${selectedToDate.year}-${selectedToDate.month < 10 ? '0${selectedToDate.month}' : selectedToDate.month}-${selectedToDate.day < 10 ? '0${selectedToDate.day}' : selectedToDate.day}"
    };
    if (connected) {
      String url = "studs/create";
      debugPrint("Pay load of stud request:: $body");
      notifyListeners();
      try {
        showAppLoader(context, message: "Sending Request...");
        if (context.mounted) {
          (bool, String) requestFetched = await ApiClient().postRequest(url,
              context: context,
              body: body,
              printResponseBody: true,
              requestName: "Send Stud Request");
          popLoader(context: context, isGoRouterScreen: false);
          if (requestFetched.$1) {
            fetched = true;
            isErrorMessage = false;
            resMessage = "Stud request created successfully";
            notifyListeners();
          } else {
            resMessage = requestFetched.$2;
            notifyListeners();
          }
        }
      } on SocketException catch (_) {
        resMessage = "Internet connection is not available";
        notifyListeners();
      } catch (e) {
        resMessage = "Please try again";
        debugPrint("Send Stud Request Exception::::::::${e.toString()}");
        popLoader(context: context, isGoRouterScreen: false);
        notifyListeners();
      }
    } else {
      resMessage = "Internet connection is not available";
      notifyListeners();
    }
    return fetched;
  }

  PlacePredictionModel? placePredictionModel;
  // Method to fetch place suggestions
  Future<void> fetchPlaceSuggestions(String input,
      {bool resetPrediction = false}) async {
    if (resetPrediction) {
      placePredictionModel = null;
    } else {
      if (input.isEmpty) {
        placePredictionModel = null;
        return;
      }
      final String url =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$googleAPIKey";
      final response = await http.get(Uri.parse(url));
      // debugPrint("Places suggestion response:::: ${response.body}");
      if (response.statusCode == 200) {
        placePredictionModel = placePredictionModelFromJson(response.body);
      } else {
        throw Exception('Failed to load suggestions');
      }
    }
    notifyListeners();
  }

  LatLongModel? latLongModel;
  // Method to fetch place suggestions
  Future<void> getLatLong(String address) async {
    latLongModel = null;
    final String url =
        "https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$googleAPIKey";
    final response = await http.get(Uri.parse(url));
    debugPrint("Lat Long Response::::: ${response.body}");
    if (response.statusCode == 200) {
      latLongModel = latLongModelFromJson(response.body);
      debugPrint(
          "Lat:: ${latLongModel?.results[0].geometry.location?.lat} Long:: ${latLongModel?.results[0].geometry.location?.lng}");
    } else {
      throw Exception('Failed to load suggestions');
    }
    notifyListeners();
  }

  void resetCanineFields() {
    canineImages = [];
    nameOfCanineController.text = "";
    descriptionController.text = "";
    selectedState = null;
    selectedCity = null;
    selectedBreed = null;
    addressController.text = "";
    latLongModel = null;
    noPuppyDealAmountController.text = "";
    puppyDealAmountController.text = "";
    addingCanine = false;
    addedCanineID = "";
    notifyListeners();
  }

  // bool uploadingCanineImages = false;
  Future<bool> uploadPetImages(
      {required dynamic petId, required BuildContext context}) async {
    var networkStatus = await connectionChecker();
    bool infoSent = false;
    notifyListeners();
    const url = "$basedURL/settings/media/uploads";
    debugPrint("URL:::::::$url $petId");

    if (networkStatus) {
      addingCanine = true;
      notifyListeners();

      try {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(url),
        );

        request.headers.addAll(headerWithTokenAndFormDataMapFunc());
        request.fields['for'] = "pet";
        request.fields['lookUp'] = petId;
        request.fields['type'] = "coverImage";

        debugPrint("Request Fields::: ${request.fields}");

        if (canineImages.isNotEmpty) {
          for (var file in canineImages) {
            request.files.add(await http.MultipartFile.fromPath(
              'file[]',
              file.path,
              contentType: MediaType(
                  'application', 'jpg'), // Adjust the media type as needed
            ));
            debugPrint("Added image name ${file.path}");
          }
        } else {
          debugPrint("This product has no image============");
        }

        var response = await request.send();
        debugPrint("The status CODE ===== ${response.statusCode}");
        if (response.statusCode == 200 && context.mounted) {
          infoSent = true;
          getCanines(context: context);
          resetCanineFields();
          Navigator.pop(context);
          notifyListeners();
        } else if (response.statusCode == 401 && context.mounted) {
          response.stream.transform(utf8.decoder).listen((value) {
            resMessage = "${json.decode(value)['message']}";
            debugPrint("Add Product RESPONSE BODY::::$value");
            debugPrint("The status CODE ===== ${response.statusCode}");
            notifyListeners();
          });
          notifyListeners();
        } else {
          response.stream.transform(utf8.decoder).listen((value) {
            resMessage =
                "${json.decode(value)['message'] ?? 'Something went wrong'}";
            debugPrint("Add Product RESPONSE BODY::::$value");
            debugPrint("The status CODE ===== ${response.statusCode}");
            addingCanine = false;
          });
        }
      } catch (error) {
        debugPrint("Error Adding Product ${error.toString()}");
      }
    } else {}

    addingCanine = false;
    notifyListeners();

    return infoSent;
  }

  void resetSearchText() {
    placePredictionModel = null;
    notifyListeners();
  }

  String selectedGender = male;

  void updateSelectedGender(String gender) {
    selectedGender = gender;
    notifyListeners();
  }

  String resMessage = "";
  void clear() {
    resMessage = "";
    notifyListeners();
  }

  bool showAddOffer = false;
  void updateShowAddOffer(bool newValue) {
    yourOfferController.text = "";
    showAddOffer = newValue;
    isErrorMessage = true;
    notifyListeners();
  }

  final messageController = TextEditingController();
  final yourOfferController = TextEditingController();

  List<CrossDealData> crossDealOptions = [];

  void addCrossDeals() {
    crossDealOptions = [];
    if (selectedCanine?.studParams?.noPuppyDealAmount != null) {
      final noPuppyDeal = CrossDealData(
          amount: selectedCanine!.studParams!.noPuppyDealAmount.toString(),
          type: "No Puppy Deal");
      crossDealOptions.add(noPuppyDeal);
      selectedCrossDeal = noPuppyDeal;
    }
    if (selectedCanine?.studParams?.puppyDealAmount != null) {
      final puppyDeal = CrossDealData(
          amount: selectedCanine!.studParams!.puppyDealAmount.toString(),
          type: "Puppy Deal");
      crossDealOptions.add(puppyDeal);
    }
    notifyListeners();
  }
}

class CrossDealData {
  final String type;
  final String amount;
  CrossDealData({
    required this.amount,
    required this.type,
  });
}
