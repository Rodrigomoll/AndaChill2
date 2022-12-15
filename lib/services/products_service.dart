import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:anda_chill/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'andachill-16196-default-rtdb.firebaseio.com';

  final List<Post> products = [];

  late Post selectedProduct;
  bool isLoading = true;
  bool isSaving = false;

  ProductsService() {
    this.loadProducts();
  }

  Future<List<Post>> loadProducts() async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'Posts.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(resp.body);

    productsMap.forEach((key, value) {
      final tempProduct = Post.fromMap(value);
      tempProduct.id = key;
      this.products.add(tempProduct);
    });

    isLoading = false;
    notifyListeners();

    return this.products;
  }

  Future saveOrCreteProduct(Post product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      // es una creación de producto
      await this.createProduct(product);
    } else {
      //Actualizar el producto
      await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Post product) async {
    final url = Uri.https(_baseUrl, 'Posts/${product.id}.json');
    final resp = await http.put(url, body: product.toJson());
    final decodedData = resp.body;

    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;

    return product.id!;
  }

  Future<String> createProduct(Post product) async {
    final url = Uri.https(_baseUrl, 'Posts.json');
    final resp = await http.post(url, body: product.toJson());
    final decodedData = json.decode(resp.body);

    product.id = decodedData['nombre'];
    this.products.add(product);

    return product.id!;
  }
}
