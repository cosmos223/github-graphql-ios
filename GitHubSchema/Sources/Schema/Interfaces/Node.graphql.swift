// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public extension Interfaces {
  /// An object with an ID.
  static let Node = ApolloAPI.Interface(
    name: "Node",
    keyFields: nil,
    implementingObjects: [
      "AddedToMergeQueueEvent",
      "AddedToProjectEvent",
      "App",
      "AssignedEvent",
      "AutoMergeDisabledEvent",
      "AutoMergeEnabledEvent",
      "AutoRebaseEnabledEvent",
      "AutoSquashEnabledEvent",
      "AutomaticBaseChangeFailedEvent",
      "AutomaticBaseChangeSucceededEvent",
      "BaseRefChangedEvent",
      "BaseRefDeletedEvent",
      "BaseRefForcePushedEvent",
      "Blob",
      "Bot",
      "BranchProtectionRule",
      "BypassForcePushAllowance",
      "BypassPullRequestAllowance",
      "CWE",
      "CheckRun",
      "CheckSuite",
      "ClosedEvent",
      "CodeOfConduct",
      "CommentDeletedEvent",
      "Commit",
      "CommitComment",
      "CommitCommentThread",
      "Comparison",
      "ConnectedEvent",
      "ConvertToDraftEvent",
      "ConvertedNoteToIssueEvent",
      "ConvertedToDiscussionEvent",
      "CrossReferencedEvent",
      "DemilestonedEvent",
      "DependencyGraphManifest",
      "DeployKey",
      "DeployedEvent",
      "Deployment",
      "DeploymentEnvironmentChangedEvent",
      "DeploymentReview",
      "DeploymentStatus",
      "DisconnectedEvent",
      "Discussion",
      "DiscussionCategory",
      "DiscussionComment",
      "DiscussionPoll",
      "DiscussionPollOption",
      "DraftIssue",
      "Enterprise",
      "EnterpriseAdministratorInvitation",
      "EnterpriseIdentityProvider",
      "EnterpriseMemberInvitation",
      "EnterpriseRepositoryInfo",
      "EnterpriseServerInstallation",
      "EnterpriseServerUserAccount",
      "EnterpriseServerUserAccountEmail",
      "EnterpriseServerUserAccountsUpload",
      "EnterpriseUserAccount",
      "Environment",
      "ExternalIdentity",
      "Gist",
      "GistComment",
      "HeadRefDeletedEvent",
      "HeadRefForcePushedEvent",
      "HeadRefRestoredEvent",
      "IpAllowListEntry",
      "Issue",
      "IssueComment",
      "IssueType",
      "IssueTypeAddedEvent",
      "IssueTypeChangedEvent",
      "IssueTypeRemovedEvent",
      "Label",
      "LabeledEvent",
      "Language",
      "License",
      "LinkedBranch",
      "LockedEvent",
      "Mannequin",
      "MarkedAsDuplicateEvent",
      "MarketplaceCategory",
      "MarketplaceListing",
      "MemberFeatureRequestNotification",
      "MembersCanDeleteReposClearAuditEntry",
      "MembersCanDeleteReposDisableAuditEntry",
      "MembersCanDeleteReposEnableAuditEntry",
      "MentionedEvent",
      "MergeQueue",
      "MergeQueueEntry",
      "MergedEvent",
      "MigrationSource",
      "Milestone",
      "MilestonedEvent",
      "MovedColumnsInProjectEvent",
      "OIDCProvider",
      "OauthApplicationCreateAuditEntry",
      "OrgAddBillingManagerAuditEntry",
      "OrgAddMemberAuditEntry",
      "OrgBlockUserAuditEntry",
      "OrgConfigDisableCollaboratorsOnlyAuditEntry",
      "OrgConfigEnableCollaboratorsOnlyAuditEntry",
      "OrgCreateAuditEntry",
      "OrgDisableOauthAppRestrictionsAuditEntry",
      "OrgDisableSamlAuditEntry",
      "OrgDisableTwoFactorRequirementAuditEntry",
      "OrgEnableOauthAppRestrictionsAuditEntry",
      "OrgEnableSamlAuditEntry",
      "OrgEnableTwoFactorRequirementAuditEntry",
      "OrgInviteMemberAuditEntry",
      "OrgInviteToBusinessAuditEntry",
      "OrgOauthAppAccessApprovedAuditEntry",
      "OrgOauthAppAccessBlockedAuditEntry",
      "OrgOauthAppAccessDeniedAuditEntry",
      "OrgOauthAppAccessRequestedAuditEntry",
      "OrgOauthAppAccessUnblockedAuditEntry",
      "OrgRemoveBillingManagerAuditEntry",
      "OrgRemoveMemberAuditEntry",
      "OrgRemoveOutsideCollaboratorAuditEntry",
      "OrgRestoreMemberAuditEntry",
      "OrgUnblockUserAuditEntry",
      "OrgUpdateDefaultRepositoryPermissionAuditEntry",
      "OrgUpdateMemberAuditEntry",
      "OrgUpdateMemberRepositoryCreationPermissionAuditEntry",
      "OrgUpdateMemberRepositoryInvitationPermissionAuditEntry",
      "Organization",
      "OrganizationIdentityProvider",
      "OrganizationInvitation",
      "OrganizationMigration",
      "Package",
      "PackageFile",
      "PackageTag",
      "PackageVersion",
      "ParentIssueAddedEvent",
      "ParentIssueRemovedEvent",
      "PinnedDiscussion",
      "PinnedEnvironment",
      "PinnedEvent",
      "PinnedIssue",
      "PrivateRepositoryForkingDisableAuditEntry",
      "PrivateRepositoryForkingEnableAuditEntry",
      "Project",
      "ProjectCard",
      "ProjectColumn",
      "ProjectV2",
      "ProjectV2Field",
      "ProjectV2Item",
      "ProjectV2ItemFieldDateValue",
      "ProjectV2ItemFieldIterationValue",
      "ProjectV2ItemFieldNumberValue",
      "ProjectV2ItemFieldSingleSelectValue",
      "ProjectV2ItemFieldTextValue",
      "ProjectV2IterationField",
      "ProjectV2SingleSelectField",
      "ProjectV2StatusUpdate",
      "ProjectV2View",
      "ProjectV2Workflow",
      "PublicKey",
      "PullRequest",
      "PullRequestCommit",
      "PullRequestCommitCommentThread",
      "PullRequestReview",
      "PullRequestReviewComment",
      "PullRequestReviewThread",
      "PullRequestThread",
      "Push",
      "PushAllowance",
      "Query",
      "Reaction",
      "ReadyForReviewEvent",
      "Ref",
      "ReferencedEvent",
      "Release",
      "ReleaseAsset",
      "RemovedFromMergeQueueEvent",
      "RemovedFromProjectEvent",
      "RenamedTitleEvent",
      "ReopenedEvent",
      "RepoAccessAuditEntry",
      "RepoAddMemberAuditEntry",
      "RepoAddTopicAuditEntry",
      "RepoArchivedAuditEntry",
      "RepoChangeMergeSettingAuditEntry",
      "RepoConfigDisableAnonymousGitAccessAuditEntry",
      "RepoConfigDisableCollaboratorsOnlyAuditEntry",
      "RepoConfigDisableContributorsOnlyAuditEntry",
      "RepoConfigDisableSockpuppetDisallowedAuditEntry",
      "RepoConfigEnableAnonymousGitAccessAuditEntry",
      "RepoConfigEnableCollaboratorsOnlyAuditEntry",
      "RepoConfigEnableContributorsOnlyAuditEntry",
      "RepoConfigEnableSockpuppetDisallowedAuditEntry",
      "RepoConfigLockAnonymousGitAccessAuditEntry",
      "RepoConfigUnlockAnonymousGitAccessAuditEntry",
      "RepoCreateAuditEntry",
      "RepoDestroyAuditEntry",
      "RepoRemoveMemberAuditEntry",
      "RepoRemoveTopicAuditEntry",
      "Repository",
      "RepositoryInvitation",
      "RepositoryMigration",
      "RepositoryRule",
      "RepositoryRuleset",
      "RepositoryRulesetBypassActor",
      "RepositoryTopic",
      "RepositoryVisibilityChangeDisableAuditEntry",
      "RepositoryVisibilityChangeEnableAuditEntry",
      "RepositoryVulnerabilityAlert",
      "ReviewDismissalAllowance",
      "ReviewDismissedEvent",
      "ReviewRequest",
      "ReviewRequestRemovedEvent",
      "ReviewRequestedEvent",
      "SavedReply",
      "SecurityAdvisory",
      "SponsorsActivity",
      "SponsorsListing",
      "SponsorsListingFeaturedItem",
      "SponsorsTier",
      "Sponsorship",
      "SponsorshipNewsletter",
      "Status",
      "StatusCheckRollup",
      "StatusContext",
      "SubIssueAddedEvent",
      "SubIssueRemovedEvent",
      "SubscribedEvent",
      "Tag",
      "Team",
      "TeamAddMemberAuditEntry",
      "TeamAddRepositoryAuditEntry",
      "TeamChangeParentTeamAuditEntry",
      "TeamDiscussion",
      "TeamDiscussionComment",
      "TeamRemoveMemberAuditEntry",
      "TeamRemoveRepositoryAuditEntry",
      "Topic",
      "TransferredEvent",
      "Tree",
      "UnassignedEvent",
      "UnlabeledEvent",
      "UnlockedEvent",
      "UnmarkedAsDuplicateEvent",
      "UnpinnedEvent",
      "UnsubscribedEvent",
      "User",
      "UserBlockedEvent",
      "UserContentEdit",
      "UserList",
      "UserNamespaceRepository",
      "UserStatus",
      "VerifiableDomain",
      "Workflow",
      "WorkflowRun",
      "WorkflowRunFile"
    ]
  )
}