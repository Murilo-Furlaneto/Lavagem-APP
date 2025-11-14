// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _funcaoMeta = const VerificationMeta('funcao');
  @override
  late final GeneratedColumn<String> funcao = GeneratedColumn<String>(
      'funcao', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isLoggedInMeta =
      const VerificationMeta('isLoggedIn');
  @override
  late final GeneratedColumn<bool> isLoggedIn = GeneratedColumn<bool>(
      'is_logged_in', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_logged_in" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, uid, nome, email, funcao, isLoggedIn];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('funcao')) {
      context.handle(_funcaoMeta,
          funcao.isAcceptableOrUnknown(data['funcao']!, _funcaoMeta));
    } else if (isInserting) {
      context.missing(_funcaoMeta);
    }
    if (data.containsKey('is_logged_in')) {
      context.handle(
          _isLoggedInMeta,
          isLoggedIn.isAcceptableOrUnknown(
              data['is_logged_in']!, _isLoggedInMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      nome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      funcao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}funcao'])!,
      isLoggedIn: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_logged_in'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String uid;
  final String nome;
  final String email;
  final String funcao;
  final bool isLoggedIn;
  const User(
      {required this.id,
      required this.uid,
      required this.nome,
      required this.email,
      required this.funcao,
      required this.isLoggedIn});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uid'] = Variable<String>(uid);
    map['nome'] = Variable<String>(nome);
    map['email'] = Variable<String>(email);
    map['funcao'] = Variable<String>(funcao);
    map['is_logged_in'] = Variable<bool>(isLoggedIn);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      uid: Value(uid),
      nome: Value(nome),
      email: Value(email),
      funcao: Value(funcao),
      isLoggedIn: Value(isLoggedIn),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      uid: serializer.fromJson<String>(json['uid']),
      nome: serializer.fromJson<String>(json['nome']),
      email: serializer.fromJson<String>(json['email']),
      funcao: serializer.fromJson<String>(json['funcao']),
      isLoggedIn: serializer.fromJson<bool>(json['isLoggedIn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uid': serializer.toJson<String>(uid),
      'nome': serializer.toJson<String>(nome),
      'email': serializer.toJson<String>(email),
      'funcao': serializer.toJson<String>(funcao),
      'isLoggedIn': serializer.toJson<bool>(isLoggedIn),
    };
  }

  User copyWith(
          {int? id,
          String? uid,
          String? nome,
          String? email,
          String? funcao,
          bool? isLoggedIn}) =>
      User(
        id: id ?? this.id,
        uid: uid ?? this.uid,
        nome: nome ?? this.nome,
        email: email ?? this.email,
        funcao: funcao ?? this.funcao,
        isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      uid: data.uid.present ? data.uid.value : this.uid,
      nome: data.nome.present ? data.nome.value : this.nome,
      email: data.email.present ? data.email.value : this.email,
      funcao: data.funcao.present ? data.funcao.value : this.funcao,
      isLoggedIn:
          data.isLoggedIn.present ? data.isLoggedIn.value : this.isLoggedIn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('nome: $nome, ')
          ..write('email: $email, ')
          ..write('funcao: $funcao, ')
          ..write('isLoggedIn: $isLoggedIn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, uid, nome, email, funcao, isLoggedIn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.uid == this.uid &&
          other.nome == this.nome &&
          other.email == this.email &&
          other.funcao == this.funcao &&
          other.isLoggedIn == this.isLoggedIn);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> uid;
  final Value<String> nome;
  final Value<String> email;
  final Value<String> funcao;
  final Value<bool> isLoggedIn;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.uid = const Value.absent(),
    this.nome = const Value.absent(),
    this.email = const Value.absent(),
    this.funcao = const Value.absent(),
    this.isLoggedIn = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String uid,
    required String nome,
    required String email,
    required String funcao,
    this.isLoggedIn = const Value.absent(),
  })  : uid = Value(uid),
        nome = Value(nome),
        email = Value(email),
        funcao = Value(funcao);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? uid,
    Expression<String>? nome,
    Expression<String>? email,
    Expression<String>? funcao,
    Expression<bool>? isLoggedIn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uid != null) 'uid': uid,
      if (nome != null) 'nome': nome,
      if (email != null) 'email': email,
      if (funcao != null) 'funcao': funcao,
      if (isLoggedIn != null) 'is_logged_in': isLoggedIn,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String>? uid,
      Value<String>? nome,
      Value<String>? email,
      Value<String>? funcao,
      Value<bool>? isLoggedIn}) {
    return UsersCompanion(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      funcao: funcao ?? this.funcao,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (funcao.present) {
      map['funcao'] = Variable<String>(funcao.value);
    }
    if (isLoggedIn.present) {
      map['is_logged_in'] = Variable<bool>(isLoggedIn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('nome: $nome, ')
          ..write('email: $email, ')
          ..write('funcao: $funcao, ')
          ..write('isLoggedIn: $isLoggedIn')
          ..write(')'))
        .toString();
  }
}

class $VeiculosTable extends Veiculos with TableInfo<$VeiculosTable, Veiculo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VeiculosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (uid)'));
  static const VerificationMeta _modeloMeta = const VerificationMeta('modelo');
  @override
  late final GeneratedColumn<String> modelo = GeneratedColumn<String>(
      'modelo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _placaMeta = const VerificationMeta('placa');
  @override
  late final GeneratedColumn<String> placa = GeneratedColumn<String>(
      'placa', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _marcaMeta = const VerificationMeta('marca');
  @override
  late final GeneratedColumn<String> marca = GeneratedColumn<String>(
      'marca', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, modelo, placa, marca, status];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'veiculos';
  @override
  VerificationContext validateIntegrity(Insertable<Veiculo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('modelo')) {
      context.handle(_modeloMeta,
          modelo.isAcceptableOrUnknown(data['modelo']!, _modeloMeta));
    } else if (isInserting) {
      context.missing(_modeloMeta);
    }
    if (data.containsKey('placa')) {
      context.handle(
          _placaMeta, placa.isAcceptableOrUnknown(data['placa']!, _placaMeta));
    } else if (isInserting) {
      context.missing(_placaMeta);
    }
    if (data.containsKey('marca')) {
      context.handle(
          _marcaMeta, marca.isAcceptableOrUnknown(data['marca']!, _marcaMeta));
    } else if (isInserting) {
      context.missing(_marcaMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Veiculo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Veiculo(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      modelo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}modelo'])!,
      placa: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}placa'])!,
      marca: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}marca'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
    );
  }

  @override
  $VeiculosTable createAlias(String alias) {
    return $VeiculosTable(attachedDatabase, alias);
  }
}

