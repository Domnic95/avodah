class LibraryModel {
  LibraryModel({
     this.id,
     this.resourceTitle,
     this.resourceDescription,
     this.resourceVideoLink,
     this.resourceUrl,
     this.cloudinaryId,
     this.cloudinaryUrl,
     this.cloudinarySecureUrl,
     this.cloudinaryAudioSecureUrl,
     this.resourceType,
     this.clientId,
     this.resourceStatus,
     this.adminUserId,
     this.lastModified,
     this.cats,
  });
    int? id;
    String? resourceTitle;
    String? resourceDescription;
   String? resourceVideoLink;
   String? resourceUrl;
   String? cloudinaryId;
   String? cloudinaryUrl;
   String? cloudinarySecureUrl;
   String? cloudinaryAudioSecureUrl;
   String? resourceType;
   int? clientId;
   int? resourceStatus;
   int? adminUserId;
   String? lastModified;
   List<String>? cats;
  
  LibraryModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    resourceTitle = json['resource_title'];
    resourceDescription = json['resource_description'];
    resourceVideoLink = json['resource_video_link'];
    resourceUrl = json['resource_url'];
    cloudinaryId = json['cloudinaryId'];
    cloudinaryUrl = json['cloudinaryUrl'];
    cloudinarySecureUrl = json['cloudinarySecureUrl'];
    cloudinaryAudioSecureUrl = json['cloudinaryAudioSecureUrl'];
    resourceType = json['resource_type'];
    clientId = json['client_id'];
    resourceStatus = json['resource_status'];
    adminUserId = json['admin_user_id'];
    lastModified = json['last_modified'];
    cats = List.castFrom<dynamic, String>(json['cats']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['resource_title'] = resourceTitle;
    _data['resource_description'] = resourceDescription;
    _data['resource_video_link'] = resourceVideoLink;
    _data['resource_url'] = resourceUrl;
    _data['cloudinaryId'] = cloudinaryId;
    _data['cloudinaryUrl'] = cloudinaryUrl;
    _data['cloudinarySecureUrl'] = cloudinarySecureUrl;
    _data['cloudinaryAudioSecureUrl'] = cloudinaryAudioSecureUrl;
    _data['resource_type'] = resourceType;
    _data['client_id'] = clientId;
    _data['resource_status'] = resourceStatus;
    _data['admin_user_id'] = adminUserId;
    _data['last_modified'] = lastModified;
    _data['cats'] = cats;
    return _data;
  }
}