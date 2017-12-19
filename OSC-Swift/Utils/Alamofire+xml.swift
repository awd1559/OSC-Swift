
import Alamofire
import Ono

enum BackendError: Error {
    case network(error: Error) // Capture any underlying Error from the URLSession API
    case dataSerialization(error: Error)
    case jsonSerialization(error: Error)
    case xmlSerialization(error: Error)
    case objectSerialization(reason: String)
}

extension DataRequest {
    static func xmlResponseSerializer() -> DataResponseSerializer<ONOXMLDocument> {
        return DataResponseSerializer { request, response, data, error in
            // Pass through any underlying URLSession error to the .network case.
            guard error == nil else { return .failure(BackendError.network(error: error!)) }
            
            // Use Alamofire's existing data serializer to extract the data, passing the error as nil, as it has
            // already been handled.
            let result = Request.serializeResponseData(response: response, data: data, error: nil)
            
            guard case let .success(validData) = result else {
                return .failure(BackendError.dataSerialization(error: result.error! as! AFError))
            }
            
            do {
                let xml = try ONOXMLDocument(data: validData)
                return .success(xml)
            } catch {
                return .failure(BackendError.xmlSerialization(error: error))
            }
        }
    }
    
    @discardableResult
    func responseXMLDocument(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<ONOXMLDocument>) -> Void)
        -> Self
    {
        return response(
            queue: queue,
            responseSerializer: DataRequest.xmlResponseSerializer(),
            completionHandler: completionHandler
        )
    }
}