class Veiculo extends DataClass implements Insertable<Veiculo> {
  final int id;
  final String userId;
  final String modelo;
  final String placa;
  final String marca;
  final String status;
  const Veiculo(
      {required this.id,
      required this.userId,
      required this.modelo,
      required this.placa,
      required this.marca,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['modelo'] = Variable<String>(modelo);
    map['placa'] = Variable<String>(placa);
    map['marca'] = Variable<String>(marca);
    map['status'] = Variable<String>(status);
    return map;
  }

  VeiculosCompanion toCompanion(bool nullToAbsent) {
    return VeiculosCompanion(
      id: Value(id),
      userId: Value(userId),
      modelo: Value(modelo),
      placa: Value(placa),
      marca: Value(marca),
      status: Value(status),
    );
  }

  factory Veiculo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Veiculo(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      modelo: serializer.fromJson<String>(json['modelo']),
      placa: serializer.fromJson<String>(json['placa']),
      marca: serializer.fromJson<String>(json['marca']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'modelo': serializer.toJson<String>(modelo),
      'placa': serializer.toJson<String>(placa),
      'marca': serializer.toJson<String>(marca),
      'status': serializer.toJson<String>(status),
    };
  }

  Veiculo copyWith(
          {int? id,
          String? userId,
          String? modelo,
          String? placa,
          String? marca,
          String? status}) =>
      Veiculo(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        modelo: modelo ?? this.modelo,
        placa: placa ?? this.placa,
        marca: marca ?? this.marca,
        status: status ?? this.status,
      );
  Veiculo copyWithCompanion(VeiculosCompanion data) {
    return Veiculo(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      modelo: data.modelo.present ? data.modelo.value : this.modelo,
      placa: data.placa.present ? data.placa.value : this.placa,
      marca: data.marca.present ? data.marca.value : this.marca,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Veiculo(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('modelo: $modelo, ')
          ..write('placa: $placa, ')
          ..write('marca: $marca, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, modelo, placa, marca, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Veiculo &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.modelo == this.modelo &&
          other.placa == this.placa &&
          other.marca == this.marca &&
          other.status == this.status);
}

class VeiculosCompanion extends UpdateCompanion<Veiculo> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> modelo;
  final Value<String> placa;
  final Value<String> marca;
  final Value<String> status;
  const VeiculosCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.modelo = const Value.absent(),
    this.placa = const Value.absent(),
    this.marca = const Value.absent(),
    this.status = const Value.absent(),
  });
  VeiculosCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String modelo,
    required String placa,
    required String marca,
    required String status,
  })  : userId = Value(userId),
        modelo = Value(modelo),
        placa = Value(placa),
        marca = Value(marca),
        status = Value(status);
  static Insertable<Veiculo> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? modelo,
    Expression<String>? placa,
    Expression<String>? marca,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (modelo != null) 'modelo': modelo,
      if (placa != null) 'placa': placa,
      if (marca != null) 'marca': marca,
      if (status != null) 'status': status,
    });
  }

  VeiculosCompanion copyWith(
      {Value<int>? id,
      Value<String>? userId,
      Value<String>? modelo,
      Value<String>? placa,
      Value<String>? marca,
      Value<String>? status}) {
    return VeiculosCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      modelo: modelo ?? this.modelo,
      placa: placa ?? this.placa,
      marca: marca ?? this.marca,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (modelo.present) {
      map['modelo'] = Variable<String>(modelo.value);
    }
    if (placa.present) {
      map['placa'] = Variable<String>(placa.value);
    }
    if (marca.present) {
      map['marca'] = Variable<String>(marca.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VeiculosCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('modelo: $modelo, ')
          ..write('placa: $placa, ')
          ..write('marca: $marca, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $VeiculosTable veiculos = $VeiculosTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [users, veiculos];
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  required String uid,
  required String nome,
  required String email,
  required String funcao,
  Value<bool> isLoggedIn,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String> uid,
  Value<String> nome,
  Value<String> email,
  Value<String> funcao,
  Value<bool> isLoggedIn,
});

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$VeiculosTable, List<Veiculo>> _veiculosRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.veiculos,
          aliasName: $_aliasNameGenerator(db.users.uid, db.veiculos.userId));

  $$VeiculosTableProcessedTableManager get veiculosRefs {
    final manager = $$VeiculosTableTableManager($_db, $_db.veiculos)
        .filter((f) => f.userId.uid.sqlEquals($_itemColumn<String>('uid')!));

    final cache = $_typedResult.readTableOrNull(_veiculosRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get funcao => $composableBuilder(
      column: $table.funcao, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isLoggedIn => $composableBuilder(
      column: $table.isLoggedIn, builder: (column) => ColumnFilters(column));

  Expression<bool> veiculosRefs(
      Expression<bool> Function($$VeiculosTableFilterComposer f) f) {
    final $$VeiculosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.veiculos,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VeiculosTableFilterComposer(
              $db: $db,
              $table: $db.veiculos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get funcao => $composableBuilder(
      column: $table.funcao, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isLoggedIn => $composableBuilder(
      column: $table.isLoggedIn, builder: (column) => ColumnOrderings(column));
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get funcao =>
      $composableBuilder(column: $table.funcao, builder: (column) => column);

  GeneratedColumn<bool> get isLoggedIn => $composableBuilder(
      column: $table.isLoggedIn, builder: (column) => column);

  Expression<T> veiculosRefs<T extends Object>(
      Expression<T> Function($$VeiculosTableAnnotationComposer a) f) {
    final $$VeiculosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.uid,
        referencedTable: $db.veiculos,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VeiculosTableAnnotationComposer(
              $db: $db,
              $table: $db.veiculos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, $$UsersTableReferences),
    User,
    PrefetchHooks Function({bool veiculosRefs})> {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> uid = const Value.absent(),
            Value<String> nome = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String> funcao = const Value.absent(),
            Value<bool> isLoggedIn = const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            uid: uid,
            nome: nome,
            email: email,
            funcao: funcao,
            isLoggedIn: isLoggedIn,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String uid,
            required String nome,
            required String email,
            required String funcao,
            Value<bool> isLoggedIn = const Value.absent(),
          }) =>
              UsersCompanion.insert(
            id: id,
            uid: uid,
            nome: nome,
            email: email,
            funcao: funcao,
            isLoggedIn: isLoggedIn,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$UsersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({veiculosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (veiculosRefs) db.veiculos],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (veiculosRefs)
                    await $_getPrefetchedData<User, $UsersTable, Veiculo>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._veiculosRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0).veiculosRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.uid),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$UsersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, $$UsersTableReferences),
    User,
    PrefetchHooks Function({bool veiculosRefs})>;
typedef $$VeiculosTableCreateCompanionBuilder = VeiculosCompanion Function({
  Value<int> id,
  required String userId,
  required String modelo,
  required String placa,
  required String marca,
  required String status,
});
typedef $$VeiculosTableUpdateCompanionBuilder = VeiculosCompanion Function({
  Value<int> id,
  Value<String> userId,
  Value<String> modelo,
  Value<String> placa,
  Value<String> marca,
  Value<String> status,
});

final class $$VeiculosTableReferences
    extends BaseReferences<_$AppDatabase, $VeiculosTable, Veiculo> {
  $$VeiculosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users
      .createAlias($_aliasNameGenerator(db.veiculos.userId, db.users.uid));

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.uid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$VeiculosTableFilterComposer
    extends Composer<_$AppDatabase, $VeiculosTable> {
  $$VeiculosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get modelo => $composableBuilder(
      column: $table.modelo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get placa => $composableBuilder(
      column: $table.placa, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get marca => $composableBuilder(
      column: $table.marca, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$VeiculosTableOrderingComposer
    extends Composer<_$AppDatabase, $VeiculosTable> {
  $$VeiculosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get modelo => $composableBuilder(
      column: $table.modelo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get placa => $composableBuilder(
      column: $table.placa, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get marca => $composableBuilder(
      column: $table.marca, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$VeiculosTableAnnotationComposer
    extends Composer<_$AppDatabase, $VeiculosTable> {
  $$VeiculosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get modelo =>
      $composableBuilder(column: $table.modelo, builder: (column) => column);

  GeneratedColumn<String> get placa =>
      $composableBuilder(column: $table.placa, builder: (column) => column);

  GeneratedColumn<String> get marca =>
      $composableBuilder(column: $table.marca, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.uid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$VeiculosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VeiculosTable,
    Veiculo,
    $$VeiculosTableFilterComposer,
    $$VeiculosTableOrderingComposer,
    $$VeiculosTableAnnotationComposer,
    $$VeiculosTableCreateCompanionBuilder,
    $$VeiculosTableUpdateCompanionBuilder,
    (Veiculo, $$VeiculosTableReferences),
    Veiculo,
    PrefetchHooks Function({bool userId})> {
  $$VeiculosTableTableManager(_$AppDatabase db, $VeiculosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VeiculosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VeiculosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VeiculosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> modelo = const Value.absent(),
            Value<String> placa = const Value.absent(),
            Value<String> marca = const Value.absent(),
            Value<String> status = const Value.absent(),
          }) =>
              VeiculosCompanion(
            id: id,
            userId: userId,
            modelo: modelo,
            placa: placa,
            marca: marca,
            status: status,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String userId,
            required String modelo,
            required String placa,
            required String marca,
            required String status,
          }) =>
              VeiculosCompanion.insert(
            id: id,
            userId: userId,
            modelo: modelo,
            placa: placa,
            marca: marca,
            status: status,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$VeiculosTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable: $$VeiculosTableReferences._userIdTable(db),
                    referencedColumn:
                        $$VeiculosTableReferences._userIdTable(db).uid,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$VeiculosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $VeiculosTable,
    Veiculo,
    $$VeiculosTableFilterComposer,
    $$VeiculosTableOrderingComposer,
    $$VeiculosTableAnnotationComposer,
    $$VeiculosTableCreateCompanionBuilder,
    $$VeiculosTableUpdateCompanionBuilder,
    (Veiculo, $$VeiculosTableReferences),
    Veiculo,
    PrefetchHooks Function({bool userId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$VeiculosTableTableManager get veiculos =>
      $$VeiculosTableTableManager(_db, _db.veiculos);
}
