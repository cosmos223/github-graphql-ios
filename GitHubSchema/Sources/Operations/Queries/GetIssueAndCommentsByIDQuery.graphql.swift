// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetIssueAndCommentsByIDQuery: GraphQLQuery {
  public static let operationName: String = "GetIssueAndCommentsByID"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetIssueAndCommentsByID($id: ID!, $first: Int = 25, $after: String) { node(id: $id) { __typename ... on Issue { id title body number viewerCanDelete viewerCanUpdate author { __typename login avatarUrl } comments(first: $first, after: $after) { __typename pageInfo { __typename hasNextPage endCursor } nodes { __typename id body viewerCanDelete viewerCanUpdate author { __typename login avatarUrl } } } } } }"#
    ))

  public var id: ID
  public var first: GraphQLNullable<Int>
  public var after: GraphQLNullable<String>

  public init(
    id: ID,
    first: GraphQLNullable<Int> = 25,
    after: GraphQLNullable<String>
  ) {
    self.id = id
    self.first = first
    self.after = after
  }

  public var __variables: Variables? { [
    "id": id,
    "first": first,
    "after": after
  ] }

  public struct Data: GitHubSchema.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { GitHubSchema.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("node", Node?.self, arguments: ["id": .variable("id")]),
    ] }

    /// Fetches an object given its ID.
    public var node: Node? { __data["node"] }

    /// Node
    ///
    /// Parent Type: `Node`
    public struct Node: GitHubSchema.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { GitHubSchema.Interfaces.Node }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .inlineFragment(AsIssue.self),
      ] }

      public var asIssue: AsIssue? { _asInlineFragment() }

      /// Node.AsIssue
      ///
      /// Parent Type: `Issue`
      public struct AsIssue: GitHubSchema.InlineFragment {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public typealias RootEntityType = GetIssueAndCommentsByIDQuery.Data.Node
        public static var __parentType: any ApolloAPI.ParentType { GitHubSchema.Objects.Issue }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("id", GitHubSchema.ID.self),
          .field("title", String.self),
          .field("body", String.self),
          .field("number", Int.self),
          .field("viewerCanDelete", Bool.self),
          .field("viewerCanUpdate", Bool.self),
          .field("author", Author?.self),
          .field("comments", Comments.self, arguments: [
            "first": .variable("first"),
            "after": .variable("after")
          ]),
        ] }

        /// The Node ID of the Issue object
        public var id: GitHubSchema.ID { __data["id"] }
        /// Identifies the issue title.
        public var title: String { __data["title"] }
        /// Identifies the body of the issue.
        public var body: String { __data["body"] }
        /// Identifies the issue number.
        public var number: Int { __data["number"] }
        /// Check if the current viewer can delete this object.
        public var viewerCanDelete: Bool { __data["viewerCanDelete"] }
        /// Check if the current viewer can update this object.
        public var viewerCanUpdate: Bool { __data["viewerCanUpdate"] }
        /// The actor who authored the comment.
        public var author: Author? { __data["author"] }
        /// A list of comments associated with the Issue.
        public var comments: Comments { __data["comments"] }

        /// Node.AsIssue.Author
        ///
        /// Parent Type: `Actor`
        public struct Author: GitHubSchema.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { GitHubSchema.Interfaces.Actor }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("login", String.self),
            .field("avatarUrl", GitHubSchema.URI.self),
          ] }

          /// The username of the actor.
          public var login: String { __data["login"] }
          /// A URL pointing to the actor's public avatar.
          public var avatarUrl: GitHubSchema.URI { __data["avatarUrl"] }
        }

        /// Node.AsIssue.Comments
        ///
        /// Parent Type: `IssueCommentConnection`
        public struct Comments: GitHubSchema.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { GitHubSchema.Objects.IssueCommentConnection }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("pageInfo", PageInfo.self),
            .field("nodes", [Node?]?.self),
          ] }

          /// Information to aid in pagination.
          public var pageInfo: PageInfo { __data["pageInfo"] }
          /// A list of nodes.
          public var nodes: [Node?]? { __data["nodes"] }

          /// Node.AsIssue.Comments.PageInfo
          ///
          /// Parent Type: `PageInfo`
          public struct PageInfo: GitHubSchema.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: any ApolloAPI.ParentType { GitHubSchema.Objects.PageInfo }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("hasNextPage", Bool.self),
              .field("endCursor", String?.self),
            ] }

            /// When paginating forwards, are there more items?
            public var hasNextPage: Bool { __data["hasNextPage"] }
            /// When paginating forwards, the cursor to continue.
            public var endCursor: String? { __data["endCursor"] }
          }

          /// Node.AsIssue.Comments.Node
          ///
          /// Parent Type: `IssueComment`
          public struct Node: GitHubSchema.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: any ApolloAPI.ParentType { GitHubSchema.Objects.IssueComment }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("id", GitHubSchema.ID.self),
              .field("body", String.self),
              .field("viewerCanDelete", Bool.self),
              .field("viewerCanUpdate", Bool.self),
              .field("author", Author?.self),
            ] }

            /// The Node ID of the IssueComment object
            public var id: GitHubSchema.ID { __data["id"] }
            /// The body as Markdown.
            public var body: String { __data["body"] }
            /// Check if the current viewer can delete this object.
            public var viewerCanDelete: Bool { __data["viewerCanDelete"] }
            /// Check if the current viewer can update this object.
            public var viewerCanUpdate: Bool { __data["viewerCanUpdate"] }
            /// The actor who authored the comment.
            public var author: Author? { __data["author"] }

            /// Node.AsIssue.Comments.Node.Author
            ///
            /// Parent Type: `Actor`
            public struct Author: GitHubSchema.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: any ApolloAPI.ParentType { GitHubSchema.Interfaces.Actor }
              public static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("login", String.self),
                .field("avatarUrl", GitHubSchema.URI.self),
              ] }

              /// The username of the actor.
              public var login: String { __data["login"] }
              /// A URL pointing to the actor's public avatar.
              public var avatarUrl: GitHubSchema.URI { __data["avatarUrl"] }
            }
          }
        }
      }
    }
  }
}
