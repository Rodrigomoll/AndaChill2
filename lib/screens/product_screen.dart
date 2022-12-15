import 'dart:ffi';
import 'package:anda_chill/screens/login_screen.dart';
import 'package:anda_chill/services/services.dart';
import 'package:anda_chill/ui/input_decorations.dart';
import 'package:flutter/material.dart';
import 'package:anda_chill/providers/product_form_provider.dart';
import 'package:anda_chill/widgets/widgets.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectedProduct),
      child: _ProductScreenBody(productService: productService),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              Stack(
                children: [
                  ProductImage(url: productService.selectedProduct.picture),
                  Positioned(
                      top: 60,
                      left: 20,
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(Icons.arrow_back_ios_new,
                            size: 40, color: Colors.white),
                      )),
                  Positioned(
                      top: 60,
                      right: 20,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.camera_alt_outlined,
                            size: 40, color: Colors.white),
                      )),
                ],
              ),
              _ProductForm(),
              SizedBox(height: 100),
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save_outlined),
        onPressed: () async {
          if (!productForm.isValidForm()) return;

          await productService.saveOrCreteProduct(productForm.product);
        },
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
            key: productForm.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                SizedBox(height: 10),
                TextFormField(
                  initialValue: product.nombre,
                  onChanged: (value) => product.nombre = value,
                  validator: (value) {
                    if (value == null || value.length < 1)
                      return 'El nombre es obligatorio';
                  },
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'Nombre del post', labelText: 'Nombre'),
                ),
                SizedBox(height: 30),
                TextFormField(
                  initialValue: '${product.precio}',
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                  onChanged: (value) {
                    if (double.tryParse(value) == null) {
                      product.precio = 0;
                    } else {
                      product.precio = double.parse(value);
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecorations.authInputDecoration(
                      hintText: '\$50', labelText: 'Precio'),
                ),
                SizedBox(height: 30),
                SwitchListTile.adaptive(
                  value: product.disponible,
                  title: Text('Disponible'),
                  activeColor: Colors.indigo,
                  onChanged: productForm.updateAvailability,
                ),
                SizedBox(height: 30)
              ],
            )),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5)
          ]);
}