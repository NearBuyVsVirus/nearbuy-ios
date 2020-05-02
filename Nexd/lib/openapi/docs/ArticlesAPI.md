# ArticlesAPI

All URIs are relative to *https://nexd-backend.herokuapp.com:443/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**articlesControllerFindAll**](ArticlesAPI.md#articlescontrollerfindall) | **GET** /articles | List articles
[**articlesControllerInsertOne**](ArticlesAPI.md#articlescontrollerinsertone) | **POST** /articles | Create an article


# **articlesControllerFindAll**
```swift
    open class func articlesControllerFindAll() -> Observable<[Article]>
```

List articles

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import NexdClient


// TODO RxSwift sample code not yet implemented. To contribute, please open a ticket via http://github.com/OpenAPITools/openapi-generator/issues/new
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**[Article]**](Article.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **articlesControllerInsertOne**
```swift
    open class func articlesControllerInsertOne(xAdminSecret: String, createArticleDto: CreateArticleDto) -> Observable<Article>
```

Create an article

### Example 
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import NexdClient

let xAdminSecret = "xAdminSecret_example" // String | Secret to access the admin functions.
let createArticleDto = CreateArticleDto(name: "name_example") // CreateArticleDto | 

// TODO RxSwift sample code not yet implemented. To contribute, please open a ticket via http://github.com/OpenAPITools/openapi-generator/issues/new
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **xAdminSecret** | **String** | Secret to access the admin functions. | 
 **createArticleDto** | [**CreateArticleDto**](CreateArticleDto.md) |  | 

### Return type

[**Article**](Article.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

