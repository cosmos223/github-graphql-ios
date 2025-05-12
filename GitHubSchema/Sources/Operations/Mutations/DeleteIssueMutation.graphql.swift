// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class DeleteIssueMutation: GraphQLMutation {
  public static let operationName: String = "DeleteIssue"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation DeleteIssue($issueId: ID!) { deleteIssue(input: { issueId: $issueId }) { __typename clientMutationId } }"#
    ))

  public var issueId: ID

  public init(issueId: ID) {
    self.issueId = issueId
  }

  public var __variables: Variables? { ["issueId": issueId] }

  public struct Data: GitHubSchema.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: any ApolloAPI.ParentType { GitHubSchema.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("deleteIssue", DeleteIssue?.self, arguments: ["input": ["issueId": .variable("issueId")]]),
    ] }

    /// Deletes an Issue object.
    public var deleteIssue: DeleteIssue? { __data["deleteIssue"] }

    /// DeleteIssue
    ///
    /// Parent Type: `DeleteIssuePayload`
    public struct DeleteIssue: GitHubSchema.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { GitHubSchema.Objects.DeleteIssuePayload }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("clientMutationId", String?.self),
      ] }

      /// A unique identifier for the client performing the mutation.
      public var clientMutationId: String? { __data["clientMutationId"] }
    }
  }
}
