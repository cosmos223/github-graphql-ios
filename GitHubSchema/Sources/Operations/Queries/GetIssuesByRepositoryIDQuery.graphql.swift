// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetIssuesByRepositoryIDQuery: GraphQLQuery {
  public static let operationName: String = "GetIssuesByRepositoryID"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetIssuesByRepositoryID($id: ID!, $first: Int = 25, $after: String) { node(id: $id) { __typename ... on Repository { issues( first: $first after: $after orderBy: { field: CREATED_AT, direction: DESC } ) { __typename pageInfo { __typename hasNextPage endCursor } nodes { __typename id title number state author { __typename login } } } } } }"#
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
        .inlineFragment(AsRepository.self),
      ] }

      public var asRepository: AsRepository? { _asInlineFragment() }

      /// Node.AsRepository
      ///
      /// Parent Type: `Repository`
      public struct AsRepository: GitHubSchema.InlineFragment {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public typealias RootEntityType = GetIssuesByRepositoryIDQuery.Data.Node
        public static var __parentType: any ApolloAPI.ParentType { GitHubSchema.Objects.Repository }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("issues", Issues.self, arguments: [
            "first": .variable("first"),
            "after": .variable("after"),
            "orderBy": [
              "field": "CREATED_AT",
              "direction": "DESC"
            ]
          ]),
        ] }

        /// A list of issues that have been opened in the repository.
        public var issues: Issues { __data["issues"] }

        /// Node.AsRepository.Issues
        ///
        /// Parent Type: `IssueConnection`
        public struct Issues: GitHubSchema.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { GitHubSchema.Objects.IssueConnection }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("pageInfo", PageInfo.self),
            .field("nodes", [Node?]?.self),
          ] }

          /// Information to aid in pagination.
          public var pageInfo: PageInfo { __data["pageInfo"] }
          /// A list of nodes.
          public var nodes: [Node?]? { __data["nodes"] }

          /// Node.AsRepository.Issues.PageInfo
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

          /// Node.AsRepository.Issues.Node
          ///
          /// Parent Type: `Issue`
          public struct Node: GitHubSchema.SelectionSet {
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

            /// Node.AsRepository.Issues.Node.Author
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
  }
}
