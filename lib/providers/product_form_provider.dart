import 'package:anda_chill/models/models.dart';
import 'package:flutter/material.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Post product;

  ProductFormProvider(this.product);

  updateAvailability(bool value) {
    print(value);
    this.product.disponible = value;
    notifyListeners();
  }

  bool isValidForm() {
    print(product.nombre);
    print(product.precio);
    print(product.disponible);
    return formKey.currentState?.validate() ?? false;
  }
}
