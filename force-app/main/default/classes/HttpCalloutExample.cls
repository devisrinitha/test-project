public class HttpCalloutExample {
    public static String makeHttpCallout() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://postman-echo.com/get?foo1=bar1&foo2=bar2');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        String responseBody = response.getBody();
        System.debug('HTTP Response Body: ' + responseBody);
        return responseBody; // Return the response body as a String
    }
}
