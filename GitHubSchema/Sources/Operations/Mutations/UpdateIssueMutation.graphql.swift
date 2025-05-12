// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UpdateIssueMutation: GraphQLMutation {
  public static let operationName: String = "UpdateIssue"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation UpdateIssue($id: ID!, $title: String!, $body: String) { updateIssue(input: { id: $id, title: $title, body: $body }) { __typename clientMutationId } }"#
    ))

  public var id: ID
  public var title: String
  public var body: GraphQLNullable<String>

  public init(
    id: ID,
    title: String,
    body: GraphQLNullable<String>
  ) {
    self.id = id
    self.title = title
    self.body = body
  }

  public var __variables: Variables? { [
    "id": id,
    "title": title,
    "body": body
  ] }

  public struct Data: GitHubSchema.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { GitHubSchema.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("updateIssue", UpdateIssue?.self, arguments: ["input": [
        "id": .variable("id"),
        "title": .variable("title"),
        "body": .variable("body")
      ]]),
    ] }

    /// Updates an Issue.
    public var updateIssue: UpdateIssue? { __data["updateIssue"] }

    /// UpdateIssue
    ///
    /// Parent Type: `UpdateIssuePayload`
    public struct UpdateIssue: GitHubSchema.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { GitHubSchema.Objects.UpdateIssuePayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("clientMutationId", String?.self),
      ] }

      /// A unique identifier for the client performing the mutation.
      public var clientMutationId: String? { __data["clientMutationId"] }
    }
  }
}
