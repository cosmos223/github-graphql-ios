// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class AddCommentMutation: GraphQLMutation {
  public static let operationName: String = "AddComment"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation AddComment($id: ID!, $body: String!) { addComment(input: { subjectId: $id, body: $body }) { __typename clientMutationId } }"#
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
      .field("addComment", AddComment?.self, arguments: ["input": [
        "subjectId": .variable("id"),
        "body": .variable("body")
      ]]),
    ] }

    /// Adds a comment to an Issue or Pull Request.
    public var addComment: AddComment? { __data["addComment"] }

    /// AddComment
    ///
    /// Parent Type: `AddCommentPayload`
    public struct AddComment: GitHubSchema.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { GitHubSchema.Objects.AddCommentPayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("clientMutationId", String?.self),
      ] }

      /// A unique identifier for the client performing the mutation.
      public var clientMutationId: String? { __data["clientMutationId"] }
    }
  }
}
