import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture_posts_app/core/utils/typedef.dart';

abstract class UseCaseWithPrams<Type,Prams>{
 const UseCaseWithPrams();
 ResultFuture<Type> call(Prams prams);
}

abstract class UseCaseWithoutPrams<Type>{
  const UseCaseWithoutPrams();
  ResultFuture<Type> call();
}
