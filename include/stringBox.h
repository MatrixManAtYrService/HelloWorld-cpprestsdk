#ifndef STRINGBOX_H
#define STRINGBOX_H

#include <string>
#include "cpprest/json.h"

#define STRING U("string")

// Sample data for testSpeak and testListen
struct StringBox
{
    std::string string;

    static StringBox FromJSON(const web::json::object object)
    {
        StringBox result;
        web::json::value strObj = object.at(STRING);
        string_t str = strObj.as_string();

        result.string = utility::conversions::to_utf8string(str);
        return result;
    }

    web::json::value AsJSON()
    {
        web::json::value result = web::json::value::object();
        result[STRING] = web::json::value::string(utility::conversions::to_string_t(string));
        return result;
    }
};




#endif
