import ballerina/grpc;
import ballerina/protobuf.types.empty;
import ballerina/protobuf.types.wrappers;

public isolated client class usersClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, ROOT_DESCRIPTOR_MYCONTRACT, getDescriptorMapMycontract());
    }

    isolated remote function create_user(CreateRequest|ContextCreateRequest req) returns CreateResponse|grpc:Error {
        map<string|string[]> headers = {};
        CreateRequest message;
        if req is ContextCreateRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("users/create_user", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <CreateResponse>result;
    }

    isolated remote function create_userContext(CreateRequest|ContextCreateRequest req) returns ContextCreateResponse|grpc:Error {
        map<string|string[]> headers = {};
        CreateRequest message;
        if req is ContextCreateRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("users/create_user", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <CreateResponse>result, headers: respHeaders};
    }

    isolated remote function update_user(CreateRequest|ContextCreateRequest req) returns SingleUserResponse|grpc:Error {
        map<string|string[]> headers = {};
        CreateRequest message;
        if req is ContextCreateRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("users/update_user", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <SingleUserResponse>result;
    }

    isolated remote function update_userContext(CreateRequest|ContextCreateRequest req) returns ContextSingleUserResponse|grpc:Error {
        map<string|string[]> headers = {};
        CreateRequest message;
        if req is ContextCreateRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("users/update_user", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <SingleUserResponse>result, headers: respHeaders};
    }

    isolated remote function view_user(string|wrappers:ContextString req) returns SingleUserResponse|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("users/view_user", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <SingleUserResponse>result;
    }

    isolated remote function view_userContext(string|wrappers:ContextString req) returns ContextSingleUserResponse|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("users/view_user", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <SingleUserResponse>result, headers: respHeaders};
    }

    isolated remote function delete_user(string|wrappers:ContextString req) returns grpc:Error? {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        _ = check self.grpcClient->executeSimpleRPC("users/delete_user", message, headers);
    }

    isolated remote function delete_userContext(string|wrappers:ContextString req) returns empty:ContextNil|grpc:Error {
        map<string|string[]> headers = {};
        string message;
        if req is wrappers:ContextString {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("users/delete_user", message, headers);
        [anydata, map<string|string[]>] [_, respHeaders] = payload;
        return {headers: respHeaders};
    }

    isolated remote function get_all_users() returns stream<SingleUserResponse, grpc:Error?>|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("users/get_all_users", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        SingleUserResponseStream outputStream = new SingleUserResponseStream(result);
        return new stream<SingleUserResponse, grpc:Error?>(outputStream);
    }

    isolated remote function get_all_usersContext() returns ContextSingleUserResponseStream|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("users/get_all_users", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        SingleUserResponseStream outputStream = new SingleUserResponseStream(result);
        return {content: new stream<SingleUserResponse, grpc:Error?>(outputStream), headers: respHeaders};
    }

    isolated remote function get_some_users() returns Get_some_usersStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeBidirectionalStreaming("users/get_some_users");
        return new Get_some_usersStreamingClient(sClient);
    }
}

public class SingleUserResponseStream {
    private stream<anydata, grpc:Error?> anydataStream;

    public isolated function init(stream<anydata, grpc:Error?> anydataStream) {
        self.anydataStream = anydataStream;
    }

    public isolated function next() returns record {|SingleUserResponse value;|}|grpc:Error? {
        var streamValue = self.anydataStream.next();
        if (streamValue is ()) {
            return streamValue;
        } else if (streamValue is grpc:Error) {
            return streamValue;
        } else {
            record {|SingleUserResponse value;|} nextRecord = {value: <SingleUserResponse>streamValue.value};
            return nextRecord;
        }
    }

    public isolated function close() returns grpc:Error? {
        return self.anydataStream.close();
    }
}

