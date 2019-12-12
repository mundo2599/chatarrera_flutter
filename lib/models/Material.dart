class MaterialC {
  String id;
  String nombre;
  String idPadre;
  double precio;
  List<MaterialC> hijos;

  MaterialC({
    this.id,
    this.nombre,
    this.precio,
    this.idPadre,
    this.hijos,
  });

  MaterialC.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.nombre = map['nombre'];
    this.precio = map['precio'] / 1;
    this.idPadre = map['id_padre'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': this.id,
      'nombre': this.nombre,
      'precio': this.precio,
      'id_padre': this.idPadre,
    };
  }

  @override
  String toString() {
    return nombre;
  }
}
