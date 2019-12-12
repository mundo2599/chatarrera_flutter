class MaterialC {
  String _id;
  String _nombre;
  String _idPadre;
  double _precioVenta;
  double _precioCompra;

  MaterialC(
    this._id, 
    this._nombre, 
    this._precioVenta, 
    this._precioCompra, 
    this._idPadre
  );

  String get id => _id;
  String get nombre => _nombre;
  String get llavePadre => _idPadre;
  double get precioVenta => _precioVenta;
  double get precioCompra => _precioCompra;

  MaterialC.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nombre = map['nombre'];
    this._precioVenta = map['precio_venta'] / 1;
    this._precioCompra = map['precio_compra'] / 1;
    this._idPadre = map['id_padre'];
  }

  @override
  String toString() {
    return nombre;
  }
  
}