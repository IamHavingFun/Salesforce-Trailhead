public class WarehouseCalloutServiceMock implements HttpCalloutMock {
    // implement http mock callout
    public HTTPResponse respond(HttpRequest request) {
        HttpResponse response = new HttpResponse();
        response.setBody(
        '[{"_id":"55d66226726b611100aaf741","replacement":false,"quantity":5,"name":"Warehouse Updated Item","maintenanceperiod":365,"lifespan":120,"cost":5000,"sku":"100000"},' +
        '{"_id":"55d66226726b611100aaf742","replacement":true,"quantity":183,"name":"Warehouse Updated Item","maintenanceperiod":0,"lifespan":0,"cost":300,"sku":"100001"},' +
        '{"_id":"55d66226726b611100aaf743","replacement":true,"quantity":143,"name":"Warehouse Updated Item","maintenanceperiod":0,"lifespan":0,"cost":22,"sku":"100002"}' +
            ']');
		response.setHeader('Content-Type', 'application/json');
        response.setStatusCode(200);    
        return response;
    }
}