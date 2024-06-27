import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_connect.dart';

import '../utility/constants.dart';

class HttpService {
  Future<Response> getItems({required String endpointUrl}) async {
    try {
      return await GetConnect().get('$SERVER_URL/$endpointUrl');
    } catch (e) {
      log('Error: $e');
      return Response(
          body: json.encode({'error': e.toString()}), statusCode: 500);
    }
  }

  Future<Response> addItem(
      {required String endpointUrl, required dynamic itemData}) async {
    try {
      final response =
          await GetConnect().post('$SERVER_URL/$endpointUrl', itemData);
      return response;
    } catch (e) {
      log('Error: $e');
      return Response(
          body: json.encode({'message': e.toString()}), statusCode: 500);
    }
  }

  Future<Response> updateItem(
      {required String endpointUrl,
      required String itemId,
      required dynamic itemData}) async {
    try {
      return await GetConnect()
          .put('$SERVER_URL/$endpointUrl/$itemId', itemData);
    } catch (e) {
      log('Error: $e');
      return Response(
          body: json.encode({'message': e.toString()}), statusCode: 500);
    }
  }

  Future<Response> deleteItem(
      {required String endpointUrl, required String itemId}) async {
    try {
      return await GetConnect().delete('$SERVER_URL/$endpointUrl/$itemId');
    } catch (e) {
      log('Error: $e');
      return Response(
          body: json.encode({'message': e.toString()}), statusCode: 500);
    }
  }
}
