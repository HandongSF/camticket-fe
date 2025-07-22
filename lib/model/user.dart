/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

class User {
  final int? id;
  final int? kakaoId;
  final String? name;
  final String? nickName;
  final String? email;
  final String? profileImageUrl;
  final String? introduction;
  final String? bankAccount;
  final String role;

  User({
    this.id,
    this.kakaoId,
    this.name,
    this.nickName,
    this.email,
    this.profileImageUrl,
    this.introduction,
    this.bankAccount,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      kakaoId: json['kakaoId'],
      name: json['name'],
      nickName: json['nickName'],
      email: json['email'],
      profileImageUrl: json['profileImageUrl'],
      introduction: json['introduction'],
      bankAccount: json['bankAccount'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kakaoId': kakaoId,
      'name': name,
      'nickName': nickName,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'introduction': introduction,
      'bankAccount': bankAccount,
      'role': role,
    };
  }
}
