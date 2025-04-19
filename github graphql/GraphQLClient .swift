//
//  GraphQLClient .swift
//  github graphql
//
//  Created by 矢島良乙 on 2025/04/18.
//

import Apollo
import ApolloAPI
import Foundation

class GraphQLClient {
    
    static let shared = GraphQLClient()
    
    let apollo = {
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        let client = URLSessionClient()
        //let provider = DefaultInterceptorProvider(client: client, store: store)
        let provider = NetworkInterceptorProvider(client: client, store: store)
        let url = URL(string: "https://api.github.com/graphql")!
        let transport = RequestChainNetworkTransport(
            interceptorProvider: provider,
            endpointURL: url,
        )
        return ApolloClient(networkTransport: transport, store: store)
    }()
    
    private init() {}
}

class AuthorizationInterceptor: ApolloInterceptor {
    public var id: String = UUID().uuidString
    
    func interceptAsync<Operation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
    ) where Operation : GraphQLOperation {
        let token = UserDefaults.standard.string(forKey: "accessToken") ?? ""
        request.addHeader(name: "Authorization", value: "Bearer \(token)")
        chain.proceedAsync(request: request, response: response, interceptor: self, completion: completion)
    }
    
}

class NetworkInterceptorProvider: DefaultInterceptorProvider {
    
    override func interceptors<Operation>(for operation: Operation) -> [ApolloInterceptor] where Operation : GraphQLOperation {
        var interceptors = super.interceptors(for: operation)
        interceptors.insert(AuthorizationInterceptor(), at: 0)
        return interceptors
    }
    
}
