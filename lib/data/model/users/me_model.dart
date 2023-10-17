// class MeModel {
//   MeModel({
//     this.id,
//     this.customerOrgName,
//     this.provinceId,
//     this.districtId,
//     this.muniId,
//     this.wardNo,
//     this.tole,
//     this.houseNo,
//     this.mobileNo,
//     this.landline,
//     this.email,
//     this.emailByRss,
//     this.organizationTypeId,
//     this.contactPersonTelephone,
//     this.contactPersonMobileNo,
//     this.contactPersonEmail,
//     this.orgImage,
//     this.newsAgreementFile,
//     this.filePath,
//     this.emailVerified,
//     this.subscription,
//   });

//   int? id;
//   String? customerOrgName;
//   int? provinceId;
//   int? districtId;
//   int? muniId;
//   String? wardNo;
//   String? tole;
//   String? houseNo;
//   String? mobileNo;
//   String? landline;
//   String? email;
//   String? emailByRss;
//   int? organizationTypeId;
//   String? contactPersonTelephone;
//   String? contactPersonMobileNo;
//   String? contactPersonEmail;
//   String? orgImage;
//   String? newsAgreementFile;
//   String? filePath;
//   String? emailVerified;
//   String? subscription;

//   factory MeModel.fromJson(Map<String, dynamic> json) => MeModel(
//         id: json["id"] == null ? null : json["id"],
//         customerOrgName: json["customer_org_name"] == null
//             ? null
//             : json["customer_org_name"],
//         provinceId: json["province_id"] == null ? null : json["province_id"],
//         districtId: json["district_id"] == null ? null : json["district_id"],
//         muniId: json["muni_id"] == null ? null : json["muni_id"],
//         wardNo: json["ward_no"],
//         tole: json["tole"],
//         houseNo: json["house_no"],
//         mobileNo: json["mobile_no"],
//         landline: json["landline"],
//         email: json["email"] == null ? null : json["email"],
//         emailByRss: json["email_by_rss"],
//         organizationTypeId: json["organization_type_id"] == null
//             ? null
//             : json["organization_type_id"],
//         contactPersonTelephone: json["contact_person_telephone"],
//         contactPersonMobileNo: json["contact_person_mobile_no"],
//         contactPersonEmail: json["contact_person_email"],
//         orgImage: json["org_image"],
//         newsAgreementFile: json["news_agreement_file"],
//         filePath: json["file_path"],
//         emailVerified:
//             json["email_verified"] == null ? null : json["email_verified"],
//         subscription:
//             json["subscription"] == null ? null : json["subscription"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id == null ? null : id,
//         "customer_org_name": customerOrgName == null ? null : customerOrgName,
//         "province_id": provinceId == null ? null : provinceId,
//         "district_id": districtId == null ? null : districtId,
//         "muni_id": muniId == null ? null : muniId,
//         "ward_no": wardNo,
//         "tole": tole,
//         "house_no": houseNo,
//         "mobile_no": mobileNo,
//         "landline": landline,
//         "email": email == null ? null : email,
//         "email_by_rss": emailByRss,
//         "organization_type_id":
//             organizationTypeId == null ? null : organizationTypeId,
//         "contact_person_telephone": contactPersonTelephone,
//         "contact_person_mobile_no": contactPersonMobileNo,
//         "contact_person_email": contactPersonEmail,
//         "org_image": orgImage,
//         "news_agreement_file": newsAgreementFile,
//         "file_path": filePath,
//         "email_verified": emailVerified == null ? null : emailVerified,
//         "subscription": subscription == null ? null : subscription,
//       };
// }

// import 'package:equatable/equatable.dart';

// // ignore: must_be_immutable
// class MeModel extends Equatable {
//   int? id;
//   String? customerOrgName;
//   int? provinceId;
//   int? districtId;
//   int? muniId;
//   String? wardNo;
//   String? tole;
//   String? houseNo;
//   String? mobileNo;
//   String? landline;
//   String? email;
//   String? emailByRss;
//   int? organizationTypeId;
//   String? contactPersonTelephone;
//   String? contactPersonMobileNo;
//   String? contactPersonEmail;
//   String? orgImage;
//   String? newsAgreementFile;
//   String? filePath;
//   String? emailVerified;
//   String? subscription;

