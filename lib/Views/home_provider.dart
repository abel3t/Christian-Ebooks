import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:christianBooks/Models/category.dart';
import 'package:christianBooks/Utils/api-v2.dart';
import 'package:christianBooks/Utils/api_request_status.dart';
import 'package:christianBooks/Utils/functions.dart';

class HomeProvider with ChangeNotifier {
  CategoryFeed top = CategoryFeed();
  CategoryFeed recent = CategoryFeed();
  APIRequestStatus apiRequestStatus = APIRequestStatus.loading;

  getFeeds() async {
    setApiRequestStatus(APIRequestStatus.loading);
    Api.getCategory(Api.popular).then((popular) {
      setTop(popular);
      Api.getCategory(Api.noteworthy).then((newReleases) {
        setRecent(newReleases);
        setApiRequestStatus(APIRequestStatus.loaded);
      }).catchError((e) {
        checkError(e);
        throw (e);
      });
    }).catchError((e) {
      checkError(e);
      throw (e);
    });
  }

  void checkError(e) {
    if (Functions.checkConnectionError(e)) {
      setApiRequestStatus(APIRequestStatus.connectionError);
    } else {
      setApiRequestStatus(APIRequestStatus.error);
    }
  }

  void setApiRequestStatus(APIRequestStatus value) {
    apiRequestStatus = value;
    notifyListeners();
  }

  void setTop(value) {
    top = value;
    notifyListeners();
  }

  CategoryFeed getTop() {
    return top;
  }

  void setRecent(value) {
    recent = value;
    notifyListeners();
  }

  CategoryFeed getRecent() {
    return recent;
  }
}
