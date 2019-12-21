class MaterialC {
  String id;
  String nombre;
  String idPadre;
  double precio;
  List<MaterialC> hijos = <MaterialC>[];

  MaterialC({
    this.id,
    this.nombre,
    this.precio,
    this.idPadre,
    this.hijos = const <MaterialC>[],
  });

  MaterialC.fromMap(Map<String, dynamic> map, String id) {
    this.id = id;
    this.nombre = map['nombre'];
    this.precio = map['precio'] / 1;
    this.idPadre = map['id_padre'];
  }

  Map<String, dynamic> toMap() {
    assert(this.nombre != null && this.nombre != '');
    assert(this.precio != null);

    Map<String, dynamic> map = Map<String, dynamic>();
      
      map['nombre'] = this.nombre;
      map['precio'] = this.precio;
      if(this.idPadre != null) map['id_padre'] = this.idPadre;

    return map;
  }

  @override
  String toString() {
    return nombre;
  }
}
