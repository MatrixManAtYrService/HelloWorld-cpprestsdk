#include <cpprest/json.h>
#include <cpprest/http_listener.h>

using namespace web;
using namespace http;
using namespace utility;
using namespace http::experimental::listener;

#include "stringBox.h"

class MyListener
{
public:

    http_listener listener;

    MyListener(string_t address) : listener(address)
    {
        listener.support(methods::PUT, std::bind(&MyListener::handle_put, this, std::placeholders::_1));
    }

    pplx::task<void> open() { return listener.open(); }
    pplx::task<void> close() { return listener.close(); }

    void handle_put(http_request message)
    {
        message.reply(status_codes::OK)
            .wait();
        message.extract_json()
            .then([=](json::value value)
        {
            const std::string payload = (StringBox::FromJSON(value.as_object()).string);
            std::cout << payload << std::endl;
        })
            .wait();
    }

};


int main(int argc, char** argv)
{
    string_t port = U("8080");
    if (argc == 2)
    {
        port = conversions::to_string_t(argv[1]);
    }

    string_t address = U("http://localhost:");
    address.append(port);
    address.append(U("/RESTtest"));

    MyListener myListener(address);
    myListener.open().wait();

    std::cout << "Press ENTER to exit." << std::endl;

    std::string line;
    std::getline(std::cin, line);

    myListener.close().wait();
    return 0;
}

