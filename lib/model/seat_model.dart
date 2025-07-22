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

class SeatStatus {
  final String seatCode;
  final String status;
  final bool selected;

  SeatStatus({
    required this.seatCode,
    required this.status,
    required this.selected,
  });

  factory SeatStatus.fromJson(Map<String, dynamic> json) {
    return SeatStatus(
      seatCode: json['seatCode'],
      status: json['status'],
      selected: json['selected'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seatCode': seatCode,
      'status': status,
      'selected': selected,
    };
  }
}
