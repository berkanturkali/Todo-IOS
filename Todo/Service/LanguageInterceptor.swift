//

import Foundation

class LanguageInterceptor: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
            guard let mutableRequest = (self.request as NSURLRequest).mutableCopy() as? NSMutableURLRequest else { return }
            
        let language = Locale.current.language.languageCode?.identifier ?? "en"
            mutableRequest.setValue(language, forHTTPHeaderField: "Accept-Language")
            
            let task = URLSession.shared.dataTask(with: mutableRequest as URLRequest) { [weak self] data, response, error in
                guard let self = self else { return }
                
                if let error = error {
                    self.client?.urlProtocol(self, didFailWithError: error)
                    return
                }
                
                if let response = response {
                    self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                }
                
                if let data = data {
                    self.client?.urlProtocol(self, didLoad: data)
                }
                
                self.client?.urlProtocolDidFinishLoading(self)
            }
            
            task.resume()
        }
    
    override func stopLoading() {
        
    }

}
