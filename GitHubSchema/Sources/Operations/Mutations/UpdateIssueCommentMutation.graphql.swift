// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class UpdateIssueCommentMutation: GraphQLMutation {
  public static let operationName: String = "UpdateIssueComment"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation UpdateIssueComment($id: ID!, $body: String!) { updateIssueComment(input: { id: $id, body: $body }) { __typename clientMutationId } }"#
    ))

  public var id: ID
  public var body: String

  public init(
    id: ID,
    body: String
  ) {
    self.id = id
    self.body = body
  }

  public var __variables: Variables? { [
    "id": id,
    "body": body
  ] }

  public struct Data: GitHubSchema.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { GitHubSchema.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("updateIssueComment", UpdateIssueComment?.self, arguments: ["input": [
        "id": .variable("id"),
        "body": .variable("body")
      ]]),
    ] }

    /// Updates an IssueComment object.
    public var updateIssueComment: UpdateIssueComment? { __data["updateIssueComment"] }

    /// UpdateIssueComment
    ///
    /// Parent Type: `UpdateIssueCommentPayload`
    public struct UpdateIssueComment: GitHubSchema.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { GitHubSchema.Objects.UpdateIssueCommentPayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("clientMutationId", String?.self),
      ] }

      /// A unique identifier for the client performing the mutation.
      public var clientMutationId: String? { __data["clientMutationId"] }
    }
  }
}