public client class Get_some_usersStreamingClient {
    private grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendString(string message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextString(wrappers:ContextString message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveSingleUserResponse() returns SingleUserResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
            return <SingleUserResponse>payload;
        }
    }

    isolated remote function receiveContextSingleUserResponse() returns ContextSingleUserResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: <SingleUserResponse>payload, headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public client class UsersCreateResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendCreateResponse(CreateResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextCreateResponse(ContextCreateResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class UsersNilCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class UsersSingleUserResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendSingleUserResponse(SingleUserResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextSingleUserResponse(ContextSingleUserResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public type ContextSingleUserResponseStream record {|
    stream<SingleUserResponse, error?> content;
    map<string|string[]> headers;
|};

public type ContextCreateRequest record {|
    CreateRequest content;
    map<string|string[]> headers;
|};

public type ContextCreateResponse record {|
    CreateResponse content;
    map<string|string[]> headers;
|};

public type ContextSingleUserResponse record {|
    SingleUserResponse content;
    map<string|string[]> headers;
|};

public type CreateRequest record {|
    string username = "";
    string lastname = "";
    string firstname = "";
    string email = "";
|};

public type CreateResponse record {|
    string userid = "";
|};

public type SingleUserResponse record {|
    string lastname = "";
    string firstname = "";
    string email = "";
|};

const string ROOT_DESCRIPTOR_MYCONTRACT = "0A106D79636F6E74726163742E70726F746F1A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F1A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F227B0A0D43726561746552657175657374121A0A08757365726E616D651801200128095208757365726E616D65121A0A086C6173746E616D6518022001280952086C6173746E616D65121C0A0966697273746E616D65180320012809520966697273746E616D6512140A05656D61696C1804200128095205656D61696C22280A0E437265617465526573706F6E736512160A06757365726964180120012809520675736572696422640A1253696E676C6555736572526573706F6E7365121A0A086C6173746E616D6518012001280952086C6173746E616D65121C0A0966697273746E616D65180220012809520966697273746E616D6512140A05656D61696C1803200128095205656D61696C32F9020A057573657273122E0A0B6372656174655F75736572120E2E437265617465526571756573741A0F2E437265617465526573706F6E736512320A0B7570646174655F75736572120E2E437265617465526571756573741A132E53696E676C6555736572526573706F6E7365123E0A09766965775F75736572121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A132E53696E676C6555736572526573706F6E736512430A0B64656C6574655F75736572121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A162E676F6F676C652E70726F746F6275662E456D707479123E0A0D6765745F616C6C5F757365727312162E676F6F676C652E70726F746F6275662E456D7074791A132E53696E676C6555736572526573706F6E7365300112470A0E6765745F736F6D655F7573657273121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A132E53696E676C6555736572526573706F6E736528013001620670726F746F33";

public isolated function getDescriptorMapMycontract() returns map<string> {
    return {"google/protobuf/empty.proto": "0A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F120F676F6F676C652E70726F746F62756622070A05456D70747942540A13636F6D2E676F6F676C652E70726F746F627566420A456D70747950726F746F50015A057479706573F80101A20203475042AA021E476F6F676C652E50726F746F6275662E57656C6C4B6E6F776E5479706573620670726F746F33", "google/protobuf/wrappers.proto": "0A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F120F676F6F676C652E70726F746F62756622230A0B446F75626C6556616C756512140A0576616C7565180120012801520576616C756522220A0A466C6F617456616C756512140A0576616C7565180120012802520576616C756522220A0A496E74363456616C756512140A0576616C7565180120012803520576616C756522230A0B55496E74363456616C756512140A0576616C7565180120012804520576616C756522220A0A496E74333256616C756512140A0576616C7565180120012805520576616C756522230A0B55496E74333256616C756512140A0576616C756518012001280D520576616C756522210A09426F6F6C56616C756512140A0576616C7565180120012808520576616C756522230A0B537472696E6756616C756512140A0576616C7565180120012809520576616C756522220A0A427974657356616C756512140A0576616C756518012001280C520576616C756542570A13636F6D2E676F6F676C652E70726F746F627566420D577261707065727350726F746F50015A057479706573F80101A20203475042AA021E476F6F676C652E50726F746F6275662E57656C6C4B6E6F776E5479706573620670726F746F33", "mycontract.proto": "0A106D79636F6E74726163742E70726F746F1A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F1A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F227B0A0D43726561746552657175657374121A0A08757365726E616D651801200128095208757365726E616D65121A0A086C6173746E616D6518022001280952086C6173746E616D65121C0A0966697273746E616D65180320012809520966697273746E616D6512140A05656D61696C1804200128095205656D61696C22280A0E437265617465526573706F6E736512160A06757365726964180120012809520675736572696422640A1253696E676C6555736572526573706F6E7365121A0A086C6173746E616D6518012001280952086C6173746E616D65121C0A0966697273746E616D65180220012809520966697273746E616D6512140A05656D61696C1803200128095205656D61696C32F9020A057573657273122E0A0B6372656174655F75736572120E2E437265617465526571756573741A0F2E437265617465526573706F6E736512320A0B7570646174655F75736572120E2E437265617465526571756573741A132E53696E676C6555736572526573706F6E7365123E0A09766965775F75736572121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A132E53696E676C6555736572526573706F6E736512430A0B64656C6574655F75736572121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A162E676F6F676C652E70726F746F6275662E456D707479123E0A0D6765745F616C6C5F757365727312162E676F6F676C652E70726F746F6275662E456D7074791A132E53696E676C6555736572526573706F6E7365300112470A0E6765745F736F6D655F7573657273121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A132E53696E676C6555736572526573706F6E736528013001620670726F746F33"};
}

