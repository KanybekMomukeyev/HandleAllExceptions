// To parse this JSON data, do
//
//     final jsonSampleModel = jsonSampleModelFromJson(jsonString);

import 'dart:convert';

Future<List<JsonSampleModel>> jsonSampleModelFromJson(String str) async {
  return List<JsonSampleModel>.from(
      json.decode(str).map((x) => JsonSampleModel.fromJson(x)));
}

String jsonSampleModelToJson(List<JsonSampleModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JsonSampleModel {
  JsonSampleModel({
    required this.id,
    required this.type,
    required this.actor,
    required this.repo,
    required this.payload,
    required this.public,
    required this.createdAt,
    this.org,
  });

  String id;
  String type;
  Actor actor;
  Repo repo;
  Payload payload;
  bool public;
  DateTime createdAt;
  Actor? org;

  factory JsonSampleModel.fromJson(Map<String, dynamic> json) =>
      JsonSampleModel(
        id: json["id"],
        type: json["type"],
        actor: Actor.fromJson(json["actor"]),
        repo: Repo.fromJson(json["repo"]),
        payload: Payload.fromJson(json["payload"]),
        public: json["public"],
        createdAt: DateTime.parse(json["created_at"]),
        org: json["org"] == null ? null : Actor.fromJson(json["org"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "actor": actor.toJson(),
        "repo": repo.toJson(),
        "payload": payload.toJson(),
        "public": public,
        "created_at": createdAt.toIso8601String(),
        "org": org?.toJson(),
      };
}

class Actor {
  Actor({
    required this.id,
    required this.login,
    required this.gravatarId,
    required this.url,
    required this.avatarUrl,
  });

  int id;
  String login;
  String gravatarId;
  String url;
  String avatarUrl;

  factory Actor.fromJson(Map<String, dynamic> json) => Actor(
        id: json["id"],
        login: json["login"],
        gravatarId: json["gravatar_id"],
        url: json["url"],
        avatarUrl: json["avatar_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "login": login,
        "gravatar_id": gravatarId,
        "url": url,
        "avatar_url": avatarUrl,
      };
}

class Payload {
  Payload({
    this.ref,
    this.refType,
    this.masterBranch,
    this.description,
    this.pusherType,
    this.pushId,
    this.size,
    this.distinctSize,
    this.head,
    this.before,
    this.commits,
    this.action,
    this.release,
  });

  MasterBranch? ref;
  String? refType;
  MasterBranch? masterBranch;
  String? description;
  String? pusherType;
  int? pushId;
  int? size;
  int? distinctSize;
  String? head;
  String? before;
  List<Commit>? commits;
  String? action;
  Release? release;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        ref: masterBranchValues.map[json["ref"]],
        refType: json["ref_type"],
        masterBranch: masterBranchValues.map[json["master_branch"]],
        description: json["description"],
        pusherType: json["pusher_type"],
        pushId: json["push_id"],
        size: json["size"],
        distinctSize: json["distinct_size"],
        head: json["head"],
        before: json["before"],
        commits: json["commits"] == null
            ? []
            : List<Commit>.from(json["commits"].map((x) => Commit.fromJson(x))),
        action: json["action"],
        release:
            json["release"] == null ? null : Release.fromJson(json["release"]),
      );

  Map<String, dynamic> toJson() => {
        "ref": masterBranchValues.reverse[ref],
        "ref_type": refType,
        "master_branch": masterBranchValues.reverse[masterBranch],
        "description": description,
        "pusher_type": pusherType,
        "push_id": pushId,
        "size": size,
        "distinct_size": distinctSize,
        "head": head,
        "before": before,
        "commits": commits == null
            ? []
            : List<dynamic>.from(commits!.map((x) => x.toJson())),
        "action": action,
        "release": release?.toJson(),
      };
}

class Commit {
  Commit({
    required this.sha,
    required this.author,
    required this.message,
    required this.distinct,
    required this.url,
  });

  String sha;
  CommitAuthor author;
  String message;
  bool distinct;
  String url;

  factory Commit.fromJson(Map<String, dynamic> json) => Commit(
        sha: json["sha"],
        author: CommitAuthor.fromJson(json["author"]),
        message: json["message"],
        distinct: json["distinct"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "sha": sha,
        "author": author.toJson(),
        "message": message,
        "distinct": distinct,
        "url": url,
      };
}

class CommitAuthor {
  CommitAuthor({
    required this.email,
    required this.name,
  });

  String email;
  String name;

  factory CommitAuthor.fromJson(Map<String, dynamic> json) => CommitAuthor(
        email: json["email"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
      };
}

enum MasterBranch { MASTER, REFS_HEADS_MASTER, REFS_HEADS_DEVELOP }

final masterBranchValues = EnumValues({
  "master": MasterBranch.MASTER,
  "refs/heads/develop": MasterBranch.REFS_HEADS_DEVELOP,
  "refs/heads/master": MasterBranch.REFS_HEADS_MASTER
});

class Release {
  Release({
    required this.url,
    required this.assetsUrl,
    required this.uploadUrl,
    required this.htmlUrl,
    required this.id,
    required this.tagName,
    required this.targetCommitish,
    required this.name,
    required this.draft,
    required this.author,
    required this.prerelease,
    required this.createdAt,
    required this.publishedAt,
    required this.assets,
    required this.tarballUrl,
    required this.zipballUrl,
    required this.body,
  });

  String url;
  String assetsUrl;
  String uploadUrl;
  String htmlUrl;
  int id;
  String tagName;
  MasterBranch? targetCommitish;
  String name;
  bool draft;
  UploaderClass author;
  bool prerelease;
  DateTime createdAt;
  DateTime publishedAt;
  List<Asset> assets;
  String tarballUrl;
  String zipballUrl;
  String body;

  factory Release.fromJson(Map<String, dynamic> json) => Release(
        url: json["url"],
        assetsUrl: json["assets_url"],
        uploadUrl: json["upload_url"],
        htmlUrl: json["html_url"],
        id: json["id"],
        tagName: json["tag_name"],
        targetCommitish: masterBranchValues.map[json["target_commitish"]],
        name: json["name"],
        draft: json["draft"],
        author: UploaderClass.fromJson(json["author"]),
        prerelease: json["prerelease"],
        createdAt: DateTime.parse(json["created_at"]),
        publishedAt: DateTime.parse(json["published_at"]),
        assets: List<Asset>.from(json["assets"].map((x) => Asset.fromJson(x))),
        tarballUrl: json["tarball_url"],
        zipballUrl: json["zipball_url"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "assets_url": assetsUrl,
        "upload_url": uploadUrl,
        "html_url": htmlUrl,
        "id": id,
        "tag_name": tagName,
        "target_commitish": masterBranchValues.reverse[targetCommitish],
        "name": name,
        "draft": draft,
        "author": author.toJson(),
        "prerelease": prerelease,
        "created_at": createdAt.toIso8601String(),
        "published_at": publishedAt.toIso8601String(),
        "assets": List<dynamic>.from(assets.map((x) => x.toJson())),
        "tarball_url": tarballUrl,
        "zipball_url": zipballUrl,
        "body": body,
      };
}

class Asset {
  Asset({
    required this.url,
    required this.id,
    required this.name,
    this.label,
    required this.uploader,
    required this.contentType,
    required this.state,
    required this.size,
    required this.downloadCount,
    required this.createdAt,
    required this.updatedAt,
    required this.browserDownloadUrl,
  });

  String url;
  int id;
  String name;
  dynamic label;
  UploaderClass uploader;
  String contentType;
  String state;
  int size;
  int downloadCount;
  DateTime createdAt;
  DateTime updatedAt;
  String browserDownloadUrl;

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
        url: json["url"],
        id: json["id"],
        name: json["name"],
        label: json["label"],
        uploader: UploaderClass.fromJson(json["uploader"]),
        contentType: json["content_type"],
        state: json["state"],
        size: json["size"],
        downloadCount: json["download_count"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        browserDownloadUrl: json["browser_download_url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "id": id,
        "name": name,
        "label": label,
        "uploader": uploader.toJson(),
        "content_type": contentType,
        "state": state,
        "size": size,
        "download_count": downloadCount,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "browser_download_url": browserDownloadUrl,
      };
}

class UploaderClass {
  UploaderClass({
    required this.login,
    required this.id,
    required this.avatarUrl,
    required this.gravatarId,
    required this.url,
    required this.htmlUrl,
    required this.followersUrl,
    required this.followingUrl,
    required this.gistsUrl,
    required this.starredUrl,
    required this.subscriptionsUrl,
    required this.organizationsUrl,
    required this.reposUrl,
    required this.eventsUrl,
    required this.receivedEventsUrl,
    required this.type,
    required this.siteAdmin,
  });

  String login;
  int id;
  String avatarUrl;
  String gravatarId;
  String url;
  String htmlUrl;
  String followersUrl;
  String followingUrl;
  String gistsUrl;
  String starredUrl;
  String subscriptionsUrl;
  String organizationsUrl;
  String reposUrl;
  String eventsUrl;
  String receivedEventsUrl;
  String type;
  bool siteAdmin;

  factory UploaderClass.fromJson(Map<String, dynamic> json) => UploaderClass(
        login: json["login"],
        id: json["id"],
        avatarUrl: json["avatar_url"],
        gravatarId: json["gravatar_id"],
        url: json["url"],
        htmlUrl: json["html_url"],
        followersUrl: json["followers_url"],
        followingUrl: json["following_url"],
        gistsUrl: json["gists_url"],
        starredUrl: json["starred_url"],
        subscriptionsUrl: json["subscriptions_url"],
        organizationsUrl: json["organizations_url"],
        reposUrl: json["repos_url"],
        eventsUrl: json["events_url"],
        receivedEventsUrl: json["received_events_url"],
        type: json["type"],
        siteAdmin: json["site_admin"],
      );

  Map<String, dynamic> toJson() => {
        "login": login,
        "id": id,
        "avatar_url": avatarUrl,
        "gravatar_id": gravatarId,
        "url": url,
        "html_url": htmlUrl,
        "followers_url": followersUrl,
        "following_url": followingUrl,
        "gists_url": gistsUrl,
        "starred_url": starredUrl,
        "subscriptions_url": subscriptionsUrl,
        "organizations_url": organizationsUrl,
        "repos_url": reposUrl,
        "events_url": eventsUrl,
        "received_events_url": receivedEventsUrl,
        "type": type,
        "site_admin": siteAdmin,
      };
}

class Repo {
  Repo({
    required this.id,
    required this.name,
    required this.url,
  });

  int id;
  String name;
  String url;

  factory Repo.fromJson(Map<String, dynamic> json) => Repo(
        id: json["id"],
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
