// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CreateIssueMutation: GraphQLMutation {
  public static let operationName: String = "CreateIssue"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CreateIssue($repositoryId: ID!, $title: String!, $body: String) { createIssue(input: { repositoryId: $repositoryId, title: $title, body: $body }) { __typename issue { __typename id title number state author { __typename login } } } }"#
    ))

  public var repositoryId: ID
  public var title: String
  public var body: GraphQLNullable<String>

  public init(
    repositoryId: ID,
    title: String,
    body: GraphQLNullable<String>
  ) {
    self.repositoryId = repositoryId
    self.title = title
    self.body = body
  }

  public var __variables: Variables? { [
    "repositoryId": repositoryId,
    "title": title,
    "body": body
  ] }

  public struct Data: GitHubSchema.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { GitHubSchema.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("createIssue", CreateIssue?.self, arguments: ["input": [
        "repositoryId": .variable("repositoryId"),
        "title": .variable("title"),
        "body": .variable("body")
      ]]),
    ] }

    /// Creates a new issue.
    public var createIssue: CreateIssue? { __data["createIssue"] }

    /// CreateIssue
    ///
    /// Parent Type: `CreateIssuePayload`
    public struct CreateIssue: GitHubSchema.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { GitHubSchema.Objects.CreateIssuePayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("issue", Issue?.self),
      ] }

      /// The new issue.
      public var issue: Issue? { __data["issue"] }

      /// CreateIssue.Issue
      ///
      /// Parent Type: `Issue`
      public struct Issue: GitHubSchema.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { GitHubSchema.Objects.Issue }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", GitHubSchema.ID.self),
          .field("title", String.self),
          .field("number", Int.self),
          .field("state", GraphQLEnum<GitHubSchema.IssueState>.self),
          .field("author", Author?.self),
        ] }

        /// The Node ID of the Issue object
        public var id: GitHubSchema.ID { __data["id"] }
        /// Identifies the issue title.
        public var title: String { __data["title"] }
        /// Identifies the issue number.
        public var number: Int { __data["number"] }
        /// Identifies the state of the issue.
        public var state: GraphQLEnum<GitHubSchema.IssueState> { __data["state"] }
        /// The actor who authored the comment.
        public var author: Author? { __data["author"] }

        /// CreateIssue.Issue.Author
        ///
        /// Parent Type: `Actor`
        public struct Author: GitHubSchema.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { GitHubSchema.Interfaces.Actor }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("login", String.self),
          ] }

          /// The username of the actor.
          public var login: String { __data["login"] }
        }
      }
    }
  }
}
