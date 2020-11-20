import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {

  //これを、一つ目のTextFormFieldのonFieldSubmittedに入れることによって、
  // return keyを押したときに、次のTextFormFieldに行くようになる。
  // 次のTextFormFieldでは、focusModeプロパティを入れることで動くようになる
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode  = FocusNode();

  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );

  // @override
  // void initState() {
  //   _imageUrlFocusNode.addListener(_updateImageUrl);
  //   super.initState();
  // }


  //disposeを入れないとうまく動かない(メモリーリークを引き起こす恐れがあるため)
  @override
  void dispose() {
    // _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  // void _updateImageUrl() {
  //   if(_imageUrlFocusNode.hasFocus) {
  //     setState(() {
  //
  //     });
  //   }
  // }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if(!isValid) {
      return;
    }
    _form.currentState.save();
    print(_editedProduct.title);
    print(_editedProduct.description);
    print(_editedProduct.price);
    print(_editedProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Edit Product'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.save),
                onPressed: _saveForm
            )
          ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _form,
            child: ListView(children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
              validator: (value) {
                if(value.isEmpty) {
                  return 'Please enter a value';
                }
                return null;
              },
              onSaved: (value) {
                _editedProduct = Product(
                    id: null,
                    title: value,
                    description: _editedProduct.description,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl);
              },
            ),
          TextFormField(
              decoration: InputDecoration(labelText: 'Price'),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
              focusNode: _priceFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
              onSaved: (value) {
                _editedProduct = Product(
                    id: null,
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    price: double.parse(value),
                    imageUrl: _editedProduct.imageUrl);
              },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Description'),
            maxLines: 3,
            keyboardType: TextInputType.multiline,
            onSaved: (value) {
              _editedProduct = Product(
                  id: null,
                  title: _editedProduct.title,
                  description: value,
                  price: _editedProduct.price,
                  imageUrl: _editedProduct.imageUrl);
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
            Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.only(top: 8, right: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey
                  ),
              ),
              child: _imageUrlController.text.isEmpty
                  ? Text('Enter a URL') :
                    FittedBox(
                      child: Image.network(
                        _imageUrlController.text,
                        fit: BoxFit.cover
                      ),
                    ),
            ),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(labelText: 'Image URL'),
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
                controller: _imageUrlController,
                focusNode: _imageUrlFocusNode,
                onFieldSubmitted: (_) {
                  _saveForm();
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      id: null,
                      title: _editedProduct.title,
                      description: _editedProduct.description,
                      price: _editedProduct.price,
                      imageUrl: value);
                },
                //これでURL更新
                onEditingComplete: () {
                  setState(() {

                  });
                },
              ),
            )
          ],)
        ],
        )),
      ),
    );
  }
}
