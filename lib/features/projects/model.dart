// ignore_for_file: prefer_final_fields

part of '../projects.dart';

// typedef ProjectMember = ({ User user, MemberPermissions permissions, bool leader });

// final class Project with Model {
//   DocumentSnapshot _snapshot;

//   @override
//   DocumentSnapshot get $snapshot => _snapshot;

//   String _name;
//   Timestamp _createdAt;
//   Timestamp? _deadline;
//   MemberPermissions _defaultPermissions;
// }

// class MemberPermissions {
//   bool _createTasks;
//   bool _updateTasks;
//   bool _deleteTasks;

//   bool _inviteMembers;
//   bool _removeMembers;
  
//   bool _updatePermissions;
//   bool _updateProject;

//   bool get createTasks => _createTasks;
//   bool get updateTasks => _updateTasks;
//   bool get deleteTasks => _deleteTasks;
//   bool get inviteMembers => _inviteMembers;
//   bool get removeMembers => _removeMembers;
//   bool get updatePermissions => _updatePermissions;
//   bool get updateProject => _updateProject;

//   ProjectPermissions({
//     required bool createTasks,
//     required bool updateTasks,
//     required bool deleteTasks,
//     required bool inviteMembers,
//     required bool removeMembers,
//     required bool updatePermissions,
//     required bool updateProject,
//   }) : _createTasks = createTasks,
//     _updateTasks = updateTasks,
//     _deleteTasks = deleteTasks,
//     _inviteMembers = inviteMembers,
//     _removeMembers = removeMembers,
//     _updatePermissions = updatePermissions,
//     _updateProject = updateProject;
// }