public class ProjectCalloutServiceMockFailure implements HttpCalloutMock{
    public HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setStatusCode(500);
        response.setBody('Failure');
        return response;
    }
}