//   MeModel(
//       {this.id,
//       this.customerOrgName,
//       this.provinceId,
//       this.districtId,
//       this.muniId,
//       this.wardNo,
//       this.tole,
//       this.houseNo,
//       this.mobileNo,
//       this.landline,
//       this.email,
//       this.emailByRss,
//       this.organizationTypeId,
//       this.contactPersonTelephone,
//       this.contactPersonMobileNo,
//       this.contactPersonEmail,
//       this.orgImage,
//       this.newsAgreementFile,
//       this.filePath,
//       this.emailVerified,
//       this.subscription});

//   MeModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     customerOrgName = json['customer_org_name'];
//     provinceId = json['province_id'];
//     districtId = json['district_id'];
//     muniId = json['muni_id'];
//     wardNo = json['ward_no'];
//     tole = json['tole'];
//     houseNo = json['house_no'];
//     mobileNo = json['mobile_no'];
//     landline = json['landline'];
//     email = json['email'];
//     emailByRss = json['email_by_rss'];
//     organizationTypeId = json['organization_type_id'];
//     contactPersonTelephone = json['contact_person_telephone'];
//     contactPersonMobileNo = json['contact_person_mobile_no'];
//     contactPersonEmail = json['contact_person_email'];
//     orgImage = json['org_image'];
//     newsAgreementFile = json['news_agreement_file'];
//     filePath = json['file_path'];
//     emailVerified = json['email_verified'];
//     subscription = json['subscription'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['customer_org_name'] = this.customerOrgName;
//     data['province_id'] = this.provinceId;
//     data['district_id'] = this.districtId;
//     data['muni_id'] = this.muniId;
//     data['ward_no'] = this.wardNo;
//     data['tole'] = this.tole;
//     data['house_no'] = this.houseNo;
//     data['mobile_no'] = this.mobileNo;
//     data['landline'] = this.landline;
//     data['email'] = this.email;
//     data['email_by_rss'] = this.emailByRss;
//     data['organization_type_id'] = this.organizationTypeId;
//     data['contact_person_telephone'] = this.contactPersonTelephone;
//     data['contact_person_mobile_no'] = this.contactPersonMobileNo;
//     data['contact_person_email'] = this.contactPersonEmail;
//     data['org_image'] = this.orgImage;
//     data['news_agreement_file'] = this.newsAgreementFile;
//     data['file_path'] = this.filePath;
//     data['email_verified'] = this.emailVerified;
//     data['subscription'] = this.subscription;
//     return data;
//   }

//   @override
//   List<Object?> get props => [
//         id!,
//         customerOrgName!,
//         provinceId!,
//         districtId!,
//         muniId,
//         wardNo,
//         tole,
//         houseNo,
//         mobileNo,
//         landline,
//         email,
//         emailByRss,
//         organizationTypeId,
//         contactPersonTelephone,
//         contactPersonMobileNo,
//         contactPersonEmail,
//         orgImage,
//         newsAgreementFile,
//         filePath,
//         emailVerified,
//         subscription
//       ];

//   @override
//   bool get stringify => true;
// }

class MeModel {
  Data? data;

  MeModel({this.data});

