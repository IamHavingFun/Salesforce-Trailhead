public class ProjectCalloutServiceMock implements HttpCalloutMock {
    public HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setStatusCode(201);
        response.setBody('OK');
        return response;
    }
}