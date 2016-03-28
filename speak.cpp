#include <cpprest/http_client.h>
#include <cpprest/json.h>

using namespace utility;
using namespace web;
using namespace web::http;
using namespace web::http::client;
using namespace concurrency::streams;

#include "stringBox.h"
#include <iostream>
#include <utility>

using namespace std;

void DisplayResponse(json::value response)
{
    if (!response.is_null())
    { 
        StringBox payload = StringBox::FromJSON(response.as_object());
        cout << payload.string << endl;
    }
}


pplx::task<http_response> make_task_request(http_client & client,
                                            method mtd,
                                            string pathQueryFragment,
                                            json::value jvalue)
{
    return (mtd == methods::GET || mtd == methods::HEAD) ?
        client.request(mtd, conversions::to_string_t(pathQueryFragment), pplx::cancellation_token::none()) :
        client.request(mtd, conversions::to_string_t(pathQueryFragment), std::move(jvalue), pplx::cancellation_token::none());
}

void make_request(http_client & client, string pathQueryFragment, method mtd, json::value jvalue)
{
   make_task_request(client, mtd, pathQueryFragment, jvalue)
      .then([](http_response response)
      {
         if (response.status_code() == status_codes::OK)
         {
             cout << "status: OK" << endl;
         }
         else
         {
             cout << "status: not ok" << endl;
         }
      })
      .wait();
}

int main(int argc, char** argv)
{
    string_t port = U("8080");
    if (argc == 2)
    {
        port = conversions::to_string_t(argv[1]);
    }
    http_client client(U("http://localhost:8080/RESTtest"));

    StringBox payload = StringBox();
    payload.string = "Hello World!";
    ucout << payload.AsJSON().serialize() << endl;

    make_request(client, "/post", methods::PUT, payload.AsJSON());

    std::cout << "Press ENTER to exit." << std::endl;

    std::string line;
    std::getline(std::cin, line);
    return 0;


}
