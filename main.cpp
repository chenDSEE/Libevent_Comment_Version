#include <event2/event.h>
#include <iostream>
#include <string>
using namespace std;

void timer_cb(evutil_socket_t fd, short what, void *arg)
{
    cout << "aimer" << endl;
}
int main()
{
    auto *base = event_base_new();
    struct timeval five_seconds = {1, 0};
    auto *ev = event_new(base, -1, EV_TIMEOUT, timer_cb, NULL);
    event_add(ev, &five_seconds);
    event_base_dispatch(base);
    event_free(ev);
    event_base_free(base);
    return 0;
}
