@isTest
public class HttpCalloutExampleTest {

    // Define a mock HTTP response
    public class MockHttpResponse implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"foo1":"bar1","foo2":"bar2"}');
            res.setStatusCode(200);
            return res;
        }
    }

    @isTest
    static void testMakeHttpCallout() {
        // Set up the mock HTTP callout
        Test.setMock(HttpCalloutMock.class, new MockHttpResponse());

        // Start the test
        Test.startTest();

        // Call the method to make the HTTP callout
        String responseBody = HttpCalloutExample.makeHttpCallout();

        // Stop the test
        Test.stopTest();

        // Verify that the HTTP response body is not null
        System.assertNotEquals(null, responseBody, 'Response body is null');
    }
}
