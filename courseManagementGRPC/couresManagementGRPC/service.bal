import ballerina/io;
import ballerina/grpc;

type UserDetail record {
    string username;
    string firstname;
    string lastname;
    string email;
};

listener grpc:Listener ep = new (9090);

@grpc:ServiceDescriptor {descriptor: ROOT_DESCRIPTOR_MYCONTRACT, descMap: getDescriptorMapMycontract()}
isolated service "users" on ep {
    private map<UserDetail> all_users = {};

    remote function create_user(CreateRequest value) returns CreateResponse|error {
        io:println("executing remote operation create_user...");
        string new_user_name = value.username;
        UserDetail new_user = {username: new_user_name, firstname: value.firstname, lastname: value.lastname, email: value.email};

        lock {
            if self.all_users.hasKey(new_user_name.clone()) {
                string user_already_exists_error_message = "A user with username ${new_user_name} already exists";
                return error(user_already_exists_error_message);
            } else {
                self.all_users[new_user_name.clone()] = new_user.clone();
                return {userid: new_user_name.clone()};
            }
        }
    }

    remote function update_user(CreateRequest value) returns SingleUserResponse|error {
        io:println("executing remote operation update_user...");
        string new_user_name = value.username;
        UserDetail up_user = {username: new_user_name, firstname: value.firstname, lastname: value.lastname, email: value.email};

        lock {
            if self.all_users.hasKey(new_user_name.clone()) {
                self.all_users[new_user_name.clone()] = up_user.clone();
                return {firstname: up_user.firstname, lastname: up_user.lastname, email: up_user.email}.clone();
            } else {
                string no_user_error_message = "no user with username ${new_user_name} exists";
                return error(no_user_error_message);
            }
        }
    }

    // function view_user() returns json[] {
    //     json[] userArray = [];
    //     lock {
    //         foreach key , value in self.all_users {
    //             json userJson = {
    //             "username": value.username,
    //             "firstname": value.firstname,
    //             "lastname": value.lastname,
    //             "email": value.email
    //         };
    //             userArray.push(userJson);
    //         }
    //     }
    //     return userArray;
    // }

}