  MeModel.fromJson(Map<String, dynamic> json) {
    data = new Data.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? customerOrgName;
  Province? province;
  District? district;
  Muni? muni;
  int? wardNo;
  String? tole;
  int? houseNo;
  String? mobileNo;
  String? landline;
  String? email;
  String? emailByRss;
  String? organizationType;
  String? contactPersonTelephone;
  String? contactPersonMobileNo;
  String? contactPersonEmail;
  String? orgImage;
  String? oregImagePath;
  String? newsAgreementFile;
  String? filePath;
  String? emailVerified;
  String? subscription;
  String? account_approval;
  String? subscription_status;
  String? subscription_end_date;
  String? subscription_start_date;
  Data(
      {this.id,
      this.customerOrgName,
      this.province,
      this.district,
      this.muni,
      this.wardNo,
      this.tole,
      this.houseNo,
      this.mobileNo,
      this.landline,
      this.email,
      this.emailByRss,
      this.organizationType,
      this.contactPersonTelephone,
      this.contactPersonMobileNo,
      this.contactPersonEmail,
      this.orgImage,
      this.oregImagePath,
      this.newsAgreementFile,
      this.filePath,
      this.emailVerified,
      this.subscription,
      this.account_approval,
      this.subscription_status,
      this.subscription_end_date,
      this.subscription_start_date});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerOrgName = json['customer_org_name'];
    province = json['province'] != null
        ? new Province.fromJson(json['province'])
        : null;
    district = json['district'] != null
        ? new District.fromJson(json['district'])
        : null;
    muni = json['muni'] != null ? new Muni.fromJson(json['muni']) : null;
    wardNo = json['ward_no'];
    tole = json['tole'];
    houseNo = json['house_no'];
    mobileNo = json['mobile_no'];
    landline = json['landline'];
    email = json['email'];
    emailByRss = json['email_by_rss'];
    organizationType = json['organization_type'];
    contactPersonTelephone = json['contact_person_telephone'];
    contactPersonMobileNo = json['contact_person_mobile_no'];
    contactPersonEmail = json['contact_person_email'];
    orgImage = json['org_image'];
    oregImagePath = json['oreg_image_path'];
    newsAgreementFile = json['news_agreement_file'];
    filePath = json['file_path'];
    emailVerified = json['email_verified'];
    subscription = json['subscription'];
    account_approval = json["account_approval"];
    subscription_status = json["subscription_status"];
    subscription_end_date = json["subscription_end_date"];
    subscription_start_date = json["subscription_start_date"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_org_name'] = this.customerOrgName;
    if (this.province != null) {
      data['province'] = this.province!.toJson();
    }
    if (this.district != null) {
      data['district'] = this.district!.toJson();
    }
    if (this.muni != null) {
      data['muni'] = this.muni!.toJson();
    }
    data['ward_no'] = this.wardNo;
    data['tole'] = this.tole;
    data['house_no'] = this.houseNo;
    data['mobile_no'] = this.mobileNo;
    data['landline'] = this.landline;
    data['email'] = this.email;
    data['email_by_rss'] = this.emailByRss;
    data['organization_type'] = this.organizationType;
    data['contact_person_telephone'] = this.contactPersonTelephone;
    data['contact_person_mobile_no'] = this.contactPersonMobileNo;
    data['contact_person_email'] = this.contactPersonEmail;
    data['org_image'] = this.orgImage;
    data['oreg_image_path'] = this.oregImagePath;
    data['news_agreement_file'] = this.newsAgreementFile;
    data['file_path'] = this.filePath;
    data['email_verified'] = this.emailVerified;
    data['subscription'] = this.subscription;
    data["subscription_status"] = this.subscription_status;
    data["subscription_end_date"] = this.subscription_end_date;
    data["subscription_start_date"] = this.subscription_start_date;
    return data;
  }
}

class Province {
  int? id;
  String? pradeshName;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Province(
      {this.id,
      this.pradeshName,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  Province.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pradeshName = json['pradesh_name'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pradesh_name'] = this.pradeshName;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class District {
  int? id;
  int? pradeshId;
  String? districtCode;
  String? nepaliName;
  String? englishName;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  District(
      {this.id,
      this.pradeshId,
      this.districtCode,
      this.nepaliName,
      this.englishName,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  District.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pradeshId = json['pradesh_id'];
    districtCode = json['district_code'];
    nepaliName = json['nepali_name'];
    englishName = json['english_name'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pradesh_id'] = this.pradeshId;
    data['district_code'] = this.districtCode;
    data['nepali_name'] = this.nepaliName;
    data['english_name'] = this.englishName;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Muni {
  int? id;
  int? muniTypeId;
  int? districtId;
  String? muniCode;
  String? muniName;
  String? muniNameEn;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Muni(
      {this.id,
      this.muniTypeId,
      this.districtId,
      this.muniCode,
      this.muniName,
      this.muniNameEn,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  Muni.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    muniTypeId = json['muni_type_id'];
    districtId = json['district_id'];
    muniCode = json['muni_code'];
    muniName = json['muni_name'];
    muniNameEn = json['muni_name_en'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['muni_type_id'] = this.muniTypeId;
    data['district_id'] = this.districtId;
    data['muni_code'] = this.muniCode;
    data['muni_name'] = this.muniName;
    data['muni_name_en'] = this.muniNameEn;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
