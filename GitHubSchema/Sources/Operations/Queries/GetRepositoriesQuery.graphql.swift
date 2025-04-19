// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetRepositoriesQuery: GraphQLQuery {
  public static let operationName: String = "GetRepositories"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetRepositories($first: Int = 25, $query: String = "", $after: String) { search(query: $query, type: REPOSITORY, first: $first, after: $after) { __typename pageInfo { __typename endCursor hasNextPage } nodes { __typename ... on Repository { nameWithOwner id name description url stargazerCount owner { __typename login } } } } }"#
    ))

  public var first: GraphQLNullable<Int>
  public var query: GraphQLNullable<String>
  public var after: GraphQLNullable<String>

  public init(
    first: GraphQLNullable<Int> = 25,
    query: GraphQLNullable<String> = "",
    after: GraphQLNullable<String>
  ) {
    self.first = first
    self.query = query
    self.after = after
  }

  public var __variables: Variables? { [
    "first": first,
    "query": query,
    "after": after
  ] }

  public struct Data: GitHubSchema.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { GitHubSchema.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("search", Search.self, arguments: [
        "query": .variable("query"),
        "type": "REPOSITORY",
        "first": .variable("first"),
        "after": .variable("after")
      ]),
    ] }

    /// Perform a search across resources, returning a maximum of 1,000 results.
    public var search: Search { __data["search"] }

    /// Search
    ///
    /// Parent Type: `SearchResultItemConnection`
    public struct Search: GitHubSchema.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { GitHubSchema.Objects.SearchResultItemConnection }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("pageInfo", PageInfo.self),
        .field("nodes", [Node?]?.self),
      ] }

      /// Information to aid in pagination.
      public var pageInfo: PageInfo { __data["pageInfo"] }
      /// A list of nodes.
      public var nodes: [Node?]? { __data["nodes"] }

      /// Search.PageInfo
      ///
      /// Parent Type: `PageInfo`
      public struct PageInfo: GitHubSchema.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { GitHubSchema.Objects.PageInfo }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("endCursor", String?.self),
          .field("hasNextPage", Bool.self),
        ] }

        /// When paginating forwards, the cursor to continue.
        public var endCursor: String? { __data["endCursor"] }
        /// When paginating forwards, are there more items?
        public var hasNextPage: Bool { __data["hasNextPage"] }
      }

      /// Search.Node
      ///
      /// Parent Type: `SearchResultItem`
      public struct Node: GitHubSchema.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { GitHubSchema.Unions.SearchResultItem }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .inlineFragment(AsRepository.self),
        ] }

        public var asRepository: AsRepository? { _asInlineFragment() }

        /// Search.Node.AsRepository
        ///
        /// Parent Type: `Repository`
        public struct AsRepository: GitHubSchema.InlineFragment {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public typealias RootEntityType = GetRepositoriesQuery.Data.Search.Node
          public static var __parentType: any ApolloAPI.ParentType { GitHubSchema.Objects.Repository }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("nameWithOwner", String.self),
            .field("id", GitHubSchema.ID.self),
            .field("name", String.self),
            .field("description", String?.self),
            .field("url", GitHubSchema.URI.self),
            .field("stargazerCount", Int.self),
            .field("owner", Owner.self),
          ] }

          /// The repository's name with owner.
          public var nameWithOwner: String { __data["nameWithOwner"] }
          /// The Node ID of the Repository object
          public var id: GitHubSchema.ID { __data["id"] }
          /// The name of the repository.
          public var name: String { __data["name"] }
          /// The description of the repository.
          public var description: String? { __data["description"] }
          /// The HTTP URL for this repository
          public var url: GitHubSchema.URI { __data["url"] }
          /// Returns a count of how many stargazers there are on this object
          ///
          public var stargazerCount: Int { __data["stargazerCount"] }
          /// The User owner of the repository.
          public var owner: Owner { __data["owner"] }

          /// Search.Node.AsRepository.Owner
          ///
          /// Parent Type: `RepositoryOwner`
          public struct Owner: GitHubSchema.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: any ApolloAPI.ParentType { GitHubSchema.Interfaces.RepositoryOwner }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("login", String.self),
            ] }

            /// The username used to login.
            public var login: String { __data["login"] }
          }
        }
      }
    }
  }
}
