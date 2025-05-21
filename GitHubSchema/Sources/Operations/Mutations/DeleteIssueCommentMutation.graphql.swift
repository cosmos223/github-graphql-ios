// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class DeleteIssueCommentMutation: GraphQLMutation {
  public static let operationName: String = "DeleteIssueComment"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation DeleteIssueComment($id: ID!) { deleteIssueComment(input: { id: $id }) { __typename clientMutationId } }"#
    ))

  public var id: ID

  public init(id: ID) {
    self.id = id
  }

  public var __variables: Variables? { ["id": id] }

  public struct Data: GitHubSchema.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { GitHubSchema.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("deleteIssueComment", DeleteIssueComment?.self, arguments: ["input": ["id": .variable("id")]]),
    ] }

    /// Deletes an IssueComment object.
    public var deleteIssueComment: DeleteIssueComment? { __data["deleteIssueComment"] }

    /// DeleteIssueComment
    ///
    /// Parent Type: `DeleteIssueCommentPayload`
    public struct DeleteIssueComment: GitHubSchema.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { GitHubSchema.Objects.DeleteIssueCommentPayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("clientMutationId", String?.self),
      ] }

      /// A unique identifier for the client performing the mutation.
      public var clientMutationId: String? { __data["clientMutationId"] }
    }
  }
}
